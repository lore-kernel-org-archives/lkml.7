Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF3BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FF322419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfKTL6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:58:50 -0500
Received: from foss.arm.com ([217.140.110.172]:38194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbfKTL6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:58:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54892328;
        Wed, 20 Nov 2019 03:58:49 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6D5D3F703;
        Wed, 20 Nov 2019 03:58:47 -0800 (PST)
Date:   Wed, 20 Nov 2019 11:58:45 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 11/11] sched/fair: rework find_idlest_group
Message-ID: <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent

On 10/18/19 15:26, Vincent Guittot wrote:
> The slow wake up path computes per sched_group statisics to select the
> idlest group, which is quite similar to what load_balance() is doing
> for selecting busiest group. Rework find_idlest_group() to classify the
> sched_group and select the idlest one following the same steps as
> load_balance().
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

LTP test has caught a regression in perf_event_open02 test on linux-next and I
bisected it to this patch.

That is checking out next-20191119 tag and reverting this patch on top the test
passes. Without the revert the test fails.

I think this patch disturbs this part of the test:

	https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c#L209

When I revert this patch count_hardware_counters() returns a non zero value.
But with it applied it returns 0 which indicates that the condition terminates
earlier than what the test expects.

I'm failing to see the connection yet, but since I spent enough time bisecting
it I thought I'll throw this out before I continue to bottom it out in hope it
rings a bell for you or someone else.

The problem was consistently reproducible on Juno-r2.

LTP was compiled from 20190930 tag using

	./configure --host=aarch64-linux-gnu --prefix=~/arm64-ltp/
	make && make install



*** Output of the test when it fails ***

	# ./perf_event_open02 -v
	at iteration:0 value:254410384 time_enabled:195570320 time_running:156044100
	perf_event_open02    0  TINFO  :  overall task clock: 166935520
	perf_event_open02    0  TINFO  :  hw sum: 1200812256, task clock sum: 667703360
	hw counters: 300202518 300202881 300203246 300203611
	task clock counters: 166927400 166926780 166925660 166923520
	perf_event_open02    0  TINFO  :  ratio: 3.999768
	perf_event_open02    0  TINFO  :  nhw: 0.000100     /* I added this extra line for debug */
	perf_event_open02    1  TFAIL  :  perf_event_open02.c:370: test failed (ratio was greater than )



*** Output of the test when it passes (this patch reverted) ***

	# ./perf_event_open02 -v
	at iteration:0 value:300271482 time_enabled:177756080 time_running:177756080
	at iteration:1 value:300252655 time_enabled:166939100 time_running:166939100
	at iteration:2 value:300252877 time_enabled:166924920 time_running:166924920
	at iteration:3 value:300242545 time_enabled:166909620 time_running:166909620
	at iteration:4 value:300250779 time_enabled:166918540 time_running:166918540
	at iteration:5 value:300250660 time_enabled:166922180 time_running:166922180
	at iteration:6 value:258369655 time_enabled:167388920 time_running:143996600
	perf_event_open02    0  TINFO  :  overall task clock: 167540640
	perf_event_open02    0  TINFO  :  hw sum: 1801473873, task clock sum: 1005046160
	hw counters: 177971955 185132938 185488818 185488199 185480943 185477118 179657001 172499668 172137672 172139561
	task clock counters: 99299900 103293440 103503840 103502040 103499020 103496160 100224320 96227620 95999400 96000420
	perf_event_open02    0  TINFO  :  ratio: 5.998820
	perf_event_open02    0  TINFO  :  nhw: 6.000100     /* I added this extra line for debug */
	perf_event_open02    1  TPASS  :  test passed

Thanks

--
Qais Yousef
