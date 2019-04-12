Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C3BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954282084E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nzbn5mKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDLX4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:56:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32907 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDLX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 19:56:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so5875791pfo.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 16:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yu1IkjIYt9va9FkTgPsXk3ZRt/tLDiVtYlOdjbiYM30=;
        b=nzbn5mKjS3+/O5R/JNXON4yJy7yW7onU03yGHp/5MUlKtazcPKTQI1vq1VMWSso2Oz
         ebbVylJAHRbM2g9kH07CpwycrWCCl7QRA8DzxUx1MU08zHb59RggjSv+sT/r7FhNDv6E
         6KjPNrrX0ys4tMnIra8WkqWIYWdXWgJkzQ0qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yu1IkjIYt9va9FkTgPsXk3ZRt/tLDiVtYlOdjbiYM30=;
        b=QhmMIexi3cp2WVkKw+mizcCcDH+QQBNXtlzpafZnA93HF24bHnLceXiSwLvs1n8CMV
         epIaCqyKqSnddVNim832muAc8SEE8Z+BW/6SpK4AI27cTNrM3KkiXeb3DddEw22s7vNy
         notPU/i/N4i9AKufaOE1JcnLZ8hNNvwa2EXbAwhwnTTt0lLHtRsr2JrRvCDVVoaqzX/f
         k/27AhTlOdMS6n3CymWyqM4l0D213DWPArZqP4fjjm+hTOQ1dBOrd29ezdG9CXf5mYfB
         p/RmRnz4HxzPqOkP2saHXZ8iiPrwql7QVQwKFpUu30eIfA41/2XY+gMm/zLDHR0BDtS1
         2Zvw==
X-Gm-Message-State: APjAAAVuC65Dd4sYW0jn/GdmwF67d5m3cLDnixZuTPa68k1SLFfw9Pvw
        dlMSUVH1XD991AZ7h3uAq3gCzw==
X-Google-Smtp-Source: APXvYqwD5y08nH2PWJP+1qni5sP51BwbJuMKfLETfiSHTzzSGRX05V265S328hnuXFFam3VDIOJtdg==
X-Received: by 2002:a63:c104:: with SMTP id w4mr56885927pgf.409.1555113395043;
        Fri, 12 Apr 2019 16:56:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s9sm30565812pfe.183.2019.04.12.16.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 16:56:34 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:56:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        linux-usb@vger.kernel.org, Randy Li <ayaka@soulik.info>,
        ryandcase@chromium.org, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Yunzhi Li <lyz@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: dwc2: optionally assert phy reset when waking up
Message-ID: <20190412235633.GY112750@google.com>
References: <20190412224149.106971-1-dianders@chromium.org>
 <20190412224149.106971-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412224149.106971-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 03:41:47PM -0700, Douglas Anderson wrote:
