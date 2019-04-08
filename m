Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDA7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21397213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcfzzZtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDHNHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:07:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34224 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:07:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id o199so2325073lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AyWKrT0NuvHSYj7C91aK7wR5Y+FA1C/FvU7EnCeP48=;
        b=tcfzzZtGPiGRqVGNPEDTrH+hICLknnt8lyY7JmlytyxS/fguhjvjITAkCC7PkguApq
         MFv6tBpZVXKZPAEy8nga3NJY11BcFtim4y7jgpIIgNXXq8UD9SlRsclsq2UsibuaE5T0
         9EYetbDu0cEzYG5s5JJmO9ka8343ARYel8vrZuYDFWvNdDB4A3KX8FNedhYrh0Apjbcp
         YqDqzEHUL+0Bu/0Zbo4VHdQtCzQzvzjc4gCPUdDQOrptl8CaIelsZ7J2MZRCe4pKk0qr
         yMTuEWo2x/2BdtHK+IdCIEPUCouVSKqV+8P/re6zTD9DzaPBJZMfMlmPCUljelVwMpev
         Z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AyWKrT0NuvHSYj7C91aK7wR5Y+FA1C/FvU7EnCeP48=;
        b=cYiZfxz2pXikT0WL/jKtLayb/wcWh50edxbrrksT7km9E9+0PME15b00007aSYl0Lt
         nvVivL41cPGRRnGpcAbEaqOeVdQWNZg1qZuiobilSYMl6i6Eoes9BNJ+3r+WTkV/w+Bf
         +6HE8V5ATlGjhwgKFJIJDWanj4+OLIo3/VdQ74b8u9rdJwMQG7C5mggGzUgKbpCQlGKK
         xdpcEJjN4Cgl5BsvYsWWDe3QwFsbLYHplWSta3fzulF3bIIIK3xuBj7VYyrZrLzi05nW
         ORPmtxgbZ/fce0f1ZhRTHSsiolQHfpKz7k+NTRTAlwuzuBd+uyyS5f6LrWDPv5L7kSOE
         27+g==
X-Gm-Message-State: APjAAAU+dc9766HPTxaxl2CffDJTmXJG2VPeU/kcqUWRtFIoi4/kPhQE
        /ABHo5FHO6QqHgmS8OfzirDTzCg5qJBDRLdm2i4stA==
X-Google-Smtp-Source: APXvYqyYYCE4/Ks6czxKLdL0dVVnf2FQbH1agfmCMWG0srCdnxXgM859ZaP1jzXfd8A5h9d/zgxhwzlxf6tNhkpgIxc=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr15564999lfh.103.1554728824187;
 Mon, 08 Apr 2019 06:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <1554298852-9955-1-git-send-email-p.paillet@st.com>
 <1554298852-9955-2-git-send-email-p.paillet@st.com> <CACRpkdZ9evBnvnmidQ2VW=dPUdGBM4Pkzo1VyMfDdQZFe6U7TA@mail.gmail.com>
 <5CAB3DF8.7020505@st.com>
In-Reply-To: <5CAB3DF8.7020505@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 15:06:52 +0200
Message-ID: <CACRpkdY1Vd_xDgoF8NaJ85Dy+ub0-GPTdU9sttB5uzmJnRXw2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: stm32: add stpmic1 support on stm32mp157c
 ed1 board
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
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

On Mon, Apr 8, 2019 at 2:26 PM Pascal PAILLET-LME <p.paillet@st.com> wrote:

> > I hope you are not trying to work around a bug in the driver by
> > stripping out DMA configuration from the device tree, because then
> > it is probably a better idea to fix the bug.

> This is not a workaround. The PMIC can use the DMA over I2C bus.
> Our goal is to avoid using a DMA channel for a consumer that generates a
> very few traffic. Dma channels may lack for other use cases.
>
> If you agree, you can add the to the commit message.

OK I understand, then also write it directly in the dts as a comment,
so people understand why it is being removed when they just look
in the device tree.

Yours,
Linus Walleij
