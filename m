Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B71206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZNAvkO1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfHTLEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:04:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfHTLEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ts4v6M3z2r4Kl3nDDDGqpuSc/Z0cqjuzGtxOIWMF0Kc=; b=ZNAvkO1mOiFhEryFwP2Jdiacm
        +Tk9lxLBZlHhJJd5TysLQeLIAKZ9St7JOu+CnhgtxoIz5uYQNDBpDq+Dap0+cM2piopslwxnlKi6g
        0YMq+OFgJoCHkUcVw4ZhWHcUYAEIVt3q6mYc+yu/5F06wxobZl4/+bMeaPxZ8RteCC92Fa59CXbE3
        6+wxxnEMDKMjIx8flfhZAyzuEKIeVLhD6keJ5ftJVILpAhak1qL5hYyYfPGrfIPa+KbYX6NSGo1VA
        u1nIsZg1GVmGH/SZeUzf4zr5uEw2TdhBpD5D1vRXtkpUv/2Sl5OEMyuXcAoaYv0OPfdR8KTsSy+qY
        KnJVqwzMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i01wH-0006ny-Ti; Tue, 20 Aug 2019 11:04:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EA2A307456;
        Tue, 20 Aug 2019 13:03:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1930820B342B1; Tue, 20 Aug 2019 13:04:30 +0200 (CEST)
Date:   Tue, 20 Aug 2019 13:04:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     c00423981 <caomeng5@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpustat: print watchdog time and statistics of soft and
 hard interrupts in soft lockup scenes
Message-ID: <20190820110430.GL2332@hirez.programming.kicks-ass.net>
References: <60319e82-3c2b-ff24-4ba7-4d58048130ff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60319e82-3c2b-ff24-4ba7-4d58048130ff@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:12:24PM +0800, c00423981 wrote:
> +static u64 cpustat_curr_cputime(int cpu, int index)
> +{
> +	u64 time;
> +
> +	if (index == CPUTIME_IDLE)
> +		time = get_idle_time(cpu);
> +	else if (index == CPUTIME_IOWAIT)
> +		time = get_iowait_time(cpu);

NAK; don't add new users of this terminally broken interface.
