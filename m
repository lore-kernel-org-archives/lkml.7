Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A96621920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V1NyWn2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbfIRSjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:39:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55990 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:39:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8IIcspF087130;
        Wed, 18 Sep 2019 13:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568831934;
        bh=3+BfNVSEtgGLGShzzySJZ6vjEalbhA/I3ZGOwubwsx0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=V1NyWn2rlqp+VYR43gngyEAAjt+LwgrjW5NcbOetZqOCQV9xLjPoVBQNshwQZOj6+
         DAuQjYcDM5ASUYvH9a3TdwnRdlHobb3+kUU6CggUC06k0t2oNFsu9ieLZMpWjPBvQl
         pqlwCM+z4aFgcRthowkAp9vrHoXKl2Wf4eMFNGl4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8IIcsEf013503
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Sep 2019 13:38:54 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 18
 Sep 2019 13:38:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 18 Sep 2019 13:38:50 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8IIcrWe092923;
        Wed, 18 Sep 2019 13:38:53 -0500
Subject: Re: [PATCH 3/5] leds: lm3692x: Handle failure to probe the regulator
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1568772964.git.agx@sigxcpu.org>
 <8491e5df20f4672a242c9072f58c243291cfe752.1568772964.git.agx@sigxcpu.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4bde1b54-bdc5-8aa8-d10b-0cc131ef7673@ti.com>
Date:   Wed, 18 Sep 2019 13:41:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8491e5df20f4672a242c9072f58c243291cfe752.1568772964.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guido

On 9/17/19 9:19 PM, Guido Günther wrote:
> Instead use devm_regulator_get_optional since the regulator
> is optional and check for errors.
>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>   drivers/leds/leds-lm3692x.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
> index f394669ad8f2..9972c932d51e 100644
> --- a/drivers/leds/leds-lm3692x.c
> +++ b/drivers/leds/leds-lm3692x.c
> @@ -333,9 +333,14 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>   		return ret;
>   	}
>   
> -	led->regulator = devm_regulator_get(&led->client->dev, "vled");
> -	if (IS_ERR(led->regulator))
> -		led->regulator = NULL;
> +	led->regulator = devm_regulator_get_optional(&led->client->dev, "vled");
> +	if (IS_ERR(led->regulator)) {
> +		ret = PTR_ERR(led->regulator);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&led->client->dev,
> +				"Failed to get vled regulator: %d\n", ret);
nitpick. Add a new line for readability
> +		return ret;
> +	}

If the regulator is not set then led->regulator should be set to NULL.

Dan


>   
>   	child = device_get_next_child_node(&led->client->dev, child);
>   	if (!child) {
