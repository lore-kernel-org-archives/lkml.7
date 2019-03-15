Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC20AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9140F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yI4EShvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfCOCyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:54:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40387 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCOCyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 22:54:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id f11so8564707qti.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HUgh40+C8/2OCmX/UW2ZUro8RAG3vLQ9m//fEUxwous=;
        b=yI4EShvCw/j4gXJcpUISzIi8Bw5cyKpRaLwfltUsa6vojDsQPaxDnRHeimDILntWAj
         YMRMNndwkBlmTVzNFtYnRPkbZSdm/oMuzz6LM5ALkQPzKZtYlYTfQ3qAtr2sAaUmXu8H
         TZybdGHGjVN1QkU953zx10q6o0GqeocdPA9Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HUgh40+C8/2OCmX/UW2ZUro8RAG3vLQ9m//fEUxwous=;
        b=EwouPLtswJ9QqO/EB8acpKQSTgnFeqtNJljUV7QtTdhNVhJ95umEI0LhBDoFoRYnmW
         bhDmN/z8jbfKeVvFHEyfZa86TKZl3rOX4shqJfyBftnVGIWaLywsGJCFzwZ6YqwzMz5+
         HXJQjBTLJIWE7XlVdcDrH6Z9ljUjP5M3oLoSBzLoWLGUsNPIetLhyOOICLMdJFnyGDtE
         QaZfqCKY70qjB4zX3178EwwwxMeGqy8QSsn/ZInALpJ6KvsMtAqpLOJuU2LU5IDmHWi0
         zD86W9fNTV2QMydyOStem891cFBY7iuR1EalZoVcuva1CyQ0eBE5CKWMCxrNY5z7dFZX
         rBEg==
X-Gm-Message-State: APjAAAUZ2ZaDrcPtszMqrqyjCy4aqHe+6a2hSxGJvmTx/WAv4bNOYrqU
        LggCbU7jyLNdmMFcKwuzRq+M4w==
X-Google-Smtp-Source: APXvYqwmSeslzsMFyhE1hdB2M/6gE5HGS+bSWP4pkJjMaob6xQq6c98ZXFsBaiV/FMTpT0VUQjZmSA==
X-Received: by 2002:ac8:7606:: with SMTP id t6mr1020145qtq.243.1552618490194;
        Thu, 14 Mar 2019 19:54:50 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id 50sm413653qtr.96.2019.03.14.19.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 19:54:48 -0700 (PDT)
Date:   Thu, 14 Mar 2019 22:54:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190315025448.GA3378@google.com>
References: <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
 <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
 <20190314204911.GA875@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314204911.GA875@sultan-box.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 01:49:11PM -0700, Sultan Alsawaf wrote:
> On Thu, Mar 14, 2019 at 10:47:17AM -0700, Joel Fernandes wrote:
> > About the 100ms latency, I wonder whether it is that high because of
> > the way Android's lmkd is observing that a process has died. There is
> > a gap between when a process memory is freed and when it disappears
> > from the process-table.  Once a process is SIGKILLed, it becomes a
> > zombie. Its memory is freed instantly during the SIGKILL delivery (I
> > traced this so that's how I know), but until it is reaped by its
> > parent thread, it will still exist in /proc/<pid> . So if testing the
> > existence of /proc/<pid> is how Android is observing that the process
> > died, then there can be a large latency where it takes a very long
> > time for the parent to actually reap the child way after its memory
> > was long freed. A quicker way to know if a process's memory is freed
> > before it is reaped could be to read back /proc/<pid>/maps in
> > userspace of the victim <pid>, and that file will be empty for zombie
> > processes. So then one does not need wait for the parent to reap it. I
> > wonder how much of that 100ms you mentioned is actually the "Waiting
> > while Parent is reaping the child", than "memory freeing time". So
> > yeah for this second problem, the procfds work will help.
> >
> > By the way another approach that can provide a quick and asynchronous
> > notification of when the process memory is freed, is to monitor
> > sched_process_exit trace event using eBPF. You can tell eBPF the PID
> > that you want to monitor before the SIGKILL. As soon as the process
> > dies and its memory is freed, the eBPF program can send a notification
> > to user space (using the perf_events polling infra). The
> > sched_process_exit fires just after the mmput() happens so it is quite
> > close to when the memory is reclaimed. This also doesn't need any
> > kernel changes. I could come up with a prototype for this and
> > benchmark it on Android, if you want. Just let me know.
> 
> Perhaps I'm missing something, but if you want to know when a process has died
> after sending a SIGKILL to it, then why not just make the SIGKILL optionally
> block until the process has died completely? It'd be rather trivial to just
> store a pointer to an onstack completion inside the victim process' task_struct,
> and then complete it in free_task().

I'm not sure if that makes much semantic sense for how the signal handling is
supposed to work. Imagine a parent sends SIGKILL to its child, and then does
a wait(2). Because the SIGKILL blocks in your idea, then the wait cannot
execute, and because the wait cannot execute, the zombie task will not get
reaped and so the SIGKILL senders never gets unblocked and the whole thing
just gets locked up. No? I don't know it just feels incorrect.

Further, in your idea adding stuff to task_struct will simply bloat it - when
this task can easily be handled using eBPF without making any kernel changes.
Either by probing sched_process_free or sched_process_exit tracepoints.
Scheduler maintainers generally frown on adding stuff to task_struct
pointlessly there's a good reason since bloating it effects the performance
etc, and something like this would probably never be ifdef'd out behind a
CONFIG.

thanks,

 - Joel

