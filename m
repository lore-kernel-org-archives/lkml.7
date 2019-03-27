Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9B6206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="c11QeoHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfC0VeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:34:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33192 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0VeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:34:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id q3so15425344edg.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YMLa+UMqtuwSABrrxe808CIfQVgwkQYsjIYJ6xU5N+Q=;
        b=c11QeoHN8b2KdafU52W414VD0mS5N6dBowJ6ESnPhuztB52MrOC16uq+vxfS4niZlR
         NiSrz4nOAhU4qhi2QIkgiMXqSGW+2PoQ6PgBkurpaUngOKDIrxmwgUxaBpfD4Laa0+IC
         4lFIxNRovHV7Ta4qElYB978V8JF6Y6Fh4sYwMDaD4CV/kAEJVdBHQDXUOedgxETYR1My
         nogWvR6nlXfTL4ILIO1xDpkLYruZ2tsigSh0OcGKM9MD22WJhrJoq3YA0Yh3PF7olCW0
         fMQYRuL1ZBE1ZlNBW+XaPZvydrlIb0QRRYDGBInYoVHNyXcUWVeRgGem2cmE1tHGWpdo
         XHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YMLa+UMqtuwSABrrxe808CIfQVgwkQYsjIYJ6xU5N+Q=;
        b=gkvgp1iYiA29e61IQ13Ea1cgHkVP5D2C+/a2IPOJrDvtVKlRbZWDKrbmXO5pNSct3X
         3F7hn6yZi+JWSTJ3QfgLvCtFWPvhwlav3nSv8JAGAdd6YER3t8tPSgQSsisXZ7gxhrS1
         yGljMG5c9pbwoSdx0tsBi3DAHTCjD/QNP5+RfxjGSKYq5scJU/R6fJXapOsw/ebh+fih
         vDjmRT+Koa0qC/2u5TP6iPAv/V2D5RH5LIAHk/G8oflXxu7dQl1bj59XjtkGZehtoUAJ
         DWA9H95/EZf6wGOxsvGh0cHxnwTB++wJo7nbw0XFHqQ/+pcs6Bcj9OU7HAd33hSq7a35
         wqVg==
X-Gm-Message-State: APjAAAUv4Qekt61VJewUvNrs8OsCu43UqWfY6fipqdr6x8MG5WrmIPf4
        jh0DyATSiM3zaNO/z0CY3Qt+wQ==
X-Google-Smtp-Source: APXvYqxnY5gKNq/ZMWomo/w5WXmZdprdrxKQezGcI6y74UerTM9Xf2ES3Yj2BEzpJ+SwJmbA4dw4zw==
X-Received: by 2002:a50:915a:: with SMTP id f26mr26479060eda.1.1553722447191;
        Wed, 27 Mar 2019 14:34:07 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id z39sm5160036edz.26.2019.03.27.14.34.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 27 Mar 2019 14:34:06 -0700 (PDT)
Date:   Wed, 27 Mar 2019 22:34:05 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
Message-ID: <20190327213404.pv4wqtkjbufkx36u@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io>
 <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:38:13PM +0000, Jonathan Kowalski wrote:
> Christian,
> 
> Giving this some thought, it looks fine to me, but I am not convinced
> this should take a pid argument. I much prefer if obtaining a pidfd

The signatures for pidfd_open() you're suggesting are conflicting. Even
taking into account that you're referring to Andy's version:

int procfd = pidfd_open(procrootfd, pidfd, PIDFD_TO_PROCFD); //name

the "not convinced this should take a pid argument" confuses me wrt to
the proposed second signature:

pidfd_open(pid_t pid, int ns, unsigned int flags);

> goes in the translation stuff, that has very real usecases, and you
> would end up duplicating the same thing over in two places.
> 
> If the /proc/<PID> dir fd of a pidfd is relative to its procrootfd, a
> pid's pidfd is also relative to its namespace. Currently, you change

Pass a /proc/<pid> file descriptor that you have been given access to to
pidfd_open() and retrieve a pidfd to that process.

> things which would mean I now have to setns and spawn a child that
> passes me back the pidfd for a pid in the said namespace.

There are two scenarios:
- you're in a cousin pid namespace
- you're in an ancestor pid namespace

