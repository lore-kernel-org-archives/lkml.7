Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886BE20872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPbmNxNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfDAAxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 20:53:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37175 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbfDAAxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 20:53:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id v84so5879553oif.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 17:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fZfyXBhna5b8vlwx3QgblKyuLXKRH6SlLfM7+wdlsQ=;
        b=ZPbmNxNPiCUJal4s9qtVD5qyHo69dwGTeKy4y28f7LFEoRY8Ss+eIcmkmgpvISmUe/
         Cwo+BrvGSmYtJ+MFqKI2mnkY+PEAiHi7uuQ2jMf9NSI5rSl7enc6jfFyGatE6c8RMNYP
         adxuVc+RLRqq4Qc3rm5OOc//KBIa4LYhviTbpWFmhnjHIKruqnYklRNGUS42PMDHgR9w
         Dn2B8cB14fAQr0UtHpNq1caWs88MoXvWYug/7bAHu0IFyAePr8kxV89NT+k46Bt4BY33
         ouQd5YBCJIKatLtfLkTIxEcqv9Fwm2hyDZEfD4/1f6pWiW60xtifQxsudh1T5uZ5DwiN
         aV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fZfyXBhna5b8vlwx3QgblKyuLXKRH6SlLfM7+wdlsQ=;
        b=Q6bz9wBJbgl8ulr1X4y88mFw3Cin0aoOX+Rk1B4wbCIPmbqjAERSCsjBpuJ2qx9sSO
         rozPkj1n/rQq63qspDOGfdihT+F7YvTWUetvpW2df1a7gEiwVjZBXp9IGV5gxBrelowY
         GbsYSn7zVywfAQoTqmnHWBB3Ooxf1DgeAvBXtr+IBX50Y5P1xM1KkVFTBr5ZQKv4kUwf
         p5E7gYWQFFSLBM9zn1Ob/9L5QgzWo5jLoMwm0uwS6jdf4YS3j7eNhf86xcqOn/c92nJb
         CDJ3wBSwzNl0OWDyOlGCrwE4XwhzBdupp4MDTaM243kY9CGp4/QJ6oBQk9cHZrbGeg0A
         38rQ==
X-Gm-Message-State: APjAAAU/yP2AYTDzMaQPmm0nj1PcZeODfmw8kI4nrK10BvEmgXRe/q3L
        LJNZp/sGsDbw4d2bDELhk7TwknSq1q5YQMlkB2ppqw==
X-Google-Smtp-Source: APXvYqy+ouA+nLBQKkVLOLw1L6dOcwlHELbfWLVVxbMTMBuB9RYf2lO/SUAp8wCXwdJn+yv2sFPN3Nxese2I+dMpBnA=
X-Received: by 2002:aca:3806:: with SMTP id f6mr10662436oia.47.1554079993801;
 Sun, 31 Mar 2019 17:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <20190331220259.qntxynluk765hpnt@brauner.io> <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
 <20190331223355.vfbnnkmevl63etvv@brauner.io>
In-Reply-To: <20190331223355.vfbnnkmevl63etvv@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Apr 2019 02:52:46 +0200
Message-ID: <CAG48ez0OnfkrEc5SmeaPpuv2aQ31kxkoFeaSVFwu7z1m=tN-9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Colascione <dancol@google.com>,
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
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

On Mon, Apr 1, 2019 at 12:33 AM Christian Brauner <christian@brauner.io> wrote:
> On Sun, Mar 31, 2019 at 03:16:47PM -0700, Linus Torvalds wrote:
> > On Sun, Mar 31, 2019 at 3:03 PM Christian Brauner <christian@brauner.io> wrote:
> > > Thanks for the input. The problem Jann and I saw with this is that it
> > > would be awkward to have the kernel open a file in some procfs instance,
> > > since then userspace would have to specify which procfs instance the fd
> > > should come from.
> >
> > I would actually suggest we just make the rules be that the
> > pidfd_open() always return the internal /proc entry regardless of any
> > mount-point (or any "hidepid") but also suggest that exactly *because*
> > it gives you visibility into the target pid, you'd basically require
> > the strictest kind of control of the process you're trying to get the
> > pidfd of.
> >
> > Ie likely something along the lines of
> >
> >         ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS)
>
> I can live with that but I would like to hear what Jann thinks too if
> that's ok.

Ah, yes. That seems reasonable. And, as Linus said, pidfd_open() is
less important if you can just do open("/proc/...") on systems with
procfs instead.

One minor detail to keep in mind for the future is that in a
straightforward implementation of this concept, if a non-capable
process is running in a mount namespace, but in the initial network
namespace, without any reachable /proc mount, it will be able to look
at information about other processes' network connections by first
using pidfd_open() on itself or by using clone(CLONE_PIDFD), then
looking at the "net" directory under the resulting file descriptor.
