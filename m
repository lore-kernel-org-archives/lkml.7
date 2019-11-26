Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0267C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DFC2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WqR17hHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfKZRYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:24:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42651 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfKZRYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:24:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so9495119pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8USDfSi67+n5QmIEjkqw0xHLSOXAD0OKre/+CsAlyY=;
        b=WqR17hHpNHnT+OqFRxTnECAS6VxLuaUlXpRH400dg8yDi0QCb70FLtGHRex2nhWb6N
         fiHQ0CeQQfxkEqKC9XY/3rV6VseUdrWcnOzVetR7FyEtoO2mrMoUfiOGpeANag7mkKig
         /KgO5C4Pybs6agJUVTwQP/orGZxfvTQ2vBS/rk9vl3U5k+Y2F3pyOJPnxSqcZIjJ4B7b
         2qYeGUNVeXNz6e0a00Kueu0vrwXffguwYy6gbAMRHHRxdC47BHras4DyBdeEvNxv+t1G
         dfvoYBEEX6QM8sqkAk97/sKndtdjP/1VrKV8iTArz2J3HjH2k8QEI0lf9fCLZPSj6Sxf
         X3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8USDfSi67+n5QmIEjkqw0xHLSOXAD0OKre/+CsAlyY=;
        b=KUS9tZvtGh4KZ2ozGmF//PK0q4fLaKJ1JiAjwKq0qVvLiVVZsPjlmcjpi+CJhoWQkI
         zAxHdCaD1deWEDGquhKVDvOaJXtukSAco2X4IwOxFcfdPeG1Z7mpAJe8qNCd2A2tILDO
         dY3Ye02NpCxHIX2w7bsZ7aDlmUQSMCZ68wltPRzMNfCEX/253InGaUCuejAzW4DvhFw6
         Fiaw9EinleE2j1TN3MGRx0vh5JW8xxTMF26FCG8NuprAsRz1w4uq4tGwQ6Z5pGs1JcQc
         qvHVQm+vPOT67hc3gWjwNrzzJW2uqx0DSjFNl7B2e7OnMjye86aaHpP19Np1Mr/6WKq2
         8BtA==
X-Gm-Message-State: APjAAAWXuhxePh71j5V5FOPuMBgGwPdHDbU4M2R21bjc/r21W5kxmJCQ
        W2rd4nENl9k8cUJ81e8FqzBBa3WlpMGLsH+eoaJu2A==
X-Google-Smtp-Source: APXvYqxzcS+75MzEmr6shKwAMsNS2Rq8w6QNu6ay3w2CWPTSa6uH/xkHc0jBu5We2OgC5xS3qXodaJZPCjUoosyFhpk=
X-Received: by 2002:aa7:9151:: with SMTP id 17mr43002593pfi.3.1574789061374;
 Tue, 26 Nov 2019 09:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20191126161255.323992-1-colin.king@canonical.com>
In-Reply-To: <20191126161255.323992-1-colin.king@canonical.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Nov 2019 09:24:10 -0800
Message-ID: <CAKwvOdmG8Az=DFCODtehGTcLRYjEO2B6ZcDd=eNAF40dV-gw6Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: fix comparison of u8 with -1
To:     Colin King <colin.king@canonical.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        kvm@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 8:21 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The comparison of the u8 value __entry->u with -1 is always
> going to be false because a __entry-u can never be negative.
> Fix this by casting it to a s8 integer.
>
> Addresses clang warning:
> arch/x86/kvm/./mmutrace.h:360:16: warning: result of comparison
> of constant -1 with expression of type 'u8' (aka 'unsigned char')
> is always false [-Wtautological-constant-out-of-range-compare]

(__entry->u is defined as a u8)

>
> Fixes: 335e192a3fa4 ("KVM: x86: add tracepoints around __direct_map and FNAME(fetch)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/x86/kvm/mmutrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmutrace.h b/arch/x86/kvm/mmutrace.h
> index 7ca8831c7d1a..3466cd528a67 100644
> --- a/arch/x86/kvm/mmutrace.h
> +++ b/arch/x86/kvm/mmutrace.h
> @@ -357,7 +357,7 @@ TRACE_EVENT(
>                   __entry->r ? "r" : "-",
>                   __entry->spte & PT_WRITABLE_MASK ? "w" : "-",
>                   __entry->x ? "x" : "-",
> -                 __entry->u == -1 ? "" : (__entry->u ? "u" : "-"),
> +                 (s8)__entry->u == -1 ? "" : (__entry->u ? "u" : "-"),

Or could compare against 0xFF instead of -1.  Either way, thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                   __entry->level, __entry->sptep
>         )
>  );


-- 
Thanks,
~Nick Desaulniers
