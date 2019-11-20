Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62EDC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA38320679
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ruI8uTSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKTTsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:48:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40677 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfKTTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:48:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id d22so903510oic.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsU7uehqL7wnWMosnxZD743IVZUrswQeWUXFNhR2dAA=;
        b=ruI8uTSHdjBoqHZ2jFzEh7W0jWZ2DMLFOLqWav6aSkbhdtZkS9s38+PTWD8ACMDMur
         Qgx3CVYnGVT9JwJTu/yEYBBjfU31F+UDKyGGNaed2Xi1xsxhLGDEA1/fYiemRsxVcZQD
         DNiz7L9xTOaVQBts8EwUnzYGQAsax0mgBWWF/7fpSEHvow8q5YEzonc4jKyCI7g8XXKX
         z/S81nXxfadZ6yvKvMSPvRLnk80wTuxP59PKbezy7K4BcZBKD6yY+0CG/EoHzCpqWhFs
         pIBzMALNOFqt5y42crsVXrLUUJgyBsMUImUxQaucbCs9+FPT5oyYy49hU5Gsn62c+Dec
         M6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsU7uehqL7wnWMosnxZD743IVZUrswQeWUXFNhR2dAA=;
        b=OdoAZEx/CpheVOH/B3XqObwXD/i2agiN5rhUpgxE/4VdGcskLci+lrSlojZIYXuJTI
         mtKaQBMUI0qK1JJKwzMbrzWIkNN7QT9TgUGVG0xen5sAt5dAJ6oITFgsMml1wXvSAuez
         apk9g+SglTDkDGd0F72tkloIgP6PifPa+A1G2/VDy773g++ROIeJVHbl3QiOQQY1G53l
         XbVdEBT7WNYY+X4Xy71h2PlR5Be+jWrheNkRJFPl8ulkcfDyA15BVjhkN16D73eaFxDy
         9opq1fertqKCsKIvKyPyPfgVAEdWt9k3HwKNiD7nmsdvIsrEp9Ynh/qkcrJNFTjMOjXQ
         Cynw==
X-Gm-Message-State: APjAAAUFlIBm/XnrSbb66gOFCRfZncX1oUWP4W/nS+1hQPA386bW2quX
        T0kvnf00A4e3ZjttxbcrvMeAlMiKpUSc9TNENF36zg==
X-Google-Smtp-Source: APXvYqx/g4BDi4Ep4xVGg1QmPYKz53hEOqfiaQgYctXmYAiZxgwMeeig4RXOI711HsPMUkELprAS61STvR/YqA628Cc=
X-Received: by 2002:aca:d80b:: with SMTP id p11mr4437774oig.83.1574279332230;
 Wed, 20 Nov 2019 11:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20191120203434.2a0727b3@canb.auug.org.au> <58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org>
In-Reply-To: <58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 20 Nov 2019 20:48:41 +0100
Message-ID: <CANpmjNOHTyTRCeo3oxEPTY__TCjAQ8nMvcqDSZ6Otfs7vVESSA@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 20 (kcsan + objtool)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 at 17:18, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/20/19 1:34 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20191119:
> >
>
> on x86_64:
>
> kernel/kcsan/core.o: warning: objtool: kcsan_found_watchpoint()+0xa: call to kcsan_is_enabled() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_read1()+0x13: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_write1()+0x10: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_read2()+0x13: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_write2()+0x10: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_read4()+0x13: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_write4()+0x10: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_read8()+0x13: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_write8()+0x10: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_read16()+0x13: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_write16()+0x10: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_read_range()+0x13: call to find_watchpoint() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_write_range()+0x10: call to find_watchpoint() with UACCESS enabled
>
> kernel/trace/trace_branch.o: warning: objtool: ftrace_likely_update()+0x361: call to __stack_chk_fail() with UACCESS enabled
>
>
> Full randconfig file is attached.

Thanks.

This is due to CONFIG_CC_OPTIMIZE_FOR_SIZE=y. It seems the compiler
decides to not even inline small static inline functions. I tried to
make this go away by adding __always_inline, but then we're also left
with atomic64_try_cmpxchg which never gets inlined.

The optimized build simply inlines the small static inline functions.
We certainly do not want to add more functions to the objtool
whitelist, especially those that are private to KCSAN.

We could fix it by either:

1. Adding __always_inline to every function used by the KCSAN runtime
outside user_access_save + also fix atomic64_try_cmpxchg
(atomic-instrumented.h).

2. Just not compile KCSAN with -Os, i.e. have the Makefile strip -Os
and replace it with -O2 for kcsan/core.c. #2 is the simpler option,
and would probably make KCSAN more effective even with -Os. Although
it might violate the assumption of whoever decided they want both
CC_OPTIMIZE_FOR_SIZE and KCSAN. It might also mean that future
compilers that have a new inlining algorithm will have the same
problem.

What do people think is better?

Thanks,
-- Marco

> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
