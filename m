Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44492C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1471A2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="S6ky3e3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfL0Sbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:31:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40684 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0Sbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:31:36 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so10321113qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 10:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SAOi4rX0PzzPY1Qd9BMC9D2IASEpSAZxjVF7/BcYdLo=;
        b=S6ky3e3meAJ7Q4N4XsrW8YT1Rm6tPFtg2HaCkj7ly+J4lV/QNQ58seC3aSbC0FKmsF
         qDCuZFaTS8jPaWi2MWtRo1ilqvmdUpnhtu2M3TuS2BeEwfecQAR53sK7tSGzegwZr4xQ
         jXFYIQfn5nTXl7kcLqg9ai65+g0Nbbrc4IYvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SAOi4rX0PzzPY1Qd9BMC9D2IASEpSAZxjVF7/BcYdLo=;
        b=RqE0AStf3MSIGvmWznnUPLVbZORrVWQUVM572mWaX4UKAaYp/91hhglPixw1wnR221
         NGHqwUORUt8JdYy6ORf3IhGpqPbVXMLaC8nqbYeOvRahjac7xYgrq1jvR1gR8uCMe2oT
         s7OSUJX/LX+6NZiCE33Y2tMIinKm9PC8Cc7/7dxNMtI12kBzA3VJCOpO3pfjarC+53Hj
         ZVwvk1ZX13yv/oGQVJyNrZWz9yjb12N7mGSTOuoj42bYGvda9fKyRX3lzvtwjngO8jJv
         Ta7CYQm9WTv1m5dn0UpqIIEmSp1ZjlsIxeRFs5dERppmBNhYyEIrq0dbg45dfbEWkpby
         wvPQ==
X-Gm-Message-State: APjAAAWsEJc0nais++qKbFdkk0PiM4zdkDx/Pebowu17GM/gVL+BVp8E
        azLHzggQ4paCXQA+XWrlC0rPew==
X-Google-Smtp-Source: APXvYqzips0lhd3HlySbex84ooEnXX60SOSbnq573j02uQZ/feUcY4BBMnytU71xjgPAulLj8evuvA==
X-Received: by 2002:ad4:4dc3:: with SMTP id cw3mr40752196qvb.130.1577471495835;
        Fri, 27 Dec 2019 10:31:35 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id t2sm10760889qtn.22.2019.12.27.10.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 10:31:34 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 27 Dec 2019 13:31:29 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>, mtk.manpages@gmail.com
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v3)
In-Reply-To: <20191226124659.GA20204@kernel.org>
Message-ID: <alpine.DEB.2.21.1912271327320.4876@macbook-air>
References: <20191223060759.841176-1-namhyung@kernel.org> <alpine.DEB.2.21.1912231235090.775@macbook-air> <CAM9d7cj06Hj3hOSdcyTpRWaoBY0wLjPpt7_+CbUqtsF-_08Czg@mail.gmail.com> <20191226124659.GA20204@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019, Arnaldo Carvalho de Melo wrote:

> Em Tue, Dec 24, 2019 at 09:40:04AM +0900, Namhyung Kim escreveu:
> > On Tue, Dec 24, 2019 at 2:35 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
> > > On Mon, 23 Dec 2019, Namhyung Kim wrote:
> > > > This work is to improve cgroup profiling in perf.  Currently it only
> > > > supports profiling tasks in a specific cgroup and there's no way to
> > > > identify which cgroup the current sample belongs to.  So I added
> > > > PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> > > > integer having file handle of the cgroup.  And kernel also generates
> > > > PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> > > > cgroup name (path in the cgroup filesystem).  The cgroup id can be
> > > > read from userspace by name_to_handle_at() system call so it can
> > > > synthesize the CGROUP event for existing groups.
> 
> > > so is there a patch to the manpage that describes this new behavior in
> > > perf_event_open()?
> 
> > Not yet.  I'll cook a patch once it's merged to the Linus' tree.
> 
> Vince, was it ever considered to carry the man page in the kernel
> sources and then make it so that new features need to come with the
> respective changes to the man page? I think that would be a good move,
> you would be the maintainer for that file, what do you think?

While I do a lot of work on the perf_event_open() manpage,  it's part of 
the linux man-pages project so I don't really control where it is 
maintained.

I personally do not think it would help much merging into the kernel tree.
I still think the idea of moving everything into linux-git (such as the  
"perf" tool) isn't always the best idea and can make it harder for people
who aren't kernel developers to work on things.

Vince
