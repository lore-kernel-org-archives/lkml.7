Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFC5C76198
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FEE208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGlyw6Q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbfGRVaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:30:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35078 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391556AbfGRVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:30:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so13206073pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Kg4e7WJhopl3gfQ88VPQnEvXn0fCE4TNc6Qi8excrA=;
        b=XGlyw6Q8ysBBtTHOOum9BHjDmPSc1sI8WLNMUrICUYMGmrsPez8FFPxmSwfvUqUFVT
         fKCDRQp2fLC+FniwHviGGwD6ys/rDQhiy9Q6Vzl0TSVZnuWgtg9rB/BN3RAjo0IvUG15
         uJnWwS0ATKe3d+RGYew8jbtLXtwjIO78vyz+YbvaCuVeMqmCrUZ9EI6G6VSChiBxYwUH
         9jc5Cy9BDQMr4BOqXkp4rmsB4U+ImgqOf9zpYVygOEqUhOtup4FuvV1k27/1VjBGxJaS
         V9wCPaRfptfw7vKmU9KJk9eXz6Q/YFDXIXDdDVEq/C80XPvnPc8uw1jXZEVRG8Z/KkjP
         /rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Kg4e7WJhopl3gfQ88VPQnEvXn0fCE4TNc6Qi8excrA=;
        b=oX1AlUSCKA9hKTsVSINWQDU/lNuFPBGB6WS8qKEEjPlNNzCB68u3JQrmOjoIWZ2XFS
         82Kl1tHqSc4bQMr2wtBuYUxn7YoVu411W5Pbx6R5dJuT3sAi3dP7QRgt+wqtl8AAWRUO
         41iUJd3QBQTNi5VNBtTUpr3E6qfXBgIn9isvqaO1Xk1vYeYaQhpuft6222qe3V2/FDEf
         kAClQxfMtG1D1RmZ7E5bg2xSwzYPLcbw0xPixSaxdRowQcK1l9zDjt4jrx/yUuh8eLqc
         H+VByR41JzIcF1EiZg29j5R7by3E6WkCg8eRrMlmowOyolAx3ol5iJ+nhYScQoC5flIC
         lsVQ==
X-Gm-Message-State: APjAAAUlF1h8dNwXB1ce72nvKpYIx0qu3SeJF8nV/nlkKYgF8gbb1tEU
        0aww5nWnC7Kgpzbqvbh3HFlk/271Whh47iNW/Zdljg==
X-Google-Smtp-Source: APXvYqx8k89qmHUDy6zioXETxvVwoCx81KNoNX8Y5A8x1AMK1kTaZwhrNuMPCtzQJ+jSQATFEDc69e9BwaH91rPEBm8=
X-Received: by 2002:a63:60a:: with SMTP id 10mr19112038pgg.381.1563485409250;
 Thu, 18 Jul 2019 14:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190718000206.121392-1-vaibhavrustagi@google.com>
In-Reply-To: <20190718000206.121392-1-vaibhavrustagi@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 14:29:58 -0700
Message-ID: <CAKwvOdm_D1RnbzP6ZSuyOjm5DuNFrST4s8ihwVfOyAXm6wOc_g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support kexec/kdump for clang built kernel
To:     Vaibhav Rustagi <vaibhavrustagi@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 5:02 PM Vaibhav Rustagi
<vaibhavrustagi@google.com> wrote:
>
> This patch series includes the following:
>
> 1. Adding compiler options to not use XMM registers in the purgatory code.
> 2. Reuse the implementation of memcpy and memset instead of relying on
> __builtin_memcpy and __builtin_memset as it causes infinite recursion
> in clang.

Thanks for the series, and debugging and finding the issue.  These
would explain why I couldn't get kexec to work with Clang built
kernels.  Comments/reviews inbound on the individual patches.

>
> Nick Desaulniers (1):
>   x86/purgatory: do not use __builtin_memcpy and __builtin_memset.
>
> Vaibhav Rustagi (1):
>   x86/purgatory: add -mno-sse, -mno-mmx, -mno-sse2 to Makefile
>
>  arch/x86/purgatory/Makefile    |  4 ++++
>  arch/x86/purgatory/purgatory.c |  6 ++++++
>  arch/x86/purgatory/string.c    | 23 -----------------------
>  3 files changed, 10 insertions(+), 23 deletions(-)
>  delete mode 100644 arch/x86/purgatory/string.c
>
> --
> 2.22.0.510.g264f2c817a-goog
>


-- 
Thanks,
~Nick Desaulniers
