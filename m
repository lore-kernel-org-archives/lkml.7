Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED65C0030F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA22F21D80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfIEOOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:14:30 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36672 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729157AbfIEOO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:14:29 -0400
Received: (qmail 2656 invoked by uid 2102); 5 Sep 2019 10:14:28 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Sep 2019 10:14:28 -0400
Date:   Thu, 5 Sep 2019 10:14:28 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jacky.Cao@sony.com
cc:     balbi@kernel.org, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kento.A.Kobayashi@sony.com>
Subject: Re: [PATCH v3] USB: dummy-hcd: fix power budget for SuperSpeed mode
In-Reply-To: <16EA1F625E922C43B00B9D82250220500871CDE5@APYOKXMS108.ap.sony.com>
Message-ID: <Pine.LNX.4.44L0.1909051014160.1631-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 Jacky.Cao@sony.com wrote:

> The power budget for SuperSpeed mode should be 900 mA
> according to USB specification, so set the power budget
> to 900mA for dummy_start_ss which is only used for
> SuperSpeed mode.
> 
> If the max power consumption of SuperSpeed device is
> larger than 500 mA, insufficient available bus power
> error happens in usb_choose_configuration function
> when the device connects to dummy hcd.
> 
> Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
> ---
> Changes in v3:
>   - Rename POWER_BUDGET_3_0 to POWER_BUDGET_3
>   - Update commit message from USB3.0 specification to USB specification
> 
> Changes in v2:
>   - Fix whitespace damage
> 
>  drivers/usb/gadget/udc/dummy_hcd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index 8414fac..3d499d9 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -48,6 +48,7 @@
>  #define DRIVER_VERSION	"02 May 2005"
>  
>  #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
> +#define POWER_BUDGET_3	900	/* in mA */
>  
>  static const char	driver_name[] = "dummy_hcd";
>  static const char	driver_desc[] = "USB Host+Gadget Emulator";
> @@ -2432,7 +2433,7 @@ static int dummy_start_ss(struct dummy_hcd *dum_hcd)
>  	dum_hcd->rh_state = DUMMY_RH_RUNNING;
>  	dum_hcd->stream_en_ep = 0;
>  	INIT_LIST_HEAD(&dum_hcd->urbp_list);
> -	dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET;
> +	dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET_3;
>  	dummy_hcd_to_hcd(dum_hcd)->state = HC_STATE_RUNNING;
>  	dummy_hcd_to_hcd(dum_hcd)->uses_new_polling = 1;
>  #ifdef CONFIG_USB_OTG

Acked-by: Alan Stern <stern@rowland.harvard.edu>

