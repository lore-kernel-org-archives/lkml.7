Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33ECC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 06:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD7A20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 06:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7cQPDwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfDMGiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 02:38:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38225 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfDMGit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 02:38:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so13827367qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOzPa/neEIEvpY2nHAFZN2hmkw4d4+4re5hwN4eTKnY=;
        b=d7cQPDwI5wIQySxWLQZdUDgBrRVnEW5V/TAkyWiJY/qWo7w7WXyVDINClqtqYuRFOc
         OGMDwc8gZap3dtPEyv1ceXxeiCEVd47D3mRoRR/WA7t8hLbAiuoaqUWH/ubV9u0vIS0d
         JKy2N1SRQfgdqFimHXZiDpdkJfQZNFVg7t0Y3xP2zUVegfqEXLHkoRFXTG2QjLq5yhOp
         LIoKqfgP8ejG7ZkoPfSc9DubAQupAgS3ORbUt2rQ2xCgNBEvQCi/78x5AyWxQBJzm6hQ
         vcBiIQ5TrizIEpWfo1AMJWMvI0wJE8Z1kHXJgRKJi28v+VH2woC52HO8OhvK7rBEInws
         pvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOzPa/neEIEvpY2nHAFZN2hmkw4d4+4re5hwN4eTKnY=;
        b=V1XY/zetDlU2cn43rSre1wMbwi7168TipThlYkXsbiPT5+C+0JdOPb1oSZydVftiZ0
         sfYGwCMhq7zbUZmvpDDhl4EjZdWWuQ2rHYNceUEx0hYhWQmOs7G+YZsffIEBjVvij0XF
         LvMczE5wvjef7aIlYRP3fL1L5xYgHAdVHKnWUHVb50dAEhtt6kNyHuZV5FTaR3yn6V+x
         ygpZreMjUA6KFwfZXaE6jN5Cat76DNNoycSMaboksJ3pfaW7wJRafcoAfzr7KBY0arUU
         tgZfvf/8w7g0jeqcaSEB3+qOwnThQZ8HaTNTqFx7IQXJ41gV5H8tVw2ZDg99bTRkVbxr
         QHUQ==
X-Gm-Message-State: APjAAAWOqodznM7gVOG9Pzx/+VjGQq//+sIWTY7ZhJVkNpTWYY+kJgBx
        Ril1GWDYCw5ZYIOzDRICcEhIsdTlshFGIAxQelRgSzUK
X-Google-Smtp-Source: APXvYqxfhvZ7yZLeL33fpsr13UjDGNyuoRxlmJO08B5rqw4HfT9ZEo5EfOu8NQc0jOCvd388dSLufol/2mhK/J6oj3A=
X-Received: by 2002:ac8:2b65:: with SMTP id 34mr50392133qtv.93.1555137529089;
 Fri, 12 Apr 2019 23:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190402160244.32434-1-frederic@kernel.org> <20190402160244.32434-5-frederic@kernel.org>
In-Reply-To: <20190402160244.32434-5-frederic@kernel.org>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Sat, 13 Apr 2019 14:38:38 +0800
Message-ID: <CAHttsrYcHfcDBXXtCjXDSTgFbbOv=B2UKkEMq9GwvXB5WpMSdA@mail.gmail.com>
Subject: Re: [PATCH 4/4] locking/lockdep: Test all incompatible scenario at
 once in check_irq_usage()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 at 00:05, Frederic Weisbecker <frederic@kernel.org> wrote:
>
> check_prev_add_irq() tests all incompatible scenarios one after the
> other while adding a lock (@next) to a tree dependency (@prev):
>
>         LOCK_USED_IN_HARDIRQ          vs         LOCK_ENABLED_HARDIRQ
>         LOCK_USED_IN_HARDIRQ_READ     vs         LOCK_ENABLED_HARDIRQ
>         LOCK_USED_IN_SOFTIRQ          vs         LOCK_ENABLED_SOFTIRQ
>         LOCK_USED_IN_SOFTIRQ_READ     vs         LOCK_ENABLED_SOFTIRQ

May I ask why

LOCK_USED_IN_*IRQ vs. LOCK_ENABLED_*IRQ_READ

is not tested?

Thanks,
Yuyang
