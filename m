Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C777E22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfGZL7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:59:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36315 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGZL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:59:52 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqyt1-0004Au-UU; Fri, 26 Jul 2019 05:59:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqyt0-0000uG-Ri; Fri, 26 Jul 2019 05:59:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
References: <20190724144651.28272-1-christian@brauner.io>
        <20190724144651.28272-2-christian@brauner.io>
        <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
        <87zhl2wabp.fsf@xmission.com>
        <20190726080133.yrxsaaxasxudyjj4@brauner.io>
Date:   Fri, 26 Jul 2019 06:59:39 -0500
In-Reply-To: <20190726080133.yrxsaaxasxudyjj4@brauner.io> (Christian Brauner's
        message of "Fri, 26 Jul 2019 10:01:34 +0200")
Message-ID: <87wog5qa50.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hqyt0-0000uG-Ri;;;mid=<87wog5qa50.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18txf5UV7zGzyXMtwHXajRZzLdtwucGOwM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 1/5] exit: kill struct waitid_info
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Thu, Jul 25, 2019 at 07:46:50AM -0500, Eric W. Biederman wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
>> >>
>> >> The code here uses a struct waitid_info to catch basic information about
>> >> process exit including the pid, uid, status, and signal that caused the
>> >> process to exit. This information is then stuffed into a struct siginfo
>> >> for the waitid() syscall. That seems like an odd thing to do. We can
>> >> just pass down a siginfo_t struct directly which let's us cleanup and
>> >> simplify the whole code quite a bit.
>> >
>> > Ack. Except I'd like the commit message to explain where this comes
>> > from instead of that "That seems like an odd thing to do".
>> >
>> > The _original_ reason for "struct waitid_info" was that "siginfo_t" is
>> > huge because of all the insane padding that various architectures do.
>> >
>> > So it was introduced by commit 67d7ddded322 ("waitid(2): leave copyout
>> > of siginfo to syscall itself") very much to avoid stack usage issues.
>> > And I quote:
>> >
>> >     collect the information needed for siginfo into
>> >     a small structure (waitid_info)
>> >
>> > simply because "sigset_t" was big.
>> >
>> > But that size came from the explicit "pad it out to 128 bytes for
>> > future expansion that will never happen", and the kernel using the
>> > same exact sigset_t that was exposed to user space.
>> >
>> > Then in commit 4ce5f9c9e754 ("signal: Use a smaller struct siginfo in
>> > the kernel") we got rid of the insane padding for in-kernel use,
>> > exactly because it causes issues like this.
>> >
>> > End result: that "struct waitid_info" no longer makes sense. It's not
>> > appreciably smaller than kernel_siginfo_t is today, but it made sense
>> > at the time.
>> 
>> Apologies.  I meant to reply yesterday but I was preempted by baby
>> issues.
>> 
>> I strongly disagree that this direction makes sense.  The largest
>> value that I see from struct waitid_info is that it makes it possible to
>> reason about which values are returned where struct kernel_siginfo does
>> not.
>> 
>> One of the details the existence of struct waitid_info makes clear is
>> that unlike the related child death path the wait code does not
>> fillin si_utime and si_stime.  Which is very important to know when you
>> are dealing with y2038 issues and Arnd Bergmann is.
>> 
>> The most egregious example I know of using siginfo wrong is:
>> 70f1b0d34bdf ("signal/usb: Replace kill_pid_info_as_cred with
>> kill_pid_usb_asyncio").  But just by moving struct siginfo out of the
>> program logic and into dedicated little functions that just deal with
>> the craziness of struct siginfo I have found lots of little bugs.
>> 
>> We don't need that kind of invitation to bugs in the wait logic.
>
> I don't think it's a strong enough argument for rejecting this change.
> Suspecting that something might go wrong if we simplify something is a
> valid call to proceed with caution and be on the lookout for potential
> regressions so we can react fast. I respect that. But it's not
> necessarily a good argument to reject a change.

Except your change was not a simplification.   Your change was
a substitution to do the work of filling in struct kernel_siginfo in 4
locations instead of just 2.

The only simplification came from not using unsafe_put_user.  Which is
valid but has nothing to do with struct waitid_info.

> I'm happy to switch from an initializer (which is not even clear is a
> bug) to using clear_siginfo().

I just double checked the definitions in signal_types.h and
uapi/asm-generic/siginfo.h and there is definitely padding on 64bit.
So yes barring magic compiler plug ins it is a bug.

> And I'm also going to split this patch out of the P_PIDFD patch but I'm
> going to send this out again. I haven't heard a sound argument why
> this
> patch is worse than what we have right now in there.

Then I am afraid I have not expressed myself well.

When I read through this patch I saw.
- A bug when dealing with struct kernel_siginfo.
- A substitution from of struct waitid_info to struct kernel_siginfo.
- An actual simplification in replacing several unsafe_put_user calls
  with copy_siginfo_to_user.
- A gratuitous change in change the order of several of the statements.
- No simplification in the logic of do_wait.

Or in short I saw you did "s/struct waitid_info/struct kernel_siginfo/"
and introduced bugs.  Further you increased the number of locations that
we need to be very careful with struct kernel_siginfo from 2 to 4.


For myself I am extremely sensitive to people taking a cavalier attitude
to using siginfo.  So that we have a chance of maintaining that code I
have been steadily cleaning it up for the last year or two.  I hope
things are better now.  I think I have gotten the core code that
manipulates struct siginfo from something that no one had the time to
read through and understand to something that a person can look at and
in a couple hours understand the nuances of.

But it still remains the case that we must be much more careful with
struct siginfo than we are with other structures.  It still remains
entirely too easy to fill it out wrong unless you are paying close
attention to all of the details.


Or in other words I think if you simplified your cleanup something like
below it would be a good cleanup.

Eric


diff --git a/kernel/exit.c b/kernel/exit.c
index 3d86930f035e..9ce896b478f5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1552,11 +1552,12 @@ static long do_wait(struct wait_opts *wo)
 	return retval;
 }
 
-static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
+static long kernel_waitid(int which, pid_t upid, struct kernel_siginfo *info,
 			  int options, struct rusage *ru)
 {
 	struct wait_opts wo;
 	struct pid *pid = NULL;
+	struct waitid_info winfo = { .status = 0 };
 	enum pid_type type;
 	long ret;
 
@@ -1592,11 +1593,21 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 	wo.wo_type	= type;
 	wo.wo_pid	= pid;
 	wo.wo_flags	= options;
-	wo.wo_info	= infop;
+	wo.wo_info	= &winfo;
 	wo.wo_rusage	= ru;
 	ret = do_wait(&wo);
-
 	put_pid(pid);
+
+	clear_siginfo(info);
+	if (ret > 0) {
+		info->si_signo = SIGCHLD;
+		info->si_errno = 0;
+		info->si_code = winfo.cause;
+		info->si_pid = winfo.pid;
+		info->si_uid = winfo.uid;
+		info->si_status = winfo.status;
+	}
+
 	return ret;
 }
 
@@ -1604,33 +1615,18 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 		infop, int, options, struct rusage __user *, ru)
 {
 	struct rusage r;
-	struct waitid_info info = {.status = 0};
+	struct kernel_siginfo info;
 	long err = kernel_waitid(which, upid, &info, options, ru ? &r : NULL);
-	int signo = 0;
 
 	if (err > 0) {
-		signo = SIGCHLD;
 		err = 0;
 		if (ru && copy_to_user(ru, &r, sizeof(struct rusage)))
 			return -EFAULT;
 	}
-	if (!infop)
-		return err;
 
-	if (!user_access_begin(infop, sizeof(*infop)))
+	if (infop && copy_siginfo_to_user(infop, &info))
 		return -EFAULT;
-
-	unsafe_put_user(signo, &infop->si_signo, Efault);
-	unsafe_put_user(0, &infop->si_errno, Efault);
-	unsafe_put_user(info.cause, &infop->si_code, Efault);
-	unsafe_put_user(info.pid, &infop->si_pid, Efault);
-	unsafe_put_user(info.uid, &infop->si_uid, Efault);
-	unsafe_put_user(info.status, &infop->si_status, Efault);
-	user_access_end();
 	return err;
-Efault:
-	user_access_end();
-	return -EFAULT;
 }
 
 long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
