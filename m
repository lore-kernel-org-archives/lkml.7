Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D70C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6CA21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555715520;
	bh=ePj/BWoLV3AAsvH/rEPZCke8uzzjZYdlFd4lptMDRy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OI83z94azuO+MXgZriG0gzxJbAZGO+s0lFplwKP9e2Uek9SyIZlgvRVvXk8XHaNri
	 ef0U3Mpg7tGqvRHC6wIWF6W3KvjOZgQBqoOlIfRO7ao6+Q/p4lJ60CHS/rJzJjaVU3
	 6pv18H+O9bEaY+b9mZcLlWNMIZ3N+sOBj2UhbadA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfDSXL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:11:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42047 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDSXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:11:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id v22so5713920lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdUf3lFbFQiNVBd828vl0zLRp6GM+2VM7En0qhuWigE=;
        b=W1H/EhobO3jdaaFICBrL4EdvmrKM5H/rZe9k3wwV4Xjsn8IG1+N3EncfkPMpszyU5h
         jWaiv1a7My9tKLMI/AOpM8zIfr0rydXlPidRIVM5StgDb0YtknNIn3Pjwm86NQXgnQvj
         H7avsLNDEC3dUuePD1+ekBG08hJ2FbNbiQQV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdUf3lFbFQiNVBd828vl0zLRp6GM+2VM7En0qhuWigE=;
        b=XVgQilZF1e4+ys4EgO82zB4U+08lAU/Feh0A1cHfph6Cr8XHIUmcn35zQIMq/92BYC
         AeWC/JcZ2INw2iNHr9+MqP7YFb/O4y2LZCP2/sKNBLv50Xn8/lIyVYpx3tq/ZBvOfROf
         NYWJmiW4Tpg3FVrtHaBIHFqxh5VSzN/ICKKofpx00NBAncW+/2UJY5OYSHB/XNr9ipvI
         HJQbRTFS5HgyGK9vIKvXXknNry67FW64H1F+jqSdWGxqh3CSlyqGG1fwWOlOdUp17kJo
         PdT4RB0N1AOFLbSkAjV1HwP2GOyah0pRyiFgxU0sgeaZGestcZgY4BnuiQwXzbKEkaUd
         LMiw==
X-Gm-Message-State: APjAAAXwYj0lXEBNEGIQT0btjXtoKFqtFEA7BIvzQaspKX8fcEjIC7Dr
        WXwoLfiRHi8PyjJ+gxe6+eZ7PQ21r0E=
X-Google-Smtp-Source: APXvYqzyQy0QZLJCbqkaH8Z8eQ9ihcX4J1fpWCWa4EiaKIXbC9MCthYfTkIwLxwsyfRAE/KDTIhzRw==
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr3610804ljj.84.1555715515648;
        Fri, 19 Apr 2019 16:11:55 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c19sm658970lfi.69.2019.04.19.16.11.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 16:11:54 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id u17so4970761lfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:11:54 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr3548958lfn.148.1555715513747;
 Fri, 19 Apr 2019 16:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com> <20190419212002.GB44851@google.com>
In-Reply-To: <20190419212002.GB44851@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Apr 2019 16:11:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiYUuk7LrkNaggvzZqB63Efu5sChV5hAOdn1ZfunUw6Q@mail.gmail.com>
Message-ID: <CAHk-=wiiYUuk7LrkNaggvzZqB63Efu5sChV5hAOdn1ZfunUw6Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian@brauner.io>,
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

On Fri, Apr 19, 2019 at 2:20 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> According to Linus, POLLHUP usually indicates that something is readable:

Note that if you use the legacy interfaces (ie "select()"), then even
just a plain POLLHUP will always just show as "readable".

So for a lot of applications, it won't even matter. Returning POLLHUP
will mean it's readable whether POLLIN is set or not (and EPOLLERR
will automatically mean that it's marked both readable and writable).

In fact, I'd argue that not a lot of people care about the more
esoteric bits at all. If your poll function does POLLIN and POLLOUT,
it's fine. Anything else is specialized enough that most people simply
won't care. Don't overdesign things too much. You need to have a major
reason to care about the other POLL bits.

It's also worth noting that POLLERR/POLLHUP/POLLNVAL cannot be masked
for "poll()". Even if you only ask for POLLIN/POLLOUT, you will always
get POLLERR/POLLHUP notification. That is again historical behavior,
and it's kind of a "you can't poll a hung up fd". But it once again
means that you should consider POLLHUP to be something *exceptional*
and final, where no further or other state changes can happen or are
relevant.

That may well work fine for pidfd when the task is gone, but it's
really worth noting that any *normal* state should be about
POLLIN/POLLOUT. People should not think that "POLLHUP sounds like the
appropriate name", they should realize that POLLHUP is basically a
terminal error condition, not a "input is available".

So just keep that in mind.

                Linus
