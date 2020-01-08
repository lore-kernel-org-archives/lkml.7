Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9881C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05CE20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fmu2+rMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgAHI5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:57:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46776 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgAHI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:57:39 -0500
Received: by mail-qk1-f194.google.com with SMTP id r14so1907291qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txHGvTmn6wHXPp2oQOJpqKQj8noXhF4VbGKRGRI9/tU=;
        b=Fmu2+rMdGH01pAOFv9xENu9HKyrQuitINAws5ePHXdMU3xruGlysnG5rLwZfvug1bU
         dvirjyp/LKV7X2OHq9BL2qNsJ1a4/Y5qFIHU4vq3gZwbU8TZRVu/ba5u0Xzk3Ec5Q0Ds
         WW27qghCc4Qi/QUT/ch/sBr5K/mGcq3oOsx10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txHGvTmn6wHXPp2oQOJpqKQj8noXhF4VbGKRGRI9/tU=;
        b=E96kkWYmUVuqNW1MhtBEir/8O2bxMaPflKioe+2qhqoyUavqdwyhEtxqnuTY4BSr7K
         0ftybUMwn3WiE4ZLjGYsrV5NTMB2/6GH+1afa4Xj1HzSQnQtP8Wl7rD3xkqHW6rpIBva
         /uQXC8y0azcHvlqLgfiKkGrAKVkLvCwJV/SH4MZ1Vbs+SWLwiP6v75xkBiefb21tfl/F
         pg+aYHkci9I9BTtE09GlzQVhKkKlFZsS0EGAzF4eZje1d+xgxZZhQn0S0UoJHetD5Qtm
         9MP8L1GZ66BDVPrllJVAx3LxUYV3F+TIItkKxIiLHJdkLuQU7F4kjwR4R7WNyiBH3iTA
         Z64Q==
X-Gm-Message-State: APjAAAXv9Fs7pZ0kJJsVQKQJlY9C+xRcN4Zl9WxKCGYhgeP+H2O81Bcz
        3S+EU38exVoZ+xFue6OAQNFIQ6yFetvjV6ejoInzKg==
X-Google-Smtp-Source: APXvYqyxg+WXfWADIYH7mp/FamID6msEFLooGtjXHNkGMJ3b/HHH7fES5RiF7qjZJrTUVIs9ZocSgYGBXQI6iIPX6GE=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr3269467qkg.457.1578473858520;
 Wed, 08 Jan 2020 00:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20191227141405.3396-1-yong.liang@mediatek.com> <20191227141405.3396-3-yong.liang@mediatek.com>
In-Reply-To: <20191227141405.3396-3-yong.liang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 8 Jan 2020 16:57:27 +0800
Message-ID: <CANMq1KBaE0OimRaa2tiQQYS2irsaNQR_7O8RCWYMpTGnnYNYEg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: mt8183: Add watchdog dt-binding
To:     Yong Liang <yong.liang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks trivial.

On Fri, Dec 27, 2019 at 10:25 PM Yong Liang <yong.liang@mediatek.com> wrote:
>
> From: "yong.liang" <yong.liang@mediatek.com>
>
> This patch add watchdog binding documentation for
> watchdog on MTK Socs.
>
> Signed-off-by: yong.liang <yong.liang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index fd380eb28df5..3ee625d0812f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -9,6 +9,7 @@ Required properties:
>         "mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>         "mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
>         "mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
> +       "mediatek,mt8183-wdt", "mediatek,mt6589-wdt": for MT8183
>         "mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>
>  - reg : Specifies base physical address and size of the registers.
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
