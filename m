Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0311C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39EC216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGETE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:04:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47662 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725778AbfGETE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 15:04:29 -0400
Received: (qmail 5565 invoked by uid 2102); 5 Jul 2019 15:04:28 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Jul 2019 15:04:28 -0400
Date:   Fri, 5 Jul 2019 15:04:28 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ryan Kennedy <ryan5544@gmail.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: pci-quirks: Correct AMD PLL quirk detection
In-Reply-To: <20190704153529.9429-2-ryan5544@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1907051504160.1606-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019, Ryan Kennedy wrote:

> The AMD PLL USB quirk is incorrectly enabled on newer Ryzen
> chipsets. The logic in usb_amd_find_chipset_info currently checks
> for unaffected chipsets rather than affected ones. This broke
> once a new chipset was added in e788787ef. It makes more sense
> to reverse the logic so it won't need to be updated as new
> chipsets are added. Note that the core of the workaround in
> usb_amd_quirk_pll does correctly check the chipset.
> 
> Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
> ---
>  drivers/usb/host/pci-quirks.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 3ce71cbfbb58..ad05c27b3a7b 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -205,7 +205,7 @@ int usb_amd_find_chipset_info(void)
>  {
>  	unsigned long flags;
>  	struct amd_chipset_info info;
> -	int ret;
> +	int need_pll_quirk = 0;
>  
>  	spin_lock_irqsave(&amd_lock, flags);
>  
> @@ -219,21 +219,28 @@ int usb_amd_find_chipset_info(void)
>  	spin_unlock_irqrestore(&amd_lock, flags);
>  
>  	if (!amd_chipset_sb_type_init(&info)) {
> -		ret = 0;
>  		goto commit;
>  	}
>  
> -	/* Below chipset generations needn't enable AMD PLL quirk */
> -	if (info.sb_type.gen == AMD_CHIPSET_UNKNOWN ||
> -			info.sb_type.gen == AMD_CHIPSET_SB600 ||
> -			info.sb_type.gen == AMD_CHIPSET_YANGTZE ||
> -			(info.sb_type.gen == AMD_CHIPSET_SB700 &&
> -			info.sb_type.rev > 0x3b)) {
> +	switch (info.sb_type.gen) {
> +	case AMD_CHIPSET_SB700:
> +		need_pll_quirk = info.sb_type.rev <= 0x3B;
> +		break;
> +	case AMD_CHIPSET_SB800:
> +	case AMD_CHIPSET_HUDSON2:
> +	case AMD_CHIPSET_BOLTON:
> +		need_pll_quirk = 1;
> +		break;
> +	default:
> +		need_pll_quirk = 0;
> +		break;
> +	}
> +
> +	if (!need_pll_quirk) {
>  		if (info.smbus_dev) {
>  			pci_dev_put(info.smbus_dev);
>  			info.smbus_dev = NULL;
>  		}
> -		ret = 0;
>  		goto commit;
>  	}
>  
> @@ -252,7 +259,7 @@ int usb_amd_find_chipset_info(void)
>  		}
>  	}
>  
> -	ret = info.probe_result = 1;
> +	need_pll_quirk = info.probe_result = 1;
>  	printk(KERN_DEBUG "QUIRK: Enable AMD PLL fix\n");
>  
>  commit:
> @@ -263,7 +270,7 @@ int usb_amd_find_chipset_info(void)
>  
>  		/* Mark that we where here */
>  		amd_chipset.probe_count++;
> -		ret = amd_chipset.probe_result;
> +		need_pll_quirk = amd_chipset.probe_result;
>  
>  		spin_unlock_irqrestore(&amd_lock, flags);
>  
> @@ -277,7 +284,7 @@ int usb_amd_find_chipset_info(void)
>  		spin_unlock_irqrestore(&amd_lock, flags);
>  	}
>  
> -	return ret;
> +	return need_pll_quirk;
>  }
>  EXPORT_SYMBOL_GPL(usb_amd_find_chipset_info);

Acked-by: Alan Stern <stern@rowland.harvard.edu>

