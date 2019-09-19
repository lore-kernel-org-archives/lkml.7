Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C87C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A3D214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwXO/26j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfISCtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 22:49:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43298 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfISCtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:49:16 -0400
Received: by mail-io1-f68.google.com with SMTP id v2so4084963iob.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 19:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlzhPoLh7b1S6T7cDcD4eBPph7wATcAJsn+h7CRgZVQ=;
        b=NwXO/26j5PnHmjd2RLNhyU1zrVLojB3fLLqcM4aIvtIwA6mfoG6elPrXZXxg5WsxXq
         6r2fUdi05qwcnMDzcqkL4GIXvX4HOrziRDJFEj3DnBxHnWomZNooeBuH0AbeS0hB4sjd
         o2ShVAW0r91FILzP7Fy+0BkeNrGQLH1UbPmwpwEwe1fwhral2bXYorOSUGnItNCIzSri
         T5MtirtU8pMvNqHiT4+H4zZuJ/rxghego9KBMytTi1p3Nt9FCHLceQbCihz9THqoUv1i
         R3MzFl5G1Aa6dRlfa93YjCT/5klhbDGzCGnuT56bB2axVntkclx7oUlUmX1OznfiPgWY
         jkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlzhPoLh7b1S6T7cDcD4eBPph7wATcAJsn+h7CRgZVQ=;
        b=JLdmzbcLt6lhMHPEWRswwxGF3XBU8sdubpEMsPnnS5k69EbnIvYFJwH4Hy7/9xtDQH
         bk94ViahJphnSfXAxkuXLYRrIPD0l/Kyn7xWSOQG7XlsD+GBHZ0zXE4JtIFAP/Zfx7KZ
         LwUnAqdqV7iHTSCTFG4OZeIyA/qvkD4WMoFgzOlU5o9Cjr44XW+JNE6Uvx4NPGDPjEIs
         D0lQXLbk7xYXxz7dght9vkjfiIvqZJKUjwN6CwQ/IZa07vD35NfeUtoq2Skv2eAKChfd
         hoURa8GJ97w5PSU5v0K7E+847Y4VF7nLaF8wtOSbiGewNoreUTfGx00/PbKmilWUsPRR
         KBUA==
X-Gm-Message-State: APjAAAWJj3T91ECtM0FjvimJaYxJW4LvMTahOXbqDZhpsFceYE9BoTmj
        GAitEYuG1VW594SZKHrvq8/lQihjyVmgmgx0Ytw=
X-Google-Smtp-Source: APXvYqyWTUvYaon8dzjGZxZo1Qxty4TvkqAcY67SytyH5Iz5WyX5HBzxj4/mwpGflTSdLB39JCubNu9BonaLNUR+CAs=
X-Received: by 2002:a02:cabb:: with SMTP id e27mr8943286jap.107.1568861355823;
 Wed, 18 Sep 2019 19:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190919014340.GM3084169@devbig004.ftw2.facebook.com>
In-Reply-To: <20190919014340.GM3084169@devbig004.ftw2.facebook.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 19 Sep 2019 10:49:04 +0800
Message-ID: <CAJhGHyBd53ogp35FkmwDhzCv7=MipXwyoHGPVXjsaxSH540O8A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix spurious sanity check failures in destroy_workqueue()
To:     Tejun Heo <tj@kernel.org>
Cc:     ~@devbig004.ftw2.facebook.com, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Marcin Pawlowski <mpawlowski@fb.com>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

There is one test in show_pwq()
"""
 worker == pwq->wq->rescuer ? "(RESCUER)" : "",
"""
I'm wondering if it needs to be updated to
"""
worker->rescue_wq ? "(RESCUER)" : "",
"""

And document "/* MD: rescue worker */" might be better
than current "/* I: rescue worker */", although ->rescuer can
be accessed without wq_mayday_lock lock in some code.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>



On Thu, Sep 19, 2019 at 9:43 AM Tejun Heo <tj@kernel.org> wrote:
>
> Before actually destrying a workqueue, destroy_workqueue() checks
> whether it's actually idle.  If it isn't, it prints out a bunch of
> warning messages and leaves the workqueue dangling.  It unfortunately
> has a couple issues.
>
> * Mayday list queueing increments pwq's refcnts which gets detected as
>   busy and fails the sanity checks.  However, because mayday list
>   queueing is asynchronous, this condition can happen without any
>   actual work items left in the workqueue.
>
> * Sanity check failure leaves the sysfs interface behind too which can
>   lead to init failure of newer instances of the workqueue.
>
> This patch fixes the above two by
>
> * If a workqueue has a rescuer, disable and kill the rescuer before
>   sanity checks.  Disabling and killing is guaranteed to flush the
>   existing mayday list.
>
> * Remove sysfs interface before sanity checks.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Marcin Pawlowski <mpawlowski@fb.com>
> Reported-by: "Williams, Gerald S" <gerald.s.williams@intel.com>
> Cc: stable@vger.kernel.org
> ---
> Applying to wq/for-5.4.
>
> Thanks.
>
>  kernel/workqueue.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 95aea04ff722..73e3ea9e31d3 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4318,9 +4318,28 @@ void destroy_workqueue(struct workqueue_struct *wq)
>         struct pool_workqueue *pwq;
>         int node;
>
> +       /*
> +        * Remove it from sysfs first so that sanity check failure doesn't
> +        * lead to sysfs name conflicts.
> +        */
> +       workqueue_sysfs_unregister(wq);
> +
>         /* drain it before proceeding with destruction */
>         drain_workqueue(wq);
>
> +       /* kill rescuer, if sanity checks fail, leave it w/o rescuer */
> +       if (wq->rescuer) {
> +               struct worker *rescuer = wq->rescuer;
> +
> +               /* this prevents new queueing */
> +               spin_lock_irq(&wq_mayday_lock);
> +               wq->rescuer = NULL;
> +               spin_unlock_irq(&wq_mayday_lock);
> +
> +               /* rescuer will empty maydays list before exiting */
> +               kthread_stop(rescuer->task);
> +       }
> +
>         /* sanity checks */
>         mutex_lock(&wq->mutex);
>         for_each_pwq(pwq, wq) {
> @@ -4352,11 +4371,6 @@ void destroy_workqueue(struct workqueue_struct *wq)
>         list_del_rcu(&wq->list);
>         mutex_unlock(&wq_pool_mutex);
>
> -       workqueue_sysfs_unregister(wq);
> -
> -       if (wq->rescuer)
> -               kthread_stop(wq->rescuer->task);
> -
>         if (!(wq->flags & WQ_UNBOUND)) {
>                 wq_unregister_lockdep(wq);
>                 /*
> --
> 2.17.1
>
