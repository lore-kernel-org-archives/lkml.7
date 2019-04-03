Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F86C2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aulu3KKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfDCHyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:54:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37154 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfDCHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rWQPsTaTv0kAuN5Xb8mmeMvMdNlT7Hs/zZrjqh/jbeM=; b=aulu3KKx0ntrc8IYvS+wXj2Hh
        YMLXFdGn6tnBVgmqUmGrHwljoJNHMw6feyszdO8SFOWcSqWdjXCmuUMawyyjsjYPBDc8Dd6XoqHjM
        G31tULJq2A2IRRMwksuRzDr+eiZluF5Xgg2TqaMNcF7OlTU1wIkjCp/37b+DrCQxjXMR9PZLe4Wjf
        gEWQLDRCqCzmm9jiluYfoa/Q4wrcdeLudxqUyPZFdaNUWEsGMgfCMMBAUeJGEIDRE98ryOb1F6e6L
        uTO+U9clV3fZKT2AH4ZA3Q84kA1u/zIU/P1gwd6wzbQR9LFpBnaoZQcKlbLxzNjtH0qq2bYz7MRXp
        40WqD4q/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBaix-0000ca-Vb; Wed, 03 Apr 2019 07:54:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2114929A6F664; Wed,  3 Apr 2019 09:54:17 +0200 (CEST)
Date:   Wed, 3 Apr 2019 09:54:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Message-ID: <20190403075417.GB4038@hirez.programming.kicks-ass.net>
References: <cover.1554218314.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554218314.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:21:12PM +0000, Lendacky, Thomas wrote:
> Tom Lendacky (3):
>   x86/perf/amd: Resolve race condition when disabling PMC
>   x86/perf/amd: Resolve NMI latency issues for active PMCs
>   x86/perf/amd: Remove need to check "running" bit in NMI handler
> 
>  arch/x86/events/amd/core.c | 139 +++++++++++++++++++++++++++++++++++--
>  arch/x86/events/core.c     |  13 +---
>  2 files changed, 137 insertions(+), 15 deletions(-)

no base64 encoding this time, applied without issue.

Thanks Tom!

