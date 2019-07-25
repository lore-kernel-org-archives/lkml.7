Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958ABC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B5B21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XBPmLfnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfGYKgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:36:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36027 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGYKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:36:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so49799332edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQ5eu5T8bd0iWq+deSWzM6tglKfb1SWMy/MM2LiEz9k=;
        b=XBPmLfnVwr/7eur+UqagLpzPfTEI471X0hzeJK9kCbJAYEWipu0LJvkDzCeGw8ygdH
         N0LbUzRcwqwpW4PkvXZSNqJLEtdRryxKefvoOJ5/1nkdJ3ssKK4pMCF8ie3VP5EyIcvW
         qT4xEDSkaG0gpqe8ynZmtAGOqWGkzjET5sTPd1sePdTUWmeJCHW0c4q7XjeoTBxE1TCw
         FqZ/6uDuNTh84nBe/Go36ZbeTuRH49e4nuvpqWAq/qDhNrkgLecNKAPqZNG76sMs2gKd
         FriQ7L+r2ADxbF0J2tv2yD/7Q63e1VsLb23eVr8B4E4KNQTRqAUsagO+a12ethB1k81D
         BYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQ5eu5T8bd0iWq+deSWzM6tglKfb1SWMy/MM2LiEz9k=;
        b=ZeSt0xoQ+ro2eN72me40pxpT7NTLHe91zfDGQ8GykNSsKE8X4URNXjatvyAqcrJhIa
         YZj9SGGXdrLl5+IIUdZnf+TmIRphlp/HEjkB9eRpR6hxEuCio06BegBmTDzHAUEKgQut
         FqweGu06582QJj6hcTP6UyXt2nrGNvHz4N7NDsybDAd/nvPV68z7VUks7ec8/v6TPQI6
         R+ufJQ3Is8Q9eb6rL26287ZYUL0Hnfe31ThHGr26E0bZxSGnVkP76M3rBFdfgKh/Zgjz
         yiondpVrQMBXSGTS/Uk2rdje+xFYWZk1mZ5ygFReKBWaZcXNVHRuanx5WKuMoWUQtX1N
         85mw==
X-Gm-Message-State: APjAAAVIgdvbP32NneDsgZjlX8ejn3dkyX6YnLIfqve+gb7kxHc9jJXT
        sk4JIXCsVePmSW0jmB+K2sM=
X-Google-Smtp-Source: APXvYqwr0w96C9E3KmMEQ1OaEoayIkDJj63yxWm9LwY9XRCEcwx3aktseA/PBCJGJp0r84595ZeTFQ==
X-Received: by 2002:a50:f410:: with SMTP id r16mr76790306edm.120.1564050964343;
        Thu, 25 Jul 2019 03:36:04 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id p15sm7737732ejr.1.2019.07.25.03.36.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:36:03 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:36:02 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel-team <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725103601.4ck4bpsdsgcpdknt@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <CAG48ez3nuY__qvctoOnX7mQbjjP4chEs4K-OPxSQficiPLS18w@mail.gmail.com>
 <CFB4D39F-24B9-4AD9-B19C-E2D14D38A808@brauner.io>
 <CAG48ez1vd4Yhd3DqHVjTWM-N0MaNnX9n8MNV7MEyU5m3XDu+kQ@mail.gmail.com>
 <20190725103048.GE4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725103048.GE4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:30:48PM +0200, Oleg Nesterov wrote:
> On 07/24, Jann Horn wrote:
> >
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1902,6 +1902,10 @@ static __latent_entropy struct task_struct *copy_process(
> >         delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
> >         p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
> >         p->flags |= PF_FORKNOEXEC;
> > +       if (!(clone_flags & CLONE_THREAD))
> > +               p->flags &= ~PF_PF_WAIT_PID;
> > +       if (clone_flags & CLONE_WAIT_PID)
> > +               p->flags |= PF_PF_WAIT_PID;
> 
> agreed, but then the "if (!thread_group_leader(tsk))" block in de_thread()
> should also copy PF_PF_WAIT_PID.
> 
> > An alternative would be to not use p->flags at all, but instead make
> > this a property of the signal_struct - since the property is shared by
> > all threads, that might make more sense?
> 
> I tend to agree.

Hm, ok. That's two people that prefer to make this a flag in
signal_struct. Ok, let me adapt the patch.

Thanks!
Christian
