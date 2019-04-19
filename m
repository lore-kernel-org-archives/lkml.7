Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776BEC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3334021736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YjOM6EZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfDSTmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:42:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46007 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfDSTmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:42:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id k92so5128552edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VGIR2GbXtLGp4RT2/AEt9YHchRcZ4aJqrosRiOcl9W4=;
        b=YjOM6EZdny5nWDR9k0aVd67l+sIW6vCh7kdOX8HesmZuvnAfgjBbn3pUljLy6Oltx6
         cIkj9MIm8w24BDfyKKJw6nxynRbHE93RXOPxL2g1HxH6LwxmxtGnqbSJoZh7VvCanmg8
         VcZxeo7w0iFKlOB2DYGN1Gc3jCqMiKA7zW+3JqGm31CcE69iByczTR9jYN0m1eQDdhsJ
         N5TsXdsuwdETjvkENm6LeEsIGFjaX/Wl1hxxyjwlZKuuxKoDm/rycohIAPFr5LDMj7O1
         DfVxFYCA1neVA6KakQ9D4rxk8WVrJHfGDv2SAbU8jPQCCB1lFMLF7XllUYMcWSRmscWr
         aMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VGIR2GbXtLGp4RT2/AEt9YHchRcZ4aJqrosRiOcl9W4=;
        b=FZ1+0CCrHjupmUcG8fE5nz73ZnvDCuxnVbl8qpS+/uFB/u3VhJQYtfM/kdHEjC1hca
         GgTA3wscZHkru9b1praVM6a7Tz9b287epQyXxc8jkF2VQUf50sObhkMTYWolpv7+VBsH
         XYsBDjiI9DlgY/CCs0O+zsDD5//YHdyFx1DQ9zyIScNS2pw6GMaLahuEsiIDuPPlGMg6
         vw7wogjaOypxWNH8lw/vm/xNlI9c3X/NH11Ha0J11IE90cGmQy3JfLyrNvPB0qi9ORmj
         QDsGqB19UrRISwMUkEkSDERj464bKS4Bs9AGnHCJJ5adVzN5B0KFpdkIJLruO37MlpFq
         24TQ==
X-Gm-Message-State: APjAAAUqGJAyQ4h0ACk+NGjpgbcsY7N+BboL+kJmgXyJfKHzxs7VSowV
        4uut5TddBN5hHcSQDoNVOWFiuw==
X-Google-Smtp-Source: APXvYqwxLJNfmvmyd+tZ9c5ITdQBF4dQoTHBAtDj9pyqr+lhJ9RcOc20xM92PmHarGtzncQoJ05/XA==
X-Received: by 2002:a17:906:5994:: with SMTP id j20mr2646063ejq.295.1555702926419;
        Fri, 19 Apr 2019 12:42:06 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id z3sm995178eja.32.2019.04.19.12.42.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Apr 2019 12:42:05 -0700 (PDT)
Date:   Fri, 19 Apr 2019 21:42:04 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190419194203.am6ci63rpwsnchzg@brauner.io>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419192233.d2n6al7hgoga6gts@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419192233.d2n6al7hgoga6gts@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:22:33PM +0200, Christian Brauner wrote:
> On Fri, Apr 19, 2019 at 09:18:58PM +0200, Christian Brauner wrote:
> > On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >> On 04/16, Joel Fernandes wrote:
> > > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > > >> > >
> > > > >> > > Could you explain when it should return POLLIN? When the whole
> > > > >process exits?
> > > > >> >
> > > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > > >or when it
> > > > >> > is in a zombie state and there's no other thread in the thread
> > > > >group.
> > > > >>
> > > > >> IOW, when the whole thread group exits, so it can't be used to
> > > > >monitor sub-threads.
> > > > >>
> > > > >> just in case... speaking of this patch it doesn't modify
> > > > >proc_tid_base_operations,
> > > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > > >going to use
> > > > >> the anonymous file returned by CLONE_PIDFD ?
> > > > >
> > > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > > >proc_tgid_base_operations despite not being a thread group leader.
> > > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > > >be hit trivially, and then the code will misbehave.
> > > > >
> > > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > > >out if you're dealing with a thread group leader, or make the code
> > > > >work for threads, too.
> > > > 
> > > > The latter case probably being preferred if this API is supposed to be
> > > > useable for thread management in userspace.
> > > 
> > > At the moment, we are not planning to use this for sub-thread management. I
> > > am reworking this patch to only work on clone(2) pidfds which makes the above
> > 
> > Indeed and agreed.
> > 
> > > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > > patches, CLONE_THREAD with pidfd is not supported.
> > 
> > Yes. We have no one asking for it right now and we can easily add this
> > later.
> > 
> > Admittedly I haven't gotten around to reviewing the patches here yet
> > completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> > on process exit which I think is nice as well. How about returning
> > POLLIN | POLLHUP on process exit?
> > We already do things like this. For example, when you proxy between
> > ttys. If the process that you're reading data from has exited and closed
> > it's end you still can't usually simply exit because it might have still
> > buffered data that you want to read.  The way one can deal with this
> > from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> > you keep on reading until you only observe a POLLHUP without a POLLIN
> > event at which point you know you have read
> > all data.
> > I like the semantics for pidfds as well as it would indicate:
> > - POLLHUP -> process has exited
> 
> or POLLRDHUP. The check you'd usually perform would probably be
> if ((revents & (POLLIN | POLLPRI)) > 0) && ((revents & (POLLHUP | POLLRDHUP)) > 0)
>         /* keep on trying to read */
> 
> I guess you have that set of flags already suggested in another mail?

The code where this pattern is e.g. used is in drivers/tty/n_tty.c:

static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
                                                        poll_table *wait)
{
        __poll_t mask = 0;
 
        poll_wait(file, &tty->read_wait, wait);
        poll_wait(file, &tty->write_wait, wait);
        if (input_available_p(tty, 1))
                mask |= EPOLLIN | EPOLLRDNORM;
        else {
                tty_buffer_flush_work(tty->port);
                if (input_available_p(tty, 1))
                        mask |= EPOLLIN | EPOLLRDNORM;
        }
        if (tty->packet && tty->link->ctrl_status)
                mask |= EPOLLPRI | EPOLLIN | EPOLLRDNORM;
        if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
                mask |= EPOLLHUP;
        if (tty_hung_up_p(file))
                mask |= EPOLLHUP;
        if (tty->ops->write && !tty_is_writelocked(tty) &&
                        tty_chars_in_buffer(tty) < WAKEUP_CHARS &&
                        tty_write_room(tty) > 0)
                mask |= EPOLLOUT | EPOLLWRNORM;
        return mask;
}
