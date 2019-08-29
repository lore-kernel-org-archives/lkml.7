Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4010CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FD82166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567092317;
	bh=izoNkph/QjwkRYkXPZQmm9ytluYnjBoc9TYsmIgqnSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XZuKAaXCI/QgWizVgRseSQkCuA83FOqYmecERQ1LdR68tCG/aW4cUOqpdmpMIFbZx
	 bfIMWKGK1Lpg5MPno3IB9mAV/fQ9GBJsamwqFy9BTPIzTCIPWTv50T4en9uozzrwKO
	 sEhnJRyokVvLx98UEEqX5Bfxsb9i5au0hIiTgN04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfH2PZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfH2PZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:25:15 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEC6F2342F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567092315;
        bh=izoNkph/QjwkRYkXPZQmm9ytluYnjBoc9TYsmIgqnSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iUFipIVZ1HFIrEALnAF/EnoEcF209ZLWvRC4PEWbszkw/lCP9Yvj37ci8J+w7/hxQ
         zi/3IdAUX14zyQDtjJ0thyL4mPt5cSWzBq103mHEZpUO2EBt91zBEDCvu4xzO9SOzg
         6Vbq+bL+ekh6s4QH3C1lVJ97BVS4YmMDzILHOYCc=
Received: by mail-wm1-f52.google.com with SMTP id l2so4306365wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:25:14 -0700 (PDT)
X-Gm-Message-State: APjAAAVds5Hcr2hucHzv8NZROY/HVd090qTDetfT1LZnyamfpgR1XK8m
        RjOoca62mDNUMowAUj2ljSPakxbWhqBeCTefgPLcew==
X-Google-Smtp-Source: APXvYqw9u1fu+EHt/4WAojvjLjQ7rKpFezaEHESzZAnb7jZ2raRq1MIbYw3eQuXsuFrZUlLqFJAlw9hQa1Rszg/FXvs=
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr12807622wmg.0.1567092313279;
 Thu, 29 Aug 2019 08:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190829111843.41003-1-vincenzo.frascino@arm.com> <20190829111843.41003-5-vincenzo.frascino@arm.com>
In-Reply-To: <20190829111843.41003-5-vincenzo.frascino@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 29 Aug 2019 08:25:02 -0700
X-Gmail-Original-Message-ID: <CALCETrVprrrR3TSVSAnHfLW4HDQG=gcVrdjmsk6ss6Z3+vKOBg@mail.gmail.com>
Message-ID: <CALCETrVprrrR3TSVSAnHfLW4HDQG=gcVrdjmsk6ss6Z3+vKOBg@mail.gmail.com>
Subject: Re: [PATCH 4/7] lib: vdso: Remove VDSO_HAS_32BIT_FALLBACK
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 4:19 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> VDSO_HAS_32BIT_FALLBACK was introduced to address a regression which
> caused seccomp to deny access to the applications to clock_gettime64()
> and clock_getres64() because they are not enabled in the existing
> filters.
>
> The purpose of VDSO_HAS_32BIT_FALLBACK was to simplify the conditional
> implementation of __cvdso_clock_get*time32() variants.
>
> Now that all the architectures that support the generic vDSO library
> have been converted to support the 32 bit fallbacks the conditional
> can be removed.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> CC: Andy Lutomirski <luto@kernel.org>
> References: c60a32ea4f45 ("lib/vdso/32: Provide legacy syscall fallbacks")
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  lib/vdso/gettimeofday.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index a86e89e6dedc..2c4b311c226d 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -126,13 +126,8 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
>
>         ret = __cvdso_clock_gettime_common(clock, &ts);
>
> -#ifdef VDSO_HAS_32BIT_FALLBACK
>         if (unlikely(ret))
>                 return clock_gettime32_fallback(clock, res);
> -#else
> -       if (unlikely(ret))
> -               ret = clock_gettime_fallback(clock, &ts);
> -#endif
>
>         if (likely(!ret)) {
>                 res->tv_sec = ts.tv_sec;

I think you could have a little follow-up patch to remove the if
statement -- by the time you get here, it's guaranteed that ret == 0.

--Andy
