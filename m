Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A7DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE312070B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKZudid9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfHUKqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:46:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfHUKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pQ2Wv/KrpNQLYBZ94T0F4LpmsjFVcLACEl2TET9qJzw=; b=iKZudid9Djsq/hKG3KK+PUj33
        7A60449jHZXVtMRzMaKQqDPA1iwfOrRSl7dy/3WMDEsOo47k7WzBjhvG3PAbziLfhDQAAYPGtmeL0
        e5nyIjeDLpi9SNBVmzdfOn9INaGwtXA5OQRBoJN5voGV95JaNNGuZ8Vz/YV7v5605opAEWzxdBg/N
        WpFyBDRozoOSYS7G6R3+Nso3qGwo+5QmH+sMLYVHTjiby39FRvoWwzjhCEVsA5wcN3d2p2QiNSsQY
        Z79bOEqEdbtGmWbTKQupd4tuiYHaoFrmmGn/DxPZdmlcXKI9n8VKSuIkXCY1js6NDVWI8kPD8LSa2
        teGmLRB0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0O8c-0000Uh-2Q; Wed, 21 Aug 2019 10:46:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C6C9307456;
        Wed, 21 Aug 2019 12:46:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0F9620C3BF31; Wed, 21 Aug 2019 12:46:43 +0200 (CEST)
Date:   Wed, 21 Aug 2019 12:46:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     c00423981 <caomeng5@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpustat: print watchdog time and statistics of soft and
 hard interrupts in soft lockup scenes
Message-ID: <20190821104643.GA2349@hirez.programming.kicks-ass.net>
References: <60319e82-3c2b-ff24-4ba7-4d58048130ff@huawei.com>
 <20190820110430.GL2332@hirez.programming.kicks-ass.net>
 <4eb6b499-b6b0-602a-ae89-0c1dceaa5088@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb6b499-b6b0-602a-ae89-0c1dceaa5088@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Wed, Aug 21, 2019 at 04:26:17PM +0800, c00423981 wrote:
> Sorry, I cannot understand this problem accurately. I try to understand it and I guess what you want
> to express is that the return value type should be cputime64_t but not u64, just like as follows:
> 
> +static cputime64_t cpustat_curr_cputime(int cpu, int index)
> +{
> +	cputime64_t time;
> +
> +	if (index == CPUTIME_IDLE)
> +		time = get_idle_time(cpu);
> +	else if (index == CPUTIME_IOWAIT)
> +		time = get_iowait_time(cpu);
> 
> I don't know if I understand it correctly. Looking forward to your answer.

get_iowait_time(cpu) is terminally broken, see commit:

  e33a9bba85a8 ("sched/core: move IO scheduling accounting from io_schedule_timeout() into scheduler")
