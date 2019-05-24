Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94076C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F10217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cvl7JA+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390903AbfEXLYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:24:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41345 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390654AbfEXLYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:24:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id m18so6911379qki.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJOfEs/MqDUbj+5GWfxqoTL+Bnu2gJiCCqBKbfD1wrw=;
        b=Cvl7JA+e+AVFmYWhu4jfB9IBFJMs3UrJuQAHr8G84WfcFbHYYdnqNhSCTe+ZtcSnWf
         rzXWKMc6HTAUDclUVjYUUww8hXPFS50T6YXTCSLdGrNaqWPnMnrQxAd6MoOgU6DzPuz5
         BrMBv068cpA54YqwABzC/8gwXnsigRRsGM/gtorFnLkDK+whFy50WUW8FVR57zy4AWE+
         kNzBR+1njXc1ImbB9goDKdUvjbNPZcXF7yDvJb3YZUZUR/pYPtQiNXXfqiow8V//vFpR
         KfTsSDiGsVVBdvgCwXal2d90XQF3X0YgmERFZmDMipobhdPM/xt/Xtu2BfXtCE7+LitZ
         GPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJOfEs/MqDUbj+5GWfxqoTL+Bnu2gJiCCqBKbfD1wrw=;
        b=e4aTHaeUAgc0j4qqnOFHnfsEcoJKOEoDrDPoHN0LY9k81YWCWR3kPF35LhdCrGCgM1
         WWVRIQ/KnhJaxD5M1EbYgvuWkcYltdQWc+/b4XjHdqaoHVZt3vSbagfLKt3NQXwp4bL/
         7u32eVeMqy5YpcpcbjUUoa5WGM7Bdyx07+KKbgdV224jYdRFrJOMsfpOyOMwmGXJLcYF
         FF0oWPpFrdpWIR8Z1IUU661n7q2r0pVKSCXCVbEbmLNqYwEQfZqx88Nnk3P6WQ1KbRlS
         DmU8VsZJmAXgJH/Z8dRNOHlcYFsnOhHNRrajxH9PEmYRVjzJzVeCmcnmO2foUc+P6Kf5
         j+KQ==
X-Gm-Message-State: APjAAAXSs4o2QlAXq7szLdqW7sCZni2Z0xA6PK6a3KH8iY+40xouItim
        Wk/rTerZC+cwVPJwLgV24/eegCZSZZvW6RU1Su7Frw==
X-Google-Smtp-Source: APXvYqwdg7Y2VtK6CWVYHgo4gTEBhE8cGin8YUEKNu+EbS+93jSoldSI3JTfoxGuJdQANtMMQQ2lmSxsjjO2/iAmeuA=
X-Received: by 2002:ac8:2291:: with SMTP id f17mr33453092qta.51.1558697090303;
 Fri, 24 May 2019 04:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <1557474150-19618-1-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1557474150-19618-1-git-send-email-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:24:37 +0200
Message-ID: <CACRpkdYgTbTa6RmM3y-myk31ZxLGZ+8KvLof1XHkockrX4tofA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: stm32: add suspend/resume management
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 9:42 AM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> During power sequence, GPIO hardware registers could be lost if the power
> supply is switched off. Each device using pinctrl API is in charge of
> managing pins during suspend/resume sequences. But for pins used as gpio or
> irq stm32 pinctrl driver has to save the hardware configuration.
> Each register will be saved at runtime and restored during resume sequence.

Both patches applied.

On the same pinctrl devel branch is also Benjamin's patches to support
the "link_consumers" property on the pin controller descriptor to
enable links from pin control consumers back to their pin controller
suppliers, especially important for STMFX.

Would you please check if it work fine if you turn on this feature
for the SoC STM32 pin controller?

I am working a bit on refining the patches, so I want to enable testing
with some SoC pin controllers as well and possibly make the
behavior default.

Yours,
Linus Walleij
