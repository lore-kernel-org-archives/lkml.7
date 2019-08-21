Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6182339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CSPe5oLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfHUWZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 18:25:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35691 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfHUWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:25:26 -0400
Received: by mail-io1-f67.google.com with SMTP id i22so7939040ioh.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oy2sEaeUKQmIQDPnRHPvhcv2oR+KrijeR8lZYw8C0/k=;
        b=CSPe5oLS5GCxhgWQHq7yG/45Wg9e/dcWfFbvVFUOIsEVMJdZpfA/aKz+r7CI1beOsg
         86MdsJUsnV+wsOxFltJkf3VxoPs3AeT+rO9MHIufSAnfPYcJGgCo9VCu3C791QS2ksW8
         fnVsI6EvzYRseYPoUwiicdAuYpiIrE3mZ4LUbeQYrGq+ffvzPF1WozYb9yFaPKcDXFlt
         VuF0CNfyYEmTcstqpLwpCtL6a1vV4HLPjueD8ZFRQAECGw5vNqbeZn/Sdt/LBlFb/FlP
         BykJ83k8VyhtKxLpHT1xX3wXOfcpZR2LPiidgFv/MpUnsXkVKkuChZE46KTAO+DgvcFq
         KKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oy2sEaeUKQmIQDPnRHPvhcv2oR+KrijeR8lZYw8C0/k=;
        b=qmIrB8dtxGKHJWhViexTiDs/5o6/oI0gFaYLNbfIVMTnjNvn4Bta12YAsSjWaR7N35
         /t5ijQnCzofKhzYQqDviSR78VNpGxzbg2Q9o7StP4qm5e5ZiAXGEKH/mzVczSuhi3N5J
         f6Nez9Pu+5u3Ol8FhNsnopPR5neetmhVfSZsS+6mlZZVbqBkA/YVdNMPS4tTmkzV/4lx
         N/WEITqrXzdYIbBThF8wYtgc4XXhQ7vLueOobB5vWhkxYMPCFS+VOeL+qeq5R7/JKuIH
         gOf4cXai7pfyMgwP3r3nx+mCER5+pnp0upm3/KDjzmlfcS72HdAJY91DrHf9OlHL57tu
         J2ww==
X-Gm-Message-State: APjAAAWB5y7j6MJf6lzw88LrEoPWb9t8RI6awiAtn0k+sD9M9l7lxPKx
        plylOzSLO2Rp2PuhUp5I7B/t4JP8X47RmO7YpOTAnQ==
X-Google-Smtp-Source: APXvYqxogVj5UGWnLw3ZYO4+aHd3dAgmuZTb+9ASSNDaOafz38TIIp6+hr7TuauJyMcZe39gLj9RHKEIQTyQ3LHEXRE=
X-Received: by 2002:a5e:8e0d:: with SMTP id a13mr38379962ion.28.1566426325439;
 Wed, 21 Aug 2019 15:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190821001445.32114-1-echron@arista.com> <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
From:   Edward Chron <echron@arista.com>
Date:   Wed, 21 Aug 2019 15:25:13 -0700
Message-ID: <CAM3twVSfO7Z-fgHxy0CDgnJ33X6OgRzbrF+210QSGfPF4mxEuQ@mail.gmail.com>
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process message
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 8:25 PM David Rientjes <rientjes@google.com> wrote:
>
> On Tue, 20 Aug 2019, Edward Chron wrote:
>
> > For an OOM event: print oom_score_adj value for the OOM Killed process to
> > document what the oom score adjust value was at the time the process was
> > OOM Killed. The adjustment value can be set by user code and it affects
> > the resulting oom_score so it is used to influence kill process selection.
> >
> > When eligible tasks are not printed (sysctl oom_dump_tasks = 0) printing
> > this value is the only documentation of the value for the process being
> > killed. Having this value on the Killed process message documents if a
> > miscconfiguration occurred or it can confirm that the oom_score_adj
> > value applies as expected.
> >
> > An example which illustates both misconfiguration and validation that
> > the oom_score_adj was applied as expected is:
> >
> > Aug 14 23:00:02 testserver kernel: Out of memory: Killed process 2692
> >  (systemd-udevd) total-vm:1056800kB, anon-rss:1052760kB, file-rss:4kB,
> >  shmem-rss:0kB oom_score_adj:1000
> >
> > The systemd-udevd is a critical system application that should have an
> > oom_score_adj of -1000. Here it was misconfigured to have a adjustment
> > of 1000 making it a highly favored OOM kill target process. The output
> > documents both the misconfiguration and the fact that the process
> > was correctly targeted by OOM due to the miconfiguration. Having
> > the oom_score_adj on the Killed message ensures that it is documented.
> >
> > Signed-off-by: Edward Chron <echron@arista.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Acked-by: David Rientjes <rientjes@google.com>
>
> vm.oom_dump_tasks is pretty useful, however, so it's curious why you
> haven't left it enabled :/
>
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index eda2e2a0bdc6..c781f73b6cd6 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -884,12 +884,13 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
> >        */
> >       do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
> >       mark_oom_victim(victim);
> > -     pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
> > +     pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB oom_score_adj:%ld\n",
> >               message, task_pid_nr(victim), victim->comm,
> >               K(victim->mm->total_vm),
> >               K(get_mm_counter(victim->mm, MM_ANONPAGES)),
> >               K(get_mm_counter(victim->mm, MM_FILEPAGES)),
> > -             K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
> > +             K(get_mm_counter(victim->mm, MM_SHMEMPAGES)),
> > +             (long)victim->signal->oom_score_adj);
> >       task_unlock(victim);
> >
> >       /*
>
> Nit: why not just use %hd and avoid the cast to long?

Sorry I may have accidently top posted my response to this. Here is
where my response should go:
-----------------------------------------------------------------------------------------------------------------------------------

Good point, I can post this with your correction.

I will add your Acked-by: David Rientjes <rientjes@google.com>

I am adding your Acked-by to the revised patch as this is what Michal
asked me to do (so I assume that is what I should do).

Should I post as a separate fix again or simply post here?

I'll post here and if you prefer a fresh submission, let me know and
I'll do that.

Thank-you for reviewing this patch.
