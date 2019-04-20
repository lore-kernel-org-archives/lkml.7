Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1601FC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8152521479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b="X8IbzBiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfDTIac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 04:30:32 -0400
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:55596 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbfDTIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 04:30:31 -0400
X-Greylist: delayed 1212 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Apr 2019 04:30:30 EDT
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <dick@mrns.nl>)
        id 1hHl4i-0000eN-5Q; Sat, 20 Apr 2019 10:10:16 +0200
Received: from ip-213-127-67-73.ip.prioritytelecom.net ([213.127.67.73] helo=routi.mrns.nl)
        by smtp6.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <dick@mrns.nl>)
        id 1hHl4h-0005OY-2E; Sat, 20 Apr 2019 10:10:16 +0200
Received: by routi.mrns.nl (sSMTP sendmail emulation); Sat, 20 Apr 2019 10:10:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrns.nl;
 i=@mrns.nl; q=dns/txt; s=mail; t=1555747814; h=date : from : to : cc :
 subject : message-id : mime-version : content-type : from;
 bh=znwOSSSBdKg6HYBzdnX6GCpeT7U3Py2XItMkuRtGaUc=;
 b=X8IbzBizj6IzLqViUvswcW83xgHMZBfLB1iYVsHktepyuCFqF0Lot2g7j655o2hQK05OH
 CreRWnflSH5uijLQaE7ZMOxoltR8RKYTcCKGTC0rpG+PjM5Y4Ty6jUZ7NJq4W7/sxac5S3+
 +u5dB2NGRFauPnYuvunmmV5zqMexrfU=
Date:   Sat, 20 Apr 2019 10:10:14 +0200
From:   Dick Marinus <dick@mrns.nl>
To:     linux-kernel@vger.kernel.org
Cc:     wens@csie.org
Subject: Re: [PATCH] Bluetooth: hci_bcm: Fix empty regulator supplies for
 Intel Macs
Message-ID: <20190420081014.nmgjyrekngga4ncl@routi.mrns.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-SourceIP: 213.127.67.73
X-Authenticated-Sender: boeierlaan60@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=ENp4LGRC c=1 sm=1 tr=0 a=0nvI0T6MiNaq20ZY2X3xbg==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=kj9zAlcOel0A:10 a=oexKYjalfGEA:10 a=zu6OG0ZhAAAA:8 a=VwQbUJbxAAAA:8 a=vYmT8LKSE7Qjc22oWjAA:9 a=ZDFt9QSJGRoUNatP:21 a=YSwbCBWV7iuL550X:21 a=CjuIK1q_8ugA:10 a=pAN39diAhXWuPx0-Vjn3:22 a=AjGcO6oz07-iQ99wixmX:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the issue for hanging at modprobe intel-lpss-pci on my
macbook pro 13,3 2016.

Error in dmesg:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000090

Thanks a lot!

Tested-by: Dick Marinus <dick@mrns.nl>
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The code path for Macs goes through bcm_apple_get_resources(), which
> skips over the code that sets up the regulator supplies. As a result,
> the call to regulator_bulk_enable() / regulator_bulk_disable() results
> in a NULL pointer dereference.
> 
> This was reported on the kernel.org Bugzilla, bug 202963.
> 
> Unbreak Broadcom Bluetooth support on Intel Macs by checking if the
> supplies were set up before enabling or disabling them.
> 
> The same does not need to be done for the clocks, as the common clock
> framework API checks for NULL pointers.
> 
> Fixes: 75d11676dccb ("Bluetooth: hci_bcm: Add support for regulator supplies")
> Cc: <stable@vger.kernel.org> # 5.0.x
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> I do not own a Mac, so this needs to be tested by someone else.
> 
> ---
>  drivers/bluetooth/hci_bcm.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ddbe518c3e5b..b5d31d583d60 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -228,9 +228,15 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
>  	int err;
>  
>  	if (powered && !dev->res_enabled) {
> -		err = regulator_bulk_enable(BCM_NUM_SUPPLIES, dev->supplies);
> -		if (err)
> -			return err;
> +		/* Intel Macs use bcm_apple_get_resources() and don't
> +		 * have regulator supplies configured.
> +		 */
> +		if (dev->supplies[0].supply) {
> +			err = regulator_bulk_enable(BCM_NUM_SUPPLIES,
> +						    dev->supplies);
> +			if (err)
> +				return err;
> +		}
>  
>  		/* LPO clock needs to be 32.768 kHz */
>  		err = clk_set_rate(dev->lpo_clk, 32768);
> @@ -259,7 +265,13 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
>  	if (!powered && dev->res_enabled) {
>  		clk_disable_unprepare(dev->txco_clk);
>  		clk_disable_unprepare(dev->lpo_clk);
> -		regulator_bulk_disable(BCM_NUM_SUPPLIES, dev->supplies);
> +
> +		/* Intel Macs use bcm_apple_get_resources() and don't
> +		 * have regulator supplies configured.
> +		 */
> +		if (dev->supplies[0].supply)
> +			regulator_bulk_disable(BCM_NUM_SUPPLIES,
> +					       dev->supplies);
>  	}
>  
>  	/* wait for device to power on and come out of reset */
> -- 
> 2.20.1
