Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F0CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17458208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ariIGk+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF1Rfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:35:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47842 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF1Rfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:35:46 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5SHZgII110855;
        Fri, 28 Jun 2019 12:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561743342;
        bh=IozxFK3j20SwrhOv9xhTPXdk9E84xivh5mGBBnnQs20=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ariIGk+sB5lpsDkLf5JmT+p+oFaTGg/czmS7GrdfkB+TldOR6TFd8O2f3P9x1m5Df
         bzeH5dXRtLXrstPA0QsnKQZoa826wBeOty+UF6gZNf8PbfwOM/pUISo7A1KtKBeBGJ
         DNzj9VwRAfiYJN8XHfK1O608F2TMP9E2J/3w+2sE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5SHZg3b076163
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jun 2019 12:35:42 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 28
 Jun 2019 12:35:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 28 Jun 2019 12:35:41 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id x5SHZfCK100507;
        Fri, 28 Jun 2019 12:35:41 -0500
Date:   Fri, 28 Jun 2019 12:37:02 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - simplify event reporting code
Message-ID: <20190628173702.6wr453fmcyfdxoid@ti.com>
References: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
 <20190623063153.261546-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190623063153.261546-2-dmitry.torokhov@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote on Sat [2019-Jun-22 23:31:53 -0700]:
> Now that input_mt_report_slot_state() returns true if slot is active we no
> longer need a temporary for the slot state.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Appears to work fine in my test:

Tested-by: Benoit Parrot <bparrot@ti.com>

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index ec770226e119..3cc4341bbdff 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -229,7 +229,6 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
>  
>  	for (i = 0; i < tsdata->max_support_points; i++) {
>  		u8 *buf = &rdbuf[i * tplen + offset];
> -		bool down;
>  
>  		type = buf[0] >> 6;
>  		/* ignore Reserved events */
> @@ -247,16 +246,12 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
>  			swap(x, y);
>  
>  		id = (buf[2] >> 4) & 0x0f;
> -		down = type != TOUCH_EVENT_UP;
>  
>  		input_mt_slot(tsdata->input, id);
> -		input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
> -
> -		if (!down)
> -			continue;
> -
> -		touchscreen_report_pos(tsdata->input, &tsdata->prop, x, y,
> -				       true);
> +		if (input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER,
> +					       type != TOUCH_EVENT_UP))
> +			touchscreen_report_pos(tsdata->input, &tsdata->prop,
> +					       x, y, true);
>  	}
>  
>  	input_mt_report_pointer_emulation(tsdata->input, true);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
