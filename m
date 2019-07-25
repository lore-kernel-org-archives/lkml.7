Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B75C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F9E21851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbfGYQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:57:37 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33382 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfGYQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:57:36 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqh3a-0001sw-Mh; Thu, 25 Jul 2019 10:57:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqh3W-00083e-6X; Thu, 25 Jul 2019 10:57:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, keescook@chromium.org, joel@joelfernandes.org,
        tglx@linutronix.de, tj@kernel.org, dhowells@redhat.com,
        jannh@google.com, luto@kernel.org, akpm@linux-foundation.org,
        cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
References: <20190724144651.28272-1-christian@brauner.io>
        <20190724144651.28272-5-christian@brauner.io>
        <20190725103543.GF4707@redhat.com>
        <20190725104006.7myahvjtnbcgu3in@brauner.io>
        <20190725112503.GG4707@redhat.com> <20190725114359.GH4707@redhat.com>
        <20190725122650.4i3arct5rpchqmyt@brauner.io>
Date:   Thu, 25 Jul 2019 11:57:19 -0500
In-Reply-To: <20190725122650.4i3arct5rpchqmyt@brauner.io> (Christian Brauner's
        message of "Thu, 25 Jul 2019 14:26:51 +0200")
Message-ID: <878ssmuk5s.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hqh3W-00083e-6X;;;mid=<878ssmuk5s.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18QSBD8aKgfkOI6Bh2C9GVbrFxs+FxUpU8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Thu, Jul 25, 2019 at 01:43:59PM +0200, Oleg Nesterov wrote:
>> Or. We can change wait_consider_task() to not clear ->notask_error if
>> WXXX and the child is PF_WAIT_PID.
>> 
>> This way you can "safely" use wait() without WNOHANG, it won't block if
>> all the children which can report an even are PF_WAIT_PID.
>> 
>> But I do not understand your use-cases, I have no idea if this can help
>
> One usecase (among others listed in the commit message) are shared
> libraries. P_ALL is usually something you can't really use in a shared
> library because you have no idea what else might be fork()ed off. Only
> the main program can use this but none of the auxiliary libraries that
> it uses.
> The other way around you want to be able fork() off something without
> affecting P_ALL in the main program.
> The key is that you want to be able to create child processes in a
> shared library without the main programing having to know about this so
> that it can use P_ALL and never get stuff from the library.
>
> Assume you have a project with a main loop with a million things
> happening in that mainloop like some gui app running an avi video. For
> example, gtk uses gstreamer which forks off all codecs in child
> processes which are sandboxed for security. So gstreamer is using helper
> processes in the background which are my children now. Now I'm creating
> four more additional helper processes as well. Now, in my (glib, qt
> whatever) mainloop on SIGCHLD some part of the app is checking with
> WNHOANG and finds a process has exited. It's cleaning this thing up now
> but it's not a process it wanted to clean up. The other part of the app
> is now doing waitid(P_PID, pid) but will find the process already gone
> it wanted to reap.
>
> I hope I'm expressing this well enough.


I think so.

A) I think Oleg is correct that you should test the flag in
   do_wait_thread rather than elsewhere.

B) We have a deficiency in do_wait that should be addressed.  The
   do_wait function does not have a fast path for waiting on a
   particular process.  For adding this functionality I such a fast path
   goes from a nice to have to a necessity for getting all of the
   fiddly details correct.

C) I believe the semantics should be that while such a file descriptor
   is open, only that file descriptor can be used to reap the process.
   And that it should be allowed to pass the file descriptor between
   processes.  Which means the parent can die and the process be
   reparted to init and we should still be able to reap the process with
   the file descriptor.

D) I think it is a toss up how we should deal with such a process when
   the file descriptor is closed.  Setting the process to autoreap
   or reparent to init and let init deal with it.  My inclination is
   that autoreap is the correct behavior.
   
Eric

  



