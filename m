Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C23C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A426B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSO+abSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfGQFdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 01:33:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41163 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQFdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:33:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id v22so16514140qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 22:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiyaRaIWUGIsAa8lRiNjECqd/N4fEUvhVcUuMO28K0E=;
        b=YSO+abSwu2ezoMPct2o4RKHrP0PgNwSzcQjt+oqwXwecnjrX2JDJCvQ4OdZRGLzW5O
         gd2Ejwy8TvaUkHtOs/6jB9/k+58LfKZBfdnJBZtjMr18hMa2IRAPjRbrA4CChKGpFO0v
         EGAoEgXp2gP1LEn4MUOw8cBKLhm9IfbLUjwDrYRmyCvNZyFtST/tp98Dkk9damXz+7p1
         aolOISQV9Dyy6zCG4c64v9wyVg/95aoKm5wprKkpNLCICgrqrLNWh4sr7nh9+NoPmvyV
         Cpajs++nZVNKhbCuessupquwH0Bap83aQLXeb5k71ayIEpNv0ySOlg6OGfDCRyQK1aVK
         PO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiyaRaIWUGIsAa8lRiNjECqd/N4fEUvhVcUuMO28K0E=;
        b=uFt8IRttkLEZdCB+0a8zaTSzuuEFgyrKeUo1f1wLofI3J4HUk7pvjr+qh1vKZAjUXp
         EQi1Qait2QSLz7LlDOPi4SDN8dBiPEvpK4++NgbRAJ2lF+ctemjH9A6ydU8IWfM6lZbg
         nYGkZqYX7pMVol0AwgoDg4PEcpjG7PceVOi7tspza9sDdyHsoTX5vIVTJ1dRuXq3hkKy
         WhDctS0jBU87BYfKIyWR8MQ7+SD2VebQmvqz3i0KL2A8JBMwfTMmqA+UmiyErEIaZtle
         ggdzz+LyTYtG6It9LILRexB0djPgGdTc9m6+8XcvfxGPpE1Gh2Z3z4WBfME5M12/nqiS
         +Duw==
X-Gm-Message-State: APjAAAVspJaCkcXrhooROt1neX2xODYz8w9vRGRAGHDBVYff2N55lO2B
        7j1V60j0euDEqdL4Qp+5ErVtnwbtZqeQItrbLNc=
X-Google-Smtp-Source: APXvYqxY4DOlSafrfiMUVleZkw4BEDIF4C77opVS8EK78gd8hM6AQVGuL1CehtsfF9MZhulF5xML/sc9iJdLWWw/3Q8=
X-Received: by 2002:a05:620a:1181:: with SMTP id b1mr25847555qkk.390.1563341590181;
 Tue, 16 Jul 2019 22:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190715092809.736834-1-arnd@arndb.de>
In-Reply-To: <20190715092809.736834-1-arnd@arndb.de>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Wed, 17 Jul 2019 13:32:58 +0800
Message-ID: <CAHttsrb+vg-E2HpQDTKnf7Xkg03-wd2YEOAWaVCDzdeOASPcPQ@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: hide unused 'class' variable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops..... Thanks.

On Mon, 15 Jul 2019 at 17:28, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The usage is now hidden in an #ifdef, so we need to move
> the variable itself in there as well to avoid this warning:
>
> kernel/locking/lockdep_proc.c:203:21: error: unused variable 'class' [-Werror,-Wunused-variable]
>
> Fixes: 68d41d8c94a3 ("locking/lockdep: Fix lock used or unused stats error")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/locking/lockdep_proc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> index 65b6a1600c8f..bda006f8a88b 100644
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -200,7 +200,6 @@ static void lockdep_stats_debug_show(struct seq_file *m)
>
>  static int lockdep_stats_show(struct seq_file *m, void *v)
>  {
> -       struct lock_class *class;
>         unsigned long nr_unused = 0, nr_uncategorized = 0,
>                       nr_irq_safe = 0, nr_irq_unsafe = 0,
>                       nr_softirq_safe = 0, nr_softirq_unsafe = 0,
> @@ -211,6 +210,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
>                       sum_forward_deps = 0;
>
>  #ifdef CONFIG_PROVE_LOCKING
> +       struct lock_class *class;
> +
>         list_for_each_entry(class, &all_lock_classes, lock_entry) {
>
>                 if (class->usage_mask == 0)
> --
> 2.20.0
>
