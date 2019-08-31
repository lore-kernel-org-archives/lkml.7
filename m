Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F81D22CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsOW6T6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfHaUyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 16:54:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40663 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfHaUyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 16:54:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so10206214wrd.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVpAvUDIIJB/rBiWdRSCp24noGQbpHdLhKRNzvEE/U4=;
        b=nsOW6T6Ln7H6VoO1w0TdKL+n+bCxdQIg5mV76Up0msQFVNLwvZmlf44egKbADEp2/T
         /QfnTIbzeVyGiKDdY4eR5ETL/U9c6HwLawqimpMtuWepi+TaJjXVff1nNLFAHMTYPkH/
         wsrd36zt7GdmCrrN3xFmPQwRAZV8laLqDazcovK9H10t3nn89uicx22wJGA8yK4N9QCE
         lRbFRL2+vIz5Q3CNumVrnlX+xygjtPKqNmudodf/I/oOZ+8NHMfc07REAE938MVz37ck
         /swarB07BIgtGigOP4JZ2Og0bwZIiKR7JEPIxZTPw748Vu6uJbsFWYPdpKTWQCLl6Cf2
         R0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVpAvUDIIJB/rBiWdRSCp24noGQbpHdLhKRNzvEE/U4=;
        b=MtmyathDbqDuFiKLVzE3ViBaGCjz3XQ0Csv68U4UkBx5RRoZtJjXKBGFXBTgFRYr7I
         2Du8hRtSjlQIth7XwRQyfGL4nPWoJq+cDb50f4eV6g667g/SyK1Evv00cQK7g2+Qmq5Q
         DCRtXka4ydbXfNyjIAEwSp9QZYltaO6bhoj2WBC6MyIPIcobRYUx9TXuIon1RnFmYrs4
         2JwB4FFoOutYogsFBYj36S+D1UtBYefkyuPqWuzkv1OpZ/Zc6xRtowJ6By9J7+1J83z5
         QjPuGH+o8sct6V8BuAXxwVNGa+xEUCEmro4yYmGFmcMeYSqi0/HqWqyVhV9iMMDmN9dp
         Dteg==
X-Gm-Message-State: APjAAAX9eA/ivFZ5HGp3LenpP/FqY45XUwqAh93vdiWw6UIlwDS0M/I2
        EgGvi7OV8r69YOKjNYWF09C2mGFxpMU6KG4ElB1Htg==
X-Google-Smtp-Source: APXvYqwQwkYgQPi3E0gla+o/CkByrN5Hhlas0nQucIcmpMVvUtuqz0/TVYNL0niNk8F9o2kChIUPF8tg58wECmLSZqU=
X-Received: by 2002:adf:9e09:: with SMTP id u9mr26622524wre.169.1567284862130;
 Sat, 31 Aug 2019 13:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190827163204.29903-1-will@kernel.org> <20190828073052.GL2332@hirez.programming.kicks-ass.net>
 <20190828141439.sqnpm5ff4tgyn66r@willie-the-truck> <201908281353.0EFD0776@keescook>
 <CAKv+Gu_Q=o_6xDW_7YTd3J6psqs-o+qBxW4r9MXCBwjmsGpTbQ@mail.gmail.com> <201908311200.926B5C0F@keescook>
In-Reply-To: <201908311200.926B5C0F@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 31 Aug 2019 23:54:11 +0300
Message-ID: <CAKv+Gu899ZsEG43aSQ0nn9suHp-ekKeSMbPRb2OYwsAu=_Q93Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_* operations
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2019 at 22:02, Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Aug 31, 2019 at 08:48:56PM +0300, Ard Biesheuvel wrote:
> > It's been ~2 years since I looked at this code in detail, but IIRC, it
> > looked like the inc-from-zero check was missing from the x86
> > implementation because it requires a load/compare/increment/store
> > sequence instead of a single increment instruction taking a memory
> > operand. Was there more rationale at the time for omitting this
> > particular case, and if so, was it based on a benchmark? Can we run it
> > against this implementation as well?
>
> It was based on providing a protection against the pre-exploitation case
> (overflow: "something bad is about to happen, let's stop it") rather
> than the post-exploitation case (inc from zero, "something bad already
> happened, eek") with absolutely the fewest possible extra cycles, as
> various subsystem maintainers had zero tolerance for any measurable
> changes in refcounting performance.
>

Ah, of course.

> I much prefer the full coverage, even if it's a tiny bit slower. And
> based on the worse-case timings (where literally nothing else is
> happening) it seems like these changes should be WELL under the noise.
>

 Agreed.
