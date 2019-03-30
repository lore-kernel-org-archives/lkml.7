Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29F2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F33218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GhYmw0p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfC3SCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:02:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34415 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfC3SCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:02:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so4719129eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Boy6Z5pZ7bEVfjbfzz39eWJ+Ke042SqdNUU3pLWpsxU=;
        b=GhYmw0p09ijNCE8ZXjhU3bqMRhwAuj6v04HuXFLi7pUQy8CjZRQZRhVy0BnMDhThT7
         mTLIddx5fU1C8K5/dXRIMeLVZWydZiXPgD4+I6L99/pPs3Wx0+9wwHNK3grIdeqVSMld
         nFY6yL0UoBXgilfpRSJGL3xOXeKnG0M40d/1yPufPAAsnwBmJQjgg37M+ipsN/knoKFh
         0bSnUuAOVZAvWE5p6o5gfyRDHI3+aB4ZxYVt8fg25nXeWKLAaxA+Z5R1/8Hd2bLzcZOV
         GPsq84iru6hW15s8ycXwZzt0p5ZNPqfWcQSh6k1R5ymWRVvVbXk3XkZiJPbBGfRBneNR
         ytCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Boy6Z5pZ7bEVfjbfzz39eWJ+Ke042SqdNUU3pLWpsxU=;
        b=qHIbE7qARWT6b9fiKhDSAvRTkQXLx8Qc3ZpysHJscTF6KOdJD8IMvO91n14GPKYJDT
         edTz2eOb20rRD22HzzDqUU7ajRVeTUW+8ursxxTxTsAAiHFOHLxOWXe19EsKmujd7gqK
         t4DUoXDaJSfRmijjdBaL7YxNsGcJ9+YUOLUovNQR05HWrEa8Ilck5fvrCjrG1ttuIwM+
         97JbtnD2ptrVBADGvSzFx6oiF9FwN8UyfpV7Z8e6gu4Z19U+VKDVE2iWaEHBKlEo7ZOO
         iUdb84nnId8klC61yycRWVD6s8dcpEHTOsSCYKfEv1743FpdYQ/BNVkzTURjYLxT2jNx
         Xj8g==
X-Gm-Message-State: APjAAAV2Qli+38/C0C5hiWSOje7exmqeNRXeL3daAG1h7VuDD64RvdNi
        0Wt4i/lvfrqcMsjQu5shiohskg==
X-Google-Smtp-Source: APXvYqyoNYrIC0VqX8p2zHFb4UWWOY6gb/sf/+TPmwY943jjHFKqtfm5qtsMs79teVFGUO45f5PL/w==
X-Received: by 2002:a50:ac14:: with SMTP id v20mr35463089edc.63.1553968940206;
        Sat, 30 Mar 2019 11:02:20 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id m47sm1682396edm.7.2019.03.30.11.02.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 30 Mar 2019 11:02:19 -0700 (PDT)
Date:   Sat, 30 Mar 2019 19:02:18 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190330180217.emenfwjsc2ejf5ws@brauner.io>
References: <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <CAGLj2rHk5pPYg-uo4HjYQQkJJjM0ePohtLJr2TrucuOaU_skxw@mail.gmail.com>
 <20190330175241.4itdnx3tl5upzjxd@brauner.io>
 <CAGLj2rEtNNs0BXHuGkjpT4seHuh=Lj79iVYP-n117+Dv+ThcJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGLj2rEtNNs0BXHuGkjpT4seHuh=Lj79iVYP-n117+Dv+ThcJA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 05:59:34PM +0000, Jonathan Kowalski wrote:
> On Sat, Mar 30, 2019 at 5:52 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Sat, Mar 30, 2019 at 05:50:20PM +0000, Jonathan Kowalski wrote:
> > > On Sat, Mar 30, 2019 at 5:24 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Sat, Mar 30, 2019 at 10:12 AM Christian Brauner <christian@brauner.io> wrote:
> > > > >
> > > > >
> > > > > To clarify, what the Android guys really wanted to be part of the api is
> > > > > a way to get race-free access to metadata associated with a given pidfd.
> > > > > And the idea was that *if and only if procfs is mounted* you could do:
> > > > >
> > > > > int pidfd = pidfd_open(1234, 0);
> > > > >
> > > > > int procfd = open("/proc", O_RDONLY | O_CLOEXEC);
> > > > > int procpidfd = ioctl(pidfd, PIDFD_TO_PROCFD, procfd);
> > > >
> > > > And my claim is that this is three system calls - one of them very
> > > > hacky - to just do
> > > >
> > > >     int pidfd = open("/proc/%d", O_PATH);
> > > >
> > > > and you're done. It acts as the pidfd _and_ the way to get the
> > > > associated status files etc.
> > > >
> > > > So there is absolutely zero advantage to going through pidfd_open().
> > > >
> > > > No. No. No.
> > > >
> > > > So the *only* reason for "pidfd_open()" is if you don't have /proc in
> > > > the first place. In which case the whole PIDFD_TO_PROCFD is bogus.
> > > >
> > > > Yeah, yeah, if you want to avoid going through the pathname
> > > > translation, that's one thing, but if that's your aim, then you again
> > > > should also just admit that PIDFD_TO_PROCFD is disgusting and wrong,
> > > > and you're basically saying "ok, I'm not going to do /proc at all".
> > > >
> > > > So I'm ok with the whole "simpler, faster, no-proc pidfd", but then it
> > > > really has to be *SIMPLER* and *NO PROCFS*.
> > > >
> > >
> > > (Resending because accidently it wasn't a reply-all)
> > >
> > > If you go with pidfd_open, that should also mean you remove the
> > > ability to be able to use /proc/<PID> dir fds in pidfd_send_signal.
> > >
> > > Otherwise the semantics are hairy: I can only pidfd_open a task
> > > reachable from my active namespace, but somehow also be able to open a
> >
> > You can easily setns() to another pid namespace and get a pidfd there.
> > That's how most namespace interactions work right now. We already had
> > that discussion.
> 
> Only if it is a child namespace, or you have the relevant capabilities to setns.
> 
> Currently, if I just put a task in PID namespace, it can see /proc of
> an ancestor PID namespace, and opendir /proc/<PID>, this is accepted
> by pidfd_send_signal.
> 
> If you ever allow signalling across PID namespaces (because file

That's not on the plate for now and pidfd_send_signal() is checking for
that to not allow it.
