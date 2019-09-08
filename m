Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C32C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052C821479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567961490;
	bh=Kj5psPMoIgfNF7M7u6kftF3NnrTszDonpcqmUMNucgg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kzbYCrsWS82YHKw8jypU9nW9Vb4EgrErVPwAVZ2zudOXcDy4Z5RVvqyRy5w6RmhCB
	 A04fMkVgeVQiW/8/ybDIvNRkqbszsYmMQ9Uo5BmJn/DbsMqC0MUQj1iYsJ1oUAdByv
	 mB/sObElINheTsjGZ6+DQd4Hmp3TaSA9L8KEGpVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfIHQv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:51:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40580 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfIHQv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:51:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so10380037ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YoIls/aUMVBJEUhwmPfrmXKQZG9hw6rzXVJRDcN3ug=;
        b=PakuBLi7miNnPIzSldMEwve9gJJW34rFqGQdK9KgfmByuNMIJ2sVnilcxqix48yM4J
         jBB4oXyZODvICRAJbAFouqqKpBXWONSzfnmWU3oMCG1IiEKuMWzrSbZl8/cCz37ajW9C
         fAlejok1N4viYGxoqomJcVBvNtXdeHdF8KYrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YoIls/aUMVBJEUhwmPfrmXKQZG9hw6rzXVJRDcN3ug=;
        b=sSLpIUz5RWOGbfHw8fMm7RGIr68kX/WlWQD+FSSFpGsWAkqu6lQ+Mlz+tPvidsM0B1
         9BGBsckTDW/cHJbgvDHZ57/aHss7hgTL1NttTAhpLkHo1+pwfwKUjYW8WsF0RdSoZ12r
         SOhr6eDeIPztdirVlBlcEr6elpDRZW9JBRmXB9cvm57ecf+jxHdVIHz38HGl/ghPV9dC
         YIbKPdzj/BYVCNXb3tA50BDenKblgk+N+VoATe5LegmQg0Wi6pe00jxPoez/JD1a5y2G
         HmJF+4pkFLGPmZQ/ChpRX9D4JkanC2OER3t4uFgyJHcrSoPOtUL1IqZ9CKTZQRe9UuN8
         8j6w==
X-Gm-Message-State: APjAAAUFC7mfURzQcCSgqbxNdCZGhBNG11hEOCnAhovYLRhxUVdMnggM
        5k4EF7UxXSIFSQOQch7K2ozM1AGQfmo=
X-Google-Smtp-Source: APXvYqzA5qKIULCaca29B9GN47VekenVEMhAlAeXbKIJRgcVHxI2MGDyunWUkEKtlPSV/GapItD4Vg==
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr12418473lja.84.1567961486354;
        Sun, 08 Sep 2019 09:51:26 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v17sm2083206ljh.8.2019.09.08.09.51.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2019 09:51:25 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id c12so8635558lfh.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 09:51:25 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr13599372lfe.79.1567961484926;
 Sun, 08 Sep 2019 09:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net> <20190908134909.12389-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190908134909.12389-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Sep 2019 09:51:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com>
Message-ID: <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 8, 2019 at 6:49 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> +static void sync_runqueues_membarrier_state(struct mm_struct *mm)
> +{
> +       int membarrier_state = atomic_read(&mm->membarrier_state);
> +       bool fallback = false;
> +       cpumask_var_t tmpmask;
> +
> +       if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
> +               /* Fallback for OOM. */
> +               fallback = true;
> +       }
> +
> +       /*
> +        * For each cpu runqueue, if the task's mm match @mm, ensure that all
> +        * @mm's membarrier state set bits are also set in in the runqueue's
> +        * membarrier state. This ensures that a runqueue scheduling
> +        * between threads which are users of @mm has its membarrier state
> +        * updated.
> +        */
> +       cpus_read_lock();
> +       rcu_read_lock();
> +       for_each_online_cpu(cpu) {
> +               struct rq *rq = cpu_rq(cpu);
> +               struct task_struct *p;
> +
> +               p = task_rcu_dereference(&rq->curr);
> +               if (p && p->mm == mm) {
> +                       if (!fallback)
> +                               __cpumask_set_cpu(cpu, tmpmask);
> +                       else
> +                               smp_call_function_single(cpu, ipi_sync_rq_state,
> +                                                        mm, 1);
> +               }
> +       }

I really absolutely detest this whole "fallback" code.

It will never get any real testing, and the code is just broken.

Why don't you just use the mm_cpumask(mm) unconditionally? Yes, it
will possibly call too many CPU's, but this fallback code is just
completely disgusting.

Do a simple and clean implementation. Then, if you can show real
performance issues (which I doubt), maybe do something else, but even
then you should never do something that will effectively create cases
that have absolutely zero test-coverage.

                      Linus
