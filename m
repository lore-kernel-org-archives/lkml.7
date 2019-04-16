Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104DAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09392073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555401200;
	bh=eQCS9OI+Bp7Wb7eoXbJCTx3kmFFYpndKv4AGrQ4GKak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jVLih5PCAd/oNXziUbzzDOuVDnPonlvZMYhmzJMo6KgFWiTwm6jxJtMczZcFY/eib
	 hc/IbjFdIM+OBS5jh8ASJfXM7uKdFr+TvqJhd8/BqXiYsseBNniCK+61mf98sQcAo7
	 XsdSBNZ5aewXnHVuHrUuani5GZA0Hdj+bfyCd/h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDPHxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:53:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:32991 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPHxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:53:19 -0400
Received: by mail-wr1-f50.google.com with SMTP id q1so25614990wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7AtvdLQ8r/r2oUMJZEOAWKWVBTL+hHZQKqbS/QA8PKA=;
        b=sVPTdWijV9y0T8kjYNRPvvanhGy+KW3GTbMANtMgn+jqH6+tmGDQPuBcV7xykd9IMW
         oMb28AXVSdO9X5kA8TquApRd78w4JCPoNrZNEzngNPj5zwe3cAU+3vDwUKON0kHHiy2p
         HGNQdeltXRqGW7u64uweVaLOdc6DfLX45w2PWpAYAk4Ce+Jf2k2KJRPF0zICzTCg+3I4
         2IeaQ00D4+x7RXieP4w11xSvhikHrYB//lNJgMo0PNyYBk+A82BwoINecbmSiEaOe9aJ
         Es1t8XYxZ/Pq6007ZT2oFKa4Wx3Uq9klxRHQdDdtOn2XWbrEJs8KYnp7BULrNPSxsa1m
         olxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7AtvdLQ8r/r2oUMJZEOAWKWVBTL+hHZQKqbS/QA8PKA=;
        b=K3/m9fHZdPUvRGHJwuUUUmMC0bw8v+sVQxuXNT6HzOEIT1P3IrT1PwYaj1J56B/UVO
         lmG8/Od07vDRo4tNAt1CTbQvhjYsx6ydKtBncnpOrAmhQywUzx3w+C1ALPdl695A9JZy
         N66OEyfYvA/LYjK6odchRULFIF0cKsE9hJEWkORYUhn6ZWlsJiXWinzN3jpJV9n713Bj
         nKEhkPXe/LyMY4uJDqgvEugZpVdRTQtIIIcYR1nahnm3zCgkqAuc0yuzmtdeRLWLnWnn
         QmQI5/hW3UReKOuSrO22nIeIwE374Kn6FrvWBXmIQWd2Jl2V/CvYBsuwzKDdw0XzP+5h
         5qvQ==
X-Gm-Message-State: APjAAAVJm/G50ro9ur/BESW4UR95acL6SHAjMM0+PVi+x4rfYwdlj0vx
        liCs5b8cXrDfd7gTNtVzx/M=
X-Google-Smtp-Source: APXvYqxE9YF8tZam55DRWyPmjvHwUT3FhBbZcvKC1Uhs1aw3dmtB6Eios1iXV/om5r+LMFxN/P91uQ==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr30590222wrw.156.1555401197040;
        Tue, 16 Apr 2019 00:53:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a6sm43174186wrp.49.2019.04.16.00.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 00:53:16 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:53:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 02/14] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
Message-ID: <20190416075313.GA34215@gmail.com>
References: <20190412070209.GC129493@gmail.com>
 <20190412070545.GF11158@hirez.programming.kicks-ass.net>
 <20190412070904.GA45214@gmail.com>
 <b97eb5d5-1658-c405-e52e-2d20c4840948@redhat.com>
 <33b0111b-fe0f-eefc-59f4-f06d84d9cacc@redhat.com>
 <277e9c8e-8913-b251-4c98-dd2d4997d643@redhat.com>
 <20190412164123.GA119547@gmail.com>
 <4aefd2cd-f303-99ed-ada9-e7ba2ae9cd3c@redhat.com>
 <00ce3ea9-0046-740f-6a6c-3b4aff2c3c6e@redhat.com>
 <d012c68e-4c43-04af-3505-4c980e2d00a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d012c68e-4c43-04af-3505-4c980e2d00a5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> > It can be seen that a lot more readers got the lock via optimistic
> > spinning.  One possibility is that reader optimistic spinning causes
> > readers to spread out into more lock acquisition groups than without. The
> > K3 results show that grouping more readers into one lock acquisition
> > group help to improve performance for this microbenchmark. I will need
> > to run more tests to find out the root cause of this regression. It is
> > not an easy problem to solve.
> 
> Just an update on my will-it-scale regression investigation. I have
> tried various ways to tune the rwsem code to get more performance out
> from this benchmark. I got some minor improvements but nothing major. So
> it looks like that there are some workloads that have performance hurted
> by reader optimistic spinning and this benchmark is one of them. Now I
> am testing an adaptive reader optimistic spinning disabling patch that
> shows great promise as I was able to bring back a major portion of the
> lost performance. I will try to make the patch more aggressive to see if
> it can bring most of the lost performance back.

Thank you!

I've applied your two latest patches to WIP.locking/core as well, to keep 
it all tested and to see whether there's any other regressions. It's all 
looking good so far in my dogfood testing.

Thanks,

	Ingo
