Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F23C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940A24658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/gCvQa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLMJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:58:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36510 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:58:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so1976381ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 01:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQvjoAIq1lwY1cihw0edTlVsvS4hblrvKhZLt2o7yRo=;
        b=U/gCvQa0C8fp3iVKJhx0vBUt0PKFuNFM6SSSB6ihOGiYf8DrW7iq+1YekeCTTxXOVW
         wA9kO32dpsd0uQM8TAz8UtneQN+P/STd9y7C3oklU8IKWKq4HLmauGD6BnpmZ7iDuZng
         SQo0ak1qNqQdQLAdjdJpaRZMNsmlbROrTck2PxWSMWA1pEXtJHWUll0tFoE44sU342Nf
         +iVXD4rDz2GqEaL+j34YCkxDq6MgJkT5saOWL12O+djrWRrzFUS/8TEWdE85vTOOgq0/
         p+FTg/6IfT6Yw6EICXB0kxMXmQY+b4urp1jV9t48Nuj+ruxYKT1BlDjg1hghnJZ+lVvZ
         t1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQvjoAIq1lwY1cihw0edTlVsvS4hblrvKhZLt2o7yRo=;
        b=Nc5Aa9TIm7J6xF+7mO2+qpdW6r7TRcReCLT+JvRtTrV9QR9ff1CB4y3VMl8Rzn8Vj7
         loBU8uOY2L1uVKuDIZ/KI95KptQlYwZKo5quKt/gzKXhJQo+7AQj17P6+g+mWzDiAtyY
         pKR6RmUI8DMEO2k+OxhDf7CQmFIgMHui55yO+qEpqvpN4EBeJi+ubnzTrnvPS2GcDZTj
         ikUkTkNNsOdxgnvf2UTr2jqUtoFpv9wXbGjxgHLt7T1ohsB/7IQaat6NieyPUHQQ1aNH
         fUrSSy7uN+9VST227/WWX2p8eLURdn1s2bPMdSt7YpasfF/KEYCZPuFP7OYtnnxIML6g
         kTpw==
X-Gm-Message-State: APjAAAUUEDBEGhMyaYkRfpnUz+pJ3dAWQfFapOwAvDruF14rG+Up1Yw1
        RP34Z2AfK+00qDFqjRaycMpcghJfbZE6F7rr1r7X6w==
X-Google-Smtp-Source: APXvYqzu8HOUUFv2+ceRlEgeqgx8XNvHnW+7dom4XrnAzRcH0CCbokozbEW15A+wcVH7XZt92FtVTGxMTi9B00CIqHI=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr9102521ljk.77.1576231085018;
 Fri, 13 Dec 2019 01:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20191204144106.10876-1-alexandre.torgue@st.com>
In-Reply-To: <20191204144106.10876-1-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 10:57:53 +0100
Message-ID: <CACRpkdb30kFbpxb52GALXJM67tFvJ8tR83NR+44PMOKJzJjruQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinmux: fix a possible null pointer in pinmux_can_be_used_for_gpio
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 3:41 PM Alexandre Torgue <alexandre.torgue@st.com> wrote:

> This commit adds a check on ops pointer to avoid a kernel panic when
> ops->strict is used. Indeed, on some pinctrl driver (at least for
> pinctrl-stmfx) the pinmux ops is not implemented. Let's assume than gpio
> can be used in this case.
>
> Fixes: 472a61e777fe ("pinctrl/gpio: Take MUX usage into account")
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Patch applied for fixes.

Yours,
Linus Walleij
