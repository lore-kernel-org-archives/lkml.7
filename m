Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF213CA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE30208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKBBNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 21:13:47 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59692 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfKBBNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 21:13:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TgyIBrx_1572657222;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TgyIBrx_1572657222)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 09:13:43 +0800
Subject: Re: [PATCH v2] sched/numa: advanced per-cgroup numa statistic
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <682ed1d4-abf1-92f6-851f-567ff9b9a841@linux.alibaba.com>
 <20191101173936.GB16165@blackbody.suse.cz>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <0b7a20a3-4ff4-6183-c6e1-7c8c37efd0e2@linux.alibaba.com>
Date:   Sat, 2 Nov 2019 09:13:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101173936.GB16165@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal

On 2019/11/2 上午1:39, Michal Koutný wrote:
> Hello Yun.
> 
> On Tue, Oct 29, 2019 at 03:57:20PM +0800, 王贇 <yun.wang@linux.alibaba.com> wrote:
>> +static void update_numa_statistics(struct cfs_rq *cfs_rq)
>> +{
>> +	int idx;
>> +	unsigned long remote = current->numa_faults_locality[3];
>> +	unsigned long local = current->numa_faults_locality[4];
>> +
>> +	cfs_rq->nstat.jiffies++;
> This statistics effectively doubles what
> kernel/sched/cpuacct.c:cpuacct_charge() does (measuring per-cpu time).
> Hence it seems redundant.

Yes, while there is no guarantee the cpu cgroup always binding
with cpuacct in v1, we can't rely on that...

> 
>> +
>> +	if (!remote && !local)
>> +		return;
>> +
>> +	idx = (NR_NL_INTERVAL - 1) * local / (remote + local);
>> +	cfs_rq->nstat.locality[idx]++;
> IIUC, the mechanism numa_faults_locality values, this statistics only
> estimates the access locality based on NUMA balancing samples, i.e.
> there exists more precise source of that information.>
> All in all, I'd concur to Mel's suggestion of external measurement.

Currently I can only find numa balancing who is telling the real story,
at least we know after the PF, task do access the page on that CPU,
although it can't cover all the cases, it still giving good hints :-)

It would be great if we could find more similar indicators, like the
migration failure counter Mel mentioned, which give good hints on
memory policy problems, could be used as external measurement.

Regards,
Michael Wang

> 
> Michal
> 
