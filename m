Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F66C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4535825B1D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="hWSVtcjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfE3Ohr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:37:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35817 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3Ohr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:37:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so1063402wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDWtQFm+WAzDqApfOL3f1+PtlUxOkj1j4sNRaB1SPIU=;
        b=hWSVtcjJZOIrECbWF+cqlhzrgoPipyWe7boEc6ikHzB+um9Z11/GN2zX6GvWr+WT/g
         m8ROPVjiHKyM/M50lUjpBUzhgt8MVkxnLpucQCCI1szffFHXQsKIWOW2HQWVV2xn5mnE
         gxWYtWwhLwAodwWEPfuH61lkIQMGd4RrC/b9mVdwwa98izPl3EycEvLa9qOXoRuMrvvq
         0wXbDVCAEMVvsS/HHafIwkc5WfSg1FFSquxxeWrNpNLTrtk9vnqB8FESdcmUzbH3ITa4
         b13XGs2XExYTn7Apk66yJGKmHuroJtYlDHpRCQ8/SpFECgo6WODjck/hJ6wTDg+uIVDG
         izgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDWtQFm+WAzDqApfOL3f1+PtlUxOkj1j4sNRaB1SPIU=;
        b=q28qb7RS93g6ZKT2zHEDEehCYeaE8nJUV0r6j9SEIDavag0egtkVP8TQqz7IZuEGus
         nWZ4ls1HBH+sBmWOOeHmjgLvY1glYiDRk+Kwu8RNhHQfttEF897IJLUgoO5tXi+kWlbE
         O6CVslwySG086y4vAu1cFJHaswRFAQ4jwwRaiLj9uVSj+fBSFFOVPoci7WO6A4sRqNl8
         gt99mwHEBZx6xSE2h2yD43u1EnDIiyCasTo9n+Dl/eLpItlFzcfIvZY0Vp34aRxGJc9M
         K/9KPT0Dzl6p78Y/pFSGVDUY4EDeNwDJLIZGK9//N7Wa3vDvy5yCPK7BCCQtw8XQMnC0
         NNjQ==
X-Gm-Message-State: APjAAAUOKxuZ7cXEOJK+Q5cuHrT8CaBoI2QyNm2XuH8s7ad8D3Vk4dFQ
        T5qW3XWpK7dqZ3YXBIJvrjjJTmYv43YQE479MS32Mw==
X-Google-Smtp-Source: APXvYqwjcA3hHjDD/ENJ0QBQOv2caz7VXByz8oSrnxwgrl0j5NsYAqFVW27F2fEjhjzR0PCqftacvysL5G+T+AA7h6Q=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr2525587wmj.79.1559227065647;
 Thu, 30 May 2019 07:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com> <1558742162-73402-2-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1558742162-73402-2-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 30 May 2019 07:37:34 -0700
Message-ID: <CALCETrWOUCOaEct4EA65WfZ-ZbmB6N8s-1aHNvH6rdKhPJ-CPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] x86/cpufeatures: Enumerate user wait instructions
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 5:05 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> umonitor, umwait, and tpause are a set of user wait instructions.
>
> umonitor arms address monitoring hardware using an address. The
> address range is determined by using CPUID.0x5. A store to
> an address within the specified address range triggers the
> monitoring hardware to wake up the processor waiting in umwait.
>
> umwait instructs the processor to enter an implementation-dependent
> optimized state while monitoring a range of addresses. The optimized
> state may be either a light-weight power/performance optimized state
> (C0.1 state) or an improved power/performance optimized state
> (C0.2 state).
>
> tpause instructs the processor to enter an implementation-dependent
> optimized state C0.1 or C0.2 state and wake up when time-stamp counter
> reaches specified timeout.
>
> The three instructions may be executed at any privilege level.
>
> The instructions provide power saving method while waiting in
> user space. Additionally, they can allow a sibling hyperthread to
> make faster progress while this thread is waiting. One example of an
> application usage of umwait is when waiting for input data from another
> application, such as a user level multi-threaded packet processing
> engine.
>
> Availability of the user wait instructions is indicated by the presence
> of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].
>
> Detailed information on the instructions and CPUID feature WAITPKG flag
> can be found in the latest Intel Architecture Instruction Set Extensions
> and Future Features Programming Reference and Intel 64 and IA-32
> Architectures Software Developer's Manual.
>

Reviewed-by: Andy Lutomirski <luto@kernel.org>

> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 75f27ee2c263..b8bd428ae5bc 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -322,6 +322,7 @@
>  #define X86_FEATURE_UMIP               (16*32+ 2) /* User Mode Instruction Protection */
>  #define X86_FEATURE_PKU                        (16*32+ 3) /* Protection Keys for Userspace */
>  #define X86_FEATURE_OSPKE              (16*32+ 4) /* OS Protection Keys Enable */
> +#define X86_FEATURE_WAITPKG            (16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
>  #define X86_FEATURE_AVX512_VBMI2       (16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
>  #define X86_FEATURE_GFNI               (16*32+ 8) /* Galois Field New Instructions */
>  #define X86_FEATURE_VAES               (16*32+ 9) /* Vector AES */
> --
> 2.19.1
>


-- 
Andy Lutomirski
AMA Capital Management, LLC
