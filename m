Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F747C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9592084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbfIJMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:33:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:38567 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730089AbfIJMdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:33:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 05:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="268395179"
Received: from mweingar-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.26])
  by orsmga001.jf.intel.com with ESMTP; 10 Sep 2019 05:32:56 -0700
Date:   Tue, 10 Sep 2019 13:32:55 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20190910123255.GB7484@linux.intel.com>
References: <20190904190332.25019-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904190332.25019-1-ivan.lazeev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 10:03:32PM +0300, ivan.lazeev@gmail.com wrote:
> From: Ivan Lazeev <ivan.lazeev@gmail.com>
> 
> Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> 
> cmd/rsp buffers are expected to be in the same ACPI region.
> For Zen+ CPUs BIOS's might report two different regions, some of
> them also report region sizes inconsistent with values from TPM
> registers.
> 
> Work around the issue by storing ACPI regions declared for the
> device in a list, then using it to find entry corresponding
> to each buffer. Use information from the entry to map each resource
> at most once and make buffer size consistent with the length of the
> region.
> 
> Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>
> ---

Partial re-review. Please ignore the comment about multiple ACPI walks
in my previous review. Most of the other comments hold (like partial
/proc/iomem output *must* be included).

One remark I forgot is that this the v3 of your patch. Please version
your patches properly and provide the full changelog in v4. There is no
documentation what happend between v2 and v3.

Please provide more verbose explanation what the patch does. "Using it"
does not tell at all *what* is used and *how*. Please introduce the new
data structures and explain how they are used and what they replace and
so forth (you probably get the idea).

The commit message is definitely the weakest link of this patch right
now.

>  static int crb_check_resource(struct acpi_resource *ares, void *data)
>  {
> -	struct resource *io_res = data;
> +	struct list_head *list = data;
> +	struct crb_resource *cres;
>  	struct resource_win win;
>  	struct resource *res = &(win.res);
>  
>  	if (acpi_dev_resource_memory(ares, res) ||
>  	    acpi_dev_resource_address_space(ares, &win)) {
> -		*io_res = *res;
> -		io_res->name = NULL;
> +		cres = kzalloc(sizeof(*cres), GFP_KERNEL);
> +		if (!cres)
> +			return -ENOMEM;
> +
> +		cres->io_res = *res;
> +		cres->io_res.name = NULL;
> +
> +		list_add_tail(&cres->node, list);
>  	}
>  
>  	return 1;

I think that you might get away just by collecting acpi_resources and
pass that to your helpers. See the documentation of the function on
how to make it collect all the resources:

https://elixir.bootlin.com/linux/latest/source/drivers/acpi/resource.c#L622

Of course you then have to move acpi_dev_free_resource_list() to be
called after you've done ioremaps.

This was the essential thing that I wanted to remark compared to my
previous review.

/Jarkko
