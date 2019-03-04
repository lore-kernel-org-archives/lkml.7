Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA731C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A7206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfCDN6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:58:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfCDN6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:58:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFCF8EBD;
        Mon,  4 Mar 2019 05:58:15 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BADB3F575;
        Mon,  4 Mar 2019 05:58:14 -0800 (PST)
Date:   Mon, 4 Mar 2019 13:58:12 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     =?utf-8?B?V2FuZywgVmluY2VudCAo546L5LqJKQ==?= 
        <Vincent.Wang@unisoc.com>
Cc:     =?utf-8?B?WmhhbmcsIENodW55YW4gKOW8oOaYpeiJsyk=?= 
        <Chunyan.Zhang@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjRdIHNj?=
 =?utf-8?Q?hed=2Fcpufreq=3A_initializ?= =?utf-8?Q?e?= iowait_boost_max and
 iowait_boost with cpu capacity
Message-ID: <20190304135810.rq2ojnbn5vezrab3@queper01-lin>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
 <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 Mar 2019 at 07:35:04 (+0000), Wang, Vincent (王争) wrote:
> Did you mean the value of arch_scale_cpu_capacity() is changed in
> cpu_capacity_store()?

Yes, there's that, but more importantly topology_normalize_cpu_scale()
is called during boot. With printks() in the relevant functions, the
boot log on my system with two CPUFreq policies looks like this:

[    2.393085] init_cpu_capacity_callback: policy0
[    2.397714] sugov_start: policy0
[    2.403734] init_cpu_capacity_callback: policy1
[    2.407901] topology_normalize_cpu_scale: done
[    2.412581] sugov_start: policy1

So, the lack of order of sugov_start() and topology_normalize_cpu_scale()
is a problem, I think.

> If so, I can restart schedutil governor after new capacity is updated.

Hmm, that feels a bit overkill, but that should at least be a correct
way of updating sg_cpu->{min, max} in a non-racy way. And CPU capacity
changes are infrequent, so the overhead of re-starting the governor
isn't a major issue, I suppose.

You could also update the values in sugov_get_util() at the cost of a
small overhead to compute 'min'. I'm not sure what's preferable since
we wanted to avoid that kind of overhead in the first place ...

Thanks,
Quentin
