Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F612C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835C52173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfGSNho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:37:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:35262 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbfGSNhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:37:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 06:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; 
   d="scan'208";a="179627372"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2019 06:37:37 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hoT4p-0003sx-PA; Fri, 19 Jul 2019 16:37:35 +0300
Date:   Fri, 19 Jul 2019 16:37:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kangjie Lu <kjlu@umn.edu>, Aditya Pakki <pakki001@umn.edu>
Cc:     emamd001@umn.edu, smccaman@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250_lpss: check null return when calling pci_ioremap_bar
Message-ID: <20190719133735.GM9224@smile.fi.intel.com>
References: <20190719025443.2368-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719025443.2368-1-navid.emamdoost@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 09:54:42PM -0500, Navid Emamdoost wrote:
> pci_ioremap_bar may return null. This is eventually de-referenced at 
> drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check is
>  needed to prevent null de-reference. I am adding the check and in case of
>  failure returning -ENOMEM (I am not sure this is the best errno, you may 
> consider it as a placeholder), and subsequently changing the caller’s 
> return type, and propagating the error.

Thanks for the patch, my comments below.

>  	chip->irq = pci_irq_vector(pdev, 0);
>  	chip->regs = pci_ioremap_bar(pdev, 1);
> +	if (!chip->regs)
> +		return -ENOMEM;

This is the same case as below, it's fine to go on without DMA support.

>  	chip->pdata = &qrk_serial_dma_pdata;

So, I would rather to put like this...

Hold on, I remember someone already tried to fix this [1].

I dunno why it wasn't v5, due to [2].

Also, similar to yours, but wrong [3].

Thus, please, collaborate guys, and send one compiling solution  based on [1].

>  	/* Falling back to PIO mode if DMA probing fails */
>  	ret = dw_dma_probe(chip);
>  	if (ret)
> -		return;
> +		return 0;

[1]: https://www.spinics.net/lists/linux-serial/msg33965.html
[2]: https://lists.01.org/pipermail/kbuild-all/2019-March/059215.html
[3]: https://lore.kernel.org/patchwork/patch/1051000/

-- 
With Best Regards,
Andy Shevchenko


