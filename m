Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9435EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A8422CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567543026;
	bh=yD3x85nQcTurkq/j46/oSeAFg2NspMSZYWAL7/9IXxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qXsnGgaeh8MT/GNUBdTplbAV3H6fB8SFg4ndjqGy33FqdieNnkpslaQoaHYhyhs1T
	 7rjKVBedNMHPuZ3P7H+7DZ4OtyDrav7mzD3KZk74BZQnOYMYeVmfyJxsF6SKPFoIaQ
	 cXAIq70GykAW2aAdAFC7hbwfQfT+wq97j9Cv3HEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfICUhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:37:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34301 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfICUhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:37:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id z21so14018852lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z50G68r4QEp0hm+puuI+wM6t6mbHhz8AacrMldPKbJw=;
        b=bzsFHMfytUAVjrooGIiUY1jzXzxHcxW/brVMIDJ9Ygj21pkEequmDcZBxNQE6A+JA8
         tc4MFPOnXyv1gw+jJla1RG19SY41g3E9AT5nYB26H/yBm937OJg4BBHUhXzmcmEDPSz+
         tcq2aGaUHyZ6JVBEeLrVVCAv6ETeFbcHMPrdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z50G68r4QEp0hm+puuI+wM6t6mbHhz8AacrMldPKbJw=;
        b=tFqHyCHFyfxQyHbpaRGP1vM68I5rn9TuFC7+W1AFQr/3pbKovPEnv/v3zuL7BRzGon
         mLlLUfZCLgzpQ7zH6K0Q+9xAe9qXKz6l9pWLeTUUwRdVARbr5FSYm2D+DXSS2XEWfqEP
         UM8ivjEooRztAIoHt2bXz2LFqamIh8Y9DQ53J64qgmiTSZpySVRNouCQvZ+P1jAfLZWm
         J8R82cVfbvKJoVnX2q2NSUhvQ+jfY9mCBNXMSmua3CAg8OcEqt9xNuR0rIQJr0Z9/iU8
         tgGLM1jb/Av4MwnKxkkePkYiw8a9EFtDUC9nPV1F5Ps6GBCL8Eyvu6jFgJQuiRcY0q30
         BPTw==
X-Gm-Message-State: APjAAAVcjPMtQBCfp6hMm4PDuLEtAdHnlSkgBMiplCHRGpOvDfdm+ZIf
        v7n2CMbM5W9dyOMEfPPSQ3emhem9aFM=
X-Google-Smtp-Source: APXvYqwyPyXIpVKIPKjYcCYn8uY7JzEP1eMcfYDYq2IMiwTnkVQQQ8p75AWx0WOln+HmBsuGurXfWA==
X-Received: by 2002:ac2:4ac9:: with SMTP id m9mr5298031lfp.94.1567543022860;
        Tue, 03 Sep 2019 13:37:02 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w27sm562422ljd.55.2019.09.03.13.36.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 13:37:00 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id u29so13972382lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:36:59 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr6155723lfn.52.1567543019604;
 Tue, 03 Sep 2019 13:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190903202434.GX2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190903202434.GX2349@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Sep 2019 13:36:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfYb5RnJGqDV3W3093XGwOwePV-SxixaWcWM6hmidArg@mail.gmail.com>
Message-ID: <CAHk-=whfYb5RnJGqDV3W3093XGwOwePV-SxixaWcWM6hmidArg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 1:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Why can't we frob this state into a line/word we already have to
> unconditionally touch, like the thread_info::flags word for example.

I agree, but we don't have any easily used flags left, I think.

But yes, it would be better to not have membarrier always dirty
another cacheline in the scheduler. So instead of

        atomic_set(&t->membarrier_state,
                   atomic_read(&t->mm->membarrier_state));

it migth be better to do something like

        if (mm->membarrier_state)
                atomic_or(&t->membarrier_state, mm->membarrier_state);

or something along those lines - I think we've already brought in the
'mm' struct into the cache anyway, and we'd not do the write (and
dirty the destination cacheline) for the common case of no membarrier
usage.

But yes, it would be better still if we can re-use some already dirty
cache state.

I wonder if the easiest model might be to just use a percpu variable
instead for the membarrier stuff? It's not like it has to be in
'struct task_struct' at all, I think. We only care about the current
runqueues, and those are percpu anyway.

             Linus
