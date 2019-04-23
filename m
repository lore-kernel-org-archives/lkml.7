Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C6C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E562206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHFVxiMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfDWW5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:57:55 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50639 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWW5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:57:54 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so3059758itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zaivxaDwCKd+5YAkhIYhBokHLMiUOFiJMC/InmCE7TA=;
        b=KHFVxiMgsXrxiHNC6Y43Wt/SVAj50MPYHMTXu5LWE8oV/05Qg4iHrXe0lyRwlcpz3r
         MI7R7Y7y2Ezukf/kakBQNhbsLtR+f87/mJBfaw6Mkk/W+j7VOIUMwkycH6f7mUFoqCQ9
         KiTGl05ckqoUDimmW9ypWM3k3UbLSIf3pjJIDj1Xj4QdUoit3eRnMUbvb9E9o2Oxr+jz
         dwrXTIjK2VKZT+dilbn089Z+ayzgWPUUZC2x/stWPlzFocVX3SJAI1XIXKA+seqePpMQ
         N5C+vmtcUqJtQMU162/UPzW96lFpu687E/4O0Y7kH9KY/faXkm5GQtfCeVFJzWyEUAuS
         ufDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zaivxaDwCKd+5YAkhIYhBokHLMiUOFiJMC/InmCE7TA=;
        b=WokcnckeCY2AbRDH15/68c8iET8x3/kyVsk2wCoGDQIpuOCqXZXge6C9lHjYUuTM2n
         EhVxEJX1Dz6kwSWBJnklk7hRpFKLy5xkhiH5BS3Qls8/QA/p8Lp5JWxjHbWITVvQDaDE
         fO93Tv/CMbrWP/fvm9XffQfEujTGOdUP3msobkyNU3dM2EElVvM3tfKr8zE0o11mKIvf
         pnw2v+LGv5FQTs0UTgEnNBj5b1noRR5wlyb/R0vOkzQVAkkMbCrdnqhTafqTt5iAMbhd
         Fv9eDD/ICzkaB/k33DPe0N2lbXJLatQAAOz2MAGkp+4wok9+b/JYVF5BaN0FsmCpCJbA
         SxrQ==
X-Gm-Message-State: APjAAAUy1YPY8roht+8NViAF8kjjMOAsMtsEJF8sdoqsNhjrdMyCsosp
        UeWtJGVrS3LF+ZC93ucGkbKZHQP34cAjZSheUhVOMA==
X-Google-Smtp-Source: APXvYqwvA1WIVCLvFbTlkEY/ZDBgsrvZL9cumWaOwld5e2hNlp2HKxKUpimsVy7/5rTl2R2/FFlAsoOUSDziW0jBIH4=
X-Received: by 2002:a24:59c1:: with SMTP id p184mr4494047itb.158.1556060274071;
 Tue, 23 Apr 2019 15:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <CAGXu5jJmJLc41XDyaO3vSt=fPXLpph3m3TEtxAtdBiFMKqSrcA@mail.gmail.com>
In-Reply-To: <CAGXu5jJmJLc41XDyaO3vSt=fPXLpph3m3TEtxAtdBiFMKqSrcA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 24 Apr 2019 00:57:41 +0200
Message-ID: <CAKv+Gu-ZxvK7L90Xkf=U=GEeucGg9qJ+TDabuguFCxeUbn_GeQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 at 00:55, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Apr 15, 2019 at 7:38 AM Kees Cook <keescook@chromium.org> wrote:
> > +#define __msr_s(r, v)                                          \
> > +       DEFINE_MSR_S                                            \
> > +"      msr_s " __stringify(r) ", %x0\n"                        \
> > +       UNDEFINE_MSR_S : : "rZ" (v)
>
> BTW ... is "%x0" a typo here? Shouldn't this just be "%0"?
>

No, iirc, that is required to force clang to choose a x# encoding
(which is the only one supported by msr/mrs instructions). Otherwise,
it will infer from the operand size which encoding to use, and attempt
to use w# for 32-bit system registers.
