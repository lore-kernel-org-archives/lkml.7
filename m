Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BEC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4882087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfD0JdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:33:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57970 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfD0JdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:33:20 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5FB461F453;
        Sat, 27 Apr 2019 09:33:19 +0000 (UTC)
Date:   Sat, 27 Apr 2019 09:33:19 +0000
From:   Eric Wong <e@80x24.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, Omar Kilani <omar.kilani@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190427093319.sgicqik2oqkez3wk@dcvr>
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424193903.swlfmfuo6cqnpkwa@dcvr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Omar Kilani <omar.kilani@gmail.com> wrote:
> > Hi there,
> > 
> > I’m still trying to piece together a reproducible test that triggers
> > this, but I wanted to post in case someone goes “hmmm... change X
> > might have done this”.
> 
> Maybe Davidlohr knows, since he's responsible for most of the
> epoll changes in 5.0.

Well, I am not sure if I am hitting the same problem Omar is
hitting.  But I did find an epoll_pwait regression in 5.0:

epoll_pwait seems unresponsive to SIGURG in my
heavily-parallelized use case[1] on 5.0.9.  I bisected it to
commit 854a6ed56839a40f6b5d02a2962f48841482eec4
("signal: Add restore_user_sigmask()")

Just reverting the fs/eventpoll.c change in 854a6ed56 seems
enough to fix the non-responsive epoll_pwait for me.  I have not
looked deeply into this, but perhaps the signal_pending check in
restore_user_sigmask is racy w.r.t. epoll.  It is been a while
since I have looked at kernel stuff, myself.

Anyways, this revert works; but I'm not 100% sure why...

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a5d219d920e7..151739d76801 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2247,7 +2247,20 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 
 	error = do_epoll_wait(epfd, events, maxevents, timeout);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	/*
+	 * If we changed the signal mask, we need to restore the original one.
+	 * In case we've got a signal while waiting, we do not restore the
+	 * signal mask yet, and we allow do_signal() to deliver the signal on
+	 * the way back to userspace, before the signal mask is restored.
+	 */
+	if (sigmask) {
+		if (error == -EINTR) {
+			memcpy(&current->saved_sigmask, &sigsaved,
+			       sizeof(sigsaved));
+			set_restore_sigmask();
+		} else
+			set_current_blocked(&sigsaved);
+	}
 
 	return error;
 }
@@ -2272,7 +2285,20 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 
 	err = do_epoll_wait(epfd, events, maxevents, timeout);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	/*
+	 * If we changed the signal mask, we need to restore the original one.
+	 * In case we've got a signal while waiting, we do not restore the
+	 * signal mask yet, and we allow do_signal() to deliver the signal on
+	 * the way back to userspace, before the signal mask is restored.
+	 */
+	if (sigmask) {
+		if (err == -EINTR) {
+			memcpy(&current->saved_sigmask, &sigsaved,
+			       sizeof(sigsaved));
+			set_restore_sigmask();
+		} else
+			set_current_blocked(&sigsaved);
+	}
 
 	return err;
 }

Comments and/or a proper fix would be greatly appreciated.

[1] my test case is running the cmogstored 1.7.0 test suite
    in amd64 Debian stable environment.
    test/mgmt_auto_adjust would get stuck and time-out after 60s
    on vanilla v5.0.9

    tgz: https://bogomips.org/cmogstored/files/cmogstored-1.7.0.tar.gz
    # Standard autotools install,  N=32 or some high-ish number
    ./configure
    make -j$N
    make check -j$N

    # OR git clone https://bogomips.org/cmogstored.git

So, requoting the rest of Omar's original report, here; since
I am not sure if his use case involves epoll_pwait like mine does:

> Omar Kilani <omar.kilani@gmail.com> wrote:
> > Basically, something’s broken (or at least, has changed enough to
> > cause problems in user space) in epoll since 5.0. It’s still broken in
> > 5.1-rc5.
> > 
> > It doesn’t happen 100% of the time. It’s sort of hard to pin down but
> > I’ve observed the following:
> > 
> > * nginx not accepting connections under load
> > * A java app which uses netty / NIO having strange writability
> > semantics on channels, which confuses netty / java enough to not
> > properly flush written data on the socket.
> > 
> > I went and tested these Linux kernels:
> > 
> > 4.20.17
> > 4.19.32
> > 4.14.111
> > 
> > And the issue(s) do not show up there.
> > 
> > I’m still actively chasing this up, and will report back — I haven’t
> > touched kernel code in 15 years so I’m a little rusty. :)
> > 
> > Regards,
> > Omar
