Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC78C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8162186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpemiLVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfGSQve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:51:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44109 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfGSQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:51:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so23679596qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MD20IfExCxC1GSVGQW60wKgomTGICWCjQ6hD4XxAnGw=;
        b=kpemiLVuSTkgT1yRxRYlnKwPO1WAGRaWdvcqlRA3oLQwivdx6ZKdJ7WbUnqL/ge+RK
         vWKFZXCa7xA0NhQqNQmi1YLnL8o8BU/PtEAbdIA2WDCLJrxWy/h+Qbru5yd2c/AqKMnW
         K17Nh83xnyZ0IEHjtPwvOY8Gcp7TapRJCrQuqGwxZkdu7/CckPAfel11whgQ+G0WHYto
         1XcWWVF6KPmQxdIkDVeFJkQqSkoIb6/0vuF3cX9ImdLB4v7gkjhzYrPZ6ihwA+/mM3/1
         x2d2cT/J9Vrv08GmCH564foY6M3QTyHmB1BkmMRljqh5qvs8ZcLBk/wfBeCQogizVvGw
         Tbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD20IfExCxC1GSVGQW60wKgomTGICWCjQ6hD4XxAnGw=;
        b=dLcA7HWZo70GG7a0zNfVYRUgN37yA3ji/lwgz+UR+UX9l+88et1qjb9EBsqpESBxfw
         G1faTIM6RofXqPfljJzjzAzAVXgqjyTc0A2AQz0MxEpYyBj3m+cJdKS4HcGcBRGovldV
         fn2CIXtaQmO+0VyZXDK2eJgKc8kKQG5T5toaygH2qNWBXpDptIxNKKIDHUcdVFPN6XUg
         mKGntVM0Wzd+Ff653tC/wtg4fKjKLcDOSSFJvMblcfhufcHGXZKovZsy5GCrFfMf7SNB
         BuY9gKumbrdUnzSaS2Wru2uQH7/qf0SA/9W5Rb1TqN432zrquWh9IPOzSql0TW0jhg6u
         b0RA==
X-Gm-Message-State: APjAAAVtNSgzLRDn1YiWWl6KK57sAemwzvrIyBqPZxl/Ky2ciHc2dDPa
        O8/LEqmbLAM5SreRrTAZt8ViwVK+PgSxSx2ngiCvoQ==
X-Google-Smtp-Source: APXvYqxA9uMEtiLCs3KpiACSlD4ESvf1ubbKecKsByV25EeIOZ3pnWqiQ+487s8rBEvBmb5TaYFiz4unMZ7PvQttApA=
X-Received: by 2002:a37:4714:: with SMTP id u20mr35695754qka.162.1563555092394;
 Fri, 19 Jul 2019 09:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190717172100.261204-1-joel@joelfernandes.org>
 <20190719161404.GA24170@redhat.com> <20190719162726.u5fi5k3tqove6hgn@brauner.io>
In-Reply-To: <20190719162726.u5fi5k3tqove6hgn@brauner.io>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 19 Jul 2019 12:51:20 -0400
Message-ID: <CAJWu+orxkFyoTTmFJs23FD0PKX-NetF4kVVLXnWkyLdCU2_cYQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd polling
To:     Christian Brauner <christian@brauner.io>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:27 PM Christian Brauner <christian@brauner.io> wrote:
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

Agreed. Christian, do you mind dropping this hunk from the patch or do
you want me to resend the patch with the hunk dropped?
