Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D46C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E34222A0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QThEqdE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfKSO41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:56:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34562 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfKSO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:56:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so23683678ljf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=In1zGBDOC9xdynfqKqKcIIm3nf1+kiAaNiGZnanvLvY=;
        b=QThEqdE2rR48X8oh0OxwIbdEI4egtNMX2nLjCHAmFesH7XsOljlFWzkSlgEJCooM1o
         9oofv6OFX2+StOidzMwZkInUb1q7S3iYe1jGQBVRMnZfOgswcDhgDIWyKOAf1FCD6Rba
         XexJQjvzoZgk++lHzrQt26VgsTLJOx+TUHxlLHOeTK0MJEgCIpwHfRwVqJPlUzHxt9Zb
         /zQmjaHME4cmgDYw5AkgqfCHdJuboeYIpGoueKqYWs0vXtUAB+SkCD6YY4Fo0JRrpLh6
         H7lOZvbGvmSmFckDGq++HhacqpYwrhABTGhOFbyLnnmHLSRxvnwysAiHcwDZn8jbvU6f
         luHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=In1zGBDOC9xdynfqKqKcIIm3nf1+kiAaNiGZnanvLvY=;
        b=PUmw5oUmH2EGIHe0uQ82LjpFNEnOmeslj2dEYtA6sbf1V001cBbM4LESm4aWflTV9a
         e/3N/EqNi8qd8e5XCp1VZEn8gWfykLJ+8cBSVh8afYIJ/gtsOhOaAwYwXNAshHz3x9/Z
         b6EeF+W7Cy+HNfZ+SA3yHCDMpds7WA8cFfwIeEbv/HLkBZBohLKz2KTcQVTG37WQ9CeU
         MeF6flx2pYf4tXbxwWdnEeLmYmIhlzeijuxxoBp2MMhQeUEAfj8c52SVoPjlYDciQFmP
         DP7urgHMj5vqyg7teEVSW9nu1bhwD4g+V/fs1LNxv2KTu4dY0paWNSFXOd40Rq8AJ9fE
         rTvg==
X-Gm-Message-State: APjAAAURGBqTZoZUvtNJoyijSW5xccAgZFSHySjZstP5uC1RzVUGkKdw
        T00Z3VZqf7JSgttSREAoiMLNB7mV7BGQjIlKf7WxUQ==
X-Google-Smtp-Source: APXvYqwcjOU4MhPKyzAkwDWLM/doKxPzlCHlBi90UnHt7hoHtMGu2PLAM9oNBxpASzc6YLHCH2EH7pH6HA2mWJ6HL6A=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr4283993lji.251.1574175385648;
 Tue, 19 Nov 2019 06:56:25 -0800 (PST)
MIME-Version: 1.0
References: <1573819429-6937-1-git-send-email-qianggui.song@amlogic.com> <1573819429-6937-3-git-send-email-qianggui.song@amlogic.com>
In-Reply-To: <1573819429-6937-3-git-send-email-qianggui.song@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Nov 2019 15:56:14 +0100
Message-ID: <CACRpkdbQ08ivkyVnuy_+=YqHXcXQDUY8aOpp6evdGLofe3FM0g@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] pinctrl: meson: add pinctrl driver support for
 Meson-A1 SoC
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Rob Herring <robh+dt@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 1:03 PM Qianggui Song <qianggui.song@amlogic.com> wrote:

> Meson A1 SoC share the same register layout of pinmux with previous
> Meson-G12A, however there is difference for gpio and pin config register
> in A1. The main difference is that registers before A1 are grouped by
> function while those of A1 are by bank. The new register layout is as
> below:
>
> /* first bank */              /* addr */
> - P_PADCTRL_GPIOP_I         base + 0x00 << 2
> - P_PADCTRL_GPIOP_O         base + 0x01 << 2
> - P_PADCTRL_GPIOP_OEN       base + 0x02 << 2
> - P_PADCTRL_GPIOP_PULL_EN   base + 0x03 << 2
> - P_PADCTRL_GPIOP_PULL_UP   base + 0x04 << 2
> - P_PADCTRL_GPIOP_DS        base + 0x05 << 2
>
> /* second bank */
> - P_PADCTRL_GPIOB_I         base + 0x10 << 2
> - P_PADCTRL_GPIOB_O         base + 0x11 << 2
> - P_PADCTRL_GPIOB_OEN       base + 0x12 << 2
> - P_PADCTRL_GPIOB_PULL_EN   base + 0x13 << 2
> - P_PADCTRL_GPIOB_PULL_UP   base + 0x14 << 2
> - P_PADCTRL_GPIOB_DS        base + 0x15 << 2
>
> Each bank contains at least 6 registers to be configured, if one bank
> has more than 16 gpios, an extra P_PADCTRL_GPIO[X]_DS_EXT is included.
> Between two adjacent P_PADCTRL_GPIO[X]_I, there is an offset 0x10, that
> is to say, for third bank, the offsets will be 0x20,0x21,0x22,0x23,0x24
> ,0x25 according to above register layout. For previous chips, registers
> are grouped according to their functions while registers of A1 are
> according to bank.Also note that there is no AO bank any more in A1.
>
> Current Meson pinctrl driver can cover such change by using base address
> of GPIO as that of drive-strength. While simply giving reg_ds = reg_pullen
> make wrong value to reg_ds for Socs that do not support drive-strength
> like AXG.To make things simple, add an extra dt parser function for
> a1 and remain the old dt parser function for only reg parsing.
>
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>

Patch applied with Neil's Review tag.

Yours,
Linus Walleij
