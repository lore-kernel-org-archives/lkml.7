Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF6ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6BD20663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMmKiwez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfJOSLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:11:41 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:40392 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfJOSLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:11:40 -0400
Received: by mail-pg1-f175.google.com with SMTP id e13so4408868pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0za/Sp4Qykw4QW51/H0d9M7C13yw8IHUmkWtTzYXed4=;
        b=VMmKiwezo3wfATGWffS9Sj68ypdRb4vEBPOvGMn7MGGOcQbnOAkXbVztO2NQGMzoJO
         YPZ5YpKlG2/tQLjWaXlryfMt/l/SH+kE8rvK4L6ocAO+A/ZxMmFeFRe1KdYZSwcvgpeH
         maasw7nZfvZGkCMsSglYvJAXnW2TqXI3ziNYlI5L7DkGrFNShEEirRIpbDdCKcB1MoKk
         g7UaGWlLWG6SInBMl5iDCvNrl2qqIzepqa8aZe6Jcpa77ap4QzpOYkHKhBAG0g3+s3lL
         i3ikKMjlVLlAFMOe4BbolGxDrrc4tWN10WL70e806SpXDWKQLWdTkGxV8q4Y3WKE0vC4
         0Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0za/Sp4Qykw4QW51/H0d9M7C13yw8IHUmkWtTzYXed4=;
        b=IWAq/RyDjVGtOCoImJuFYolf+b0/k1kwfNovoYCHgIsymYE+/mLAHElfcelDeTJGJI
         yr0zoSlsxYp19u1J2V1X1M8v7y3Xbhw6C5WjFDL0MXot9170/0U0OOgX9JPknZwoj5SN
         OodwybborIXOYSGP62fPyjle9eueeXcYk55bT7/UxYFO0/n+rDrqESDklyOGklrQc7Sg
         pIVfezekSgx+Ooa8Au2LLSw7so8WP/YQ5mAa9T28E1N/k4OFgtOHnh36Rfp17Mf6htUt
         1buwzLuxHRgNSK0gqFw2FXc6uVjXA1ffasDYCQYuKXsOytSNlFakOKJhdqw9TXR2kfiE
         bR0A==
X-Gm-Message-State: APjAAAVotD6dXlAoc9b7HNr3k2V7b9NSFdTz1GgKBede0YidSqW6CH1e
        u+3Tc8/W+20OC8f4Z957VkiUhXASBwp/J87tbIHNwg==
X-Google-Smtp-Source: APXvYqwH71tuFzG2dIPadc4DHaN36KmLMAfeczkEh8WcUsaRC3O9hofShhek7FG9RlsJ2bWIgB6bl2aaCPI9yVENxt0=
X-Received: by 2002:a65:464b:: with SMTP id k11mr22065858pgr.263.1571163099433;
 Tue, 15 Oct 2019 11:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com> <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
In-Reply-To: <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Oct 2019 11:11:28 -0700
Message-ID: <CAKwvOdmEDQ1yy0A1Z+x-8MX6taBJPaAseghpHxphrUi29wWRfA@mail.gmail.com>
Subject: Re: AMDGPU and 16B stack alignment
To:     Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "yshuiv7@gmail.com" <yshuiv7@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:05 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Oct 15, 2019 at 12:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Oct 15, 2019 at 9:08 AM S, Shirish <sshankar@amd.com> wrote:
> > > On 10/15/2019 3:52 AM, Nick Desaulniers wrote:
> >
> > > My gcc build fails with below errors:
> > >
> > > dcn_calcs.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
> > >
> > > dcn_calc_math.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
>
> I was able to reproduce this failure on pre-7.1 versions of GCC.  It
> seems that when:
> 1. code is using doubles
> 2. setting -mpreferred-stack-boundary=3 -mno-sse2, ie. 8B stack alignment
> than GCC produces that error:
> https://godbolt.org/z/7T8nbH
>

Also, I suspect that very error solves the mystery of "why was 16B
stack alignment ever specified?"
-- 
Thanks,
~Nick Desaulniers
