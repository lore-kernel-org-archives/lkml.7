Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95BEC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C92218DA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chfL2Y+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfGCAmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:42:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44026 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCAmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:42:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so441897ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uy9P4Bv7MoU15f1hxa9HUk41ddeWB4vxhHhX7nu5AF8=;
        b=chfL2Y+vcu0HLio56W5yCpYcO12fzccTTuvBbkGhkNe/aF5ZgcfKOE24xS40HsFMlc
         Ut8Bz0uCuff4zpfBt474goph+OPSk+NhNQVgLSimuL3/Ah0v11JGh/8rGaKti0yddSiM
         q/0fOfoab+9/DUCSuDVGXRkPBEodmSnVOEGRZxSGePAp5QYIi/4446bzXKyWwa+Z9QVU
         JorSbzfYLEjhFTeRYS7/jv30gSLerU7/hW/VDodF7UL5D3eT6ZP0fWQXg/OaUFUv2/fn
         GcIo0P7LqaWgUcqGlOiipgnrK233+5QeGPJ94GG6q7nHRhDMqNxm2bzPhj2Qys7AxdxL
         UO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uy9P4Bv7MoU15f1hxa9HUk41ddeWB4vxhHhX7nu5AF8=;
        b=ndhbB+FpJZRAmEZQZu1U6nL8iy6bGys7/0YvZWk8oQ7Qtib4fqzpaGLJ/gmCwVhvWI
         N14gJCQcHGZzX6f8ciUMmFuhsTcZyP2z9s7aCcMOeZgzEYxmcqbafTWnUurGXffrAHYg
         c+Sd3qplK1swv8vIoa9d1LR/DCCQ6BVx48qvs2WEAYYMDBk2Penlgcrz3LCQFkX4fNsg
         AbsDehSRYJRB21eOL9Ainc+/JD4g2aZTrDh6k6r0+C+KJzBBqgQZ+g1GjOY4bzGf2e6w
         jrqPCnAF6dp5+yeORPlbG/apX6+6fUswsayLJ9RTaW0IM68vX5cV3OO6aJr1w+QC79Nf
         620g==
X-Gm-Message-State: APjAAAWgDx8ZdhXDyXaO0uj8VgILd9q7IpZha9UE0kViRGez7v+2J8Ia
        GUGIqL7tnalM1jbXyJ35AwxaG1VzMmPEQF+NrN4BVabN
X-Google-Smtp-Source: APXvYqybYGFXeKm3HudJJDld+RvqFOCnrMTby4Ii2vx9EH9qEyc7WekPspTFOFMLIfLcDmLdtXWyHbCAfNQSt4Z3QxE=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr167967ljg.62.1562104610089;
 Tue, 02 Jul 2019 14:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190617221134.9930-1-f.fainelli@gmail.com> <20190617221134.9930-3-f.fainelli@gmail.com>
In-Reply-To: <20190617221134.9930-3-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Jul 2019 23:56:38 +0200
Message-ID: <CACRpkdb3P6oQTK9FGUkMj4kax8us3rKH6c36pX=HD1_wMqcoJQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] ARM: Disable instrumentation for some code
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>, christoffer.dall@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>, jinb.park7@gmail.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Landley <rob@landley.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, thgarnie@google.com,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andre Przywara <andre.przywara@arm.com>,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 12:11 AM Florian Fainelli <f.fainelli@gmail.com> wrote:

> @@ -236,7 +236,8 @@ static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
>                 if (*vsp >= (unsigned long *)ctrl->sp_high)
>                         return -URC_FAILURE;
>
> -       ctrl->vrs[reg] = *(*vsp)++;
> +       ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
> +       (*vsp)++;

I would probably even put in a comment here so it is clear why we
do this. Passers-by may not know that READ_ONCE_NOCHECK() is
even related to KASan.

Other than that,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
