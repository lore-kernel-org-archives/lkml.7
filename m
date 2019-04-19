Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6108CC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24164222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="L1Yv37BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfDSSUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:20:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44203 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfDSSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:20:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so2868905pfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pBOpjqSVRQcgDQIE5fFC46VuJi1oW5SikRV9Jte1vfo=;
        b=L1Yv37BBepAhyKYzKJlE13j25B5kCNPn2+XRnAenXKKgY9NwF4JLxdXQro+0ZbbSwQ
         GYKoSuWf/wQ8Bgeeh+ZrKVtSjSaR7HV87OL/IFJEHebVoiCGJYqtW04iDFBvEDwrpM9s
         AQ4+LDp0xIsqQ3jvW6wK06zOXivtsqBGt+014=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pBOpjqSVRQcgDQIE5fFC46VuJi1oW5SikRV9Jte1vfo=;
        b=tCKw7tLTlgf1Uon2NE3Ugv7mIQNf13ibigGM/aea1VhsgUS/qx/QanrtClzr5rk2PI
         Dx7+zxrNMw2QtDVrQLG/rHOGFWOdhnXYdcoAjdrxlrJJa5ODOAd5NHykodzRj1xbCmjV
         ync3seGlxBZn1FE7C60NVzkUo01ae837MOogxI+9WFO+oe21RyaXOzV/CeRL6CpzmwoO
         yzbAW3oqIBcq+59tN3dc/AJ8U1ebv0zUAKY7l1rMS2RFI3pPS9RLJxfCUEdNL7A2AUzX
         +jMa/r2JJGsMP2bA9viyPxl2yCuUyc9MSxlEu6UirVNJHv/d3DIoVVHeUnr8WuYPmYww
         /MNQ==
X-Gm-Message-State: APjAAAVvRpGoIz4heRTsw5ynLxyC5rPV4jGwfEp+FQfKqi+mC4RYVwj4
        2OtEMg32aeFujUt3F8ZZjxrMJg==
X-Google-Smtp-Source: APXvYqyP4O7WNMvwdkkKOgCl4QSLjNofkCdc8dCkg4wZVjPAIm8Lro3vwAm1u4dnb1ruhonwoLXbMQ==
X-Received: by 2002:aa7:8212:: with SMTP id k18mr5357059pfi.50.1555697581663;
        Fri, 19 Apr 2019 11:13:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j20sm7036847pfn.84.2019.04.19.11.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 11:13:00 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:12:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net,
        rostedt@goodmis.org, dancol@google.com, christian@brauner.io,
        jannh@google.com, surenb@google.com, torvalds@linux-foundation.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Nadav Amit <namit@vmware.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190419181258.GA251571@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417130940.GC32622@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just returned to work today dealing with "life" issues, apologies for the
delays in replying. :)

On Wed, Apr 17, 2019 at 03:09:41PM +0200, Oleg Nesterov wrote:
> On 04/16, Joel Fernandes wrote:
> >
> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > >
> > > Could you explain when it should return POLLIN? When the whole process exits?
> >
> > It returns POLLIN when the task is dead or doesn't exist anymore, or when it
> > is in a zombie state and there's no other thread in the thread group.
> 
> IOW, when the whole thread group exits, so it can't be used to monitor sub-threads.
> 
> just in case... speaking of this patch it doesn't modify proc_tid_base_operations,
> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are going to use
> the anonymous file returned by CLONE_PIDFD ?

Yes, I am going to be converting to non-proc file returned by CLONE_PIDFD,
yes. (But I am still catching up with all threads and will read the latest on
whether we are still consider proc pidfds, last I understand - we are not).

> > > Then all you need is
> > >
> > > 	!task || task->exit_state && thread_group_empty(task)
> >
> > Yes this works as well, all the tests pass with your suggestion so I'll
> > change it to that. Although I will the be giving up returing EPOLLERR if the
> > task_struct doesn't exit. We don't need that, but I thought it was cool to
> > return it anyway.
> 
> OK, task == NULL means that it was already reaped by parent, pid_nr is free,
> probably useful....

Ok I will add that semantic as well then.

> > > Please do not use EXIT_DEAD/EXIT_ZOMBIE. And ->wait_pidfd should probably
> > > live in task->signal_struct.
> >
> > About wait_pidfd living in signal_struct, that wont work since the waitqueue
> > has to survive for the duration of the poll system call.
> 
> That is why I said this will need the additional cleanup in free_signal_struct().
> But I was wrong, somehow I forgot that free_poll_entry() needs wq_head->lock ;)
> so this will need much more complications, lets forget it...

Ok np :)

> > Also the waitqueue living in struct pid solves the de_thread() issue I
> > mentioned later in the following thread and in the commit message:
> > https://lore.kernel.org/patchwork/comment/1257175/
> 
> Hmm...
> 
> 	2. By including the struct pid for the waitqueue means that during
> 	de_exec, the thread doing de_thread() automatically gets the new
> 	waitqueue/pid even though its task_struct is different.
> 
> this one?
> 
> this is not true, or I do not understand...
> 
> it gets the _same_ (old, not new) PIDTYPE_TGID pid even if it changes task_struct.
> But probably this is what you actually meant, because this is what your patch wants
> or I am totally confused.

Yes, that's what I meant, sorry.

> And note that exec/de_thread doesn't change ->signal_struct, so I do not understand
> you anyway. Nevermind.

Yes right, but the signal_struct would suffer from the waitqueue lifetime
issue anyway so we can't use it. The current patch works well for everything.

thanks,

- Joel

