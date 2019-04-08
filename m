Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B87421473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIB4GYEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDHMFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:05:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43090 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfDHMFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:05:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id g7so9248172lfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJtTmQUD69eF2N2bxKRy7w8TaZOqSQShIHyAx5b0WZc=;
        b=rIB4GYEsqXgOIZ+UE2Q+i7r8m2kyGT5rKuDJMpt7ZcHosuYdcemOw8BwftLr3uOMaU
         cBRfCXe4tOdNjvM5taoivPhg3bNjbVQkV+BF7weB05S0Ywi/wf7/PwPR9AKyuoT/86+5
         cCQEDkdD6W6yxaOVNVFCPW5fCrWRKueRueez3OOynnQeanMY+cCMu8VxNeIOUpxuTfV0
         /70EODqsb3b0khCQl4UlpjJ6YlJf5bmBfslr5OE4zHww8sEJsCoESIQSL1j7u/GDyu5U
         YWPo602qjwCOOU625CE7MAjhMj6iageVJT2//ZavaJYvRG/NG644pp31ttNia+0jvj4T
         mS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJtTmQUD69eF2N2bxKRy7w8TaZOqSQShIHyAx5b0WZc=;
        b=dpBgSiBEtGwYsymwdrAtTuN7nfBQz1SrYuIu54aFCRulNCcPN2rNzFEIkC3QLUTEll
         trlz2JCkfs0KmxUx+MFHXKeM5wlwTZEraUxLubi9S2Qbez8PPKsh4FAHUBdZ0ku05wPh
         kCCVkZU6NkWwCHii8BcsPqvHoZSe/7HB1G+HYnIs4wPERMWCpQckc5VVO4kJynSFXCxw
         ayguLS4eSs0jtZgsgthQkGbx2VoiUA0J6FNO+bObm13gIpiahI2/xs1zv3MPr68T188q
         yMrRACnZ0THdrxvaWHpdY8Bc1q/AB+Sc2xbkdbFRrLtYIb2SPTPC9nAseDqtwqvRARNt
         KR6A==
X-Gm-Message-State: APjAAAWFsjQcb89Qq7qhDxyFoxMGaL/RMcAT1YCpFpg8V5SEtI/log/1
        /50q6CjTUnnL+4fvG6ntZBdeGEwfFB/0I6O7Ll8q4A==
X-Google-Smtp-Source: APXvYqzT+Po/qVlgVIbeRCtIY3RHbLTvZgcN7dRxXmhKSLdpNLu229haeeyGXRY9Wjsbs3tEaAI7/nPH/XTfknfmLZM=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr15382311lfh.103.1554725121787;
 Mon, 08 Apr 2019 05:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <1554298852-9955-1-git-send-email-p.paillet@st.com> <1554298852-9955-2-git-send-email-p.paillet@st.com>
In-Reply-To: <1554298852-9955-2-git-send-email-p.paillet@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 14:05:10 +0200
Message-ID: <CACRpkdZ9evBnvnmidQ2VW=dPUdGBM4Pkzo1VyMfDdQZFe6U7TA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: stm32: add stpmic1 support on stm32mp157c
 ed1 board
To:     Pascal PAILLET-LME <p.paillet@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:41 PM Pascal PAILLET-LME <p.paillet@st.com> wrote:

> This patch adds stpmic1 support on stm32mp157c ed1 board.
> The STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
> regulators, 3 power switches, a watchdog and an input for a power on key.
>
> Signed-off-by: Pascal Paillet <p.paillet@st.com>

OK

> +       /delete-property/dmas;
> +       /delete-property/dma-names;

Maybe you can add a comment both to the commit message and the
DTS file as to why you are doing this?

I hope you are not trying to work around a bug in the driver by
stripping out DMA configuration from the device tree, because then
it is probably a better idea to fix the bug.

Yours,
Linus Walleij
