Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76469C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2D720B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vH8xcYc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfFREVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:21:33 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37829 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFREVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:21:33 -0400
Received: by mail-yb1-f196.google.com with SMTP id 189so219468ybh.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEtE1A+FVeBvQxYd033P9YUeuxrZ3GsjmhLPdyrBUok=;
        b=vH8xcYc+TFxAr+CXKS81Vrul2KssbSwKqLNG4diKj8FJlkSAa/EV2jaJv0QAyBTBxY
         nPtg2iBRJiGkXVvK/+RVRTcjv/tNo9SiLpDQBdM1aqNN8+sr/hbfeQnrjN5HR4C9Wqe9
         2+nM2Y3SYAdu3/+zqgc4vBLaYUJW8IRHb3MV/45vVvEDTj+hliI5lUmZ7SOrEcdnpR3Z
         tI1BJeQ5hIALLU9Ggkgky49E2+8cQuxNbIoqs7ktczzPz1Z9I5b1xFKhEg4dIB/xDJPT
         LDTpuzFl5x7rc3Tvaeu3+sH7cu+58zb4+gaysdbhzXfgGpC2rdcRIlPo+hS0bMtbL0in
         2khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEtE1A+FVeBvQxYd033P9YUeuxrZ3GsjmhLPdyrBUok=;
        b=b8GVoQFPIRLhhwB7nJzMhOdI7mWthwpyfrOrvfc+XCFTZiuRn9a3fX54Q8dU/43xKu
         P526G0bymzX6bpBo4gOFkDXGKxzNqBQvYBCtzE2ybSNpGwIjrdqrFP6HmlWrdFqk+kUH
         tYdF9JBF2xwFoa8v26FBuYCOBSrnN10D3bEGJp5nrT9y5S8rfU1xkBelsg6cbUy+3E8y
         8il07FYuApmSUz27S0gduWo0xo9PrNZoh3qwSdbJhYpCYot9wIqlO5lLdz51zAeZBD72
         UWvIeRamuUpbIuxs+iIeRO/qy4pScSZ5RvAiYVS/9QT+9OJFh2nt6Z+jn4PmUg5rawrA
         ysCQ==
X-Gm-Message-State: APjAAAVCWiZObXSBXocoTRXrjpKct4S0HKNCMpmFJFhgnveW8XSQjv8s
        VoR8m8S5WYfFYkSbX9kDS21Cj+13TwONdyw3OD4HYg==
X-Google-Smtp-Source: APXvYqz2nxnNCsP6qANdViBc7IWFcaTmarfi4vuwMpaN6A94f2qkbKEUgRoo5uR3ibDCAImQ71Kc6IBCjTbDmmb7NJ0=
X-Received: by 2002:a5b:942:: with SMTP id x2mr54859299ybq.147.1560831692033;
 Mon, 17 Jun 2019 21:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004143a5058b526503@google.com> <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
 <20190615134955.GA28441@dhcp22.suse.cz> <CALvZod4hT39PfGt9Ohj+g77om5=G0coHK=+G1=GKcm-PowkXsw@mail.gmail.com>
 <5bb1fe5d-f0e1-678b-4f64-82c8d5d81f61@i-love.sakura.ne.jp>
 <CALvZod4etSv9Hv4UD=E6D7U4vyjCqhxQgq61AoTUCd+VubofFg@mail.gmail.com>
 <791594c6-45a3-d78a-70b5-901aa580ed9f@i-love.sakura.ne.jp>
 <840fa9f1-07e2-e206-2fc0-725392f96baf@i-love.sakura.ne.jp>
 <c763afc8-f0ae-756a-56a7-395f625b95fc@i-love.sakura.ne.jp>
 <CALvZod5VPLVEwRzy83+wT=aA8vsrUkvoJJZvmQxyv4YbXvrQWw@mail.gmail.com> <20190617184547.5b81f7df81af46e86441ba8c@linux-foundation.org>
In-Reply-To: <20190617184547.5b81f7df81af46e86441ba8c@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 17 Jun 2019 21:21:20 -0700
Message-ID: <CALvZod5L9VEAiGSk2JYY-e7RGLRn+tFcn-cePtw-epLGsxf2wg@mail.gmail.com>
Subject: Re: general protection fault in oom_unkillable_task
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuzhoujian@didichuxing.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:45 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 17 Jun 2019 06:23:07 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > > Here is a patch to use CSS_TASK_ITER_PROCS.
> > >
> > > From 415e52cf55bc4ad931e4f005421b827f0b02693d Mon Sep 17 00:00:00 2001
> > > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Date: Mon, 17 Jun 2019 00:09:38 +0900
> > > Subject: [PATCH] mm: memcontrol: Use CSS_TASK_ITER_PROCS at mem_cgroup_scan_tasks().
> > >
> > > Since commit c03cd7738a83b137 ("cgroup: Include dying leaders with live
> > > threads in PROCS iterations") corrected how CSS_TASK_ITER_PROCS works,
> > > mem_cgroup_scan_tasks() can use CSS_TASK_ITER_PROCS in order to check
> > > only one thread from each thread group.
> > >
> > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> >
> > Why not add the reproducer in the commit message?
>
> That would be nice.
>
> More nice would be, as always, a descriptoin of the user-visible impact
> of the patch.
>

This is just a cleanup and optimization where instead of traversing
all the threads in a memcg, we only traverse only one thread for each
thread group in a memcg. There is no user visible impact.

> As I understand it, it's just a bit of a cleanup against current
> mainline but without this patch in place, Shakeel's "mm, oom: refactor
> dump_tasks for memcg OOMs" will cause kernel crashes.  Correct?

No, the patch "mm, oom: refactor dump_tasks for memcg OOMs" is making
dump_stacks not depend on the memcg check within
oom_unkillable_task().

"mm, oom: fix oom_unkillable_task for memcg OOMs" is the actual fix
which is making oom_unkillable_task() correctly handle the memcg OOMs
code paths.

Shakeel
