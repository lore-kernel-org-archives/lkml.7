Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD09FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E0520700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjyBMzIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfC0TiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:38:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34166 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfC0TiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:38:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so20372754qtm.1;
        Wed, 27 Mar 2019 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hU8seMPTclLptQIikp0+dn1jNNCETGaudk6NUzaeh64=;
        b=FjyBMzISDmLWNbZd7RD0XCuX0tpHxmEdSbhoByI1U4l6E089ffTc4bwIp01GXQMhEZ
         Wf9Fh8Je9TezHDKRAu+Ugrn1PDU3kYBQeen3VoHy5d32LTyW/yyhRIOY5FZEuJ98TT6g
         FjVZJR6FT00reFherzDo1bc+p4SdFhZPpc4fcvksh/ULL3nvPC7KLZhtF5mfyM4xW85v
         6rcM+fIBK0H2fGYlM/5t+zJsYEiqcxyH/n6ZrTOuvrQmGc2varkycwho1RCsTHax8Y5u
         QqEjywvx9L+STKBpempSv1JX7nqxwVlFnhrj4193nnKNHXUJrToE8Ud+I26Lfut9Q0+5
         nElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hU8seMPTclLptQIikp0+dn1jNNCETGaudk6NUzaeh64=;
        b=emdqSX65wABr7maYNk3fXcogRzGnm8eRj6E5dLNbS3bBRGZrDbVs2BT8WHfvCKNXyI
         1sekd3kFbm7bl/VEORsh+h7ZwIQOA0T9JP82NX/aX9cY2pOejGZ/DCfBzT62PTZPjz5f
         0YVRNLgcZipcsDrLCCpzGlPt5wKgb/FqzeIn7/2eAQPrR89m1Cy1rGApSGeWqJ29k2xm
         lcCzroUUVqFc1Q0krqZ6r1JcEIZWSxFJ14YCTndl5DdG3d3dUR8ptlXJ7+eEkm93EO5i
         QxrT3J5FSR/HtuVyf3Y/GIXXtjo3Dcusg/FHaSkNjQevVB6KKDnUXnZ5afqaTkF+oUXK
         l/IQ==
X-Gm-Message-State: APjAAAVRke+mxxBEiuydpY9JUFfDpbEgq/O9NxrjWKQnH34EZ1LTB3WT
        MPH1IXKryHjI5RFW0X/WNwGpd6qklJAYru4YwN0=
X-Google-Smtp-Source: APXvYqyzW8Jz5eqgG9/xYDxoFMZMrtGj9LtxEBWCVzpEWcEDuiqZSIZuNQYiipJ+CVC/LPhT7l81QeCBtj8nTTi0nqw=
X-Received: by 2002:aed:358b:: with SMTP id c11mr32605651qte.70.1553715503682;
 Wed, 27 Mar 2019 12:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-3-christian@brauner.io>
In-Reply-To: <20190327162147.23198-3-christian@brauner.io>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Wed, 27 Mar 2019 19:38:13 +0000
Message-ID: <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian,

Giving this some thought, it looks fine to me, but I am not convinced
this should take a pid argument. I much prefer if obtaining a pidfd
goes in the translation stuff, that has very real usecases, and you
would end up duplicating the same thing over in two places.

If the /proc/<PID> dir fd of a pidfd is relative to its procrootfd, a
pid's pidfd is also relative to its namespace. Currently, you change
things which would mean I now have to setns and spawn a child that
passes me back the pidfd for a pid in the said namespace.

I prefer Andy's version of

  int procrootfd = open("/proc", O_DIRECTORY | O_RDONLY);
  int procfd = pidfd_open(procrootfd, pidfd, PIDFD_TO_PROCFD); //name
this procfd_open, maybe

This is just a nicer race free openat.

But, Joel and you agreed that it makes sense to split out the
translation stuff out of pidfds.

My suggestion would be to extend ioctl_ns(2) then. It already provides
a (rather clumsy) mechanism to determine the relationship by comparing
st_dev and st_ino, which userspace can do itself for two namespace
descriptors. For translation, you can extend this namespace ioctl
(there is one to get a owner UID, you could add one to get a relative
PID).

Then, your pidfd call will be:

pidfd_open(pid_t pid, int ns, unsigned int flags);

You would also be able to compile out anything procfs related (include
the new API to procfs dir fd translation), otherwise, the way to open
pidfds is in this call, and without CONFIG_PROC_FS=Y, this is as good
as pidfd_open(pid_t pid) (of which a better version I propose above).
The new API should be its own thing, and the procfs translation tuple
its own thing, tied to the proc fs option. pidfds need not have any
relation to /proc.

For this procfd conversion system call, I would also lift any
namespace related restrictions if you are planning to, given the
constraint that I can only open a pidfd from an ancestor namespace
with the new pidfd_open system call, or acquire it through a
cooperative userspace process by fd passing otherwise, and I need the
/proc root fd, having both only permits me to open the said process's
/proc/<PID> dir fd subject to normal access restrictions. This means
the simplified procfd_open can be used to do metadata access without
even talking of PIDs at all, your process could live in its own world
and, given it has the authority to open the /proc directory, be able
to purely collect metadata based on the two file descriptors it is
given.

Once you have the restriction in the same call that allows you to open
a pidfd for an addressable PID from the given namespace fd, you can
finally remove the restriction to signal across namespaces once the
siginfo stuff is sorted out, as that will only work when you
explicitly push the fd into a sandbox, the process cannot get it out
of thin air on its own (and you already mentioned it has nothing to do
with security). What I do worry about is one can use NS_GET_PARENT
ioctl to get the parent pidns if the owning userns is the same, and
just passing that gives me back a pidfd for the task. **So, you might
want to add the constraint that the PID is actually reachable by the
current task as well, apart from being reachable in the passed in
namespace.**

Lastly, I also see no need of /proc/<PID> dir fd to pidfd conversion,
I would even recommend getting rid of that, so we only have one type
of pidfd, the anon inode one. What is the usecase behind that? It
would only be needed if you did not have a way to be able to metadata
access through a pidfd, which would be the case only prior to this
patch.

I think this would simplify a lot of things, and ioctl_ns(2) is
probably already the place to do comparison operations and query
operations on hierarichal namespaces, just adding the relative PID bit
will make it gain feature parity with translate_pid.
