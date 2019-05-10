Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD5C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD912184B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ci2xc1wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfEJVny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:43:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41590 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfEJVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:43:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so3601801pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=txyEEfuShyaKA6OU4S1C4qT56CSHhTHuadhhSgL/B1w=;
        b=ci2xc1wMaUwRzlapr3pHT3/06zeHBirtF8f8zIVeaDiEcqVmHzp8ogt2zKmtauZmmL
         VZg/Ua/ac6Wvtp5CoYM+tnC+aYJaIBAZL/I49GcWt47mNK4nhHSsjecPYnOitfIdasBD
         AYTR08ttwqYyE0Ej5rmdVDb49HkxqKb+WKnZ9TH0Y0zkn244hVP/WYmeoBK5CqBl2emv
         g/aKYE7jv5GV/ja1Evbhw35hjze33nG1A3FodYiHjFc19l124BBiEBJ9VqziVZ8Mqjzx
         qBdPmQfXE/QaAS4/STKAdR9UpbmC9z32yGxjaZ5yEj7OpwP5BmxaWMtk4pmQj6lcNOxx
         L6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=txyEEfuShyaKA6OU4S1C4qT56CSHhTHuadhhSgL/B1w=;
        b=Q8cymQ9ELMXYdQHphYFlkdtDE7SNUrJzGufbG7hVtk0sc1DrO17tID1Df026IbFbTJ
         eOJjwIQO/yTRVsFzjKAy66bjv98tQfOHJhmY1YlhntmFh2YMKqiRXk/CMb9Y6k9Ohu45
         PYEAxOxit+D4DY9IAl7KG7lJJv1RzxU/00ijpcSaikoPLJ9UHO+H115zb3jjfggjkI3C
         op5T7FCUh76ZxLAI42mZeZvPTyIqGtfVPI3Dy9Zcs4qMoN84QFrVhRnlBEWwEYFfWOsF
         UmX2a1dxD+qZMlt5NHuKREIxatQEIQJqw0VEmzOnmmJIVgghqzxrmvHmSS8NEJLyt6nb
         A0+A==
X-Gm-Message-State: APjAAAXpOPXUZN6vzInbnhfGHPl4tK3aB+lUunaLey1Omjx/hqW+rgeW
        veHWKUga7T1+oIdM8DqhvbfbIRdTTde/gQ==
X-Google-Smtp-Source: APXvYqzRCjmRJjSzsDwGBlbaEZrNsuy1m6VB19YK4Aid076Xs8KZtDoj/OsSd8Sa+55YAvxnj8ibsw==
X-Received: by 2002:a63:a449:: with SMTP id c9mr16552136pgp.149.1557524632125;
        Fri, 10 May 2019 14:43:52 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id j189sm15075590pfc.72.2019.05.10.14.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 14:43:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: meson: sei510: consistently order nodes
In-Reply-To: <20190510155327.5759-2-jbrunet@baylibre.com>
References: <20190510155327.5759-1-jbrunet@baylibre.com> <20190510155327.5759-2-jbrunet@baylibre.com>
Date:   Fri, 10 May 2019 14:43:50 -0700
Message-ID: <7h4l62dlyh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Like order boards, order nodes by address then node names then aliases.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12a-sei510.dts    | 92 +++++++++----------
>  1 file changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> index 34b40587e5ef..61fb30047d7f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> @@ -14,10 +14,6 @@
>  	compatible = "seirobotics,sei510", "amlogic,g12a";
>  	model = "SEI Robotics SEI510";
>  
> -	aliases {
> -		serial0 = &uart_AO;
> -	};
> -
>  	adc_keys {
>  		compatible = "adc-keys";
>  		io-channels = <&saradc 0>;
> @@ -31,13 +27,8 @@
>  		};
>  	};
>  
> -	ao_5v: regulator-ao_5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "AO_5V";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc_in>;
> -		regulator-always-on;
> +	aliases {
> +		serial0 = &uart_AO;
>  	};

minor nit: I kind of like "aliases" and "chosen" at the top since they
are kind of special nodes, but honestly, I can't think of a really good
reason other than personal preference, so keeping things sorted as
you've done here is probably better.

Kevin
