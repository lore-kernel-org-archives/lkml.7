Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C2FC004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFB42082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih7lsyup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEFDFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 23:05:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40953 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFDFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 23:05:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id k24so9375027qtq.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 20:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0yjtj34v0KmK0weLTL4rbIhlVJ805Al3nS3amUErXQ=;
        b=ih7lsyupSNv5hg3YmzD5rk1NfdethjHS9sb5M0UQvlIKR90WyGSWfzFFega1XhONum
         cqwYcNXKqGyR3gRgC/bMDDgdYFsr8Q/C2X1TQ5UR4kYLlCeoeybVlGlkX3j7CbLlbMRq
         DNwc7KEJdLSzf99yyQuX/OTJy1H22hLNIcpIbtDG387WrEdyeLr2osTbCMU0RJD97P9x
         A6jFCNedAvuM3yLO+Bv6vCZp+gyYwbeomiW6A/e7it8tg9ltgfeO81h+bYOyDzVF2yQT
         z9LGxw8wjZSoBHDeMAzcsXciMOTRLXpnIflhnJoGY2058PQutokc2XFYFMI1JfwItxdX
         FpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0yjtj34v0KmK0weLTL4rbIhlVJ805Al3nS3amUErXQ=;
        b=EHkDmZIZLuh0bo7ZT3P5qkTrboYXLxmbATj+d9qzqKs4Tco/0GDmAr7KUT4GWsX9NR
         GeHNWtSio7i/bLE2NLz2w8ARemK+N+z5PqJGVg31FsbvrcKlpzPTbQ1s9ZU6tVMB6ZNI
         eQLMEhjAnkMy2NrgO8CsGzDEr4HumQF5Lt++Jp+ns6Fbo7Gq61PEvyQqKu3NBixpZVYV
         NjHFbsdRskLRGDyfXC7AP+u2wWkhtBajLqX+fkT3LytLzNfDsPWgulGeW1J8t0VIf8s4
         zWd/Hga+RH5xjHiHlfw7zQWPx0yBeW+03vxRhoXSDGMuOdFVUtVu6Pu8sUKfsTDd580v
         kMpA==
X-Gm-Message-State: APjAAAVart/Ook8zzs/t8PXvy6NAmR6QHrb2QoiU1ZJsfqzUCXAXC0Ef
        GufCWzOZj5dO7C0K8fpkJe0E9tuUgwfLaC+fJs4=
X-Google-Smtp-Source: APXvYqyayGKIwROeN6+YvHwqzTFbhUdvSE5VjqmT1RuebSp2XW2ruKsQ7T4zygPx38PzdsdYWEex6lwXdtFIRk61Piw=
X-Received: by 2002:a0c:af81:: with SMTP id s1mr19199265qvc.49.1557111938299;
 Sun, 05 May 2019 20:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-20-duyuyang@gmail.com>
 <20190425193247.GU12232@hirez.programming.kicks-ass.net> <CAHttsrY4jK2cayBE8zNCSJKDAkzLiBb40GVfQHpJi2YK1nEZaQ@mail.gmail.com>
 <20190430121148.GV2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190430121148.GV2623@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Mon, 6 May 2019 11:05:27 +0800
Message-ID: <CAHttsrYfCdpNwQ81ppFQ9b_57tuLYOb=xi=CbRBysnB+LgjGGg@mail.gmail.com>
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

On Tue, 30 Apr 2019 at 20:12, Peter Zijlstra <peterz@infradead.org> wrote:
> > > IOW he's going to massively explode this storage.
> >
> > If I understand correctly, he is not going to.
> >
> > First of all, we can divide the whole usage thing into tracking and checking.
> >
> > Frederic's fine-grained soft vector state is applied to usage
> > tracking, i.e., which specific vectors a lock is used or enabled.
> >
> > But for usage checking, which vectors are does not really matter. So,
> > the current size of the arrays and bitmaps are good enough. Right?
>
> Frederic? My understanding was that he really was going to split the
> whole thing. The moment you allow masking individual soft vectors, you
> get per-vector dependency chains.

It seems so. What I understand is: for IRQ usage, the difference is:

Each lock has a new usage mask:

        softirq10, ..., softirq1, hardirq

where softirq1 | softirq2 | ... | softirq10 = softirq

where softirq, exactly what was, virtually is used in the checking.
This is mainly because, any irq vector has any usage, the lock has
that usage, be it hard or soft.

If that is right, hardirq can be split too (why not if softirq does
:)). So, maybe a bitmap to do them all for tracking, and optionally
maintain aggregate softirq and hardirq for checking as before.
Regardless, may irq-safe reachability thing is not affected.

And for the chain, which is mainly for caching does not really matter
split or not (either way, the outcome will be the same?), because
there will be a hash for a chain anyway, which is the same. Right?
