Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC636C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1B7217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfHZMM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:12:59 -0400
Received: from foss.arm.com ([217.140.110.172]:56720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730841AbfHZMM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:12:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEA3728;
        Mon, 26 Aug 2019 05:12:58 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6E933F718;
        Mon, 26 Aug 2019 05:12:57 -0700 (PDT)
Subject: Re: [PATCH] sched/cpufreq: Align trace event behavior of fast
 switching
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com
References: <20190807153340.11516-1-douglas.raillard@arm.com>
 <3316959.EEulJYEQYJ@kreacher>
 <20190826094058.GP2369@hirez.programming.kicks-ass.net>
 <cb75ae16-727e-636b-2b79-4f049259c0aa@arm.com>
 <20190826112406.GR2369@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <eccb89bf-80cc-e96a-925e-181095305631@arm.com>
Date:   Mon, 26 Aug 2019 14:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826112406.GR2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2019 13:24, Peter Zijlstra wrote:
> On Mon, Aug 26, 2019 at 11:51:17AM +0200, Dietmar Eggemann wrote:
> 
>> Not sure about the extra  'if trace_cpu_frequency_enabled()' but I guess
>> it doesn't hurt.
> 
> Without that you do that for_each_cpu() iteration unconditionally, even
> if the tracepoint is disabled.

Makes sense, I'm wondering if we want this in
cpufreq_notify_transition() CPUFREQ_POSTCHANGE for the
non-fast-switching drivers as well.
