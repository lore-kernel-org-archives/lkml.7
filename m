Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A70C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3C921901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Is5BWPCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGZIBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:01:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36057 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:01:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so53460239wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZB8dfk0+fR1uXGnwfzqMYaZMnZMymTDsEAfbI/dGGgM=;
        b=Is5BWPCunQpjy7PvPMsrepFEaIGGTLAgm+Qb7dy7rLrzpOI/1YYXPHC9DF2tVSZlAu
         5MEh2PX9qkakBs66dvrzdjb5uiN83FVXp4OI12kzBTGOrsXmtRFJQIpzZ1qVRdUXz65m
         P9nqoM8Zyekr4Zn2+AhWU9HR67IJt6MevwL0ATW7qFumMQUHzmJG9jDhFVtOOyKjbc1L
         1b3q/ok8kDo7rSQlCzbPmb/OhgQOvXhDZTLSMJ0ViyjUMtGTY4JAanmwVsYojCGSK+bR
         2+QKmflufD08AKH8HOvIM3Jbe7pMKykUqxyioUpf/UgJNx5vZtG5Sk0ljUj8u2DWyU8c
         zoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZB8dfk0+fR1uXGnwfzqMYaZMnZMymTDsEAfbI/dGGgM=;
        b=aphwGhaHS4gF+VT8w6wDrsEz08tGd/twNHUtB9uGEKPLfnwE8d9WADrJNvtuGzrHGy
         oiJYOFOkcMqmDuxOwciYXICUOs5Sr0iGoMzNFOqVTFyp0nFider7V2ZDduD6eM5ogS7E
         Zzgn/SvUQICSMCk3M2B/g+eC4VF2fAPsPZJNbFQNXDV9iQiaqlq5sbOuA4Clow81vxcW
         1iXaoQgx9XLM5TOVExuLr/cDJpjgxpgZa9igw8IJZU/2d40KS/b0JyvLMc85v5wR0DrP
         /2nB4DxK6MWzwYf9cUt4fZcaef1pPamt5TfVQDOIN6pJztEPubD7uedgU/DA6L0PkiPi
         Pntw==
X-Gm-Message-State: APjAAAWk9Zl3MjxSub0UWIF75qolUk3yLehvOsZTXr5qhr44xX9Abkvm
        Q0eUi4Wej2p9pqDRgIYobtY=
X-Google-Smtp-Source: APXvYqwKBoAx+AnXpV27UMAa9BwVVgbPG1g4+ekndfqDxqQ0yHizqVxKrn6C35gyhmIDeMJfd8tE1g==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr71091327wrm.322.1564128096151;
        Fri, 26 Jul 2019 01:01:36 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id s15sm32108777wrw.21.2019.07.26.01.01.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 01:01:35 -0700 (PDT)
Date:   Fri, 26 Jul 2019 10:01:34 +0200
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
Message-ID: <20190726080133.yrxsaaxasxudyjj4@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-2-christian@brauner.io>
 <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
 <87zhl2wabp.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhl2wabp.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 07:46:50AM -0500, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
> >>
> >> The code here uses a struct waitid_info to catch basic information about
> >> process exit including the pid, uid, status, and signal that caused the
> >> process to exit. This information is then stuffed into a struct siginfo
> >> for the waitid() syscall. That seems like an odd thing to do. We can
> >> just pass down a siginfo_t struct directly which let's us cleanup and
> >> simplify the whole code quite a bit.
> >
> > Ack. Except I'd like the commit message to explain where this comes
> > from instead of that "That seems like an odd thing to do".
> >
> > The _original_ reason for "struct waitid_info" was that "siginfo_t" is
> > huge because of all the insane padding that various architectures do.
> >
> > So it was introduced by commit 67d7ddded322 ("waitid(2): leave copyout
> > of siginfo to syscall itself") very much to avoid stack usage issues.
> > And I quote:
> >
> >     collect the information needed for siginfo into
> >     a small structure (waitid_info)
> >
> > simply because "sigset_t" was big.
> >
> > But that size came from the explicit "pad it out to 128 bytes for
> > future expansion that will never happen", and the kernel using the
> > same exact sigset_t that was exposed to user space.
> >
> > Then in commit 4ce5f9c9e754 ("signal: Use a smaller struct siginfo in
> > the kernel") we got rid of the insane padding for in-kernel use,
> > exactly because it causes issues like this.
> >
> > End result: that "struct waitid_info" no longer makes sense. It's not
> > appreciably smaller than kernel_siginfo_t is today, but it made sense
> > at the time.
> 
> Apologies.  I meant to reply yesterday but I was preempted by baby
> issues.
> 
> I strongly disagree that this direction makes sense.  The largest
> value that I see from struct waitid_info is that it makes it possible to
> reason about which values are returned where struct kernel_siginfo does
> not.
> 
> One of the details the existence of struct waitid_info makes clear is
> that unlike the related child death path the wait code does not
> fillin si_utime and si_stime.  Which is very important to know when you
> are dealing with y2038 issues and Arnd Bergmann is.
> 
> The most egregious example I know of using siginfo wrong is:
> 70f1b0d34bdf ("signal/usb: Replace kill_pid_info_as_cred with
> kill_pid_usb_asyncio").  But just by moving struct siginfo out of the
> program logic and into dedicated little functions that just deal with
> the craziness of struct siginfo I have found lots of little bugs.
> 
> We don't need that kind of invitation to bugs in the wait logic.

I don't think it's a strong enough argument for rejecting this change.
Suspecting that something might go wrong if we simplify something is a
valid call to proceed with caution and be on the lookout for potential
regressions so we can react fast. I respect that. But it's not
necessarily a good argument to reject a change.

I'm happy to switch from an initializer (which is not even clear is a
bug) to using clear_siginfo().
And I'm also going to split this patch out of the P_PIDFD patch but I'm
going to send this out again. I haven't heard a sound argument why this
patch is worse than what we have right now in there.

Christian