@@ -1724,11 +1720,9 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 		struct compat_rusage __user *, uru)
 {
 	struct rusage ru;
-	struct waitid_info info = {.status = 0};
+	struct kernel_siginfo info;
 	long err = kernel_waitid(which, pid, &info, options, uru ? &ru : NULL);
-	int signo = 0;
 	if (err > 0) {
-		signo = SIGCHLD;
 		err = 0;
 		if (uru) {
 			/* kernel_waitid() overwrites everything in ru */
@@ -1741,23 +1735,9 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 		}
 	}
 
-	if (!infop)
-		return err;
-
-	if (!user_access_begin(infop, sizeof(*infop)))
+	if (infop && copy_siginfo_to_user32(infop, &info))
 		return -EFAULT;
-
-	unsafe_put_user(signo, &infop->si_signo, Efault);
-	unsafe_put_user(0, &infop->si_errno, Efault);
-	unsafe_put_user(info.cause, &infop->si_code, Efault);
-	unsafe_put_user(info.pid, &infop->si_pid, Efault);
-	unsafe_put_user(info.uid, &infop->si_uid, Efault);
-	unsafe_put_user(info.status, &infop->si_status, Efault);
-	user_access_end();
 	return err;
-Efault:
-	user_access_end();
-	return -EFAULT;
 }
 #endif
 



