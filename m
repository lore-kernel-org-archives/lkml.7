Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3B9206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzWzi45G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfDZG5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:57:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39800 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfDZG5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:57:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id h16so2987261qtk.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyqYEKvDUNhL9MMnFlKvINv444Yhz0Ms3qn2L+mBiN8=;
        b=tzWzi45G75cdiVNcT0Ii0HjMC5NjBKU6lUEQDSJSU8qs3hvbWcyNkHa12/PmMFWtm6
         BN+Gg0JTbAnWQkJDOfjhD/q9XP16jYv0VVE5UsJ+en6PkichE83m+PmwK0KQAEXdzuUV
         pC/sxdb7Rsgm5EYEV18PUtaes3BnOZHhBiF/wz/Ky9Z3wvPYhDGUslP7x+soFceVwtDm
         VZkCWVd7p4mIXxx1eAGEEw6Ji6mQsWXYw4wYSRjD5nasO9Md1USXQLjyrNpbK//FxYjp
         Ms6zZ93q2QWoWqJe5O5gCXna11+tHrD9daGsWAPeLlIVM4NhWueva7Q3ZO9iE0R/dXNY
         JR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyqYEKvDUNhL9MMnFlKvINv444Yhz0Ms3qn2L+mBiN8=;
        b=i5DicNnmLedHqpuRAwzQRWmyxkS754vbrkUCW1MCNiDAuGwCFFXA5uQI1xyu2AIwKu
         pmAaS5ava5/+Dugvoz27mSrJMG9fhg0GjTHlgM4sqv+1r7Bc3jfr4hh6E9MKs45zIuwD
         xIwYJwAyUmX4qtkm9AwN7teUg6js0xeYKP82+V4mZX7021w8b7lJiW8iOqr2KC9ahJNu
         2NU2optpxD9CueAqD+ugpZ398GiQcNdPl+eJ3h9y3qqsAbGeNZ4C5IIz29BEqkDEls1E
         czMo13Qsq4RIVKLL9Q+wnWxe8LseEaQZGbSUM0x9U3VGpVBzHADVH+Y1qk8IBRwgnXoQ
         J7Qw==
X-Gm-Message-State: APjAAAXX8e2w6jJjmRnJRh09oULnVZSpIIsAEsSbOvyWL3BcDwaLwiR/
        RFbtMtGHvXj2Yyr9mvRuQ2R0PywdJLwlBDqTev0=
X-Google-Smtp-Source: APXvYqz2fQ9zN9crfykgYDKQMqDjvyyTPJo4H+c+EAzQTRlNt0cjB6LjyirY6+9jcjDLSADK9Ul8stvy4XB3uHL4rms=
X-Received: by 2002:ac8:27a6:: with SMTP id w35mr35010736qtw.157.1556261868816;
 Thu, 25 Apr 2019 23:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-20-duyuyang@gmail.com>
 <20190425193247.GU12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425193247.GU12232@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 26 Apr 2019 14:57:37 +0800
Message-ID: <CAHttsrY4jK2cayBE8zNCSJKDAkzLiBb40GVfQHpJi2YK1nEZaQ@mail.gmail.com>
Subject: Re: [PATCH 19/28] locking/lockdep: Optimize irq usage check when
 marking lock usage bit
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Fri, 26 Apr 2019 at 03:32, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 06:19:25PM +0800, Yuyang Du wrote:
>
> After only a quick read of these next patches; this is the one that
> worries me most.
>
> You did mention Frederic's patches, but I'm not entirely sure you're
> aware why he's doing them. He's preparing to split the softirq state
> into one state per softirq vector.
>
> See here:
>
>   https://lkml.kernel.org/r/20190228171242.32144-14-frederic@kernel.org
>   https://lkml.kernel.org/r/20190228171242.32144-15-frederic@kernel.org
>
> IOW he's going to massively explode this storage.

If I understand correctly, he is not going to.

First of all, we can divide the whole usage thing into tracking and checking.

Frederic's fine-grained soft vector state is applied to usage
tracking, i.e., which specific vectors a lock is used or enabled.

But for usage checking, which vectors are does not really matter. So,
the current size of the arrays and bitmaps are good enough. Right?
