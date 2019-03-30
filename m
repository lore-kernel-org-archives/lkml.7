Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F67CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021CD2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuloRYOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfC3Ffe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:35:34 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41262 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfC3Ffd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:35:33 -0400
Received: by mail-ua1-f68.google.com with SMTP id 46so1407816uan.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 22:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=955ddIs9WI50LD3ZVZ501BfrMyXzDl1FuJIslpDr7h4=;
        b=WuloRYOG65cuqyRuyUwRrfSOp8YAbo7nqTQgi8um7dlrqrqaKeeUN+/mCsXVS8q6uk
         dCa5Gg2S4tFfPJSumRK1EVCtxDQ1iXMIMoPwSQOxRLbTrD3ADaSfXS0gQd6HvtDNWlu3
         mL9QGdU6QAMhf/FpNGY6+4WjlggK3wTaJHyjFyHso7I7s98VRS2IeNqaU5WY9HlSYp4i
         GvJ+r1g+zqheZFXOAjgzEcIobaR4vSbIBlZDIpQwroZWrntdNX3UeI5HNrezFBNssq7R
         A6pxmjIDBKkYH2MciFBnFSx7mEgsfI4eyzDRnpgXzn2SWouOuLzOyXB+Q/4tYc2ytVao
         IvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=955ddIs9WI50LD3ZVZ501BfrMyXzDl1FuJIslpDr7h4=;
        b=Mx+/qrL8hOkqIpVAH7zHyk6wnSRUqSi2an5qBcCGbgCM36lXacFRbiU81iPzxn6JFa
         +xm8Fq2K3cw2Nu1nRbaUQ4flv7G8/7Is45T4hC57RRd5y+54lIdzs/LW3q4lvLalex4o
         vZT3SBdc7Gx9Mt/GFOMYshnI1bMGVCNIGRlbtrR+zFu2aZSV1deeQdoH+QugWyut8hzI
         wh1/dXUY+rMQYpiDYblcMA53fcCfOCTo6odvZvQzLo2P2pM1O8X43FCiBteGboqdtD8l
         q5IlUKmOzxkkBkqd6vnSk9BAN2d+Xg3/aYQWpIXHmesCnquxElA/i82xck3s1+yAwSNt
         oSaw==
X-Gm-Message-State: APjAAAXVk5/ufIptkSKspCMDuYgoGDh4o8YAG43nxv0z7tWye1yXZeqV
        4TJOKKXphkbXVezXRQcsQ1gSfz9ROBSJprz9QzX/NQ==
X-Google-Smtp-Source: APXvYqzSlid1Fg57eW6tQxCADYtZYKg8KQ4Sn0ndhzeSS/W6/COMUJVRixYNQMbR6HCBMMryX3wm9Y7cwo8jw7G8i9A=
X-Received: by 2002:ab0:1591:: with SMTP id i17mr30857858uae.41.1553924132156;
 Fri, 29 Mar 2019 22:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
 <20190327213404.pv4wqtkjbufkx36u@brauner.io> <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com>
 <20190327222543.huugotqcew6jyytv@brauner.io> <CAGLj2rG0Sbho6MnPSmcS73Xj=oG92E4W_QLRu4dD8NfweoUm5Q@mail.gmail.com>
 <20190328103813.eogszrqbitw3e7k7@brauner.io>
In-Reply-To: <20190328103813.eogszrqbitw3e7k7@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 29 Mar 2019 22:35:20 -0700
Message-ID: <CAKOZueusdFurOb_uFZ3PDmZeJvYvHVKMx6=TpiWPERkKRiHfiw@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Jann Horn <jannh@google.com>,
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
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 3:38 AM Christian Brauner <christian@brauner.io> wrote:
>
> > All that said, thanks for the work on this once again. My intention is
> > just that we don't end up with an API that could have been done better
> > and be cleaner to use for potential users in the coming years.
>
> Thanks for your input on all of this. I still don't find multiplexers in
> the style of seccomp()/fsconfig()/keyctl() to be a problem since they
> deal with a specific task. They are very much different from ioctl()s in
> that regard. But since Joel, you, and Daniel found the pidctl() approach
> not very nice I dropped it. The interface needs to be satisfactory for
> all of us especially since Android and other system managers will be the
> main consumers.

Thanks.

> So let's split this into pidfd_open(pid_t pid, unsigned int flags) which
> allows to cleanly get pidfds independent procfs and do the translation
> to procpidfds in an ioctl() as we've discussed in prior threads. This

I sustain my objection to adding an ioctl. Compared to a system call,
an ioctl has a more rigid interface, greater susceptibility to
programmer error (due to the same ioctl control code potentially doing
different things for different file types), longer path length, and
more awkward filtering/monitoring/auditing/tracing. We've discussed
this issue at length before, and I thought we all agreed to use system
calls, not ioctl, for core kernel functionality. So why is an ioctl
suddenly back on the table? The way I see it, an ioctl has no
advantages except for 1) conserving system call numbers, which are not
scarce, and 2) avoiding the system call number coordination problem
(and the coordination problem isn't a factor for core kernel code). I
don't understand everyone's reluctance to add new system calls. What
am I missing? Why would we give up all the advantages that a system
call gives us?

I also don't understand Andy's argument on the other thread that an
ioctl is okay if it's an "operation on an FD" --- *most* system calls
are operations on FDs. We don't have an ioctl for sendmsg(2) and it's
an "operation on an FD".
