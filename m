Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE2CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D3B217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572646556;
	bh=oiKzqXbxZ1qogtUXaFYwofJEiYzHO/QupTLwAxKg43A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lw4loGtt7Aj0CHTQPir6zLI62evCXFDKdqyPMG/e3DusbiMtwB+uEcM2mXnT0dt7N
	 YsATDcZXrFaz4li8adsJkx/R65qbijJagZEmxU9XLdi+U04fSJVxCcn+oB5HNaMukv
	 EjrbF03vpKaESERMzQJvQakAgqJMW4buTrf9qWMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfKAWPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:15:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43062 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAWPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:15:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so774573ljh.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gayIZZpZ3YO7S4lc/JPFUATVBp6OWUJIKkXToHOqfM=;
        b=ggAu9MenZeDX8qI5t3GXKk/RauPIOZCKIxykDKXzrZ4OqOVAWOaXLPwmMKOlqhzSaf
         jv2R/CB3/qKJiP1Oy6Uz1hLHRmF+PBV2MzmurEcxPIT1DqXYkn4eRo3eXmSLJwp7UUkB
         UK7NFksb1ZQokfRcgaeEEP7IMV2wk2l/dKRJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gayIZZpZ3YO7S4lc/JPFUATVBp6OWUJIKkXToHOqfM=;
        b=Hw/BpCo3GXMs4ODnywARuzy3jvTWlzBUI8uDX4jGPS/4d3s4C5UZrikoW19qnx6lgD
         oxRV1wWgwomrXYI9pI2PTQMJJ7LtFWnW9wlW8nsUUA2Rmz/i/f5h3F5lhuNvvYxfqOTK
         C5KcgDJCruXTqQDVv3Sn+/SYRBe5xGe4lIfpuLwb/yMKKV/3DhMmrW1Mg9H0q5zDVtGY
         OL89kTEUX9QPeX7+ynOUnCiUOk6J8aAXPzIgMfZjdoHJHnA2mIuM/ANeWRectYN+7pD4
         SvG5BffqgZjsK+tGbg0Lb4iqIebhOu/uPlwmgd9K7Y2QieFD8gYwQNVs5XC0NB4K3Jjw
         OX/g==
X-Gm-Message-State: APjAAAVi2q+1VUZA254OquoIFj540IDymog399H+ihGKbbZQ0oNPznGP
        f+YP1/WS5h8IwYmVAKusdJ4Fgkfbfeg=
X-Google-Smtp-Source: APXvYqy913EpPHHdvwAS/jQGI30uaIYdx4mtYletTZ4MgHsN2L+N22PbdjRGLOLwT6UFhA8/zBWBLw==
X-Received: by 2002:a2e:9a0a:: with SMTP id o10mr9872771lji.18.1572646552004;
        Fri, 01 Nov 2019 15:15:52 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id r5sm2831558lfc.85.2019.11.01.15.15.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:15:50 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id m9so11659910ljh.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:15:50 -0700 (PDT)
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr9669110ljd.1.1572646550228;
 Fri, 01 Nov 2019 15:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191101174840.GA81963@gmail.com> <CAHk-=wi_VHc=Q2JsPbVmCgpKekNJwnbBiYrmvnSSW8aiAkg7nQ@mail.gmail.com>
 <20191101203048.GA6622@gmail.com>
In-Reply-To: <20191101203048.GA6622@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Nov 2019 15:15:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0tH4tf-YiviztA=8TpHsg-K_ERJW3t143uNnpkvCfWg@mail.gmail.com>
Message-ID: <CAHk-=wg0tH4tf-YiviztA=8TpHsg-K_ERJW3t143uNnpkvCfWg@mail.gmail.com>
Subject: Re: [GIT PULL] perf fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 1:30 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> Firstly, non-existent fields are initialized to zero by default in the
> perf ABI: *even if user-space was built well before that new field was
> introduced in the kernel*.
>
> This is done in perf_copy_attr():
>
>         /* Zero the full structure, so that a short copy will be nice. */
>         memset(attr, 0, sizeof(*attr));
>
> The user-space structure that is passed in ('uattr' within that function)
> might indeed be short and not contain the new field - but we handle this
> via uattr->size, which is set by user-space - for example 'perf' sets it
> in event_attr_init() in tools/perf/util/util.c:
>
>         /* to capture ABI version */
>         attr->size = sizeof(*attr);
>
> Second, the kernel syscall then checks this size against the kernel's
> size of attr:
>
>  - if uattr->size < kattr_size: then old ABI user-space binary is
>    running on new kernel, and we zero out residual fields.

Very good. These were the two pieces I was missing - just readfing the
commit messages it wasn't clear that this was safe at all.

Thanks for following up on my worry,

               Linus
