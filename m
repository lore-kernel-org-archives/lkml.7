Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F5BC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B83B206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Iq5j8cXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfDJR7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:59:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41934 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfDJR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:59:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so2550637oie.8;
        Wed, 10 Apr 2019 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tzr3rEdrvu7VkWFExmY/yj5g2tkhcJNdoL9bLb2rWmc=;
        b=Iq5j8cXfjQYpFcTlrEyKBE0/Fd0H+FfPBdggiMagMblnQ0n55PGceiQM52IAfvJCtT
         7E/t27C1eiASs4KR0C27VubsWktMmfnYohL6KXuLZgWjjeYuAABQ576odJyyZ70DRrG5
         hX+jVpZo4AYBz852WcAZvsS60C2U1+1yDtKhuk9nAILjvzkUf1eP1jO0RN+sK98YXkKV
         qL7z5nHKdAMjXVHvoSUdrGJKrHbARSt8lvFUPK04ZCAWZYeq7/2trrCZ68j7aSAMqfiN
         r5cWcHhhY9/71wkFtDiaFBCYfKXBQmbwmeXmjHAX9n7cTHw+P20lGel36JoRD1NWokeM
         H4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tzr3rEdrvu7VkWFExmY/yj5g2tkhcJNdoL9bLb2rWmc=;
        b=jEOW1TeWUZgI0cfmnFxTBrrAE8cnvwAPFZ2aGOcLZQRadG8O9/HnNCcHXyfrzlNzTI
         CPZbtJRwi0cNBXbwqBVPjvJpLTyOZllm3rSfll9y8Qnq9ilKGNlnbWageh68Mh2LInof
         Z8Lf1j4ENqyGSHXAbTj4cUmAkXmImr0NZgXRj4KQuLCC9u5xJy+6RBzFj3ayVQRV3aqW
         /ziuj8cMwC46cIwxY8rEnIXfmXW3uoMlh6K7Wv05NBgrBDl1qmAs1nPTs1/FpZjVqnoq
         ynUUClPCtR5frqFoOf0euUicTYYNuTnNTTMCMmASQXsSHnM7w6OK3h4cbOnt0aiexObF
         b6jQ==
X-Gm-Message-State: APjAAAVzZGFiGmP+aRrTj9dAkBFFD0UcMPaGMPL5PEEC9ygserqXw+8N
        uJqPaeFIIiD2isBX7uhLaE9OyeTrlykpZuMA0wY=
X-Google-Smtp-Source: APXvYqzHil5sGmhkf3rF0VnxRnRsbiC7CjXpbHcut3ueXny08klgusL5vpDGa3bWeLIzK3D8FsDzSXIypOpPz8pw5ko=
X-Received: by 2002:aca:ecd1:: with SMTP id k200mr3544573oih.15.1554919156366;
 Wed, 10 Apr 2019 10:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <a8539bcf66065380069676fbea99a51254309803.1554874961.git.chunfeng.yun@mediatek.com>
 <9f04a619e8a2cc44f5b1fe299a08f237f069d56d.1554874961.git.chunfeng.yun@mediatek.com>
In-Reply-To: <9f04a619e8a2cc44f5b1fe299a08f237f069d56d.1554874961.git.chunfeng.yun@mediatek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 10 Apr 2019 19:59:05 +0200
Message-ID: <CAFBinCBoQ6C7MrtwSctDgFPpXnaRVKm490piGOFmN2i2PV3GOQ@mail.gmail.com>
Subject: Re: [v2 PATCH 4/4] phy: phy-meson-gxl-usb2: get optional clock by devm_clk_get_optional()
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Motoya Tanigawa <tanigawa.motoya@socionext.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 8:13 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Use devm_clk_get_optional() to get optional clock
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
now also:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
(on my Khadas VIM by manually adjusting meson-gxl.dtsi and dropping
the clocks in usb2_phy0 and usb2_phy1)
