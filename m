Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA82C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB72146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZR2a8he6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfLTJ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:27:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55036 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLTJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2OQ9lQQmbneD1QkUqtwBua7tuO8oAf4tE8FPYgHDOPM=; b=ZR2a8he6LlYujC/9UGcarATUJ
        95QwCzrzx7czmmOT7PpYgl77Isv1Ujmq3D5y123v+SktdTXmNdVGg8EAPT2bH+2coxMTAxNvt8e34
        ZY+Z4mnu55TlHg8yj0ywXxB0DSHjwyF4cLqJS673fJyU0RXlm46cX4ad2ikjrUFlAGtEXm6WZThRa
        RH5W57NO+qdNgyNQPfVXjBGy/FVenTTKw8cWz9pdejbquTLh8Bt9MoFcrRr09jCICzWdt3BwmX4Vj
        M0n3132BtAd7IQvYAR7jUs5AnDlZ6DS3SDtexABk6oRMr7mXupEBNJxH9wZ1vnRrGGJ4pCHPOvvi9
        LlEidBcxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiEYO-00009J-Oq; Fri, 20 Dec 2019 09:26:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21EF03007F2;
        Fri, 20 Dec 2019 10:25:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 015D62B3E1689; Fri, 20 Dec 2019 10:26:31 +0100 (CET)
Date:   Fri, 20 Dec 2019 10:26:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     ktkhai@virtuozzo.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RESEND v3] sched: Micro optimization in pick_next_task()
 and in check_preempt_curr()
Message-ID: <20191220092631.GB2844@hirez.programming.kicks-ass.net>
References: <20191219113517.65617a7b@gandalf.local.home>
 <47a00e0e-69c0-2a2f-6ae1-1a8ec9b01ede@virtuozzo.com>
 <20191219160422.4eb28a2e@gandalf.local.home>
 <711a9c4b-ff32-1136-b848-17c622d548f3@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711a9c4b-ff32-1136-b848-17c622d548f3@yandex.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 12:27:05AM +0300, Kirill Tkhai wrote:
> This introduces an optimization based on xxx_sched_class addresses
> in two hot scheduler functions: pick_next_task() and check_preempt_curr().
> 
> It is possible to compare pointers to sched classes to check, which
> of them has a higher priority, instead of current iterations using
> for_each_class().
> 
> One more result of the patch is that size of object file becomes a little
> less (excluding added BUG_ON(), which goes in __init section):
> 
> $size kernel/sched/core.o
>          text     data      bss	    dec	    hex	filename
> before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
> after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Thanks guys!
