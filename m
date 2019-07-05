Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58280C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295B02089C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfGETKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:10:34 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47682 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725778AbfGETKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 15:10:33 -0400
Received: (qmail 5585 invoked by uid 2102); 5 Jul 2019 15:10:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Jul 2019 15:10:32 -0400
Date:   Fri, 5 Jul 2019 15:10:32 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ryan Kennedy <ryan5544@gmail.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: pci-quirks: Minor cleanup for AMD PLL quirk
In-Reply-To: <20190704153529.9429-3-ryan5544@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1907051504310.1606-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019, Ryan Kennedy wrote:

> usb_amd_find_chipset_info() is used for chipset detection for
> several quirks. It is strange that its return value indicates
> the need for the PLL quirk, which means it is often ignored.
> This patch adds a function specifically for checking the PLL
> quirk like the other ones. Additionally, rename probe_result to
> something more appropriate.
> 
> Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>

> @@ -322,6 +317,13 @@ bool usb_amd_prefetch_quirk(void)
>  }
>  EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
>  
> +bool usb_amd_quirk_pll_check(void)
> +{
> +	usb_amd_find_chipset_info();
> +	return amd_chipset.need_pll_quirk;
> +}
> +EXPORT_SYMBOL_GPL(usb_amd_quirk_pll_check);

I really don't see the point of separating out all but one line into a
different function.  You might as well just rename 
usb_amd_find_chipset_info to usb_amd_quirk_pll_check (along with the 
other code adjustments) and be done with it.

However, in the end I don't care if you still want to do this.  Either 
way:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

