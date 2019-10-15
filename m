Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42626ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE3721848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pG5zZ5p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfJONLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:11:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55131 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfJONLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:11:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so20831828wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=junNhP9gCsnSqnPVo5u2+J+8221y/y9z+WspBQGN5dY=;
        b=pG5zZ5p9vGBVNimp3UOKKkr+buBHVDRbo7psOns0H0BZx0rA6cm1ItierlcQWa7O4Z
         UcZ7G4/y0n8i6P63dyPYBdqFZae02DUyDeU6BvDdVXkv5uOz6PMK4uTcSe/dc0PiNIds
         h6APE3FhTxy6jKTDs7mSdBO+HWrgbC3SJLNp3heKWTj9bba8i9Cotb63aX7J9i05gkj9
         n/S8R5zkMumtkuJuQ0aIg4eEebB2n8kHGyqthshfhV6aEtElpVA8QQUB8MSQXiv+b1F8
         ukozvwqx7Jp7HHOEP/rNVKCGflICt5eIK8JNQ/dhr2AWf85xdT1Qsd73OFgN5g9C8GnD
         YvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=junNhP9gCsnSqnPVo5u2+J+8221y/y9z+WspBQGN5dY=;
        b=Oon/to+K0GVoToam2oO2RT3x51Qqx++P3pJd51IXR3JRviPVMir1PgFSrKzSwGbh60
         TXfZUlGLuIOXWZgAoy2wbPwaVdmHj0J7o575vnE+JXcMVduCxtQ+s5RLgF0QcID80jxQ
         C/cRTgsNaRsxQB8PdZ4KyLV6p9w2XwkkzSP5Uu61x5v1Jb/oOdndf63xxjb71sTWBw3b
         +xHZqraEgXGiY4k7wHpbSUcGmXwNLw8QlpTx86oPsoTn9AoIC6WTHiTGm9FfIEHeSsUK
         6dvdID+UUKggYJNSlTDxp0irCqwRLq3rtPP6jxVAQ1R6oEelrTlCWgOVh6qoBcew9fb5
         lnKA==
X-Gm-Message-State: APjAAAXHJE8AjV3VyA0TQEkiHbl+CE1OryZpudLb9a3WbXj4dQqJn9gH
        H5lP1AOOQkk2B6pGd2mRIApJkCvwYZOGC86xJ2pXhQ==
X-Google-Smtp-Source: APXvYqwNBwSOny55XqPPDJh10sin1sP5dhZyd1o+28Lx1d871n7oMCHkaC0P9Wg0nb9ScRHgvH3htMiZX+D9L6iU4Ww=
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr19886226wml.10.1571145106093;
 Tue, 15 Oct 2019 06:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-2-suzuki.poulose@arm.com> <20191011113620.GG27757@arm.com>
 <4ba5c423-4e2a-d810-cd36-32a16ad42c91@arm.com> <20191011142137.GH27757@arm.com>
 <418b0c4b-cbcd-4263-276d-1e9edc5eee0b@arm.com> <20191014145204.GS27757@arm.com>
 <12e002e7-42e8-c205-e42c-3348359d2f98@arm.com> <20191014155009.GM24047@e103592.cambridge.arm.com>
 <CAKv+Gu83oa3+DKNFowVkE=mZfLorAvGQ3GVPiZtsXzQBcsMCWg@mail.gmail.com>
 <20191015102459.GV27757@arm.com> <CAKv+Gu_=jw94Hj5Vo=5w+hb5RcPR4SQvxOM02WQr9hDhyzE67g@mail.gmail.com>
 <4b4ead8e-383e-67ee-672d-247a52f6c7f3@arm.com>
In-Reply-To: <4b4ead8e-383e-67ee-672d-247a52f6c7f3@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 15 Oct 2019 15:11:34 +0200
Message-ID: <CAKv+Gu-4uVXXj+gbiWhQqsdnoJsYnPfZ38CLUR-zWys4mG3N4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD capability
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019 at 15:03, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 15/10/2019 11:30, Ard Biesheuvel wrote:
> > On Tue, 15 Oct 2019 at 12:25, Dave Martin <Dave.Martin@arm.com> wrote:
> >>
> >> On Mon, Oct 14, 2019 at 06:57:30PM +0200, Ard Biesheuvel wrote:
> >>> On Mon, 14 Oct 2019 at 17:50, Dave P Martin <Dave.Martin@arm.com> wrote:
> >>>>
> >>>> On Mon, Oct 14, 2019 at 04:45:40PM +0100, Suzuki K Poulose wrote:
> >>>>>
> >>>>>
> >>>>> On 14/10/2019 15:52, Dave Martin wrote:
> >>>>>>
...
> >>>>>> I'm now wondering what happens if anything tries to use kernel-mode NEON
> >>>>>> before SVE is initialised -- which doesn't happen until cpufeatures
> >>>>>> configures the system features.
> >>>>>>
> >>>>>> I don't think your proposed change makes anything worse here, but it may
> >>>>>> need looking into.
> >>>>>
> >>>>> We could throw in a WARN_ON() in kernel_neon() to make sure that the SVE
> >>>>> is initialised ?
> >>>>
> >>>> Could do, at least as an experiment.
> >>>>
> >>>> Ard, do you have any thoughts on this?
> >>>>
> >>>
> >>> All in-kernel NEON code checks whether the NEON is usable, so I'd
> >>> expect that check to return 'false' if it is too early in the boot for
> >>> the NEON to be used at all.
> >>
> >> My concern is that the check may be done once, at probe time, for crypto
> >> drivers.  If probing happens before system_supports_fpsimd() has
> >> stabilised, we may be stuck with the wrong probe decision.
> >>
> >> So: are crypto drivers and kernel_mode_neon() users definitely only
> >> probed _after_ all early CPUs are up?
> >>
> >
> > Isn't SMP already up when initcalls are processed?
>
> Not all of them. Booting with initcall_debug=1 shows the following :
>
> --
>
>   // trimmed //
>
...
> [    0.027033] initcall dummy_timer_register+0x0/0x54 returned 0 after 0 usecs
>
>
> [    0.035949] Detected PIPT I-cache on CPU1
>
> [    0.036049] CPU1: found redistributor 1 region 0:0x000000002f120000
> [    0.036082] CPU1: Booted secondary processor [410fd0f0]
> [    0.048049] Detected PIPT I-cache on CPU2
>
> [    0.048149] CPU2: found redistributor 2 region 0:0x000000002f140000
> [    0.048168] CPU2: Booted secondary processor [410fd0f0]
> [    0.060249] Detected PIPT I-cache on CPU3
>
> [    0.060349] CPU3: found redistributor 3 region 0:0x000000002f160000
> [    0.060402] CPU3: Booted secondary processor [410fd0f0]
> [    0.060620] Brought up 4 CPUs
> [    0.060949] SMP: Total of 4 processors activated.
>
>

These are all early initcalls, which are actually documented as
running before SMP, and before 'pure' initcalls, which should only be
used to initialize global variables that cannot be initialized
statically. So I think we can safely disregard these as uses of kernel
mode NEON we should care about.

But I would still expect may_use_simd() to return the right value
here, independently of the logic that reasons about whether we have a
NEON in the first place.
