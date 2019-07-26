Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C2BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733D621951
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SdQArZa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGZMhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:37:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44330 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfGZMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:37:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so24739515pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xWLxR5mxn/WIqVIPsCOMymm5CovvcceNPc0vJVvgU3o=;
        b=SdQArZa52WyEjXjSDZG46CrKHmnd4cER3oWhOcTwsDK9CrBF1z3GLxerEb53Pc3th+
         wpQuMYoPC5zou+UIKoOBmPTUKOC2XfJHOAO9cBDVtwQzbzMXVKh26Gy1ZrZBJvLFQYAR
         57SLCwaD4j+chWRqSsNsiEidmove1ukOzz/TWCApHABTvgxHyp5C/9zaJOYbvs3vEHOd
         a1z2ZjJDaR1vTW7w697hPBd7TvOqEjhOuMv6+h2mfjOFuTHdrAlp5Ag0EL9jWaIIc9NI
         2aHkAPubigZSAgLcpS8h0Fgc1ziRMvk6oXKb70stiTX9/UbhpM9tYaMAsbYq1hHXxKfA
         qk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xWLxR5mxn/WIqVIPsCOMymm5CovvcceNPc0vJVvgU3o=;
        b=Rg6ZtSsWX5fEGINaYbgkeJlMF0A1i7+FKU9J77tIRGc+TXR4WQlC43qW3heLO+NQte
         svP+eI37oJonNLj7rFag8pHNjgUnHtBEparQHvrXt9IwSZpf5kTpoS9uKpeHwnfDdusB
         m3JCUWhjDHbkjT1KKiYnf8GHFuNVSZb5/VYXAD80vDvahVJmUS98FwnA4tdcz+WB1dut
         pKZ9hdb9SA+V/K0t65Rf0Ke4v6Dk7/SnNxsNeJ08Iav6U8e+7uaX4Hd9xJYZLNuH5XxA
         pFnHY63hprkYlhtMo2vHIiyeOgeYabXGx4JMT/WdgH4fqp90zVX6TWTFSXrGvXBrwBis
         jKRg==
X-Gm-Message-State: APjAAAW/BH0ZtLuoDO57PqXNbDVc4I8pSepnhTGmmA8iQLS7gaf3j+bK
        m21TUOVLZFfLIikDayX1pyE=
X-Google-Smtp-Source: APXvYqw3rSHg9MubdAi+98gPT17cGWZXqONjc569gyjeU1TkfxXlM/bk+ddhqB0l2XJcZ17uEZpl5g==
X-Received: by 2002:a63:6a81:: with SMTP id f123mr12428028pgc.348.1564144669760;
        Fri, 26 Jul 2019 05:37:49 -0700 (PDT)
Received: from brauner.io ([172.58.30.217])
        by smtp.gmail.com with ESMTPSA id h70sm48307305pgc.36.2019.07.26.05.37.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 05:37:48 -0700 (PDT)
Date:   Fri, 26 Jul 2019 14:37:39 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
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
Subject: Re: [RFC][PATCH 1/5] exit: kill struct waitid_info
Message-ID: <20190726123737.axwqx6zeeza5dmpb@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-2-christian@brauner.io>
 <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
 <87zhl2wabp.fsf@xmission.com>
 <20190726080133.yrxsaaxasxudyjj4@brauner.io>
 <87wog5qa50.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wog5qa50.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 06:59:39AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian@brauner.io> writes:
