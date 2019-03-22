Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC079C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A0921841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WAMPAopH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfCVWxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:53:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39992 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:53:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so2471157pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=GncCQtYcc5p/mQeESC8imClqO96q5DmCNZNjKyO90V0=;
        b=WAMPAopH9DFo9aKieKcMIN8LiO2W2ahOoKivCdJYcM+ggw16+LJZ00FqWasHGO3v06
         mzU1Wvu1SvUVuCWY+Tk9m1h3pj3Nvk2UEZyXnRmwNolybffS1otEcZdK3Y8AhKxlpDH6
         y1awnnF4UwsnN5J0mWQmRLioqqoWQp1d5ozpySjZVIpS1RYuN8+cwJ0w/XvtPcV5H9Zg
         0+9agMpzGonsWc8tu0+f71tYKF5/5v/VV+3eFfWf+8LULpQ8bq6AX1wB/7QzRanmXqou
         wud83sCBbdUpUXrff+8wFFg1GzY6rEr2fcUXtOdwFSl3Swlub4HTjqX786QWdOofKVX3
         x0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GncCQtYcc5p/mQeESC8imClqO96q5DmCNZNjKyO90V0=;
        b=Yq86q+6n864NmYGsapfU6eP0fFfzaWNAuIdJU1duCAsJoCUzhbKlcK/dEsKSWUu3RG
         SOR/8b0f9tNhbuCpfmYmnwEXEEPWmPpwND+bBuqRRvzcev8MBnSLbnkHJlnfI4ytraz8
         JCBX2ThFll5qZETYFeMm89x3KhDd23hcsupoYd/gG1KAp7/4RB4L1soEY7ecYBrr9paV
         ZmFXQtOpCyx0tWJ5L+d327MOmqiXQlrn8s2lHcWqE/sbW7lY9fLYIhzokECHBcrrFvTL
         y+5UhEmbSgmeXigK70eJRW8SCfcVGZJmV6u14FmtfItPaRPalixmI3uKuvMTO+SY1I/Q
         jFJA==
X-Gm-Message-State: APjAAAUHbwP+P5p5iNbfIg17NeT8cWV9S+LpIch9d7CPc7RsP5oTx1H0
        TU9SWyZKROzExM1HS1ThqtF8xg==
X-Google-Smtp-Source: APXvYqyXNvTIfknnWkTEBq9VXhyBMnGstcX4kOkMOvcVuWkrGmqRtQ8+ooHUHbVqlr9zQGvbMgTxVw==
X-Received: by 2002:a63:4718:: with SMTP id u24mr11434186pga.381.1553295222193;
        Fri, 22 Mar 2019 15:53:42 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:6963:3508:5454:eecd])
        by smtp.googlemail.com with ESMTPSA id x19sm11365757pfm.108.2019.03.22.15.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 15:53:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: meson-g12a: Add missing USB2 PHY resets
In-Reply-To: <1553078122.7071.6.camel@pengutronix.de>
References: <20190304104916.3937-1-narmstrong@baylibre.com> <1553078122.7071.6.camel@pengutronix.de>
Date:   Fri, 22 Mar 2019 15:53:40 -0700
Message-ID: <7hbm2234i3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

Philipp Zabel <p.zabel@pengutronix.de> writes:

> On Mon, 2019-03-04 at 11:49 +0100, Neil Armstrong wrote:
>> The G12A Documentation lacked these 2 reset lines, but they are present and
>> used for each USB 2 PHYs.
>> 
>> Add them to the dt-bindings for the upcoming USB support.
>> 
>> Fixes: dbfc54534dfc ("dt-bindings: reset: meson: add g12a bindings")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  include/dt-bindings/reset/amlogic,meson-g12a-reset.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
>> index 8063e8314eef..6d487c5eba2c 100644
>> --- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
>> +++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
>> @@ -51,7 +51,10 @@
>>  #define RESET_SD_EMMC_A			44
>>  #define RESET_SD_EMMC_B			45
>>  #define RESET_SD_EMMC_C			46
>> -/*					47-60 */
>> +/*					47	*/
>> +#define RESET_USB_PHY20			48
>> +#define RESET_USB_PHY21			49
>> +/*					50-60	*/
>>  #define RESET_AUDIO_CODEC		61
>>  /*					62-63	*/
>>  /*	RESET2					*/
>
> Thank you, applied to reset/fixes with Martin's review tag.

Could ou make a immtable tag for this in your tree?  This is needed for
some upcoming DT users we'd like to queue for the next cycle.

Thanks,

Kevin
