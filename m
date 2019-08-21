Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BB6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2D022DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I5S/d4SZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfHUXcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:32:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42677 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:32:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so2212268plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VOlbPmuVW0UlC0yrc6l1Ece7msX8P0YAAbmbTsWvE6k=;
        b=I5S/d4SZjPzdz35NUNswb6iBNJ1AWdtObOn29esBipz+R87RKlEolWGL6riFl7CdOV
         v1NEaRIWpbg7yCKlvsJJSkUcW3Xb1xklCcNQybKSHF007ns/7be30rF1DN3YAUz35U4f
         i/zyN/1KpR+RXnZmlwJhYVsU5GhVYTKAbpabjj6d7PAZzcah4i72+1r8SmP5zOW50ATv
         XEA34X6ob5jY/85TUuVDf0cM/l/DQsFEo5kVfHSUmKlSefvJTy2OhvCUjrg5nylofRvt
         I6a2krbyCliXa9XlsJdnoCgTDwSCLGs3ZurtnIOhu5zNbcftg/GNBXwHJqpYemrj2p/h
         jQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VOlbPmuVW0UlC0yrc6l1Ece7msX8P0YAAbmbTsWvE6k=;
        b=ZmHSnq8zgbIDco4EQGhQUXzRi91anBqfsBw/hP0e3h4rBeQ2WbmrnRJXCrZk+sSTNI
         eAvUP8/mEZPxWbu6LUypPtP1Lyf1BsvNr5giHBOo0AtIeH4RXOItmWDNaXuaSCe3c/4X
         BhwVm48Kh3x+1th3VTvVsKzxdfsJ8rvEwKKWQ1CvNqL2LXGonHFdfXCRAllnxFMPg/jf
         wOFaXT1I9hS7kv2CkXtHSzPSNT8J5UGwQSLTtzlxAYxszBqheZrSWVOv5ZqmIb4i9l2q
         1Pi+C8HqTjw8kCStKEC64ZGKIyOc7Ft1CQ3vho2hu3MPipxZD0l8QhfKRwRURRs53tsJ
         kXwg==
X-Gm-Message-State: APjAAAUHUlfggS/TvM2md25gRKKrUNvb8BM5STmWVFv3ECJK7USMn2tc
        1Vb78+Onlk4hZU3zcnp7wCFOmg==
X-Google-Smtp-Source: APXvYqwAlor0zKX5PdZk/Ir/r+5HEyYcJpkCr33V81VSFu+AJaD46KXgavZ3ATTtWp9OBJZXEvZwsQ==
X-Received: by 2002:a17:902:a715:: with SMTP id w21mr34596141plq.274.1566430319944;
        Wed, 21 Aug 2019 16:31:59 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e13sm30367654pfl.130.2019.08.21.16.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 16:31:59 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: meson-sm1-sei610: add HDMI display support
In-Reply-To: <20190821114121.10430-5-narmstrong@baylibre.com>
References: <20190821114121.10430-1-narmstrong@baylibre.com> <20190821114121.10430-5-narmstrong@baylibre.com>
Date:   Wed, 21 Aug 2019 16:31:58 -0700
Message-ID: <7ho90i5c41.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Update compatible of the pwc-vpu node and add the HDMI support nodes
> for the Amlogic SM1 Based SEI610 Board.

I think this changelog is out of date.  It's not doing anything with the
VPU pwrc node.

Kevin

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-sm1-sei610.dts     | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> index 12dab0ba2f26..66bd3bfbaf91 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> @@ -51,6 +51,17 @@
>  		};
>  	};
>  
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -177,6 +188,18 @@
>  	phy-mode = "rmii";
>  };
>  
> +&hdmi_tx {
> +	status = "okay";
> +	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
>  &i2c3 {
>  	status = "okay";
>  	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
> -- 
> 2.22.0
