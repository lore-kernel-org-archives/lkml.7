Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C136C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAD3216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apfsdlM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFZWXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:23:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33255 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:23:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so166654pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6k7zNgZLFmKpgsUzLGQdH8FivHDbJLYHnNmfeC8W16Q=;
        b=apfsdlM2T8AVRM8Ba1zwDpxgntSH5BvQFSzp5xVcxWCwf8+bUxHWNGsge2+/ErBh5+
         YeJSFFqVW8emZMdoG+SEdYcVSbdHuFI2aTXp7gh4x4N5iqSSLar98zuoY0BuInDbyhhm
         0kg1acX/A7m1Qv8F2TzgWFwdw8mDr0iqwzz/cw/ro4wkbJkRwLfPjG+PY8STmoPsdg2z
         S5WsKM1K5jACBM4m5i4slZCCzleeZYW/Y4iHWv1ldyZ2VPxZn6ic4GpZt9ITQ06+oW34
         I+YppjC9H83z+xKxbiWBtlqAGMn/aV39dgcn1AKuU98VJ9MnaRWp9nYgCTMfXKGu9ojA
         xX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6k7zNgZLFmKpgsUzLGQdH8FivHDbJLYHnNmfeC8W16Q=;
        b=nWyIgoEWM/iau7NCmlHyu80xDiafFXw6JJgRp00U+PQB8ovMUddzU2hB3L77GKCxlu
         4Po6vF+LJ4YBFex55WuKa+H4ktT2dm5n8S4X5qZZcSP9T7lXFesjjZaHuv8LcZTBsusB
         PQy1q50wtxHaywYf8uG84/0oFlXcImDqCLAakSUT9u3/CaytJy7NQykazVy659wup/pg
         x4mxTPdMyD93wMgmXX0he9AzvRi/310/yRS9H+e3/632dMqnmeNIFt1QoXky6pv2IM8i
         P0KkqHU5QZLhHu8PDkidDTsSH3iOsHoPk9tyHGh3FIKVAXNmD0/HWqCltfdfjKs4ZO/q
         uK2g==
X-Gm-Message-State: APjAAAVG6oLkK1pCVNncxdvLfOeaVHrteb5NMoDxbg3D6U4W7iU79erq
        x+FsfvnuEkD/F3CHV+5UrVarJ+MiDz/Biseu7YEqwA==
X-Google-Smtp-Source: APXvYqyDC6Fi954g5tXRrB7X7dncPn/1IBNhcUYyRhtX9mRboPTkjbLy2Digjp+YWYXJP5a8y95+w6JU9nC0iJl+sMo=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr1632154pje.123.1561587815678;
 Wed, 26 Jun 2019 15:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com> <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc> <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc> <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626092432.GJ3419@hirez.programming.kicks-ass.net> <20190626095522.GB3463@hirez.programming.kicks-ass.net>
In-Reply-To: <20190626095522.GB3463@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Jun 2019 15:23:24 -0700
Message-ID: <CAKwvOdm=cOOW1MLz2re9MvW0K4g8cENdymOQoUL1k-+5v=bg=A@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 2:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 26, 2019 at 11:24:32AM +0200, Peter Zijlstra wrote:
> > That's pretty atrocious code-gen :/
>
> And I know nobody reads comments (I don't either), but I did write one
> on this as it happens.

I've definitely read that block in include/linux/jump_label.h; can't
say I fully understand it yet, but appreciate patience and
explanations.
-- 
Thanks,
~Nick Desaulniers
