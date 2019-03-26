Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903E12070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JA4N4BLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbfCZHg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:36:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54364 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfCZHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:36:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2Q7aL3h069108;
        Tue, 26 Mar 2019 02:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553585781;
        bh=5qJL/qmrOcXdnOzu/kJK0NPOov44i/79ptf7hyIRijI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JA4N4BLXem17WNLYFiR0SkrF8lOvTN0UJjMQe7cjWXrSxaUoRkwNNgPFoqB6zMSbw
         AJNz/g4uWeSLo3mCPGjrxaEtO44S+/mlKOna3BH4+q6rGgAn86zqQZVPYvmpfhSf+t
         tQxy7XIcRcuu0wOnZaTTEpC3YYGuf28pUy05ph2c=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2Q7aL0i102716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Mar 2019 02:36:21 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 26
 Mar 2019 02:36:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 26 Mar 2019 02:36:20 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2Q7aISA047448;
        Tue, 26 Mar 2019 02:36:19 -0500
Subject: Re: [PATCH] phy: phy-twl4030-usb: Fix cable state handling
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.com>
References: <20190324232654.60812-1-tony@atomide.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <beb4e604-f6d0-0341-b2f8-263fa64ebeec@ti.com>
Date:   Tue, 26 Mar 2019 13:05:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190324232654.60812-1-tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/03/19 4:56 AM, Tony Lindgren wrote:
> With the recent regulator changes I noticed new warnings on doing rmmod of
> phy-twl4030-usb:
> 
> WARNING: CPU: 0 PID: 1080 at drivers/regulator/core.c:2046 _regulator_put
> ...
> 
> Turns out we can currently miss disconnect at least for cases where status
> is 0 and linkstat is 0. And in that case doing rmmod phy-twl4030-usb will
> produce the regulator_put() warning.
> 
> This is because the missed disconnect causes unbalanced PM runtime calls
> and the regulators will be on exit.
> 
> Let's fix the issue by using an atomic flag for the cable state to make
> sure that PM runtime won't get out of sync with the cable state. That
> way we can also simplify the code a bit.
> 
> Note that we can also drop the old comments, those relate to issues that
> the battery charger driver and musb driver is dealing with rather than
> the USB PHY driver.
> 
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

merged, thanks!

-Kishon
> ---
>  drivers/phy/ti/phy-twl4030-usb.c | 35 ++++++++++++--------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
> --- a/drivers/phy/ti/phy-twl4030-usb.c
> +++ b/drivers/phy/ti/phy-twl4030-usb.c
> @@ -172,6 +172,7 @@ struct twl4030_usb {
>  
>  	int			irq;
>  	enum musb_vbus_id_status linkstat;
> +	atomic_t		connected;
>  	bool			vbus_supplied;
>  	bool			musb_mailbox_pending;
>  
> @@ -575,39 +576,29 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>  {
>  	struct twl4030_usb *twl = _twl;
>  	enum musb_vbus_id_status status;
> -	bool status_changed = false;
>  	int err;
>  
>  	status = twl4030_usb_linkstat(twl);
>  
>  	mutex_lock(&twl->lock);
> -	if (status >= 0 && status != twl->linkstat) {
> -		status_changed =
> -			cable_present(twl->linkstat) !=
> -			cable_present(status);
> -		twl->linkstat = status;
> -	}
> +	twl->linkstat = status;
>  	mutex_unlock(&twl->lock);
>  
> -	if (status_changed) {
> -		/* FIXME add a set_power() method so that B-devices can
> -		 * configure the charger appropriately.  It's not always
> -		 * correct to consume VBUS power, and how much current to
> -		 * consume is a function of the USB configuration chosen
> -		 * by the host.
> -		 *
> -		 * REVISIT usb_gadget_vbus_connect(...) as needed, ditto
> -		 * its disconnect() sibling, when changing to/from the
> -		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
> -		 * starts to handle softconnect right.
> -		 */
> -		if (cable_present(status)) {
> +	if (cable_present(status)) {
> +		if (atomic_add_unless(&twl->connected, 1, 1)) {
> +			dev_dbg(twl->dev, "%s: cable connected %i\n",
> +				__func__, status);
>  			pm_runtime_get_sync(twl->dev);
> -		} else {
> +			twl->musb_mailbox_pending = true;
> +		}
> +	} else {
> +		if (atomic_add_unless(&twl->connected, -1, 0)) {
> +			dev_dbg(twl->dev, "%s: cable disconnected %i\n",
> +				__func__, status);
>  			pm_runtime_mark_last_busy(twl->dev);
>  			pm_runtime_put_autosuspend(twl->dev);
> +			twl->musb_mailbox_pending = true;
>  		}
> -		twl->musb_mailbox_pending = true;
>  	}
>  	if (twl->musb_mailbox_pending) {
>  		err = musb_mailbox(status);
> 