If you're in an ancestor pid namespace you can just get a pidfd based on
the pid of the process in your namespace. If you're in a cousin
pid namespace it seems reasonable that you have to do a setns to get a
pidfd. After all, you're not able to see any pids in there by default.
If you want pidfd to a cousin pid namespace prove that you can access it
by attaching to the owning user namespace of the pid namespace and get
your pidfd.

> 
> I prefer Andy's version of
> 
>   int procrootfd = open("/proc", O_DIRECTORY | O_RDONLY);
>   int procfd = pidfd_open(procrootfd, pidfd, PIDFD_TO_PROCFD); //name
> this procfd_open, maybe
> 
> This is just a nicer race free openat.
> 
> But, Joel and you agreed that it makes sense to split out the
> translation stuff out of pidfds.

I don't quite remember that part.

I honestly think that the version proposed here covers for the most part
what we want and provides a decent compromise by avoiding ioctl()s for
the translation bits, allows us to not split this into multiple
syscalls, and also allows retrieving pidfds from other pid namespaces
provided that one has gotten access to a file descriptor for
/proc/<pid>. If really needed at some point - I doubt we will - you
can extend pidfd_open() to take the flag CLONE_NEWPID:

int pidfd = pidfd_open(pid, pid_ns_fd, -1, CLONE_NEWPID);

and get pidfd for another pid namespace back.

Christian

> 
> My suggestion would be to extend ioctl_ns(2) then. It already provides
> a (rather clumsy) mechanism to determine the relationship by comparing
> st_dev and st_ino, which userspace can do itself for two namespace
> descriptors. For translation, you can extend this namespace ioctl
> (there is one to get a owner UID, you could add one to get a relative
> PID).
> 
> Then, your pidfd call will be:
> 
> pidfd_open(pid_t pid, int ns, unsigned int flags);
> 
> You would also be able to compile out anything procfs related (include
> the new API to procfs dir fd translation), otherwise, the way to open
> pidfds is in this call, and without CONFIG_PROC_FS=Y, this is as good
> as pidfd_open(pid_t pid) (of which a better version I propose above).
> The new API should be its own thing, and the procfs translation tuple
> its own thing, tied to the proc fs option. pidfds need not have any
> relation to /proc.

They don't have a relation to procfs right now in this syscall. Works
fine without procfs. That's the point.

> 
> For this procfd conversion system call, I would also lift any
> namespace related restrictions if you are planning to, given the
> constraint that I can only open a pidfd from an ancestor namespace
> with the new pidfd_open system call, or acquire it through a
> cooperative userspace process by fd passing otherwise, and I need the
> /proc root fd, having both only permits me to open the said process's
> /proc/<PID> dir fd subject to normal access restrictions. This means
> the simplified procfd_open can be used to do metadata access without
> even talking of PIDs at all, your process could live in its own world
> and, given it has the authority to open the /proc directory, be able
> to purely collect metadata based on the two file descriptors it is
> given.
> 
> Once you have the restriction in the same call that allows you to open
> a pidfd for an addressable PID from the given namespace fd, you can
> finally remove the restriction to signal across namespaces once the
> siginfo stuff is sorted out, as that will only work when you
> explicitly push the fd into a sandbox, the process cannot get it out
> of thin air on its own (and you already mentioned it has nothing to do
> with security). What I do worry about is one can use NS_GET_PARENT
> ioctl to get the parent pidns if the owning userns is the same, and
> just passing that gives me back a pidfd for the task. **So, you might
> want to add the constraint that the PID is actually reachable by the
> current task as well, apart from being reachable in the passed in
> namespace.**
> 
> Lastly, I also see no need of /proc/<PID> dir fd to pidfd conversion,
> I would even recommend getting rid of that, so we only have one type
> of pidfd, the anon inode one. What is the usecase behind that? It
> would only be needed if you did not have a way to be able to metadata
> access through a pidfd, which would be the case only prior to this
> patch.
> 
> I think this would simplify a lot of things, and ioctl_ns(2) is
> probably already the place to do comparison operations and query
> operations on hierarichal namespaces, just adding the relative PID bit
> will make it gain feature parity with translate_pid.
