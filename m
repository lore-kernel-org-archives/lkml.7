Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C0B21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GsxgiUJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfDXQLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:11:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38148 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfDXQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aGRH97kvFpdAENunhndp8axPmE0n5u7e8fWS/q4nDsM=; b=GsxgiUJwrmsabjCkPrtiUVsPn
        nLgqRus+XOFr3SgrrTWMGLKZ5NrSp1bM7/F9KS0mk5iiwgtpftVWBCfeUpWF1zlw12DnLHqo0t3yB
        0TSuPZBoFvnECHN0c4AXuuOUcVgTS9sbFt/0UIE5WKXgFJd3PlfbXriJjLQ1QoT14fkL9w5Vgptc4
        GR2MdAc2DJ5dzC/eI2rgez+KIG2ovtd0cVEXZyh5XI2aqhMeW0klX2Q3QroA8JLxq+E1abD3koYxY
        0fYnwVQWSLfiMSgz+/eaCk7kk05YeuogBOaJgPMcs8sMAHjb4s9UvFNhgaNs2ErzsbrkAVpNLagGx
        ub45Lj/sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJKT5-0005NC-Jz; Wed, 24 Apr 2019 16:09:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B64120D0A202; Wed, 24 Apr 2019 18:09:54 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:09:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] futex: Consolidate duplicated timer setup code
Message-ID: <20190424160954.GP11158@hirez.programming.kicks-ass.net>
References: <20190424153651.15002-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424153651.15002-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:36:51AM -0400, Waiman Long wrote:
> +static inline struct hrtimer_sleeper *
> +futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
> +		  int flags, u64 range_ns)
> +{
> +	if (!time)
> +		return NULL;
> +
> +	hrtimer_init_on_stack(&timeout->timer, (flags & FLAGS_CLOCKRT) ?
> +			      CLOCK_REALTIME : CLOCK_MONOTONIC,
> +			      HRTIMER_MODE_ABS);
> +	hrtimer_init_sleeper(timeout, current);
> +	if (range_ns)
> +		hrtimer_set_expires_range_ns(&timeout->timer, *time, range_ns);
> +	else
> +		hrtimer_set_expires(&timeout->timer, *time);

That can be an unconditinoal:

	hrtimer_set_expires_range_ns(&timeout->timer, *time, range_ns);

See how:

  timer->node.expires = ktime_add_safe(time, ns_to_ktime(delta));

is the same as:

  timer->node.expires = time;

when !delta.

> +
> +	return timeout;
> +}

Anyway, looks good otherwise.
