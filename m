Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65538C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B227274EF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfFAT0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 15:26:09 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:39317 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726148AbfFAT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 15:26:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0A19318224087;
        Sat,  1 Jun 2019 19:26:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sound41_180a175e3152b
X-Filterd-Recvd-Size: 3016
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Jun 2019 19:26:04 +0000 (UTC)
Message-ID: <a88b259e59c6a713a819266d9ad5c248efa43295.camel@perches.com>
Subject: Re: [PATCH 8/8] staging: rtl8712: Fixed CamelCase in struct
 _adapter from drv_types.h
From:   Joe Perches <joe@perches.com>
To:     Deepak Mishra <linux.dkm@gmail.com>, linux-kernel@vger.kernel.org,
        wlanfae <wlanfae@realtek.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Date:   Sat, 01 Jun 2019 12:26:02 -0700
In-Reply-To: <ad9dad01b15d233cbded3f0693c3c33e21f8d286.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
         <ad9dad01b15d233cbded3f0693c3c33e21f8d286.1559412149.git.linux.dkm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 00:13 +0530, Deepak Mishra wrote:
> This patch fixes CamelCase blnEnableRxFF0Filter by renaming it
> to bln_enable_rx_ff0_filter in drv_types.h and related files rtl871x_cmd.c
> xmit_linux.c

One could also improve this by removing the
hungarian like bln_ prefix and simplify the
name of the boolean variable.

> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
[]
> @@ -164,7 +164,7 @@ struct _adapter {
>  	struct iw_statistics iwstats;
>  	int pid; /*process id from UI*/
>  	struct work_struct wk_filter_rx_ff0;
> -	u8 blnEnableRxFF0Filter;
> +	u8 bln_enable_rx_ff0_filter;

e.g.:

	bool enable_rx_ff0_filter;

> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
[]
> @@ -238,7 +238,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
>  	mod_timer(&pmlmepriv->scan_to_timer,
>  		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
>  	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
> -	padapter->blnEnableRxFF0Filter = 0;
> +	padapter->bln_enable_rx_ff0_filter = 0;

	padapter->enable_rx_ff0_filter = false;

> diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
[]
> @@ -103,11 +103,11 @@ void r8712_SetFilter(struct work_struct *work)
>  	r8712_write8(padapter, 0x117, newvalue);
>  
>  	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
> -	padapter->blnEnableRxFF0Filter = 1;
> +	padapter->bln_enable_rx_ff0_filter = 1;

	padapter->enable_rx_ff0_filter = true;

etc...

Then you could rename padapter to adapter, and maybe
"struct _adapter" to something more sensible like
"struct rtl8712dev" etc...

And one day, hopefully sooner than later, realtek will
improve their driver software base and help eliminate
all the duplicated non-style defects across the family
of drivers for their hardware...



