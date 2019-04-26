Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308A8C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03824206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2/Cj2E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfDZHGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:06:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40072 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZHGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:06:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id y49so165614qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6HcQ1+0pWmKCOtOZFrgkZfRLyjP4/xTC1PdjicHU30=;
        b=W2/Cj2E4FG6X1qKpZC6N2S+XAES13IBz9g+XnSDZYMjSw49jj/+v0BQw6tfX3qMsCW
         s9gtLCxWwzWUHQ0mJYEqwREy+u3BxzLbfcfysnD5fcCKvcW2ZQjz6hrNWmUlSG4r+owZ
         hQQJe0pcANzkDnuduZtUsbmnsq0XIIjfTplgKrv9eBG9xVrx6vBb8bn8HJgTd7jGe3wO
         W0hh2srfXo9WMgxPRHKIO8JSENm6xAu4WBpnSiXm+ApgZ2zF7Wu9bVGiBDTMkKilTEg+
         Ro5tEyyXAxmgtwHO5UgKBiifSjMlpdRBMtI/WYuac9HS6W4H0XxxRWp2DfL2WdQmLXO7
         a94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6HcQ1+0pWmKCOtOZFrgkZfRLyjP4/xTC1PdjicHU30=;
        b=cLrhA08bVUlAZsNpfz9WWEUMH+ypOtiyY9rT3VJxfYe6jExba9aB1/CRbIFoULTtq0
         0lQlgp2NQm+aiLffrPmTQ+W4au/uwumWgtX3OHGMGBDAFTAGgWS8CkVVeW9lBvr5/nP9
         dNcdqpr7HhF9I8vCbuThebhPAwMv32X1eu8rITljmhUFEwa77rjYPpAgtVpbP6ZXs6M/
         WY350akZGP3GvlEeo0CJmjlXbvxXkSVAwQMYxp7WMvhLzb32hatb/T9R8hjHGo/Zd0bN
         qaMwZmnixr9Xm2j/oFCbXwFoROVakHZcApAx2J25PWlwF+ayZ52TlBz44LP50yr0t4RX
         e/gQ==
X-Gm-Message-State: APjAAAXVQaWYfb5HQd5JMvy3gLZ2oSXtAAi3rt0CgDaySyZos+ot2VVH
        kf53PC2JaUZIPyyyKdYf4Y+9+YWXia0QnQkfcKg=
X-Google-Smtp-Source: APXvYqwwDONV66Ai74otPmyy5eAUlEZpG6e3qLemD6Ii2M0Gwn+2drW3vP5jeL1p2lhwhn2czk3RAqbC/T2bHo5vkF4=
X-Received: by 2002:ac8:2843:: with SMTP id 3mr34486583qtr.327.1556262408677;
 Fri, 26 Apr 2019 00:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-25-duyuyang@gmail.com>
 <20190425200336.GY12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425200336.GY12232@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 26 Apr 2019 15:06:34 +0800
Message-ID: <CAHttsrbf30jTT3XidoeWV7j2xovCvJuM3=qy4u1z_GC3dXYp8A@mail.gmail.com>
Subject: Re: [PATCH 24/28] locking/lockdep: Remove !dir in lock irq usage check
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Fri, 26 Apr 2019 at 04:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 06:19:30PM +0800, Yuyang Du wrote:
> > In mark_lock_irq(), the following checks are performed:
> >
> >    ----------------------------------
> >   |   ->      | unsafe | read unsafe |
> >   |----------------------------------|
> >   | safe      |  F  B  |    F* B*    |
> >   |----------------------------------|
> >   | read safe |  F? B* |      -      |
> >    ----------------------------------
> >
> > Where:
> > F: check_usage_forwards
> > B: check_usage_backwards
> > *: check enabled by STRICT_READ_CHECKS
> > ?: check enabled by the !dir condition
> >
> > From checking point of view, the special F? case does not make sense,
> > whereas it perhaps is made for peroformance concern. As later patch will
> > address this issue, remove this exception, which makes the checks
> > consistent later.
> >
> > With STRICT_READ_CHECKS = 1 which is default, there is no functional
> > change.
>
> Oh man.. thinking required and it is way late.. anyway this whole read
> stuff made me remember we had a patch set on readlocks last year.
>
>   https://lkml.kernel.org/r/20180411135110.9217-1-boqun.feng@gmail.com
>
> I remember reviewing that a few times and then it dropped on the floor,
> probably because Spectre crap or something sucked up all my time again :/
>
> Sorry Boqun!

Oh man, I thought about the read-write lock stuff, but I didn't know
Boqun's patch. Let me hurt my brain looking at that patch.
