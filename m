Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A21C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEB2222C4
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkQ8uVS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfCXPNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:13:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39543 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfCXPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:13:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so4629899pfo.6;
        Sun, 24 Mar 2019 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+n6QTGQJ93zGphnQyU0PQWmAvWF8oq50ZxPtUQ0dAgE=;
        b=qkQ8uVS4GXd0ddF6xrksCG6geQN06Kxmi6w5Jf4el1wrHnzVt6bj4Yl5eMCRgg2WiA
         8vgkEwcSkdE+ZruYmh4Ck5xM5xmVJCenn6uaWIs3x+8tx2gwfof6xgoCvata1wkbGWqp
         nnD3BWkltmVr1y8vrayUI96rBO06VJ1APfsm7PP4osXB1o3E8X+jGFFZUCXsEdmJVuC5
         myvX6TlUMbmKeviY/jhLJBuIROqoqu2muCbLJkZKX0mMrlrgbr3dOwtzhh+g6J+SmK8Y
         ia47dSVPpdim8lApzMmwdueYGtsLazzFQA+tDzaj1NBDrgZKIV4RWmGQjM+WDwjfRyAW
         lpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+n6QTGQJ93zGphnQyU0PQWmAvWF8oq50ZxPtUQ0dAgE=;
        b=UbXyHl1sXnPz1C9mIeOArDrjbvQa+FuDLbd5afFsnHIZgaNwTEgEp2xjGaKB4d3uE/
         0BZAOe9INercZ1bszlHrxWaaKCJN2070a7Xcjy8DgAmhJqy7nAhFRAZMM7n8PIbnDcxv
         35FWUkr2hCtYXNLk+H3CskrPNo4drbIhqkSMOdzZrjv7lk0XNeuHBcwRyh4HWoZ9O++1
         oirqucfklK2gdY6em/Ms/FUB6bnhW6EnEElS4GU8lwTvJGlo7q2iwzNr/FzIi6M4BnOI
         SbC973tb8snKLikpYEzWCso2/RK1BV1n9fA1H052lh1xQITqXHLogAQzyjmuZ92yozZc
         Vfiw==
X-Gm-Message-State: APjAAAW0JVteivyvO54KsyeVwOpA3eFYEb3tw4eyDffbrY0HBbFxNcAM
        bHe5f3o6H0aJCOXuPD7340Q=
X-Google-Smtp-Source: APXvYqwwqmO1NPvoD24xPJBRcSkbKmTjJGTzXb8U4CB2pdvanIyho/2KOUinZTZV6EOah2xvuJQC9g==
X-Received: by 2002:a63:d209:: with SMTP id a9mr18921041pgg.341.1553440429448;
        Sun, 24 Mar 2019 08:13:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2sm21427841pgq.29.2019.03.24.08.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 08:13:48 -0700 (PDT)
Subject: Re: [PATCH 17/24] dt-bindings: wdog: mtk-wdt: add support for MT851
To:     Fabien Parent <fparent@baylibre.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-18-fparent@baylibre.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <741058cb-ef57-bda4-9d36-d7295fab9230@roeck-us.net>
Date:   Sun, 24 Mar 2019 08:13:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190323211612.860-18-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/19 2:16 PM, Fabien Parent wrote:
> Add binding documentation of mtk-wdt for MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 8682d6a93e5b..fd380eb28df5 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -9,6 +9,7 @@ Required properties:
>   	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>   	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
>   	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
> +	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>   
>   - reg : Specifies base physical address and size of the registers.
>   
> 

