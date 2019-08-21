Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EBE22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Kv1SPhc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfHUVwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:52:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44675 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbfHUVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:52:11 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so7688361iop.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRZ9pkhY1h9rFQYNWqajh16OFNxR0phdkMcgzEpGGcw=;
        b=Kv1SPhc/jQyHewGWa/qstvhOKINCQgUoaSRoc9djtyA4zFJG1QctbVdKBbUrBr5yo4
         UjO1bhQN0JSJBn0OCrfG4t9uEzpvolNfmtshCP4pNeBrez4MmuWSeEmP+LicgXxtDdP+
         ehz6Zic+Agz1UxJJbdvnL9MaManoPwDPj/7dGSDDWq9RrtbYLoBFL1dojkKyaeT8P35T
         +JvnMHe7EDOBYNs57XQ4iR7hByJovStYQhpTcL/lTdUdLqE5EF9R8Vxl95UULeRZD/jn
         TAdIhjw9JrNRCgQpNpAA8oflKkfPNzk/fa9GJ52Ts8lqO/b+zUoRq1BxE+8p04dkNwnE
         nEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRZ9pkhY1h9rFQYNWqajh16OFNxR0phdkMcgzEpGGcw=;
        b=MaRy1ZBgDpWxoQAFLuS2EGwzI1OYZAV5F3jlqfy+rt0bdIVJgTlSArNl7LP4Ru3/gQ
         f7REyrY0Z1VFBEFq7AY5puSCfvWU4iS8A77/GYJB2qV7yTK0Um8P1B+ZcodeBl1M8l/n
         LFpW0HWJepIO26GOzNLrYnEiKQwf5wVNK7Y9x8NzIn7MYuj81YXyL0uwZxbv7QNfz/Op
         zo96Jo8fuRaP7qje69VHfSEZIGNHETF50S6V/fVcsvGgYQMuSRShKnNcQazSxRKkijci
         nU2mkXn522OKz918Vxlh1aPe69sGwgAJXsN41gHt0O7fVzhuUcIXVzeRI6nYcEyPXJ8t
         6tiA==
X-Gm-Message-State: APjAAAVzlCkE18W4iCS02+SFfbzWWI1ur+17TRR1cPIuAH7VmsgQTUEs
        P8ce59+xLF/U8rlnUckYsUDScxWlsU1c74nmJEaHQQ==
X-Google-Smtp-Source: APXvYqxoLJoixZyVMPCcjGuE93lHIn4QNtcinIWMsmk4mP+zCUiw2zL5eWlWQe/sg5AejOHX8d9H2YCJWiQeInNfBOk=
X-Received: by 2002:a5e:8e0d:: with SMTP id a13mr38211482ion.28.1566424330756;
 Wed, 21 Aug 2019 14:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190821001445.32114-1-echron@arista.com> <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
From:   Edward Chron <echron@arista.com>
Date:   Wed, 21 Aug 2019 14:51:59 -0700
Message-ID: <CAM3twVT4pwDsOFm80vTsxYE7AXdV8bFKquPS7wuKFuqMo=SvoQ@mail.gmail.com>
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

Good point, I can post this with your correction.

I will add your Acked-by: David Rientjes <rientjes@google.com>

I am adding your Acked-by to the revised patch as this is what Michal
asked me to do (so I assume that is what I should do).

Should I post as a separate fix again or simply post here?
I'll post here and if you prefer a fresh submission, let me know and
I'll do that.

Thank-you for reviewing this patch.

-Edward Chron
Arista Networks

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
