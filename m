Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05288C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61CD2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNWQr1O8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfCTLRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:17:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42286 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:17:40 -0400
Received: by mail-yw1-f65.google.com with SMTP id e76so1629699ywa.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oz48NFB895ZbMvfJtIoZKMy1Z8ko+w/dzzts1G3S+gM=;
        b=dNWQr1O8riBE5SBH64MNYCjH2OGIKH6dXnBq2JFagwHS/Tj4yDj2jXaqmgKI1WCRvl
         2EYOWIaxUlCPvys9mJM4GZVCf9zOQeemTpKFpV03DOzbhWAn1+MacflB8MSQx/MM6+Vs
         GqRaxS5D9EujIuXr+hpJdpT1Z/PUbHZcEqQNrj8JYnozC05nZTKNZHu0bHIXGy0ZV3XR
         DPSiLwbsG3Ut2W/CW35XPMOKqWY1lNvMCVOB0918tFCJYEU4r1Xcy8sKYDFl1Oj2rhUi
         CBwZlxTdwQlpkCY4sr7yQ/WQCiYgaQBOLY2dz9Ooso1AouVgcTDBES0YvaJfreklllqp
         7xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oz48NFB895ZbMvfJtIoZKMy1Z8ko+w/dzzts1G3S+gM=;
        b=Ppr1ERiISjnWgbkHljvhkDvaDFKCoTzlMTbMKmWCSqku1tW2YCp4jawGceZ1HFlns9
         ZuvtbygESMdp7klqGZVqt2/b1Z2XfpYV9dfo32TZ63L9E9v+rtZgn+R5htoNBLJJOVzP
         coFbNZM/54G+V5aejrQCeMcLq9291CE/W4UlcTvLtQEp/ujuFoYfQsy/puzzqFnHEejq
         J3bB83ojn3DNA5hEplovM2USqhWlMyayETEms9qailIPNTLJR4vYZjK1PxhkfJdKszSV
         xnEXaMMGLPkq3nemf6v0a3+uO7VPpfjNR817dOEGKh9wIg/H8w5eRQe1BjR61bHaEzqV
         t8kQ==
X-Gm-Message-State: APjAAAXCOdHVUVMZEpKrCGwMxDtmnsI0v1tcExw2fXf7JBKH9RhHWwns
        fXJph9aEtnIjaoz9yYxKWyJwvz+XvXN+9MKc/SZmwg==
X-Google-Smtp-Source: APXvYqxapFYhzkxwBa5nGgz9L4vXQ0kOsITaSrIu88JY0FUrOrivd7S9onpb6xm+fBp/AdIOYrwjzwnoBIgiU4gRwsg=
X-Received: by 2002:a25:128b:: with SMTP id 133mr6474313ybs.325.1553080659767;
 Wed, 20 Mar 2019 04:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181130145622.26334-1-anders.roxell@linaro.org> <20181130101815.75038642@gandalf.local.home>
In-Reply-To: <20181130101815.75038642@gandalf.local.home>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 20 Mar 2019 12:17:29 +0100
Message-ID: <CADYN=9L=rL98C-4uTeg72KJPMK7M6xXcELz-u=PSqrY=KwaBJA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/trace: fix watchdog soft lockup
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 16:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 30 Nov 2018 15:56:22 +0100
> Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > When building a allmodconfig kernel for arm64 and boot that in qemu,
> > CONFIG_FTRACE_STARTUP_TEST gets enabled and that takes time so the
> > watchdog expires and prints out a message like this:
> > 'watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]'
> > Depending on what the what test gets called from init_trace_selftests()
> > it stays minutes in the loop.
> > Rework so that function cond_resched() gets called in the
> > init_trace_selftests loop.
> >
>
> This looks fine to me. Should it be marked for stable, and pushed into
> this release cycle, or wait till the next merge window?

Steve, I'm sorry for the late reply and no its not urgent.
Maybe it can make it into v5.2 ?

Cheers,
Anders

>
> -- Steve
>
> > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  kernel/trace/trace.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 5706599ed534..109becbc81ca 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -1547,6 +1547,10 @@ static __init int init_trace_selftests(void)
> >       pr_info("Running postponed tracer tests:\n");
> >
> >       list_for_each_entry_safe(p, n, &postponed_selftests, list) {
> > +             /* This loop can take minutes when sanitizers are enabled, so
> > +              * lets make sure we allow RCU processing.
> > +              */
> > +             cond_resched();
> >               ret = run_tracer_selftest(p->type);
> >               /* If the test fails, then warn and remove from available_tracers */
> >               if (ret < 0) {
>
