Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCCDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0A92084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMwIdMqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDZGpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:45:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45012 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDZGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:45:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id y5so1255805qkc.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jNz4gntAB8156apHxCMFhJ92iHi21h3N/PZZLyrHKQ=;
        b=QMwIdMqwRT43VgnCqcadXBtdtwH3jGQXw4Maj/+RNrsu02q9+YgaAH0lGWzKydv54g
         W8WwwzK+GjMe++5Z1ZYrXlXHPUrtpIZR2MdvCsRB93cwMyR+C0/tKsosxdGh1wB9ouiS
         20XyXpjFsyX1K6R26MbKPbSklePamHs1YKHviyqQkOH0KIGarHN2B+ja/qJz0mXNlqx+
         9zEYwgJFICiZQJas4LMWnR23p2+E7Ma2G0rcuV8XSKjXPOfheX0cB/2N4WuV0A7i1Kql
         gleHvjYVhY+ojLIMRCU6EODq/oqpj7CDOob3YIHAUJWuvZ8sk/cPS5JQkLEoLZDPum7v
         8azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jNz4gntAB8156apHxCMFhJ92iHi21h3N/PZZLyrHKQ=;
        b=Bp914XBb4q7vcIEf6ffM/uO1Lizo++xGTAbJdCRnQNvERf2bFCwQ5tq26/at8qlmap
         uIiWFoF7lV7Wj5bbpXN4kVkM4FD4LeyT/Ec2Z5VLALxCokTH/5FC2t/tyHy202FkY07w
         Qz9rnPjTvY5zzK/X129CA8zHQjxK2kQxppgTPUIfTty0NngLH4Xw3b4VBKWa245i0kBo
         PraLz71svqogfbzGMfS6EMWPeU66uECX1eevIR12oFuvQha0zO/DygPt7YdWY8i8YGAd
         /f7ZMU01Ezl2t4QC5LhruOPTTdcFnD8s1QG5SQteT23tXNE33ToNhWQ000L+b6IdL6n/
         Lc8A==
X-Gm-Message-State: APjAAAV98YuJWGlFgYmOf/kdFwRYR1TJycPTUUEEiTAOHC+zUneeTGBN
        qxawGTt3RM31rSwrQw1SCB1Tfp15bLD8CeoKPcE=
X-Google-Smtp-Source: APXvYqw2+KIi33yzOgwvrVE7CirMH0P5VuJ/rZE+IbVm/hybJ7tZl4E2NRHAVzHXquDCviCfL13PuRzRu/4R0W/ZRV8=
X-Received: by 2002:a05:620a:1088:: with SMTP id g8mr9658259qkk.173.1556261142229;
 Thu, 25 Apr 2019 23:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-24-duyuyang@gmail.com>
 <20190425195515.GX12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425195515.GX12232@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 26 Apr 2019 14:45:31 +0800
Message-ID: <CAHttsrZhg9tF_dng0LEqszYaK6Y48pyKAYKLAa+yZTkgQQaBXA@mail.gmail.com>
Subject: Re: [PATCH 23/28] locking/lockdep: Update irqsafe lock bitmaps
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

On Fri, 26 Apr 2019 at 03:55, Peter Zijlstra <peterz@infradead.org> wrote:
> > +     if (!dir) {
> > +             unsigned long *bitmaps[4] = {
> > +                     lock_classes_hardirq_safe,
> > +                     lock_classes_hardirq_safe_read,
> > +                     lock_classes_softirq_safe,
> > +                     lock_classes_softirq_safe_read
>
> That again should be something CPP magic using lockdep_states.h.

Yes.

> Also, that array can be static const, right? It's just an index into the
> static bitmaps.

Sure.

[...]
> > +static inline void remove_irqsafe_lock_bitmap(struct lock_class *class)
> > +{
> > +#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
> > +     unsigned long usage = class->usage_mask;
> > +
> > +     if (usage & LOCKF_USED_IN_HARDIRQ)
> > +             __clear_bit(class - lock_classes, lock_classes_hardirq_safe);
> > +     if (usage & LOCKF_USED_IN_HARDIRQ_READ)
> > +             __clear_bit(class - lock_classes, lock_classes_hardirq_safe_read);
> > +     if (usage & LOCKF_USED_IN_SOFTIRQ)
> > +             __clear_bit(class - lock_classes, lock_classes_softirq_safe);
> > +     if (usage & LOCKF_USED_IN_SOFTIRQ_READ)
> > +             __clear_bit(class - lock_classes, lock_classes_softirq_safe_read);
>
> More CPP foo required here.

Definitely.

> Also, do we really need to test, we could
> just unconditionally clear the bits.

Actually, these tests are used later for another cause: we want to
know which safe usage may be changed by zapping this lock.
