Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32788C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F69222CA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8fT+JAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfJENdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 09:33:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39406 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfJENdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 09:33:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so8113757oia.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mzNJk65YJInw4AobfNpYunyV6hHpMhwPzujpSu7gD4=;
        b=u8fT+JAQGEqBqwtsu8ER1jIRVLdbwbsOAx/790cFjwLj1YW46iGfwRPCYA3WRmuzr7
         Zueivcmt+sXuWrkSDGtriDrJ8U6/KsxAoCPdZE44cCLCpWtIdZVIfpqlZsZHgTukq1eq
         T787iXza6xTVS8UWRMs5NLiSRd6D5n6mYLtUuVFiDHMCfUk0sWK9Bv+G2JdnwDFVyF15
         cYg4/kAzYZvxp4d120FLMniipnN/+HDtti5iz9fYBASDQeA9rGysOvwM8F7YZwBa24/v
         gaHkqAoOTOnAFHMXxkbzMkDx7fyFtGPEm7DgdvMhjsW8GB0GEp5PtKaRcGWUKRy1nVR7
         Qo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mzNJk65YJInw4AobfNpYunyV6hHpMhwPzujpSu7gD4=;
        b=kYJ8hjV1G5wacqwIsNOA9YriXF97cOWQql/T9uIt/pjTemSY1LUxnGskBWyI1Pma/N
         xmM2zEZsB3BN+IqwBDwhaQNI3m2uVLAQTLxOZRiMQe9Sa+V0L/GC8hLQPDOw6Twj8rNA
         7a2tYDfhJ0r7LDu+/ROgTb8/WKl1waP/IcVAuqk6F60OjT/TOrOQq95XelPH4cR4vSFW
         4jMo6v0Yf0OXd66tgKFPkrzJkND6l6ami9dpE9aRTKrYVw4tnW923ESSk+Tqa5eq6li3
         erBxX5RtVqheGmgVg2FqdAHg3vavqSE9mle8atm+kbPjcrziG2l8bd893l2wjEyE8S5f
         34ug==
X-Gm-Message-State: APjAAAVGpHMtyv234r9rXbCL1nhJpWFgaZAVPcxnn66DC8HQa6XaAt4x
        ISzjExvkFjXsijxRy2o4X/ffAz+H0fZGtyDWWssclQ==
X-Google-Smtp-Source: APXvYqxV6+amrcfHckZLOYKFI8l73ohqnnfu3oFVFigaVWyyycA9cdXMw0KRc3cslSbJITe/raZ9lIXTjdxcFnyJU9s=
X-Received: by 2002:a05:6808:13:: with SMTP id u19mr11235937oic.83.1570282398616;
 Sat, 05 Oct 2019 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009b403005942237bf@google.com> <20191005112806.13960-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191005112806.13960-1-christian.brauner@ubuntu.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 5 Oct 2019 15:33:07 +0200
Message-ID: <CANpmjNMqTupyPc6-PCviB1HPTHawjzNL1r1gmdQqnwCvE=BNNA@mail.gmail.com>
Subject: Re: [PATCH] taskstats: fix data-race
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        bsingharora@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2019 at 13:28, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> When assiging and testing taskstats in taskstats
> taskstats_exit() there's a race around writing and reading sig->stats.
>
> cpu0:
> task calls exit()
> do_exit()
>         -> taskstats_exit()
>                 -> taskstats_tgid_alloc()
> The task takes sighand lock and assigns new stats to sig->stats.
>
> cpu1:
> task catches signal
> do_exit()
>         -> taskstats_tgid_alloc()
>                 -> taskstats_exit()
> The tasks reads sig->stats __without__ holding sighand lock seeing
> garbage.

Is the task seeing garbage reading the data pointed to by stats, or is
this just the pointer that would be garbage?

My only observation here is that the previous version was trying to do
double-checked locking, to avoid taking the lock if sig->stats was
already set. The obvious problem with the previous version is plain
read/write and missing memory ordering: the write inside the critical
section should be smp_store_release and there should only be one
smp_load_acquire at the start.

Maybe I missed something somewhere, but maybe my suggestion below
would be an equivalent fix without always having to take the lock to
assign the pointer? If performance is not critical here, then it's
probably not worth it.

Thanks,
-- Marco

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 13a0f2e6ebc2..f58dd285a44b 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -554,25 +554,31 @@ static int taskstats_user_cmd(struct sk_buff
*skb, struct genl_info *info)
 static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
 {
  struct signal_struct *sig = tsk->signal;
- struct taskstats *stats;
+ struct taskstats *stats_new, *stats;

- if (sig->stats || thread_group_empty(tsk))
+ /* acquire load to make pointed-to data visible */
+ stats = smp_load_acquire(&sig->stats);
+ if (stats || thread_group_empty(tsk))
  goto ret;

  /* No problem if kmem_cache_zalloc() fails */
- stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
+ stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);

  spin_lock_irq(&tsk->sighand->siglock);
- if (!sig->stats) {
- sig->stats = stats;
- stats = NULL;
+ stats = sig->stats;
+ if (!stats) {
+ stats = stats_new;
+ /* release store to order zalloc before */
+ smp_store_release(&sig->stats, stats_new);
+ stats_new = NULL;
  }
  spin_unlock_irq(&tsk->sighand->siglock);

- if (stats)
- kmem_cache_free(taskstats_cache, stats);
+ if (stats_new)
+ kmem_cache_free(taskstats_cache, stats_new);
+
 ret:
- return sig->stats;
+ return stats;
 }

 /* Send pid data out on exit */
