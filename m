Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDF7C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5687207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d8bq2pe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbfFJJci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:32:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbfFJJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:32:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so7765526wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lpPkdiohJd4k3kyRUnxZLBCkRLMOft7olv8cUcpmrY=;
        b=d8bq2pe0OIREvP1sBrmZ1gaMAoXqO5cS0kEKZ6IJzIxX2iZMlYbjold6oLmHELbF/O
         NsXNPtW99Bt4xK8S6CSiNdKmqYcKP/BQzMA2QdmnrbCz5WCYSaHuLkymFtc45AUDYalc
         glyJgIbmUMr8vrzFbEB//20tZJwpJRmp3Pqvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lpPkdiohJd4k3kyRUnxZLBCkRLMOft7olv8cUcpmrY=;
        b=bOySrC+II7A4Ma2s5+MGvdTPW4NoOuPYpw+UNsP/hnga8ARLgbLsiWyDtaScpDShZP
         uSa8HNlDvj3Bkpt/lf6AQ0bKo2o6QaSL6TCSN3qcGPLVdBqS70SMSUxkfCA+HvYSGbJU
         KMTjpsU7+4M/fWrY3ZT3pyzeTKRQB7cOTGudNNxZadGxUT2fE9q8PaMHy1Q2B5ijyJkz
         ey2ldA5D2sE2FuTo2py8RKnMBFb/u82EZbPu0HEWEpOp/ZudqDM55vowjTER0Bx6ll5n
         KfVUKFasTTmUTevS3GFx/+IPVxCTLI2EgdBZn+F3RPwd4yft1bK5iGdsOAFpwrsZDhev
         IPyw==
X-Gm-Message-State: APjAAAUjiJCUZpNahoGf0tLhEgMAMni5GyS+9wPSJbEfeSGFbabG6Iz+
        NVG0e2jXAlEAJr6bMgtCgZPNlL05tg8ZW8B9U7+Obn5qRhgkwq+O
X-Google-Smtp-Source: APXvYqxlC/1zepnlDB6ISAUjS4Mr6oZtdxtwlLE5dET2cvRDXvvztt1iNWDmDNYCBaNYBUZlydPer5oQDNG1gO/w+7U=
X-Received: by 2002:a1c:39d6:: with SMTP id g205mr12067075wma.85.1560159156021;
 Mon, 10 Jun 2019 02:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi29E++jBw8boFZAiDZA7iT5NiJhnNmiHb-Rvd9+97hSVA@mail.gmail.com>
 <20190517050931.GB32367@kroah.com> <20190517073813.GB2589@hirez.programming.kicks-ass.net>
 <CANiq72nUPoNHWM-dJuFc3=4D2=8XMuvO0PgGPjviOv+EhrAWUw@mail.gmail.com>
 <20190517085126.GA3249@kroah.com> <CANiq72muyjE3XPjmtQgJpGaqWR=YBi6KVNT3qe-EMXP7x+q_rQ@mail.gmail.com>
 <20190517152200.GI8945@kernel.org> <CABWYdi2Xsp4AUhV1GwphTd4-nN2zCZMmg5y7WheNc67KrdVBfw@mail.gmail.com>
 <4FE2D490-F379-4CAE-9784-9BF81B7FE258@kernel.org> <CABWYdi2XXPYuavF0p=JOEY999M4z3_rk-8xsi3N=do=d7k09ig@mail.gmail.com>
 <20190610074510.GA24746@kroah.com>
In-Reply-To: <20190610074510.GA24746@kroah.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Mon, 10 Jun 2019 10:32:25 +0100
Message-ID: <CALrw=nEp=hUUaKtuU3Q1c_zKO3zYC3uP_s_Dyz_zhkxW7K+4mQ@mail.gmail.com>
Subject: Re: Linux 4.19 and GCC 9
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

For us it seems applying the following 4 mainline patches makes 4.19.x
branch perf compile with GCC-9:

4d0f16d059ddb91424480d88473f7392f24aebdc: perf ui helpline: Use
strlcpy() as a shorter form of strncpy() + explicit set nul
b6313899f4ed2e76b8375cf8069556f5b94fbff0: perf help: Remove needless
use of strncpy()
5192bde7d98c99f2cd80225649e3c2e7493722f7: perf header: Fix unchecked
usage of strncpy()
97acec7df172cd1e450f81f5e293c0aa145a2797: perf data: Fix 'strncat may
truncate' build failure with recent gcc

I also checked that 4.19.49 compiles fine with GCC 9, although with a
lot of warnings, mostly from objtool, like "warning: objtool:
sock_register()+0xd: sibling call from callable instruction with
modified stack frame". But it's a start.

Can we apply the above-mentioned patches, please?

Regards,
Ignat


On Mon, Jun 10, 2019 at 8:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 10, 2019 at 12:21:51AM -0700, Ivan Babrou wrote:
> > Looks like 4.19.49 received some patches for GCC 9+, but unfortunately
> > perf still doesn't want to compile:
> >
> > [07:15:32]In file included from /usr/include/string.h:635,
> > [07:15:32] from util/debug.h:7,
> > [07:15:32] from builtin-help.c:15:
> > [07:15:32]In function 'strncpy',
> > [07:15:32] inlined from 'add_man_viewer' at builtin-help.c:192:2,
> > [07:15:32] inlined from 'perf_help_config' at builtin-help.c:284:3:
> > [07:15:32]/usr/include/x86_64-linux-gnu/bits/string3.h:126:10: error:
> > '__builtin_strncpy' output truncated before terminating nul copying as
> > many bytes from a string as its length [-Werror=stringop-truncation]
> > [07:15:32] 126 | return __builtin___strncpy_chk (__dest, __src, __len,
> > __bos (__dest));
> > [07:15:32] | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > [07:15:32]builtin-help.c: In function 'perf_help_config':
> > [07:15:32]builtin-help.c:187:15: note: length computed here
> > [07:15:32] 187 | size_t len = strlen(name);
> > [07:15:32] | ^~~~~~~~~~~~
> > [07:15:32]cc1: all warnings being treated as errors
>
>
> Any chance in finding a patch in Linus's tree that resolves this?  I
> don't have gcc9 on my systems here yet to test this.
>
> thanks,
>
> greg k-h
>
> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@cloudflare.com.
> To view this discussion on the web visit https://groups.google.com/a/cloudflare.com/d/msgid/kernel-team/20190610074510.GA24746%40kroah.com.
