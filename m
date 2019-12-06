Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6ABC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3782064B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfLFQ5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:57:42 -0500
Received: from foss.arm.com ([217.140.110.172]:50606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfLFQ5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:57:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9B4531B;
        Fri,  6 Dec 2019 08:57:39 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A87E83F52E;
        Fri,  6 Dec 2019 08:57:38 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
 <6242deaa-e570-3384-0737-e49abb0599dd@arm.com>
 <20191206125317.GC22330@linux.vnet.ibm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <8521e154-b485-c9fc-708d-7d87a12a9e9e@arm.com>
Date:   Fri, 6 Dec 2019 16:57:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191206125317.GC22330@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2019 12:53, Srikar Dronamraju wrote:
> Its probably something to think over. I probably don't have an answer on why
> we are not choosing the starting cpu to be primary CPU.  Would we have to
> think of the case where the Primary CPUs are online / offline etc? I mean
> with target cpu, we know the CPU is online for sure.
> 

Myes, CPU affinity also makes the thing much more painful (what if the task
is affined to some of the core's threads, but not the primary one?). The
current method has the merit of handling these cases.
