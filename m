Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F8120854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JnPP3rZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfCYTmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:42:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54580 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYTmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:42:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id f3so10279635wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1y/SgEcOJ+/VljQdIgMeyDpheN4RVrcYRxNNxPJK1VM=;
        b=JnPP3rZffscwzg4nxdTprPGA6f+9ndL2wh+sljyBsQGVY7qyjJLQHDzWVX0FjNVKyM
         GAnWLRRJxvg6GWK1uWuvjN25Fg1SdNuVypa21pofCa7IObglFxechHiHB9Q4fX14A33g
         CgUauqiFkMf7gfF3rWwkS8Rc0tNCiM1/3UmHntgwv/M0Arh20n4E2xMP1Of8BwXk2wKp
         5tMAg6FD8XxEkEjd3R7n6cEYrkbKcaikNhjg/B6vVBgYzk34djYRzbnN0BTM50MW6E22
         lKXATuAYicsbpc1buuvyJTG7LHdFk+L+MzcWkGEIUD58kpASdma3qyoM/kuhbMyuVNv9
         iGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1y/SgEcOJ+/VljQdIgMeyDpheN4RVrcYRxNNxPJK1VM=;
        b=Z0c/3lc4kG9QaRKuelAB0mut4yHXHbMPflKNxP3wZEmphtkDcXlZmdAdrAZzPgiV5g
         chTfR3G7LN0EbQHhIUGAAJWHP/+V7LF/PT9M3Zfn7KFdcA7q6vz6bpA+jIlKp1uZSpzE
         GbuibfGmTzn0uuGhYV5kw9wN/8Mak/U2bToNzM6gfaxOR6LCmEb1ti6DnDI2LIrqHHhB
         FydWfjCnzswfiP+GpElGzLFtyBqk6wzvjqUgLNGghLOc85G5kRVw7PT1F8gL+J5dsUi9
         dBCpp1y7V09zdEkmvNJFn71z0azDhE8A2icZuaeQ73Z7mbI1Nhq6mMeWVciMreSTQJH0
         K45A==
X-Gm-Message-State: APjAAAUOJTk0u+EcQEosC4BLW9Esqswf5fOBPZsjQIRS2tmhBw+Fa/7+
        OxAN5rVDun27XdwZiGrI1w1dvg==
X-Google-Smtp-Source: APXvYqw7TnDksnCGk4xtFGq7WLaqvt1NZ2WJHL67ZCh/VyPJVsChepW+dr62ivEO0biTTk62N6HwJA==
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr12228796wme.46.1553542921617;
        Mon, 25 Mar 2019 12:42:01 -0700 (PDT)
Received: from brauner.io (p200300EA6F14663DB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f14:663d:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id q3sm2716544wrr.75.2019.03.25.12.41.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 12:42:01 -0700 (PDT)
Date:   Mon, 25 Mar 2019 20:41:59 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        cyphar@cyphar.com, Al Viro <viro@zeniv.linux.org.uk>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 3/4] signal: support pidctl() with pidfd_send_signal()
Message-ID: <20190325194158.rapwoa3oeqluwcfn@brauner.io>
References: <20190325162052.28987-1-christian@brauner.io>
 <20190325162052.28987-4-christian@brauner.io>
 <CAG48ez1QSJTOb-DAQuVpa5feUe9K-pr8aYuyd=yXg0n9eSg-LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1QSJTOb-DAQuVpa5feUe9K-pr8aYuyd=yXg0n9eSg-LQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 07:39:25PM +0100, Jann Horn wrote:
> On Mon, Mar 25, 2019 at 5:21 PM Christian Brauner <christian@brauner.io> wrote:
> > Let pidfd_send_signal() use pidfds retrieved via pidctl(). With this patch
> > pidfd_send_signal() becomes independent of procfs. This fullfils the
> > request made when we merged the pidfd_send_signal() patchset. The
> > pidfd_send_signal() syscall is now always available allowing for it to be
> > used by users without procfs mounted or even users without procfs support
> > compiled into the kernel.
> [...]
> >  static bool access_pidfd_pidns(struct pid *pid)
> >  {
> > +       int ret;
> >         struct pid_namespace *active = task_active_pid_ns(current);
> >         struct pid_namespace *p = ns_of_pid(pid);
> >
> > -       for (;;) {
> > -               if (!p)
> > -                       return false;
> > -               if (p == active)
> > -                       break;
> > -               p = p->parent;
> > -       }
> > +       ret = pidnscmp(active, p);
> > +       if (ret < 0)
> > +               return false;
> >
> >         return true;
> >  }
> 
> Nit, if we keep this function: "if (...) return false; return true;"
> seems like an antipattern to me. How about "return ret >= 0", or even
> "return pidnscmp(active, p) >= 0"?

Yip, sounds good.
