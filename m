Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4997C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7J8siA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfCYHyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:54:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33282 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbfCYHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:54:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so8954814wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YyUYCfnhSk2r5n7LaaJyStQSJS9igmkG7hjNDVuQbFA=;
        b=p7J8siA3JHb87Ktj1uYFYTf6kGtkn/uvp8c8fyYZIcktVp9EQrptiL9Lmj7qH+g44Q
         qlI5usOxJEsXR4tXqDuj/3hLNzJZmf/2SSsfWdwWzeGLiGv0TIhaHcmZPv6yDHSrzbxF
         JufsH/5lr82Nq6hiUvggtrCFBTRxlhrRbCqkuFO8/71Eb4uhi/FSp+Dh7hkDPWDeqKg2
         ygocrmypSUAVxndtoiAIQVQDUV9lOgYLrgetxelXUiwFfrcoXmeNEee98pEHcGEvLuZs
         X/J9TL3zZRyB/5cruGDxMxdWOlIGRO+b1NdSOYUHxqgxD+uYZbMTz4R++QS6OBoLfC5S
         J3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YyUYCfnhSk2r5n7LaaJyStQSJS9igmkG7hjNDVuQbFA=;
        b=n6zd8SLO7gUWcBS/iyiv9NkOAZb4hGVu/8tLLqjuhhDNU9+elBqE9gRT33XedokuWI
         1r7aSbkVyku3Em41lsI+SGWTFoRPdpwGUIHrX6nTQp9d1TqNdlv20IJFj5Lwtk6hDlpb
         XDt/KOxsWNkuNucbVKZtw+FOXGdShorCDdy7TeGYgDLUjb8Weh4ke3zYqW9hYICM1lhp
         7iB69/c9Uygni5N1lPNq+7kEozD4bR27pwMzed/uXmKBotoqNUyMcK3CGfUB2ZH/mpvh
         hpbSe71IL4kIXhL2bqG6OaCJB1zPEw4lCBWziQErjdcDzXHBGmSg2qOfirOEx8M5RCQq
         hCTA==
X-Gm-Message-State: APjAAAX4OV0l4J2asz3roJT6ldsVXPNjVp8LgWbIpnJkRQiq2LyV+fB0
        uaiqJHiE5FJ/sR9gvQgxbBvCbw==
X-Google-Smtp-Source: APXvYqyQnT6B6Fu6amjP3aDn/fCnRS7nivqP0IkcHnYHJ4GFIZsYyHTIxNJD1yFao71vrac6aa+43Q==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr10992727wma.35.1553500442663;
        Mon, 25 Mar 2019 00:54:02 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id y1sm36907228wrd.34.2019.03.25.00.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 00:54:02 -0700 (PDT)
Date:   Mon, 25 Mar 2019 07:54:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
Message-ID: <20190325075400.GX4731@dell>
References: <20190321142838.22985-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190321142838.22985-1-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Dan Murphy wrote:

> Add the lm3532 device tree documentation.
> Remove lm3532 device tree reference from the ti_lmu devicetree
> documentation.
> 
> With the addition of the dedicated lm3532 documentation the device
> can be removed from the ti_lmu.txt.
> 
> The reason for this is that the lm3532 dt documentation now defines
> the ability to control LED output strings against different control
> banks or groups multiple strings to be controlled by a single control
> bank.
> 
> Another addition was for ALS lighting control and configuration.  The
> LM3532 has a feature that can take in the ALS reading from 2 separate
> ALS devices and adjust the brightness on the strings that are configured
> to support this feature.
> 
> Finally the device specific properties were moved to the parent node as these
> properties are not control bank configurable.  These include the runtime ramp
> and the ALS configuration.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v5 - Moved ramping range to below property definition, updated keyboard label -
> https://lore.kernel.org/patchwork/patch/1050412/
> 
> v4 - Appended "ti," to TI specific properties, add enable gpio documentation,
> removed an example, moved ramp to optional parent properties - https://lore.kernel.org/patchwork/patch/1050122/
> v3 - No changes - https://lore.kernel.org/patchwork/patch/1049026/
> v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
> added ranges for variable properties, I did not change the label - https://lore.kernel.org/patchwork/patch/1048805/
> 
>  .../devicetree/bindings/leds/leds-lm3532.txt  | 101 ++++++++++++++++++
>  .../devicetree/bindings/mfd/ti-lmu.txt        |  20 ----
>  2 files changed, 101 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt

Same for this patch:

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
