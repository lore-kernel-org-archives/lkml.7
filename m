Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55615C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296D320693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvMuuqG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfGJGaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:30:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37241 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJGaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:30:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so1051567qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 23:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vm/zZ1E3DFUQH7z4QiyYfliAbDwL89C3i7b0XZMu7Ik=;
        b=IvMuuqG/ZItyBWO+3M/JGvIcWC+HB6PHTUOGX4IIOEDAcJx3ATD9nPyqZZTiN1M+VU
         BccY8KQeWsH0HDHrosVt4H7LRrMHqfmnTrmFp+8Tlz2/2vp1Wv32k/JGzeX5g8pFFc/H
         MyEGAtY9HnZ65x9e8YFB1oiD1QPv6DVPjtQMfPUyVqc8k+JwM7imjFuCN6015JQui1QB
         WbO9wSz01qsFA1L8VkOK8ZJdJWLWAqfyQZXAgLBzpbGciX7+niZ0zlNeWueq4RkEYUHC
         XBknzAUaV1C7JQDAYR7hlRfetW0hqObiZMCE0O69g6RzRQUpZusqM/TpBWTjyhPUYsH7
         cJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vm/zZ1E3DFUQH7z4QiyYfliAbDwL89C3i7b0XZMu7Ik=;
        b=SZUA+rNj+ZxtWvWn79r6WGtAuC/kW4CFv7fkYL9mkAFpgaTDIV8o5xTkEUnSi8jvOU
         OyfWNSM+lt8Cw4IzyRVZv8SQMj9ZhKbxyRTte0GegmqfJnviIGXrthW1mQfm72fM5SJx
         TgYTwTXyRFMp9oEz9wikzh2Kvcd63nu9HDJndW4kOi0seTSELOYsfTXXpfso9L70t6N/
         flweTVaYtJPM3VDAuorbu/Mp73swTcWgOHecTu6bZGLnYfqe5lNk5kSYEQK07QbydFSR
         rdE9H/RNlUe6vZlWJ09n6bIXNWa5BAenu/3elUpE2SR40mkMYnW4Fp/EWPPJzP9vaUTL
         5y/Q==
X-Gm-Message-State: APjAAAWr63peoR6+C3awloUIB50ShxoHadchFDIh65GBv+IKs3jTVZ+Q
        6QsCQrVp7j/EiRkJowgxqNxL/u8yLqtFjDE44T0=
X-Google-Smtp-Source: APXvYqx3DhNTb5Jx9OHKiLLiURcwOf9Y/ORPhhCXZgvb77K6EyF7kqrAyafRjbHXXIs+5fPh/wrYxG2X+2+ms4HpTtg=
X-Received: by 2002:a37:9944:: with SMTP id b65mr22716631qke.105.1562740218660;
 Tue, 09 Jul 2019 23:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190628091528.17059-1-duyuyang@gmail.com> <20190628091528.17059-31-duyuyang@gmail.com>
 <20190710053002.GC14490@tardis>
In-Reply-To: <20190710053002.GC14490@tardis>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Wed, 10 Jul 2019 14:30:07 +0800
Message-ID: <CAHttsrZz866PnVX=GSxQOjqYL_E4HNjtrUfCcEFs7FMtxK8O0Q@mail.gmail.com>
Subject: Re: [PATCH v3 30/30] locking/lockdep: Remove irq-safe to irq-unsafe
 read check
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, paulmck@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Wed, 10 Jul 2019 at 13:30, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Fri, Jun 28, 2019 at 05:15:28PM +0800, Yuyang Du wrote:
> > We have a lockdep warning:
> >
> >   ========================================================
> >   WARNING: possible irq lock inversion dependency detected
> >   5.1.0-rc7+ #141 Not tainted
> >   --------------------------------------------------------
> >   kworker/8:2/328 just changed the state of lock:
> >   0000000007f1a95b (&(&host->lock)->rlock){-...}, at: ata_bmdma_interrupt+0x27/0x1c0 [libata]
> >   but this lock took another, HARDIRQ-READ-unsafe lock in the past:
> >    (&trig->leddev_list_lock){.+.?}
> >
> > and interrupts could create inverse lock ordering between them.
> >
> > other info that might help us debug this:
> >    Possible interrupt unsafe locking scenario:
> >
> >          CPU0                    CPU1
> >          ----                    ----
> >     lock(&trig->leddev_list_lock);
> >                                  local_irq_disable();
> >                                  lock(&(&host->lock)->rlock);
> >                                  lock(&trig->leddev_list_lock);
> >     <Interrupt>
> >       lock(&(&host->lock)->rlock);
> >
> >  *** DEADLOCK ***
> >
> > This splat is a false positive, which is enabled by the addition of
>
> If so, I think the better way is to reorder this patch before recursive
> read lock suppport, for better bisect-ability.

Good suggestion.

Thanks,
Yuyang