> On the rk3288 USB host-only port (the one that's not the OTG-enabled
> port) the PHY can get into a bad state when a wakeup is asserted (not
> just a wakeup from full system suspend but also a wakeup from
> autosuspend).
> 
> We can get the PHY out of its bad state by asserting its "port reset",
> but unfortunately that seems to assert a reset onto the USB bus so it
> could confuse things if we don't actually deenumerate / reenumerate the
> device.
> 
> We can also get the PHY out of its bad state by fully resetting it using
> the reset from the CRU (clock reset unit), which does a more full
> reset.  The CRU-based reset appears to actually cause devices on the bus
> to be removed and reinserted, which fixes the problem (albeit in a hacky
> way).
> 
> It's unfortunate that we need to do a full re-enumeration of devices at
> wakeup time, but this is better than alternative of letting the bus get
> wedged.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Yunzhi Li <lyz@rock-chips.com>
> ---
> 
>  drivers/usb/dwc2/core.h      |  5 +++++
>  drivers/usb/dwc2/core_intr.c | 12 ++++++++++++
>  drivers/usb/dwc2/hcd.c       | 16 +++++++++++++---
>  drivers/usb/dwc2/platform.c  |  9 +++++++++
>  4 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 30bab8463c96..f30748f4fe7e 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -859,6 +859,8 @@ struct dwc2_hregs_backup {
>   * @gadget_enabled:	Peripheral mode sub-driver initialization indicator.
>   * @ll_hw_enabled:	Status of low-level hardware resources.
>   * @hibernated:		True if core is hibernated
> + * @reset_phy_on_wake:	Quirk saying that we should assert PHY reset on a
> + *			remote wakeup.
>   * @frame_number:       Frame number read from the core. For both device
>   *			and host modes. The value ranges are from 0
>   *			to HFNUM_MAX_FRNUM.
> @@ -972,6 +974,7 @@ struct dwc2_hregs_backup {
>   * @status_buf_dma:     DMA address for status_buf
>   * @start_work:         Delayed work for handling host A-cable connection
>   * @reset_work:         Delayed work for handling a port reset
> + * @phy_reset_work:     Work structure for doing a PHY reset
>   * @otg_port:           OTG port number
>   * @frame_list:         Frame list
>   * @frame_list_dma:     Frame list DMA address
> @@ -1045,6 +1048,7 @@ struct dwc2_hsotg {
>  	unsigned int gadget_enabled:1;
>  	unsigned int ll_hw_enabled:1;
>  	unsigned int hibernated:1;
> +	unsigned int reset_phy_on_wake:1;
>  	u16 frame_number;
>  
>  	struct phy *phy;
> @@ -1147,6 +1151,7 @@ struct dwc2_hsotg {
>  
>  	struct delayed_work start_work;
>  	struct delayed_work reset_work;
> +	struct work_struct phy_reset_work;
>  	u8 otg_port;
>  	u32 *frame_list;
>  	dma_addr_t frame_list_dma;
> diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
> index 19ae2595f1c3..16ff33574116 100644
> --- a/drivers/usb/dwc2/core_intr.c
> +++ b/drivers/usb/dwc2/core_intr.c
> @@ -435,6 +435,18 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
>  			/* Restart the Phy Clock */
>  			pcgcctl &= ~PCGCTL_STOPPCLK;
>  			dwc2_writel(hsotg, pcgcctl, PCGCTL);
> +
> +			/*
> +			 * If we've got this quirk then the PHY is stuck upon
> +			 * wakeup.  Assert reset.  This will propagate out and
> +			 * eventually we'll re-enumerate the device.  Not great
> +			 * but the best we can do.  We can't call phy_reset()
> +			 * at interrupt time but there's no hurry, so we'll
> +			 * schedule it for later.
> +			 */
> +			if (hsotg->reset_phy_on_wake)
> +				schedule_work(&hsotg->phy_reset_work);
> +
>  			mod_timer(&hsotg->wkp_timer,
>  				  jiffies + msecs_to_jiffies(71));
>  		} else {
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 3f087962f498..332349148d3f 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -4376,6 +4376,17 @@ static void dwc2_hcd_reset_func(struct work_struct *work)
>  	spin_unlock_irqrestore(&hsotg->lock, flags);
>  }
>  
> +static void dwc2_hcd_phy_reset_func(struct work_struct *work)
> +{
> +	struct dwc2_hsotg *hsotg = container_of(work, struct dwc2_hsotg,
> +						phy_reset_work);
> +	int ret;
> +
> +	ret = phy_reset(hsotg->phy);
> +	if (ret)
> +		dev_warn(hsotg->dev, "PHY reset failed\n");
> +}
> +
>  /*
>   * =========================================================================
>   *  Linux HC Driver Functions
> @@ -5271,11 +5282,10 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>  		hsotg->hc_ptr_array[i] = channel;
>  	}
>  
> -	/* Initialize hsotg start work */
> +	/* Initialize work */
>  	INIT_DELAYED_WORK(&hsotg->start_work, dwc2_hcd_start_func);
> -
> -	/* Initialize port reset work */
>  	INIT_DELAYED_WORK(&hsotg->reset_work, dwc2_hcd_reset_func);
> +	INIT_WORK(&hsotg->phy_reset_work, dwc2_hcd_phy_reset_func);

You also want to make sure that the work is cancelled when the
controller is stopped/removed. It seems dwc2_hcd_stop() would be a
suitable place for that.
