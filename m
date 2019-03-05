Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFEFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9D42082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7+Hcghp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfCEMY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:24:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59890 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfCEMY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5n0gRaSrz866Ne997VIYvTrsaAtxd4fJ0OfRxmWFoBk=; b=K7+HcghpmlrJsxLmbANOP7sFe
        0AarG5xJXgzguW/RdnbmIQ7jwtz8BhhoC5opyFAdIEQpNb/RKNOCtYqlGq2a5k2YAF86YfbAC/Lhk
        loJ4juAPBVIxPyBrKcscdbHfgEBf+2A8V61wAcEjgVqovckCxotEFsiFfqKzIUpGJh6yWXMZjKaRu
        4QroEpJGwbR/pKpDXnlJBP/nMrWksrqx5DfOzDSvWiaEd2Dn17z6iWsW3d1bJS6bGM5hwyWhqeB+h
        PsvZclNIUdctGoMuNouXKOLBG3rQKg38ZAiEtAxsg8cmGapBQyEg1y720PFwpuTG+yn1wWoN3YxZK
        I+kPryUyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h197B-0005zA-0P; Tue, 05 Mar 2019 12:24:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAEDD29B18A00; Tue,  5 Mar 2019 13:24:07 +0100 (CET)
Date:   Tue, 5 Mar 2019 13:24:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Message-ID: <20190305122407.GI32477@hirez.programming.kicks-ass.net>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net>
 <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 12:00:43PM +0000, Quentin Perret wrote:

> And btw why do you need 9 steps to reach MAX starting from 128 ? If we
> double the boost at each wakeup you'll do 128 -> 256 -> 512 -> 1024 no ?

Argh; I'm so full of fail this week; 10-7=3.
