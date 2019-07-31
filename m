Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80547C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D33206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r4KC1Gpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfGaJtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:49:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39816 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfGaJtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cpKHm5IIeF506/J6eXKLRGoFimN38axnhHipdy31BH4=; b=r4KC1GpxamAZgtBBJaMTXGNpz
        OorpO0aGszQQWtWaJinC6NIcypLzB66+RGYv6jDn3VMZ8pcdo8Nux1xDol6wGtSDXHrOM74fvTrOK
        jslv6yVnNL8VZt0ylPY1IKKcZg+0uojW7HK0DxCaWq45ftafXDNlVIv3cQQG0tPe3K7Nky1IiJXoV
        A5NZWROd4I5q5573WKK5ViPRcv3kHyjw4UdLijfx1XvGaUomtN81dGUSd38gb4eN/bKSzyfDBlJvP
        H5/wiYSoiTOu4DtyjqCxBvyTB34YB4D5BSeXN9+ndIi82Vet+rUTSWtHdKxkzSnJq8I6dVHUIMFlQ
        aPLCn/K5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hslEl-0000pI-1v; Wed, 31 Jul 2019 09:49:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D13702029FD58; Wed, 31 Jul 2019 11:49:33 +0200 (CEST)
Date:   Wed, 31 Jul 2019 11:49:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: Re: [patch 0/7] posix-timers: Prepare for PREEMPT_RT - part 1
Message-ID: <20190731094933.GS31381@hirez.programming.kicks-ass.net>
References: <20190730223348.409366334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730223348.409366334@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:33:48AM +0200, Thomas Gleixner wrote:
> The following series prepares posix-timers for RT. The main change here is
> to utilize the hrtimer synchronization mechanism to prevent priority
> inversion and live locks on timer deletion.
> 
> This does not cover the posix CPU timers as they need more special
> treatment for RT which is covered in a separate series.
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
