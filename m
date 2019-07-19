Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED11C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B402921872
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gW28s7Pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfGSQd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:33:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38837 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfGSQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:33:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so32870934wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/d9rok+uziIchuNx4fir+IeDsIyz939n/QaTRJw2YiU=;
        b=gW28s7PtRmRVP7DPR/hEKIrcn2rU0/TNPo6418yib5FT08XhoFOxC71p+Kcj/WoC8n
         lcBEaruSRKroxrvOB7w2hYmGeKxRZnX+k7FZgrXcAdx2Oc+8I9Q+ZJWrNhN3Tc+RkxDw
         hPesdRlFQwYjldwUDipsYi0QgyReMFoqq6CknHr9Wn0TLqSdK+/SscFbp+3xR3xIJ3BQ
         eWsD3OGtzrxLlRi8ZeshvFOCFuJDBJ0xDYTyzq+pI06OFWozlBNHhbyMTVmRbFAlZsbT
         jevqLLfuE0K1eBeZKv4RovrrCpIPC8Qd6Eycvm08/V3ijiYJhDWWGF8lbmNKHz5SkmO3
         ndJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/d9rok+uziIchuNx4fir+IeDsIyz939n/QaTRJw2YiU=;
        b=NJI7p1o23cmdJfRuliEYSoRbSIX7d9MkcVK2czzLszBsMe6QAoQ3i9BTTgMhar6nRn
         aeX21daZ7jomCLlDNPmv52GQEAOIKp1wgh6gXED1NLCo9rC9FUjj2vzzWo2NBXRUQQGW
         MDWE+yr6qdSvs4p4aH448vNtCmASSdvTTns9hqxKIQ+XbzHnkB0/nNGcGYnvnvik/4wx
         hdKV8T1H4UF1btegvd01iY4DQJC+jMAAWHFX/2reJE8Ozi3Ce7U+KCGJH9AfU6u13BNg
         cgjBv4nSe4F9SmesqDpgxoj5UiPJ1BGojl34UYqwAoEJSNmVblcZAaetwr8Gxee19Axk
         WcVQ==
X-Gm-Message-State: APjAAAWCpN26/zF2GjXrdpwRRHSbN7BCIYVzVC0RscREbGA61Tk9jC3P
        S5lNjK6Jo7Ig0KlAsbzwXx+gDfSyyGDSL8GWw0wr4YNZ28U=
X-Google-Smtp-Source: APXvYqx3amCHiD5SGxvjm2EboUc6NudUyhGTBLYAWKpZ7ypXr9u6qRVrO/Lvpgjwr4e3MxwlOQxcnISzS2sGEhOASrU=
X-Received: by 2002:adf:e50c:: with SMTP id j12mr52974950wrm.117.1563554005652;
 Fri, 19 Jul 2019 09:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190717172100.261204-1-joel@joelfernandes.org>
 <20190719161404.GA24170@redhat.com> <20190719162726.u5fi5k3tqove6hgn@brauner.io>
In-Reply-To: <20190719162726.u5fi5k3tqove6hgn@brauner.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 19 Jul 2019 09:33:14 -0700
Message-ID: <CAJuCfpFe0CEDXPQfHYATszZGKZa7h2Kjuym2yLYcdDFicGiAWg@mail.gmail.com>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd polling
To:     Christian Brauner <christian@brauner.io>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 9:27 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Fri, Jul 19, 2019 at 06:14:05PM +0200, Oleg Nesterov wrote:
> > it seems that I missed something else...
> >
> > On 07/17, Joel Fernandes (Google) wrote:
> > >
> > > @@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
> > >             ptrace_unlink(p);
> > >
> > >             /* If parent wants a zombie, don't release it now */
> > > -           state = EXIT_ZOMBIE;
> > > +           p->exit_state = EXIT_ZOMBIE;
> > >             if (do_notify_parent(p, p->exit_signal))
> > > -                   state = EXIT_DEAD;
> > > -           p->exit_state = state;
> > > +                   p->exit_state = EXIT_DEAD;
> > > +
> > > +           state = p->exit_state;
> > >             write_unlock_irq(&tasklist_lock);
> >
> > why do you think we also need to change wait_task_zombie() ?
> >
> > pidfd_poll() only needs the exit_state != 0 check, we know that it
> > is not zero at this point. Why do we need to change exit_state before
> > do_notify_parent() ?
>
> Oh, because of?:
>
>         /*
>          * Move the task's state to DEAD/TRACE, only one thread can do this.
>          */
>         state = (ptrace_reparented(p) && thread_group_leader(p)) ?
>                 EXIT_TRACE : EXIT_DEAD;
>         if (cmpxchg(&p->exit_state, EXIT_ZOMBIE, state) != EXIT_ZOMBIE)
>                 return 0;
>
> So exit_state will definitely be set in this scenario. Good point.
>

Yes, I think you are right. AFAIU in this code path p->exit_state
should always be equal to EXIT_TRACE because of the earlier cmpxchg()
call and the if condition before do_notify_parent(). That's of course
unless there is a chance that p->exit_state gets changed by some other
thread after cmpxchg() call and before do_notify_parent()... I'm not
that familiar with this code to say for sure that it's impossible. If
that can't happen I think we can remove this one but the change in
exit_notify() should definitely stay.
Thanks,
Suren.

> Christian
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
