Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F7BC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D32720651
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfCNUtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:49:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42972 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfCNUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:49:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id m4so5564843oim.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wt8gOJHFNkRgmDnlN6CzGFr6EJDxliPV9hJpCDt7EGo=;
        b=ne6D0CdZSGZgQ5xrmNansvx3ZO02jWRYBq+5HT5sa3WJ68adWYnR90jM18VCRkkZGA
         5TLggVN7MZnNJsqsalWtBzz4psuh1vNZHL2rqLtH6e2ti4ibjeIqKcYNvKuJO5qTwnmh
         9bnY58+W11Jvv0NTWt+hwl4cIZzLQAxJoI/Je9STVwOzZGxOxUhb6wscCX1fX+EORWFi
         c1U2V20dPct5MSpxdgT5aX23bs2QNbkGoxwVKaRlgBi4mc2SW/8vH/e73/oIZaWiU/OU
         UTqzTmEo00xJ96WTLAE1FK+4l3QAFvqxntsS5s+wIWYrZKfyv2iJwpmCUa0BKJYsbGyc
         SBHQ==
X-Gm-Message-State: APjAAAVYGIDnvOcmps/MrpoBQ2KKutckjR4MBJHkdXT7+oilpsYzCSuS
        H5sTt1xG8pMBPj/uuInvdZY=
X-Google-Smtp-Source: APXvYqzJniSbh5HRjo72T9qstZDGb7JgiFghb3SsQXdE4S/CQaQ7WibPgL0TxWG1ub/BYjnvsmcb2g==
X-Received: by 2002:aca:2315:: with SMTP id e21mr303777oie.33.1552596557096;
        Thu, 14 Mar 2019 13:49:17 -0700 (PDT)
Received: from sultan-box.localdomain ([2600:1700:7c70:1680::21])
        by smtp.gmail.com with ESMTPSA id j21sm6058175otr.28.2019.03.14.13.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 13:49:16 -0700 (PDT)
Date:   Thu, 14 Mar 2019 13:49:11 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20190314204911.GA875@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
 <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 10:47:17AM -0700, Joel Fernandes wrote:
> About the 100ms latency, I wonder whether it is that high because of
> the way Android's lmkd is observing that a process has died. There is
> a gap between when a process memory is freed and when it disappears
> from the process-table.  Once a process is SIGKILLed, it becomes a
> zombie. Its memory is freed instantly during the SIGKILL delivery (I
> traced this so that's how I know), but until it is reaped by its
> parent thread, it will still exist in /proc/<pid> . So if testing the
> existence of /proc/<pid> is how Android is observing that the process
> died, then there can be a large latency where it takes a very long
> time for the parent to actually reap the child way after its memory
> was long freed. A quicker way to know if a process's memory is freed
> before it is reaped could be to read back /proc/<pid>/maps in
> userspace of the victim <pid>, and that file will be empty for zombie
> processes. So then one does not need wait for the parent to reap it. I
> wonder how much of that 100ms you mentioned is actually the "Waiting
> while Parent is reaping the child", than "memory freeing time". So
> yeah for this second problem, the procfds work will help.
>
> By the way another approach that can provide a quick and asynchronous
> notification of when the process memory is freed, is to monitor
> sched_process_exit trace event using eBPF. You can tell eBPF the PID
> that you want to monitor before the SIGKILL. As soon as the process
> dies and its memory is freed, the eBPF program can send a notification
> to user space (using the perf_events polling infra). The
> sched_process_exit fires just after the mmput() happens so it is quite
> close to when the memory is reclaimed. This also doesn't need any
> kernel changes. I could come up with a prototype for this and
> benchmark it on Android, if you want. Just let me know.

Perhaps I'm missing something, but if you want to know when a process has died
after sending a SIGKILL to it, then why not just make the SIGKILL optionally
block until the process has died completely? It'd be rather trivial to just
store a pointer to an onstack completion inside the victim process' task_struct,
and then complete it in free_task().

Thanks,
Sultan
