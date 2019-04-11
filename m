Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00985C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4191217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poDHCcir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDKNcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:32:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40312 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:32:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id a28so4723409lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvSuYyh6IKBEj54FFCtw6W7UjqwtB1CXJsCRn+E+pGw=;
        b=poDHCcirbQv0Ydxb9B8Y0kJjroHTkglNGRX9V7PrXX5qAiDRxul61bGRvdreuA3vDm
         i5gSa/Hz2dz8DsZVroN7DbQe3PjnN31070Y+eNrQzZRKkhlWEdo6awG0XKknON79hMdX
         Gtzzdk0Aw5S2/vIA/yJcyEZbQqNI21hkhf4Hnhz/awT0kpJ/MeKwMHDOi/k5IkG5kMSP
         MNSzY9NKRo6u/HdOgjOQB0NkOcHHzi4OL4V92M6vJY28YWLjf3mu8lH97PQSpHevW42N
         r0UsvPf/+dAF3HF+jSXgjce3iqvzzcf0wSj9p1/2qqnPcz9Nnci5ba8W/EXWqGO3n3VS
         33QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvSuYyh6IKBEj54FFCtw6W7UjqwtB1CXJsCRn+E+pGw=;
        b=DN5IYsMmTlviTUk5k6sNg3csCvxZDQxgRBvxZUreevZB/rFZ2ASX9CNBusuxuOtlFV
         HVWPs1B9p7OJKOosRQvg3Afi2M5NYLj3tIYA/2QJaP6wB1PDDiU2dpohnhMT539YmVMz
         ANNEnD2L3yfALcCQfkAtNIrFU2FbJO388J6CW3IKB/b+/uqPHD+iTNn2p2KeRy+VNl5R
         wOTBTiTk9hHcL1L3ovBPGL0xXbOLIEtgOz4/Yc2d8nUqlUuqR1/xM011vsAWIHIsP8Gm
         YjPkat1HvaxoNCTKappKq+7ocZdRuf8KKTFOak7Tvsb1HIM5uQ8WZkvaZCCrBTCcGUcQ
         tqOw==
X-Gm-Message-State: APjAAAVPcnPA5n7aRjqS5IWRKyq8L45pV6tivSYLaugs+NADfPAiW7+A
        WTd0c1esCH5fvC/RUIb1bQ3ZMDFQJs+eYmSHlkeV/w==
X-Google-Smtp-Source: APXvYqyjmHv/mGR/RqOhp+RKnOxwRCUtA9yqbVi0pL+gjI70u0xxHQTtGuInduan/H6y5j+/15DqnTbQJvrQ377Gw+o=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr15580332lfn.121.1554989559272;
 Thu, 11 Apr 2019 06:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <1554800820-5412-1-git-send-email-p.paillet@st.com> <1554800820-5412-3-git-send-email-p.paillet@st.com>
In-Reply-To: <1554800820-5412-3-git-send-email-p.paillet@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:32:28 +0200
Message-ID: <CACRpkdZnjA+6yXw-23AMe4FUCtWzdToaa7ebRCwzu1anQyhTzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: stm32: add stpmic1 support on
 stm32mp157a dk1 board
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:08 AM Pascal PAILLET-LME <p.paillet@st.com> wrote:

> This patch adds stpmic1 support on stm32mp157a dk1 board.
> The STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
> regulators, 3 power switches, a watchdog and an input for a power on key.
> The DMAs are disabled because the PMIC generates a very few traffic and
> DMA channels may lack for other usage.
>
> Signed-off-by: Pascal Paillet <p.paillet@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
