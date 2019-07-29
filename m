Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CAAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D464721655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AMnt3B2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfG2QgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:36:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbfG2QgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dNu3JfnT07bxXIKp1fGmLIswFtWYh1RqPuYIiNunABU=; b=AMnt3B2ndBuYhV4NLY+MPDQuG
        he6WKtdQls5PPuZ5HH5Mo9dx++Uhv3QI0iQW9tWToLXWw06qARrMMXJQQqExGAzylHMmLtW719NuB
        DHJ8JHIRa5rSyfVVi+SjtGrcYvf3KhonT6qsBFXdg0Uxa4YEwlGfMXceQ8VObqXJJ/j1eIcLLDCzH
        0culyjPV19+2MQ/l9V7sLegH6Sx1TgmWydT/5R/bCoXYVWQ3RiAYHqL+06LV0Ug1kQxEfnx/G3kBV
        7z6B1/mffWSBmyDTM+5DHAJtLvHrCksdoxoLjBWB4AxuGCi9mKKyJFB9j63zt6JJfo6PHGdzZAv+b
        tD4B90V+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs8cr-00047q-99; Mon, 29 Jul 2019 16:35:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 106D120B00052; Mon, 29 Jul 2019 18:35:52 +0200 (CEST)
Date:   Mon, 29 Jul 2019 18:35:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] sched/deadline: Remove unused int flags from
 __dequeue_task_dl()
Message-ID: <20190729163552.GL31398@hirez.programming.kicks-ass.net>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726082756.5525-3-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 09:27:53AM +0100, Dietmar Eggemann wrote:
> The int flags parameter is not used in __dequeue_task_dl(). Remove it.

I just posted a patch(es) that will actually make use of it and extends
the flags argument into dequeue_dl_entity().

  https://lkml.kernel.org/r/20190726161357.999133690@infradead.org
