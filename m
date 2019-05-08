Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBB7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEC6204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2CfoAC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfEHPuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:50:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33471 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:50:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so17946208ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B305JCF4NGCczfGfXU1a1TKoXlp/y2MhWZaGK0Ie4es=;
        b=A2CfoAC96HAV0IlhpRIdq0sCzJOOUx6zxDraSZJePsGQe/2A8A/byVvNpR7hz+daF4
         2a0ofpW8jtCw/hQJrpVYYGbOKWp+8b66TRCEwrwqjL3+Kz6QWv9huBpqZujXlMg0pD8P
         R5mo/uiy970d/CIf0irWTjfuvETtSt5Uynfv52guHz7jeOBvenHdcLnvHQvxvOqpgqe2
         h6PbXLiiVL5zMAHl22IJBGpisgZXdZrNEe7n9IzK2bwvUgv9cJs9rqEAnluIsxdAi3oB
         UoVifu8pItlm7N1OZCfy/ZJNADLGh8eoItRVw0HgeytPli+tF0EKCKYdGtPwxdbvv7cv
         qEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B305JCF4NGCczfGfXU1a1TKoXlp/y2MhWZaGK0Ie4es=;
        b=WIubzIxo8eWSX4RKaYSn3lBx7s7f41b4BgurU1b+4dZldmmqhiW+0yZSUpWZdyAfLw
         P/GtT/DTb/Tyk1JxcTS9qM2WDsc9SeMEX2S41hLNcg2gKHn+UglWuZ7ZJjnYwKctvpSf
         ybFsQgXtk8144niKFNLGiGMDuosGo6JwTv1pNq/9SGfLaiRshod9BxLN9v8H6O3NldG2
         5GOwlvWimxK+1cRfYNGM/nhdoklLtm+JJoW1+6Y+xfvkiRjIR2Yv1BzfYnKjDVFVthxd
         JO+22NduCx6XJPYshKQvI4PRk8TK5tiqdbu8a5f+HYKTxcX7v3SzLCZCj/rwjGRnX6GQ
         qtGw==
X-Gm-Message-State: APjAAAXmI/AMyYQebkescq8xNjyyE/8xWj1JKY5de4gOVgc4Lu0f/Wd2
        GpfLY3rR5l36VhJNMERZHRUm3xikEbw0F7YYhKg2OA==
X-Google-Smtp-Source: APXvYqzdJss/5JTx3UQPYduwk+6ZDR8g0zugT/w5g8w3eoUBLk7F64RpNnjtBLeHvy972J2JozmTaIktDHhRlR7gmVo=
X-Received: by 2002:a2e:810d:: with SMTP id d13mr20255512ljg.93.1557330609560;
 Wed, 08 May 2019 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
 <20190429061516.GA9796@aaronlu> <6dfc392f-e24b-e641-2f7d-f336a90415fa@linux.intel.com>
 <777b7674-4811-dac4-17df-29bd028d6b26@linux.intel.com>
In-Reply-To: <777b7674-4811-dac4-17df-29bd028d6b26@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 8 May 2019 23:49:58 +0800
Message-ID: <CAERHkrvU0nay-cG9equdOBejOZ5Ffdxo+67ZRp9q0L9BQkcAtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 8:06 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On 5/1/19 4:27 PM, Tim Chen wrote:
> > On 4/28/19 11:15 PM, Aaron Lu wrote:
> >> On Tue, Apr 23, 2019 at 04:18:16PM +0000, Vineeth Remanan Pillai wrote:
> >>> +/*
> >>> + * Find left-most (aka, highest priority) task matching @cookie.
> >>> + */
> >>> +struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
> >>> +{
> >>> +   struct rb_node *node = rq->core_tree.rb_node;
> >>> +   struct task_struct *node_task, *match;
> >>> +
> >>> +   /*
> >>> +    * The idle task always matches any cookie!
> >>> +    */
> >>> +   match = idle_sched_class.pick_task(rq);
> >>> +
> >>> +   while (node) {
> >>> +           node_task = container_of(node, struct task_struct, core_node);
> >>> +
> >>> +           if (node_task->core_cookie < cookie) {
> >>> +                   node = node->rb_left;
> >>
> >> Should go right here?
> >>
> >
> > I think Aaron is correct.  We order the rb tree where tasks with smaller core cookies
> > go to the left part of the tree.
> >
> > In this case, the cookie we are looking for is larger than the current node's cookie.
> > It seems like we should move to the right to look for a node with matching cookie.
> >
> > At least making the following change still allow us to run the system stably for sysbench.
> > Need to gather more data to see how performance changes.
>
> Pawan ran an experiment setting up 2 VMs, with one VM doing a parallel kernel build and one VM doing sysbench,
> limiting both VMs to run on 16 cpu threads (8 physical cores), with 8 vcpu for each VM.
> Making the fix did improve kernel build time by 7%.

I'm gonna agree with the patch below, but just wonder if the testing
result is consistent,
as I didn't see any improvement in my testing environment.

IIUC, from the code behavior, especially for 2 VMs case(only 2
different cookies), the
per-rq rb tree unlikely has nodes with different cookies, that is, all
the nodes on this
tree should have the same cookie, so:
- if the parameter cookie is equal to the rb tree cookie, we meet a
match and go the
third branch
- else, no matter we go left or right, we can't find a match, and
we'll return idle thread
finally.

Please correct me if I was wrong.

Thanks,
-Aubrey
>
> Tim
>
>
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 25638a47c408..ed4cfa49e3f2 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -208,9 +208,9 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
> >         while (node) {
> >                 node_task = container_of(node, struct task_struct, core_node);
> >
> > -               if (node_task->core_cookie < cookie) {
> > +               if (cookie < node_task->core_cookie) {
> >                         node = node->rb_left;
> > -               } else if (node_task->core_cookie > cookie) {
> > +               } else if (cookie > node_task->core_cookie) {
> >                         node = node->rb_right;
> >                 } else {
> >                         match = node_task;
> >
> >
>
