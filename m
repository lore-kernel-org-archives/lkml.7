Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31696C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0636920661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SbzuqJJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfLDS10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:27:26 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56970 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfLDS1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:27:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB4IR9uL118997;
        Wed, 4 Dec 2019 12:27:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575484029;
        bh=Uet6ftlBWt6BLt4lGobOQD5+cFdGEWSfTiuKL7t91js=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SbzuqJJ3+pluoOby71dsCavu5VY1IJbySeO+FHIVH2JAUN6StofHWG/cC1GLh6F17
         LDw6r7+PbTZtCvHUaRrRIxN8e7jV2AdctsNbU4vKyqu7FaEfhAMgi5d53K/QIjCtlc
         q58YXAV6zNHqrtQk9b87TGsUYr4gve4UuoeudWu4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB4IR9Tb051413
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Dec 2019 12:27:09 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Dec
 2019 12:27:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Dec 2019 12:27:07 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4IR4nI106520;
        Wed, 4 Dec 2019 12:27:05 -0600
Subject: Re: [PATCH v6 03/15] drm/bridge: tc358767: Simplify polling in
 tc_link_training()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
 <20190619052716.16831-4-andrew.smirnov@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <0d84fa72-bc96-9b88-cd89-c04327109e0e@ti.com>
Date:   Wed, 4 Dec 2019 20:27:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20190619052716.16831-4-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 19/06/2019 08:27, Andrey Smirnov wrote:

> @@ -748,22 +748,19 @@ static int tc_set_video_mode(struct tc_data *tc,
>   
>   static int tc_wait_link_training(struct tc_data *tc)
>   {
> -	u32 timeout = 1000;
>   	u32 value;
>   	int ret;
>   
> -	do {
> -		udelay(1);
> -		tc_read(DP0_LTSTAT, &value);
> -	} while ((!(value & LT_LOOPDONE)) && (--timeout));
> -
> -	if (timeout == 0) {
> +	ret = tc_poll_timeout(tc, DP0_LTSTAT, LT_LOOPDONE,
> +			      LT_LOOPDONE, 1, 1000);

This seems to break DP at least with some monitors for me. I think it's just a timeout problem, as 
increasing the values helps.

Using ktime, I can see that during link training, the first call takes ~2ms, the second ~7ms. I 
think this worked before, as udelay(1) takes much longer than 1 us.

We have 1000us limit in a few other places too, which I don't see causing issues, but might need 
increasing too.

Also, 1us sleep_us may be a bit too small to be sane. If the loops take milliseconds, probably 100us 
or even more would make sense.

This didn't cause any issues with your display?

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
