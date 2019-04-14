Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC74C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD618206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555265976;
	bh=kD9vRivbEosoyxFlKSbrIsvAO+FzctUz9vxzFkyWS54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UTFZoSSndOd1LXsS4XgRWXxvxMS1pGCg9ps686BAeFRcsQl2sA1nGTyBGFBXsS8JC
	 Fd0GHjmW/n8n82y9liHcuBDy+jl04DEF/iShKKuATI45g13rSB7bLItJtMWtvwHGOH
	 DIAma1EzJMkWgSAVKIqBubTGwBaiGmy7AJ6j0xh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfDNSTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:19:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40690 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfDNSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:19:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so13489238ljq.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAOJ4gAe+OR7+mGTTcB5DjuHBGEuf3sWqHZ+6DRVhDM=;
        b=IWtuEiNTXexwh0uZNYAhtk3ZlvBUjrkVq/rEkIKLKM68UfCOeb9vHLMInngaW23uig
         7lTMl2vXgev7U476As4L2qQ3n2ZV3z4W2duYNPvGHihZPlmeyDJtb+6NbntpEtZou0Kt
         gMd59HDv29GLZe15Vu1tA5ydNDeyIUYeoQ+vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAOJ4gAe+OR7+mGTTcB5DjuHBGEuf3sWqHZ+6DRVhDM=;
        b=jJKCsJGdfz6tFrrgsKzRzthfQI5uUtpybKraIiV3S9bDywnDsQRRs62VXZUaJ7eIlR
         RzdZ/uYisTwbQUAdUl6hreatD7BIHgz/I+OgPRQUpqzIZy08ccXxOKsUZg3mzRmGBKTk
         A9yQmHAdykU/WIQmJygUhRPmXM5iQJp9Q+tdj296yeuUoGY82gTuRZwjMQ2j6j5pGISo
         GxDG5Ka7yK4OWsH3bJBVbsUkFECkaF1sLGsqQncUtLA2x2MWdh8JbZb+VPNpzyXQbkqU
         9NEd8qZ9OUX7EAtT/6eBdc4qas4rqOORNsi8+xV9tmOoF7h4yIkOZAtWfObhEDwCi0dP
         WJRA==
X-Gm-Message-State: APjAAAUnSPAVN6sGG6WtYEUpTqARHNeVkf/qio0j6SUBbC7sbaBsu9ey
        NCy9Zn3th2e2OsON/xyCkcGXA0CQS64=
X-Google-Smtp-Source: APXvYqyEowwi4sX38jVxTzammdWt5Jr878IdI0hOhPEccp2ah/P95mf7bRovvehtf/rzSGUFklwYwA==
X-Received: by 2002:a2e:9e47:: with SMTP id g7mr39511085ljk.48.1555265968881;
        Sun, 14 Apr 2019 11:19:28 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x2sm9619578lfg.59.2019.04.14.11.19.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 11:19:27 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id r24so13522597ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 11:19:26 -0700 (PDT)
X-Received: by 2002:a2e:9597:: with SMTP id w23mr30960447ljh.111.1555265966460;
 Sun, 14 Apr 2019 11:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org> <CALCETrV7Hw50Bh=qQX86v_6euiGqX7eNboi50_7JmfQsyVR3_A@mail.gmail.com>
In-Reply-To: <CALCETrV7Hw50Bh=qQX86v_6euiGqX7eNboi50_7JmfQsyVR3_A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Apr 2019 11:19:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiL0GZn+kOyxzaS0igMRs95sipcc9r0ZgU2rRf=CR+fpw@mail.gmail.com>
Message-ID: <CAHk-=wiL0GZn+kOyxzaS0igMRs95sipcc9r0ZgU2rRf=CR+fpw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 2:33 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Are you sure?  I admit I'm not all that familiar with the innards of
> poll() on Linux, but I thought that the waitqueue only had to survive
> long enough to kick the polling thread and did *not* have to survive
> until poll() actually returned.

That is *not* true by default.

You can do that, but you need to make sure that your wakeup function
is one that removed itself from the wait queues. You can do that with
DEFINE_WAIT(name), which uses autoremove_wake_function(), or by using
your own auto-removing wakeup function together with
DEFINE_WAIT_FUNC() or init_waitqueue_func_entry().

But the default wake function does not remove on wakeup, and you'll
have to be around until poll() itself tears down all the tables.

In particular, the normal "poll_wait()" will use __pollwait, which does:

        init_waitqueue_func_entry(&entry->wait, pollwake);

and pollwake() (which is thus what gets called at wake time) will not
remove anything from the wait queue.

So no, by default your wait queue has to stay around for the duration
of poll() (ie the duration of the file descriptor, since poll() gets a
reference to it).

You *can* play games with pollwait functions (and with wait functions
in general), but by default you should consider the wait function to
stay around.

                 Linus
