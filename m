Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E047C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAEF20645
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC5B2Ges"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfEQRSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:18:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44949 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:18:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id e13so6928550ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbjfTetAqL1pRhjTEDGbQ+uNYoNVxKUkaX8lZYlWznw=;
        b=CC5B2Ges+xvej3Nhb6RmKVrq8K8CcavP5JDncg3r+toYlm0bojmH/OgLQlbeOgMGo8
         hBZGtecc9vw84t81r9B7TRr3H88irnUReCcOi4gueT82FV4YcGc/8QmdRgSwnfc05z3e
         DdvTNyx6eFN7IAYd8hKOvFZiUQI0T/cb1KNMZrA49Z4uw6QTOpa6z+XwnOE2uo+fzdJ8
         1oopsf8rW02bpStuMl44QVmuRE3gojJf3zzIj4VtKKIBo8Fv5vT/udNsSiDFgg5mN+xd
         uU6/HH0bOj1cvjGgt7gO8SblVycAuKggmfZXJ4kk72OEzmHtn4AzQ5PHX2/yZc4NvgLh
         K5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbjfTetAqL1pRhjTEDGbQ+uNYoNVxKUkaX8lZYlWznw=;
        b=MrzbfzZwhaqQkPDpGlslLkez/SQnQf1TXQnhwlVrVEsXteCo+w9r5FR2qsowno3eZQ
         3gySGiP5QE7xMraiFwNwx9aBN46+56xzYI2qRVzZYXTf9appGueG107Z8AnfaNT9GfMm
         yxiymfUrwmgU/YijAnnrUVBV5nU18V3SmBt85lpht6IhbUR6xfikOOsiHE7HKDNk6JuF
         vPZntK7A7je0RVuepV7Ew2hUEiaXoD7Lws+KPBVirfTahNDQpMIS8OxW9g5qR4CrF1yj
         TgzQjvhUHIRTiQhQqevygvclOH1i8rbkbGApujDxyXC1uNHNZWkgsrxAnLi2I3i3KUFI
         lsNg==
X-Gm-Message-State: APjAAAV8bLlZ7cFvOXWkpOKY9joaMu2lkknfCdHm99f0yuGGNAkT3Rld
        70loJVXjyVJZcs4nArtLBbbPU13xN/G50tRgh1QXxQ==
X-Google-Smtp-Source: APXvYqwzqi8wwPq6VMgDOQE/TVk0fb0Ok2ea8oI2w/F5LplYYrb3WBTTlzDix9IZ3i1H8W8lvHxLBzOnK5c38xlb1Co=
X-Received: by 2002:a2e:8347:: with SMTP id l7mr7290906ljh.17.1558113515365;
 Fri, 17 May 2019 10:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com> <57169361f2adf39569e061d3dd1e5588d22c65a3.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <57169361f2adf39569e061d3dd1e5588d22c65a3.1556025155.git.vpillai@digitalocean.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 18 May 2019 01:18:24 +0800
Message-ID: <CAERHkruv6807HyPg=UvjLiO-2uzDJgw1=44HyWQ73mnYVB37TQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/17] sched: Debug bits...
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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

On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0e3c51a1b54a..e8e5f26db052 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -106,6 +106,10 @@ static inline bool __prio_less(struct task_struct *a, struct task_struct *b, boo
>
>         int pa = __task_prio(a), pb = __task_prio(b);
>
> +       trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
> +                    a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
> +                    b->comm, b->pid, pa, b->se.vruntime, b->dl.deadline);
> +

a minor nitpick

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e3162f..68c518c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -93,7 +93,7 @@ static inline bool __prio_less(struct task_struct
*a, struct task_struct *b, u64

        trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
                        a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
-                       b->comm, b->pid, pa, b->se.vruntime, b->dl.deadline);
+                       b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);


        if (-pa < -pb)
                return true;
