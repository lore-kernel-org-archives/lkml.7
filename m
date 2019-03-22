Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09976218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="TEace9K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfCVU7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:59:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41454 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:59:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id o129so2057122qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uu3LkqEayfNWxAGHXa5LQ/QG4OaFYLEZAK6IQMPmgWU=;
        b=TEace9K+CerAvL1vD5KYTJp5Yl4WDtY4l6Fq8IHyIggjbv89eNcwnc6JZJ8PG30Ijt
         hM1mnKma9UPMlef2KhvA62mtqEwU+R6TXeTwdMrwaVD/Z42htn1EYfsx9ZkJG4xzRGA0
         S5r5B7WY1yQxgW4GGElHlwSmefz9KCBqRahoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uu3LkqEayfNWxAGHXa5LQ/QG4OaFYLEZAK6IQMPmgWU=;
        b=ayWN10jOvnXiTlIW7lyAgZce+GCgv7C+IMLbwl65+Th9VRVZEJlTfrIsskluOtBq34
         qYuYM5s/soDy9qKIfKBEOXjSjzBWcalaBFwHFpIr87i64Rna5uv5djMbEqINwJq4wVI3
         3G3OHWMO7I8chlRMjXGTeHUofpOZRNSsjKJmLu3+ChRudOQA8p8ZCJZk/UHp40yZVJBD
         f1zc9OBgyryPD6Xb78XsTDiHzH1NOmPjBcBy7J/5U4gRCnc4KIrricSg7PIq7vkUm+Lt
         f6T8icIRFr/3/YXrBu3pcM3SJOkoO7b2/IXCq3niag7txfkOsGTWn+vejTph9fFnpqiR
         Ln8w==
X-Gm-Message-State: APjAAAUUn7OUM7FRRTduWMWLGgiSpcrAlwLXTDvhk1aI68A8Ejcce7pt
        Y8sKXiG7p9pR7HfsfLElI5nLxw==
X-Google-Smtp-Source: APXvYqwppYI+M8yh3NfxIdPmUuXn9Et0tfqDRiaHsBImZTqsYD6tg+WzWZmWnQhC/cwNt01iYgX3Yw==
X-Received: by 2002:a37:4804:: with SMTP id v4mr9335461qka.104.1553288390777;
        Fri, 22 Mar 2019 13:59:50 -0700 (PDT)
Received: from [192.168.1.240] ([142.169.78.14])
        by smtp.gmail.com with ESMTPSA id k12sm6285132qti.38.2019.03.22.13.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Mar 2019 13:59:49 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        subhra.mazumdar@oracle.com, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Date:   Fri, 22 Mar 2019 16:59:30 -0400
Message-Id: <1553288370-4167-1-git-send-email-jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190322133448.GT6058@hirez.programming.kicks-ass.net>
References: <20190322133448.GT6058@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 9:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Mar 21, 2019 at 05:20:17PM -0400, Julien Desfossez wrote:
> > On further investigation, we could see that the contention is mostly in
> the
> > way rq locks are taken. With this patchset, we lock the whole core if
> > cpu.tag is set for at least one cgroup. Due to this, __schedule() is
> more or
> > less serialized for the core and that attributes to the performance loss
> > that we are seeing. We also saw that newidle_balance() takes considerably
> > long time in load_balance() due to the rq spinlock contention. Do you
> think
> > it would help if the core-wide locking was only performed when absolutely
> > needed ?
>
> Something like that could be done, but then you end up with 2 locks,
> something which I was hoping to avoid.
>
> Basically you keep rq->lock as it exists today, but add something like
> rq->core->core_lock, you then have to take that second lock (nested
> under rq->lock) for every scheduling action involving a tagged task.
>
> It makes things complicatd though; because now my head hurts thikning
> about pick_next_task().
>
> (this can obviously do away with the whole rq->lock wrappery)
>
> Also, completely untested..

We tried it and it dies within 30ms of enabling the tag on 2 VMs :-)
Now after trying to debug this my head hurts as well !

We'll continue trying to figure this out, but if you want to take a look,
the full dmesg is here: https://paste.debian.net/plainh/0b8f87f3

Thanks,

Julien
