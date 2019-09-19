Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE5C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B6821848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mS/QIMJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfISG5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:57:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34943 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfISG5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:57:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so2593692wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H6mdaYx5irFz1dKycBPlcNWUBlWg7UpLZ2wQ0axK7Z8=;
        b=mS/QIMJUn2U3A4W3Ug/Cuwf6BQQLJeQlY8zoMtZLQ1w4OmgFQBHMsOi3krQgcdR8tK
         kzHw2mWT4Fxmh7y2NR/vE2MoPDBzzjcVFInGoHfFSu8lkyiQXV6x9n0rLsWuV4dgrJdW
         vEIZuqcgna2TwGxLbnRnJUsRzsrXC01AxZdbAIP9wRCbtwCEiQ2gpqX/MSlCiGGiELrz
         fe2M+TlNlvqzqskyucQE+CMm4pThbIhm6n9OjHQMh7Oyehx5vfN/b6MckvWZ3ZO+v1a6
         skFQtf/FwCSJfaC4RU5qJwXwpYHH8FwyCPME7rorNokFhNkcgPs/GtDjNr2JgPlJ7Q6E
         Ti+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H6mdaYx5irFz1dKycBPlcNWUBlWg7UpLZ2wQ0axK7Z8=;
        b=C58COUdVT7Ahd+M7Nj8ljMBqOjqTndBknAwBC+fQycuRvWjn+za5kY1rwOh6wTaRIp
         BQhjKRaAvwu7x5PJzEW6Q64ELS1/kS16Y+JwhfejfnqDGbi1q8RhqnsVNj2d8n1yrear
         jiZHffPUj0YLQYNHcIAdEHzaUC0PWExh2xo9j1XyiPB2scTInUtaX0COMpGM5CJ4ynIs
         tyGy55T/kO7J+Efhb2wizluyZsG2QZBs8QrBsXAuKY1itKQa7zEvaFMkq8EBbDBu216R
         I94Hvx8SUzMNv6xaEhuQ4t4M2ZEAAl0LighUmpH64yrT7BUJVW6C4aAcnUzGUKtAVudB
         PVcw==
X-Gm-Message-State: APjAAAV2cWgAgYEbke/60N2LE/Db0MlnnnJ8bvN/XoygRXvlyQvrNjJ6
        WOX/EvgF0DuQARhC+xZxQLOUP1ncon5LBw==
X-Google-Smtp-Source: APXvYqz6FGwaKbs4wUddwO8P8nj2r+dQVUlAjhvcPIaT7WYVNhNVIhcmuCCXJqGe6mqrfmmzPtUbng==
X-Received: by 2002:a1c:4c12:: with SMTP id z18mr1363862wmf.45.1568876233569;
        Wed, 18 Sep 2019 23:57:13 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id c132sm6485686wme.27.2019.09.18.23.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 23:57:13 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
To:     Xin Ji <xji@analogixsemi.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sheng Pan <span@analogixsemi.com>
References: <cover.1568858880.git.xji@analogixsemi.com>
 <e41d10504b7d1e977a1f53663c287e4e7d53011a.1568858880.git.xji@analogixsemi.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <446ff66c-8097-fca8-8371-9223679f16bb@baylibre.com>
Date:   Thu, 19 Sep 2019 08:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e41d10504b7d1e977a1f53663c287e4e7d53011a.1568858880.git.xji@analogixsemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/09/2019 08:55, Xin Ji wrote:
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI to DisplayPort 1.3 4K.
> 
> You can add support to your board with binding.
> 
> Example:
> 	anx_bridge: anx7625@58 {
> 		compatible = "analogix,anx7625";
> 		reg = <0x58>;
> 		anx,low_power_mode = <1>;
> 		anx,dsi_supported = <1>;
> 		anx,dsi_channel = <1>;
> 		anx,dsi_lanes = <4>;
> 		anx,internal_pannel = <1>;
> 		anx,p-on-gpio = <&gpio0 45 GPIO_ACTIVE_LOW>;
> 		anx,reset-gpio = <&gpio0 73 GPIO_ACTIVE_LOW>;
> 		status = "okay";
> 		port {
> 			anx7625_1_in: endpoint {
> 				remote-endpoint = <&mipi_dsi_bridge_1>;
> 			};
> 		};
> 	};
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../devicetree/bindings/display/bridge/anx7625.txt | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7625.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.txt b/Documentation/devicetree/bindings/display/bridge/anx7625.txt
> new file mode 100644
> index 0000000..f2a1c2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx7625.txt
> @@ -0,0 +1,42 @@
> +Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
> +-----------------------------------------------

New bindings should use yaml format:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/example-schema.yaml

Neil

> +
> +The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> +designed for portable devices.
> +
> +Required properties:
> +
> + - compatible		: "analogix,anx7625"
> + - reg			: I2C address of the device
> + - anx,low_power_mode	: Low power mode support feature
> + - anx,dsi_supported	: DSI or DPI
> + - anx,dsi_channel	: DSI channel index
> + - anx,dsi_lanes	: DSI lane count
> + - anx,intr-hpd-gpio	: Which GPIO to use for interrupt
> +
> +Optional properties:
> +
> + - anx,extcon_supported
> +	external connector interface support flag
> + - anx,internal_pannel
> +	Which indicate internal pannel
> + - anx,p-on-gpio
> +	Which GPIO to use for Power On chip
> + - anx,reset-gpio
> +	Which GPIO to use for RESET
> + - port
> +	SoC specific port nodes with endpoint definitions as defined in
> +	Documentation/devicetree/bindings/media/video-interfaces.txt,
> +
> +Example:
> +
> +	anx_bridge: anx7625@58 {
> +		compatible = "analogix,anx7625";
> +		reg = <0x58>;
> +		anx,low_power_mode = <0>;
> +		anx,dsi_supported = <1>;
> +		anx,dsi_channel = <1>;
> +		anx,dsi_lanes = <4>;
> +		anx,intr-hpd-gpio = <&gpio1 19 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +	};
> 

