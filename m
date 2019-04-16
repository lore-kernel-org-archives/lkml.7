Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23ECF2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555450321;
	bh=qPOFGyho0I2/DKjKP3O5z9o4CngQtJsci0PjRJroR9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KijtcfiA3o1FXuCLGW1UHO25bIbyIkAJpckLEEgzktJv945Ka9yRcLNsUW8Rt6G9l
	 QYK+ItSGT7EKhbKj0D9TTvx//NCofx6+vkkAdkO/U0oUn2kZr2JDoLGD5X7/N8QE81
	 KC1PsR3UPGONfHjSSJgAWj45qu985V95Apvc+G3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfDPVb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPVb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:31:59 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E08EB20868
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 21:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555450318;
        bh=qPOFGyho0I2/DKjKP3O5z9o4CngQtJsci0PjRJroR9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DixTqzb8Dm5p2yCEPPBxVBd06/0nfSfWjjaFUYdPDiiNxSEKnRZKKzQ+AV/eTaA/k
         kR7YqfHgpGEsJLOZOiXzkpo1bi/YSru5QnEEwVcu+a1EJ3FacEjRokQ12hwLmFBIXv
         9wStHnrXtSN07IhDSk/P9+v5bkvc8vYA0hXfcgYI=
Received: by mail-wr1-f54.google.com with SMTP id p10so29096255wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:31:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWGFD1/5Eg7f+ghk+Ho4pGtDH77Wy4ufQ70ftLoSqYilq6SNuvn
        hQdW/9mtUT1+RVqqN6SwdiLEFisEKhoBW6dtlXjr1g==
X-Google-Smtp-Source: APXvYqxNdEGgYCJVdSZRHCHv2i49FMYV0F6F3GmxBW1gVTmc5qRl2fjleE63UutMV+49cFB7SoQ4gwA59gTNZTY6+3Y=
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr326865wrn.108.1555450316449;
 Tue, 16 Apr 2019 14:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <c783a83a-01a1-9813-e2f7-0516cf7a1c16@metux.net>
In-Reply-To: <c783a83a-01a1-9813-e2f7-0516cf7a1c16@metux.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Apr 2019 14:31:44 -0700
X-Gmail-Original-Message-ID: <CALCETrWWoEvnzx6oLTEajBmiArScX5sSt74o2VO+aTiwEi_9mQ@mail.gmail.com>
Message-ID: <CALCETrWWoEvnzx6oLTEajBmiArScX5sSt74o2VO+aTiwEi_9mQ@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:46 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 15.04.19 22:29, Andy Lutomirski wrote:
>
> <snip>
>
> > I would personally *love* it if distros started setting no_new_privs> for basically all processes.
>
> Maybe a pam module for that would be fine.
> But this should be configurable per-user, as so many things still rely
> on suid.
>
> Actually, I'd like to move all authentication / privilege switching
> to factotum (login(1), sshd, etc then also could run as unprivileged
> users).
>
> > And pidfd actually gets us part of the> way toward a straightforward way to make sudo and su still work in a>
> no_new_privs world: su could call into a daemon that would spawn the>
> privileged task, and su would get a (read-only!) pidfd back and then>
> wait for the fd and exit.
>
> How exactly would the pidfd improve this scenario ?
> IMHO, would just need to pass the inherited fd's to that daemon (eg.
> via unix socket) which then sets them up in the new child process.
>

It makes it easier to wait until the privileged program exits.
Without pidfd, you can't just wait(2) because the program that gets
spawned isn't a child.  With pidfd, the daemon can pass the pidfd
back.  Without pidfd, of course, you can wait by asking the daemon to
tell you when the program exits, but that's a uglier IMO.

> > I suppose that, done naively, this might> cause some odd effects with respect to tty handling, but I bet it's>
> solveable.
>
> Yes, signals and process groups would be a bit tricky. Some signals
> could be transmitted in a similar way as ssh does.
>
> But: how can we handle things like cgroups ?

Find a secure way to tell the daemon what cgroups to use?


--Andy
