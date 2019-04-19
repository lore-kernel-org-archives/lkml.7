Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BF2C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44200217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555717097;
	bh=fwD6W5q497qhpOWm5wsr2z9tFyr326imalozMvrt/l4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nLG8xrqxbuspDSf0Q3mdZBr01Jh5mMGtmw4dg95O13ez6JZouwlKxRb+NEkdw03GG
	 kIurkUwew66aFagsR6f9crH8erIQc3+S2kVWG3CN9h1SbtI8VFPtQYUt/bSj5g7enV
	 pTfSZl8n02GZau8vCdpO2eaCZhP+zKUUXbOeVZcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDSXiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:38:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46929 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDSXiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:38:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so5740832ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpJdQEss2Hf2fCZ1JCBrqDkW/3xv13oIKhlDU7E2du4=;
        b=CaOcR/pqmdOo7x7iaoApuISj/gPfGJ1QkMjs+AMskAF1vinGAZ74i09Pgh3y1pDKhB
         79mOsOg744xJsQSz2RfFZzV+ThidOBRe5rh4e6uKUGF9ToOb+0Ag16watR+YN//OjFU/
         ZjapE5ucktlB/FOc/NeRcsKgdo0hIXyeNa3Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpJdQEss2Hf2fCZ1JCBrqDkW/3xv13oIKhlDU7E2du4=;
        b=PZYrriCPYvl6i17Kc+tKiNBveH3c3j1T3b7mrTr4W4HlCaBMBD7vlohZcGs1yqgIHC
         IHvz/NSPOKq24erxlKbrLmYzXfIH5DuA7QOa+I7XXLic3clTwyVciTvuvP1soLpEAtNE
         kpoYWgyDYiigicna1mpbgSumxUxJJEiI5jMfuidjG5kJ5BkZFJi71SZ7kYS3oQFQZzV1
         u6qfG/9pKlOsHHm+52poUeupulPUL86f+Ub/40ktpiXmm5bwq3PORJ/dX4g+Op2UT0QS
         jp4zZMktTEazSwkq7AaznysILVIDhnHrLRLor0IzYTMpiAk98urvJF69YXk/RUA+IPGg
         1PYg==
X-Gm-Message-State: APjAAAWVpKB0hbAacVwwHupaG+YLALjil/+e/YtejyhaULSEG33aZKsK
        SNA4M1TWAyMrS2BWpnxUPdPx7w+VB40=
X-Google-Smtp-Source: APXvYqwCClVXuwXGJg5feWhd1sBlF09hukCgrFLiwJ6B03yGxpFN4ITfwKkW304ptuvMhk+WZGEyQQ==
X-Received: by 2002:a05:651c:14b:: with SMTP id c11mr3599317ljd.185.1555717093028;
        Fri, 19 Apr 2019 16:38:13 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r19sm1338811lja.83.2019.04.19.16.38.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 16:38:12 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id r24so5778406ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:38:12 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr3561786lji.94.1555716778880;
 Fri, 19 Apr 2019 16:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <20190419212002.GB44851@google.com> <CAHk-=wiiYUuk7LrkNaggvzZqB63Efu5sChV5hAOdn1ZfunUw6Q@mail.gmail.com>
 <CAHrFyr6rA7w6H_N5bV_9EY26Jxza1TLp6=rLL7=grK6_tp6cHw@mail.gmail.com>
In-Reply-To: <CAHrFyr6rA7w6H_N5bV_9EY26Jxza1TLp6=rLL7=grK6_tp6cHw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Apr 2019 16:32:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8DmfsOFY4OrqRjLYCYi+2Ej7uLbidmiPg+BhBOGZVcA@mail.gmail.com>
Message-ID: <CAHk-=wh8DmfsOFY4OrqRjLYCYi+2Ej7uLbidmiPg+BhBOGZVcA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Christian Brauner <christian@brauner.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 4:20 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Sat, Apr 20, 2019 at 1:11 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It's also worth noting that POLLERR/POLLHUP/POLLNVAL cannot be masked
> > for "poll()". Even if you only ask for POLLIN/POLLOUT, you will always
> > get POLLERR/POLLHUP notification. That is again historical behavior,
> > and it's kind of a "you can't poll a hung up fd". But it once again
> > means that you should consider POLLHUP to be something *exceptional*
> > and final, where no further or other state changes can happen or are
> > relevant.
>
> Which kind of makes sense for process exit. So the historical behavior
> here is in our favor and having POLLIN | POLLHUP rather fitting.
> It just seems right that POLLHUP indicates "there can be
> no more state transitions".

Note that that is *not* true of process exit.

The final state transition isn't "exit", it is actually "process has
been reaped".  That's the point where data no longer exists.

Arguably "exit()" just means "pidfd is now readable - you can read the
status". That sounds very much like a normal POLLIN condition to me,
since the whole *point* of read() on pidfd is presumably to read the
status.

Now, if you want to have other state transitions (ie read
execve/fork/whatever state details), then you could say that _those_
state transitions are just POLLIN, but that the exit state transition
is POLLIN | POLLHUP. But logically to me it still smells like the
process being reaped should be POLLHUP.

You could also say that the execve/fork/whatever state is out of band
data, and use EPOLLRDBAND for it.

But in fact EPOLLPRI might be better for that, because that works well
with select() (ei if you want to select for execve/fork, you use the
"ex" bitmask).

That said, if FreeBSD already has something like this, and people
actually have code that uses it, there's also simply a strong argument
for "don't be needlessly different".

                      Linus
