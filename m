Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43AD217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeDnWfW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDKNaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:30:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38648 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDKNaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:30:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so5519914ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMchqb7BY0JMVPphAc4y2iitLcCREK1jGIQuC8/M1ns=;
        b=CeDnWfW6BC9LkPTuS6cYd4lkHVVmtGEFtpZHbj3YqP1ZqdMVxt+rC51GRs1JLYq2ZE
         N4B4rj1pvINIf65dMtB4SlwiT0UdqIsZy0guPCwXT6G6SNgek8Eehtt8eqUzxYbD3DsC
         8i+HK1DyY79BvawReyV6uQ25U/NRFHFT2j/38CkXcq3WESd+J4kGNUeBjy0CMfMlMgYd
         1AvGuz5/dla69DBaRzF/YvvPF4KGCyYAyiLmGL3EZ1pwgbZySY11P6xpD35IGk/RrajI
         058FgWfM26wYjRuQbqiFQytK0hi5xZ/Jy7nG7mhbPq1eqrmkzeOIlrVG596x0OwgWcxe
         aSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMchqb7BY0JMVPphAc4y2iitLcCREK1jGIQuC8/M1ns=;
        b=fmsGLnh+zIZoS8vc0/EkD+zN6/JH9xiZgdlXCt1OajtmeCgrrSkvVbqQV4YcZSBN71
         PU6JmdYkIfNlbesqj7AS9RzoZcfZmm0BaqL3oO7Vo/Kb6lI9YGRyjNJWAJKidVpMlBqB
         +KtdHCeSZUzwDZ7aQmhM5HaEXABa5YL2Oclf+PFF9XWH1QaxjVepPPGFM2/CW9GaJPYn
         XiekvnY86GSZhshhKydlbaxWwal9cpJgkY9AV+cKZ7nuBLet9e+KcO4MIwdgpd1OU+3t
         v4Xw33lYq8WN8dVqUrylsthEyaAOFJWehyuB2sUxeYmVU9NDspJGkqUUU0ajvWrk2PWO
         WfPg==
X-Gm-Message-State: APjAAAVHXH+qWvu7XDv6B4xSAMg/1X3KsFZJy3XsyJfOrj0F0scAEbeD
        p056qSdYj700mYKD1LHPPJjTH4znn4v17QPkDRrogA==
X-Google-Smtp-Source: APXvYqygphzulI6pEs5jivVL63O3ksK7ygE0g7KyKn8TRJQmvZT+Pj1KYlFi7VjBHee0PAWWFGpiyLjNBThGBkfemyw=
X-Received: by 2002:a2e:9a46:: with SMTP id k6mr26251257ljj.119.1554989410617;
 Thu, 11 Apr 2019 06:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <1554794651-6874-1-git-send-email-amelie.delaunay@st.com> <1554794651-6874-5-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1554794651-6874-5-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:29:58 +0200
Message-ID: <CACRpkdY8-JZkbKGx_vEwhqWAozH1a_pB0W-wULJoYizzBxPMBg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 9:24 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This patch adds pinctrl/GPIO driver for STMicroelectronics
> Multi-Function eXpander (STMFX) GPIO expander.
> STMFX is an I2C slave controller, offering up to 24 GPIOs.
> The driver relies on generic pin config interface to configure the GPIOs.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

A very clean pin controller/GPIO combo.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
