Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB9C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CA3206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="HzJjnq8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfGYM04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:26:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38118 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfGYM0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:26:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so15268213edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9aKNcQbqtSEQ2QLViWMxlIXutxeIxOIYk6E7Syx9R3M=;
        b=HzJjnq8ICgDrR/7Xt9pOiXw5RVUlib1TORuUxu71HvMJqO65/Ux6jTfikdMemxdpXs
         xFB0F/XS/GROuLQWSgIn2x9kn5aWhHaQWsS8cmP+5v21cBaEOV391x1lc/EP2gfOdFwM
         2Vuhy4xdru8Z3/6rvFqVnx0F+ShoAKvnJmHJYKdk+CK2Q2zSwzDo4NAg0J83Vn8RKwMO
         napUZgvr/ZqSc5Sm4vU5FKroJjmMGEn/1ctbCa8Iqi0bp+cKh5D5l2TQuhfESD+ZlwLy
         DjgBv9l3jBj+1KHDP9CQEXJ0x9Pml9WH+WdNCariBSFYNSwP3XuzOvmrukVquHywW4nl
         K0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9aKNcQbqtSEQ2QLViWMxlIXutxeIxOIYk6E7Syx9R3M=;
        b=HKwqok0J0C9PEQl/KxiSw0sbTkZcFOrltY8LumPmzV93pjQTRkkUCM/naw2QJa5fbC
         4nw1Uv5vTD2LpTmquYrGe7QNLSqe+DOKcWV13n08Kq/t5X54ZhF4/rtIaOLmOkic+Rtb
         6yZ4RRR5bocACeb1L32EG2MFLyYKk+29+myCh3buo2rbwzngcm7h2Db88U8uLTy/3Ckq
         hgTiDY074RYwUhEiB9TR4GngpDlRL+2vhsKwLSYb7u6kkh4faVkpLuc7H1Ssiv/nSS7z
         Zg3Rowv/OIXgSUE1i8VjEUBZnJ+h5LzqdXBwAaiv5R3lXINRbLV7VGimEMVA0tLBGk8O
         ZNvg==
X-Gm-Message-State: APjAAAUzBrv7Ug+aOn5ENZSy//u4ft8bOMn0VpweStf98bIq/lg984sF
        oyZcQ8F0q/NEdRloEYR7RQs=
X-Google-Smtp-Source: APXvYqypQMriHbVL4iQKojOec0aGpscsAqpWxtIHGIkJrv+ZbpQN6mKWH0jWKzkROfrq+kgYvpd7Bg==
X-Received: by 2002:a17:906:28c4:: with SMTP id p4mr68122099ejd.181.1564057613670;
        Thu, 25 Jul 2019 05:26:53 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id t13sm13350326edd.13.2019.07.25.05.26.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 05:26:52 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:26:51 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725122650.4i3arct5rpchqmyt@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <20190725103543.GF4707@redhat.com>
 <20190725104006.7myahvjtnbcgu3in@brauner.io>
 <20190725112503.GG4707@redhat.com>
 <20190725114359.GH4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725114359.GH4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 01:43:59PM +0200, Oleg Nesterov wrote:
> Or. We can change wait_consider_task() to not clear ->notask_error if
> WXXX and the child is PF_WAIT_PID.
> 
> This way you can "safely" use wait() without WNOHANG, it won't block if
> all the children which can report an even are PF_WAIT_PID.
> 
> But I do not understand your use-cases, I have no idea if this can help

One usecase (among others listed in the commit message) are shared
libraries. P_ALL is usually something you can't really use in a shared
library because you have no idea what else might be fork()ed off. Only
the main program can use this but none of the auxiliary libraries that
it uses.
The other way around you want to be able fork() off something without
affecting P_ALL in the main program.
The key is that you want to be able to create child processes in a
shared library without the main programing having to know about this so
that it can use P_ALL and never get stuff from the library.

Assume you have a project with a main loop with a million things
happening in that mainloop like some gui app running an avi video. For
example, gtk uses gstreamer which forks off all codecs in child
processes which are sandboxed for security. So gstreamer is using helper
processes in the background which are my children now. Now I'm creating
four more additional helper processes as well. Now, in my (glib, qt
whatever) mainloop on SIGCHLD some part of the app is checking with
WNHOANG and finds a process has exited. It's cleaning this thing up now
but it's not a process it wanted to clean up. The other part of the app
is now doing waitid(P_PID, pid) but will find the process already gone
it wanted to reap.

I hope I'm expressing this well enough.
