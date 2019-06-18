Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6440CC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4333D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfFROQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:16:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33785 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFROQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:16:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so15506376qtr.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruZoRv2MhjuvR2LtFQ77BBfVW501t5OrqUjLGXVFMGo=;
        b=I54KHHMG4OwtcUDELKqr8K+uB78lrE0GlM5slonZB41+rQHgeOYmzvkQD6avtcoqzk
         7NnP1D0OPpIo+r22E3RJgdYkudzT3jnlna1HwgMCh1gi19422CKBrNlnbWHpSm1uPWmU
         imhGT7LDbDSXff3MYueHXCQ+9ePmtxP/FbGAt3yaucBU77mL1oUlVwQtn2N0UpI6hfL9
         dEDz2bBHTPt5Ty/xGUS9euE2O6qnRk/Yh7zWDzGwNc+0sv7C38CLp6Y597XA7Ij52dsu
         G531LZM1V9LSUUgmWUhx0K45xQQmRypeaPHbHigtKpSuz5KkXG+LkqPLt7/E3YJrSc6S
         S3/A==
X-Gm-Message-State: APjAAAXr5Z2JJPEwRLrDsw8Zb/ReJJyeHSyLO7MIXO0gR9ynPs9WiZbb
        SaABgls8lE8fAvVtmdUSvaUdykshi/LmcdDpodA=
X-Google-Smtp-Source: APXvYqx88YQMSRzbZX+vqr3SJNawLqjEVZiNIcL10Mc3xMxBSF+tUg/S4XuJPG0hvDejz9NwD6IruZs6A+t3XRx8U90=
X-Received: by 2002:ac8:8dd:: with SMTP id y29mr34328837qth.304.1560867373451;
 Tue, 18 Jun 2019 07:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190617104237.2082388-1-arnd@arndb.de> <20190617112652.GB30800@fuggles.cambridge.arm.com>
 <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com>
 <20190617161330.GD30800@fuggles.cambridge.arm.com> <CAKv+Gu9Fh3anh6-TeDWZ+pL7rs7EBWZqvLXASRNjicGu7k+WKw@mail.gmail.com>
 <20190617164553.GI30800@fuggles.cambridge.arm.com> <20190618120259.GA31041@fuggles.cambridge.arm.com>
In-Reply-To: <20190618120259.GA31041@fuggles.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Jun 2019 16:15:55 +0200
Message-ID: <CAK8P3a2NQSm3sPcJq=6=Espa5da_L+2RNtyS=jkkzD3tx-4ehA@mail.gmail.com>
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 2:03 PM Will Deacon <will.deacon@arm.com> wrote:
>
> From 6e004b8824d4eb6a4e61cd794fbc3a761b50135b Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Tue, 18 Jun 2019 12:56:49 +0100
> Subject: [PATCH] genksyms: Teach parse about __uint128_t built-in type
>
> __uint128_t crops up in a few files that export symbols to modules, so
> teach genksyms about it so that we don't end up skipping the CRC
> generation for some symbols due to the parser failing to spot them:
>
>   | WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version
>   |          generation failed, symbol will not be versioned.
>   | ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against
>   |     `__crc_kernel_neon_begin' can not be used when making a shared
>   |     object
>   | ld: arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation:
>   |     unsupported relocation
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I've added this to my randconfig build setup, replacing my earlier
patch, and will let you know if any problems with it remain.

         Arnd
