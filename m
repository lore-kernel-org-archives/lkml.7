Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE89D20659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLCKjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:39:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:39104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCKjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:39:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36A81B25A;
        Tue,  3 Dec 2019 10:39:51 +0000 (UTC)
Subject: Re: [PATCH v1] xen-pciback: optionally allow interrupt enable flag
 writes
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     xen-devel@lists.xenproject.org,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191203054222.7966-1-marmarek@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <9ccf765b-f828-52db-6778-18e605a80a02@suse.com>
Date:   Tue, 3 Dec 2019 11:40:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191203054222.7966-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.2019 06:41, Marek Marczykowski-Górecki  wrote:
> @@ -117,6 +118,35 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
>  		pci_clear_mwi(dev);
>  	}
>  
> +	if (dev_data && dev_data->allow_interrupt_control) {
> +		if (!(cmd->val & PCI_COMMAND_INTX_DISABLE) &&
> +		    (value & PCI_COMMAND_INTX_DISABLE)) {
> +			pci_intx(dev, 0);
> +		} else if ((cmd->val & PCI_COMMAND_INTX_DISABLE) &&
> +		    !(value & PCI_COMMAND_INTX_DISABLE)) {
> +			/* Do not allow enabling INTx together with MSI or MSI-X. */
> +			/* Do not trust dev->msi(x)_enabled here, as enabling could be done
> +			 * bypassing the pci_*msi* functions, by the qemu.
> +			 */
> +			err = pci_read_config_word(dev,
> +						   dev->msi_cap + PCI_MSI_FLAGS,
> +						   &cap_value);
> +			if (!err && (cap_value & PCI_MSI_FLAGS_ENABLE))
> +				err = -EBUSY;
> +			if (!err)
> +				err = pci_read_config_word(dev,
> +							   dev->msix_cap + PCI_MSIX_FLAGS,
> +							   &cap_value);

What about a device without MSI and/or MSI-X? Wouldn't you read
from (close to) config space offset 0 in this case, interpreting
some unrelated bit(s) as the MSI / MSI-X enable one(s)?

Just as an initial implementation related remark. I'm still to
think about the idea as a whole, albeit I find the argument
pretty convincing at the first glance of devices being able to
raise MSI anyway even when disabled as per the config space
setting. (Of course, as with any config space settings, devices
providing backdoor access would open similar avenues.)

Jan
