Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08570C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF04520657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwZvqBjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfG2Q1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:27:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45171 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfG2Q1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:27:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so62511318wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHHPMQ336CdhvDwSHAm2ZkUObmC6MYlngRuFkjj6+rQ=;
        b=DwZvqBjX9KZPS22QyEa1iILLH2hTN+dUD4/1b4KsFWjmUYFEpnvMp5tSzwCOjk7nXb
         47dFo9DlBP6wgTwKxLmF9vyO4cn8qs5wQBO3Omtt8RKttUKk/isZrTTkLcrQdd1Z7rRs
         D46FJFRHuv3mVsh6Y7jppOHWDuC0krJot6cLHZjhOkilCIqI+IccrKR5Wgj8v288QNhh
         Tm5F5iCRaAl3tKxEvEcc8RgJY7oAHbrGH0Ly1ylK9L/y6pN0E7y5Qftdv8n8Pr5y5F9q
         oicicY+3MN+3DuQaNUXBk9ldinCIorc4sLE/AzB8zq6Q6VeVknCRYat0EcKOmFDaTqsI
         ZCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHHPMQ336CdhvDwSHAm2ZkUObmC6MYlngRuFkjj6+rQ=;
        b=uNsq7FD2GzBk+QieX4VeN0eVW6eGqyBqfQz9CQAvAkGtc3G5D/Xdy8AMeCYXYcgDMD
         THXblzgfYmfikOa1nLQTS0dzoIvtg/QA+4bIh5sO0UzYRwNB6o8iTW66CUlsevf66wdM
         rvTdr0c1zDxTwVrUL66d3tx7kvwHnWTs7jyTgwDKkD3+V2Uy3kqUMhtKk/XI1KUkBh0Y
         BQwLo07V/9W3yUvq1o+P6vV42qoFMDhvXVQbrncPTcM8qJuXAnje8hbkHscfebgmkyss
         BVsVk/bInXXPZfgheup73fZykfgeR7fyFbajcpQbiDNUzsxlVAcAziOK/UcVZzugduKo
         4AMw==
X-Gm-Message-State: APjAAAWX5nvxj7CmtskjUbh9+lVNVddBuyrBQNn5QL20SxynpN9rRKqv
        iEZCopVXC09CNqgdGEzWQ4Y9c64oPG5oA2OzR+VPnA==
X-Google-Smtp-Source: APXvYqzQB1oJO3+x7XEVtNxM0vZcfRsQTHn2vaqSNFdzqGSy1CwX28tXj8TGjJHa9RkugwuUHla2pK2K30V09V6Y15E=
X-Received: by 2002:adf:e50c:: with SMTP id j12mr37995479wrm.117.1564417651286;
 Mon, 29 Jul 2019 09:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <20190729152957.GA21958@cmpxchg.org>
In-Reply-To: <20190729152957.GA21958@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 29 Jul 2019 09:27:20 -0700
Message-ID: <CAJuCfpFsPn9MeS-pWcrAj1ZcVZXJNn94Vina6se2MgApgEFxHQ@mail.gmail.com>
Subject: Re: [PATCH] psi: get poll_work to run when calling poll syscall next time
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jason Xing <kerneljasonxing@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, axboe@kernel.dk,
        lizefan@huawei.com, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 8:30 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hi Jason,
>
> On Tue, Jul 23, 2019 at 02:45:39PM +0800, Jason Xing wrote:
> > Only when calling the poll syscall the first time can user
> > receive POLLPRI correctly. After that, user always fails to
> > acquire the event signal.
> >
> > Reproduce case:
> > 1. Get the monitor code in Documentation/accounting/psi.txt
> > 2. Run it, and wait for the event triggered.
> > 3. Kill and restart the process.
> >
> > If the user doesn't kill the monitor process, it seems the
> > poll_work works fine. After killing and restarting the monitor,
> > the poll_work in kernel will never run again due to the wrong
> > value of poll_scheduled. Therefore, we should reset the value
> > as group_init() does after the last trigger is destroyed.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
>
> Good catch, and the fix makes sense to me. However, it was a bit hard
> to understand how the problem occurs:
>
> > ---
> >  kernel/sched/psi.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 7acc632..66f4385 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -1133,6 +1133,12 @@ static void psi_trigger_destroy(struct kref *ref)
> >       if (kworker_to_destroy) {
> >               kthread_cancel_delayed_work_sync(&group->poll_work);
> >               kthread_destroy_worker(kworker_to_destroy);
> > +             /*
> > +              * The poll_work should have the chance to be put into the
> > +              * kthread queue when calling poll syscall next time. So
> > +              * reset poll_scheduled to zero as group_init() does
> > +              */
> > +             atomic_set(&group->poll_scheduled, 0);
>
> The question is why we can end up with poll_scheduled = 1 but the work
> not running (which would reset it to 0). And the answer is because the
> scheduling side sees group->poll_kworker under RCU protection and then
> schedules it, but here we cancel the work and destroy the worker. The
> cancel needs to pair with resetting the poll_scheduled flag:
>
>         if (kworker_to_destroy) {
>                 /*
>                  * After the RCU grace period has expired, the worker
>                  * can no longer be found through group->poll_kworker.
>                  * But it might have been already scheduled before
>                  * that - deschedule it cleanly before destroying it.
>                  */
>                 kthread_cancel_delayed_work_sync(&group->poll_work);
>                 atomic_set(&group->poll_scheduled, 0);
>
>                 kthread_destroy_worker(kworker_to_destroy);
>         }
>
> With that change, please add:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Thanks!

The changes makes sense to me as well. Thanks!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
