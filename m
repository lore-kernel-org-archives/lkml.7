Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB4FC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D42420707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipkqHXR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfLFXRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:17:08 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38393 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfLFXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:17:08 -0500
Received: by mail-yb1-f195.google.com with SMTP id l129so3662153ybf.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7FUl9VETo/oiSsBNFlxfWlZpZRlSZipIrIxdJ1sDhI=;
        b=ipkqHXR+zGq6JE5Hi1lIOquFzTH3FsBByPaAMbaf0xsFi6hizT54QqC74s+lAY+cXK
         NUm6KrdRLPiFtcPiEASE3/p0ypm9dueMHR4LKimpys1nkvqvCgR3zTuDhZaA59065Q/4
         fMu38iKXoCseAoy+FMTQ2o3kJWXqsvJxVymwIS2gFpqLUfm9pAM1EV4nsY0+cCvzcImq
         mHBZwy8CKPk23NVqEHGtAIrQ00h9VKmzJGYU7vIhUi6goxwuvJppB3ExNcXxQDq7BUyQ
         J8zt4k8Tu+XPq/3aqikvyxPz+bf9MYdlx5VR/5PJvvf6YCUSSelr9g5Fjtnv/1lwwD1h
         sKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7FUl9VETo/oiSsBNFlxfWlZpZRlSZipIrIxdJ1sDhI=;
        b=YyX4kqs6lngMndqL/0INXwu910hkE2dXC2rLEvPYfNAZY5mBoWeZDE7tLrqbkkBIHk
         UjPCMP6qpPE4OazaMJ2zxI2mUhcvy9Z8vE3lSofcfkuldXsSHIcGHwYVoU0shxamAbas
         5qeclpNes4AOx0zww0kFU5gNHiM3GDL3bWkLUMhekZPMJziV1opDGUIX2gPPJfFobMP7
         qRTAAh3banEkme7AklREK9Cbohdr23KAFhMceLbnm6/YTIpQI6PvW2v3AlHV3WhGxt4z
         1eQWPE2RWO4elmoIr6UbEoTdtskvGcuJaB0mzzPCOZMF8L6yDYm04YLPFuSeMGpiXVrM
         oZPw==
X-Gm-Message-State: APjAAAXnZbT4WvxaaFmJgfxxMJ9DpNgsyeurpzGESXLWLAH1kiCjtze/
        FjTQd50cJ2e0gkOtb7XikG64/J7ZPIWrTdHfeL2+RQ==
X-Google-Smtp-Source: APXvYqxkNUB+SKolfofCSfXRfJ3BWe3AGN+7qXc9M8YGJUKNX52Q4RNby6oB6STmNU3cm19XtKlrQka2Lz+5vKAfXdM=
X-Received: by 2002:a25:b785:: with SMTP id n5mr3305327ybh.324.1575674225923;
 Fri, 06 Dec 2019 15:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191114104525.GU4131@hirez.programming.kicks-ass.net>
 <CAP-5=fU9b-qTH=whjfpkPjnUJQQTmtjZ3GFT5zYEnJ69gGO4+Q@mail.gmail.com>
In-Reply-To: <CAP-5=fU9b-qTH=whjfpkPjnUJQQTmtjZ3GFT5zYEnJ69gGO4+Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 Dec 2019 15:16:54 -0800
Message-ID: <CAP-5=fXVGfF8LZr23PUsKWkoi9+hQV3x4fG9dVSihK0FNh8Nfw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Optimize cgroup context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:17 AM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Nov 14, 2019 at 2:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Nov 13, 2019 at 04:30:32PM -0800, Ian Rogers wrote:
> > > Avoid iterating over all per-CPU events during cgroup changing context
> > > switches by organizing events by cgroup.
> >
> > When last we spoke (Plumbers in Lisbon) you mentioned that this
> > optimization was yielding far less than expected. You had graphs showing
> > how the use of cgroups impacted event scheduling time and how this patch
> > set only reduced that a little.
> >
> > Any update on all that? There seems to be a conspicuous lack of such
> > data here.
>
> I'm working on giving an update on the numbers but I suspect they are
> better than I'd measured ahead of LPC due to a bug in a script.
>
> Thanks,
> Ian

Apologies for the delay, I'm sending v5 that addresses review
comments. I'm still working on performance numbers.

Thanks,
Ian
