Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B63C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA47421920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OJX2Ulre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbfIRSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:30:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48302 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbfIRSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:30:37 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8IIUVnp035705;
        Wed, 18 Sep 2019 13:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568831431;
        bh=xT70Ic3Q3uDE1FLFpIsErlC8zGyZTIsPhLdtMKcdpRI=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=OJX2UlrePFOPwMzAwF2m2pWVDdjcUBzP+P4kQ20CMK4l4+SRs+DeV2IocjIyCMN9a
         D5GMaFhDRFqDDFz6BIsH5FsHOMIo5b44HuXXdJ/MJZLZtrPuQyStlgKh27Qfbmwlu5
         HZn7RESXRY651BeM3WjAvXwLvSDkFVIjeaQGccS8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8IIUVZB002263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Sep 2019 13:30:31 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 18
 Sep 2019 13:30:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 18 Sep 2019 13:30:28 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8IIUUAf103570;
        Wed, 18 Sep 2019 13:30:30 -0500
Subject: Re: [PATCH 2/5] leds: lm3692x: Don't overwrite return value in error
 path
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1568772964.git.agx@sigxcpu.org>
 <bc1a6e64da58d65b61c7e9358c745b0d467fc24c.1568772964.git.agx@sigxcpu.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4a6b8df3-92f3-0f93-9327-36154daa06d8@ti.com>
Date:   Wed, 18 Sep 2019 13:33:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bc1a6e64da58d65b61c7e9358c745b0d467fc24c.1568772964.git.agx@sigxcpu.org>
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
> The driver currently reports successful initialization on every failure
> as long as it's able to power off the regulator. Don't check the return
> value of regulator_disable to avoid that.
>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>   drivers/leds/leds-lm3692x.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
> index 487228c2bed2..f394669ad8f2 100644
> --- a/drivers/leds/leds-lm3692x.c
> +++ b/drivers/leds/leds-lm3692x.c
> @@ -312,15 +312,12 @@ static int lm3692x_init(struct lm3692x_led *led)
>   	if (led->enable_gpio)
>   		gpiod_direction_output(led->enable_gpio, 0);
>   
> -	if (led->regulator) {
> -		ret = regulator_disable(led->regulator);
> -		if (ret)
> -			dev_err(&led->client->dev,
> -				"Failed to disable regulator\n");
> -	}
> +	if (led->regulator)
> +		regulator_disable(led->regulator);

The change is ok and makes sense but I believe that if the regulator was 
not properly disabled there needs to be some error message t0o.

If the code got here then there is either a fault or an I/O issue not a 
regulator issue.

The regulator failing to disable should be logged.

Dan


>   
>   	return ret;
>   }
> +
>   static int lm3692x_probe_dt(struct lm3692x_led *led)
>   {
>   	struct fwnode_handle *child = NULL;