> 
> > On Thu, Jul 25, 2019 at 07:46:50AM -0500, Eric W. Biederman wrote:
> >> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >> 
> >> > On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
> >> >>
> >> >> The code here uses a struct waitid_info to catch basic information about
> >> >> process exit including the pid, uid, status, and signal that caused the
> >> >> process to exit. This information is then stuffed into a struct siginfo
> >> >> for the waitid() syscall. That seems like an odd thing to do. We can
> >> >> just pass down a siginfo_t struct directly which let's us cleanup and
> >> >> simplify the whole code quite a bit.
> >> >
> >> > Ack. Except I'd like the commit message to explain where this comes
> >> > from instead of that "That seems like an odd thing to do".
> >> >
> >> > The _original_ reason for "struct waitid_info" was that "siginfo_t" is
> >> > huge because of all the insane padding that various architectures do.
> >> >
> >> > So it was introduced by commit 67d7ddded322 ("waitid(2): leave copyout
> >> > of siginfo to syscall itself") very much to avoid stack usage issues.
> >> > And I quote:
> >> >
> >> >     collect the information needed for siginfo into
> >> >     a small structure (waitid_info)
> >> >
> >> > simply because "sigset_t" was big.
> >> >
> >> > But that size came from the explicit "pad it out to 128 bytes for
> >> > future expansion that will never happen", and the kernel using the
> >> > same exact sigset_t that was exposed to user space.
> >> >
> >> > Then in commit 4ce5f9c9e754 ("signal: Use a smaller struct siginfo in
> >> > the kernel") we got rid of the insane padding for in-kernel use,
> >> > exactly because it causes issues like this.
> >> >
> >> > End result: that "struct waitid_info" no longer makes sense. It's not
> >> > appreciably smaller than kernel_siginfo_t is today, but it made sense
> >> > at the time.
> >> 
> >> Apologies.  I meant to reply yesterday but I was preempted by baby
> >> issues.
> >> 
> >> I strongly disagree that this direction makes sense.  The largest
> >> value that I see from struct waitid_info is that it makes it possible to
> >> reason about which values are returned where struct kernel_siginfo does
> >> not.
> >> 
> >> One of the details the existence of struct waitid_info makes clear is
> >> that unlike the related child death path the wait code does not
> >> fillin si_utime and si_stime.  Which is very important to know when you
> >> are dealing with y2038 issues and Arnd Bergmann is.
> >> 
> >> The most egregious example I know of using siginfo wrong is:
> >> 70f1b0d34bdf ("signal/usb: Replace kill_pid_info_as_cred with
> >> kill_pid_usb_asyncio").  But just by moving struct siginfo out of the
> >> program logic and into dedicated little functions that just deal with
> >> the craziness of struct siginfo I have found lots of little bugs.
> >> 
> >> We don't need that kind of invitation to bugs in the wait logic.
> >
> > I don't think it's a strong enough argument for rejecting this change.
> > Suspecting that something might go wrong if we simplify something is a
> > valid call to proceed with caution and be on the lookout for potential
> > regressions so we can react fast. I respect that. But it's not
> > necessarily a good argument to reject a change.
> 
> Except your change was not a simplification.   Your change was
> a substitution to do the work of filling in struct kernel_siginfo in 4
> locations instead of just 2.
> 
> The only simplification came from not using unsafe_put_user.  Which is
> valid but has nothing to do with struct waitid_info.
> 
> > I'm happy to switch from an initializer (which is not even clear is a
> > bug) to using clear_siginfo().
> 
> I just double checked the definitions in signal_types.h and
> uapi/asm-generic/siginfo.h and there is definitely padding on 64bit.
> So yes barring magic compiler plug ins it is a bug.
> 
> > And I'm also going to split this patch out of the P_PIDFD patch but I'm
> > going to send this out again. I haven't heard a sound argument why
> > this
> > patch is worse than what we have right now in there.
> 
> Then I am afraid I have not expressed myself well.
> 
> When I read through this patch I saw.
> - A bug when dealing with struct kernel_siginfo.
> - A substitution from of struct waitid_info to struct kernel_siginfo.
> - An actual simplification in replacing several unsafe_put_user calls
>   with copy_siginfo_to_user.
> - A gratuitous change in change the order of several of the statements.
> - No simplification in the logic of do_wait.

I'm not going to feel bad for trying to improve a piece of code and not
getting it right the first time.
Removal of a custom struct that is only used to copy bits of information
into another struct for which we have a dedicated in-kernel struct to
avoid exactly that seems like a valid use of
s/<custom-struct>/<dedicated-kernel-struct>/ to me; especially since I
needed to touch that file anyway.

> 
> Or in short I saw you did "s/struct waitid_info/struct kernel_siginfo/"
> and introduced bugs.  Further you increased the number of locations that
> we need to be very careful with struct kernel_siginfo from 2 to 4.

If you're concerned about siginfo_t being used in more places than it is
right now, then please put a comment above it that it should be avoided
and that because of architectural nuances clear_signfo() needs to be
used to initialize it correctly.

Christian
