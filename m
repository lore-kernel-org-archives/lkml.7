Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FABCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E9B222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLSLT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:19:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfLSLT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:19:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45C48AB91;
        Thu, 19 Dec 2019 11:19:56 +0000 (UTC)
Subject: Re: [PATCH v2] xen-pciback: optionally allow interrupt enable flag
 writes
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     xen-devel@lists.xenproject.org,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191219034941.19141-1-marmarek@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <c0e27fbe-e2f7-22ca-c3f4-bafb252c7bcc@suse.com>
Date:   Thu, 19 Dec 2019 12:20:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191219034941.19141-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2019 04:49, Marek Marczykowski-Górecki  wrote:
> +enum interrupt_type xen_pcibk_get_interrupt_type(struct pci_dev *dev)
> +{
> +	int err;
> +	u16 val;
> +
> +	err = pci_read_config_word(dev, PCI_COMMAND, &val);
> +	if (err)
> +		return INTERRUPT_TYPE_ERR;
> +	if (!(val & PCI_COMMAND_INTX_DISABLE))
> +		return INTERRUPT_TYPE_INTX;
> +
> +	/* Do not trust dev->msi(x)_enabled here, as enabling could be done
> +	 * bypassing the pci_*msi* functions, by the qemu.
> +	 */

Judging from this comment, how can you assume only one of the
three variants is actually enabled? It's against the spec, yes,
but it's not at all impossible afaict. I think you want the
return value here to be
- negative errno values (no need to discard the actual error
  codes) or
- a non-negative bitmap indicating which of the interrupt types
  is/are currently enabled.
That way ...

> +static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
> +				void *data)
> +{
> +	int err;
> +	u16 old_value;
> +	const struct msi_msix_field_config *field_config = data;
> +	const struct xen_pcibk_dev_data *dev_data = pci_get_drvdata(dev);
> +
> +	if (xen_pcibk_permissive || dev_data->permissive)
> +		goto write;
> +
> +	err = pci_read_config_word(dev, offset, &old_value);
> +	if (err)
> +		return err;
> +
> +	if (new_value == old_value)
> +		return 0;
> +
> +	if (!dev_data->allow_interrupt_control ||
> +	    (new_value ^ old_value) & ~field_config->enable_bit)
> +		return PCIBIOS_SET_FAILED;
> +
> +	if (new_value & field_config->enable_bit) {
> +		/* don't allow enabling together with other interrupt types */
> +		const enum interrupt_type int_type = xen_pcibk_get_interrupt_type(dev);
> +		if (int_type == INTERRUPT_TYPE_NONE ||
> +		    int_type == field_config->int_type)

... equality comparisons like this one will actually become safe.

Jan
