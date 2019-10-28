Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69661CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F70720830
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hGmgnEUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbfJ1Uus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:50:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJ1Uur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=86FM2in48XbE3DSJy2qOmHFh4dIabUwAQblIqTAtbOY=; b=hGmgnEUwRBa+zBnkwQ4FXPN6c
        6r/qgVstTMAIEY9dzYAzr0XgcKXV58IrmFtAqH1xwjExSFzyk+uqHn6/p4M/1lBunzpKxrnv1mkkK
        7Ft4uuJ+x/FSTrCd69noCJgc+Wr9qz7Ryux/BUssQsKpNzKIYkv0M5/cY42/Kwen3KWp61sXgTbIH
        lx0CNwl9sntTRiSYOPGhJfK9KBCZOpLFLPbjzDnxyEMizEaNjK/7Q3BXMpZOn0dYu/G4lO3R9P6B0
        l7vlWaXbgAwNstPn44lQOSGi+EBPTLObQys2bR4/Z4Zj/SWjQgtJiLJ6tLwsgcoSK0sV4Ajn7RLwh
        zlu6YMv2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPByB-0001W0-UT; Mon, 28 Oct 2019 20:50:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9270980D8F; Mon, 28 Oct 2019 21:50:34 +0100 (CET)
Date:   Mon, 28 Oct 2019 21:50:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191028205034.GL4643@worktop.programming.kicks-ass.net>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20191028143749.GE4114@hirez.programming.kicks-ass.net>
 <20191028140147.036a0001@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028140147.036a0001@grimm.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 02:01:47PM -0400, Steven Rostedt wrote:
> On Mon, 28 Oct 2019 15:37:49 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:

> > Works for me; Steve you OK with this?
> 
> Nothing against it, but I want to take a deeper look before we accept
> it. Are you OK in waiting a week? I'm currently at Open Source Summit
> and still have two more talks to write (giving them Thursday). I wont
> have time to look till next week.

Sure, I'll keep it in my queue, but will make sure it doesn't hit -tip
until you've had time.
