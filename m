Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D3BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A8D22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfHUI0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:26:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726409AbfHUI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:26:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A1478709B65622D03112;
        Wed, 21 Aug 2019 16:26:33 +0800 (CST)
Received: from [127.0.0.1] (10.133.211.147) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 16:26:29 +0800
Subject: Re: [PATCH] cpustat: print watchdog time and statistics of soft and
 hard interrupts in soft lockup scenes
To:     Peter Zijlstra <peterz@infradead.org>
References: <60319e82-3c2b-ff24-4ba7-4d58048130ff@huawei.com>
 <20190820110430.GL2332@hirez.programming.kicks-ass.net>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
From:   c00423981 <caomeng5@huawei.com>
Message-ID: <4eb6b499-b6b0-602a-ae89-0c1dceaa5088@huawei.com>
Date:   Wed, 21 Aug 2019 16:26:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190820110430.GL2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.211.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I cannot understand this problem accurately. I try to understand it and I guess what you want
to express is that the return value type should be cputime64_t but not u64, just like as follows:

+static cputime64_t cpustat_curr_cputime(int cpu, int index)
+{
+	cputime64_t time;
+
+	if (index == CPUTIME_IDLE)
+		time = get_idle_time(cpu);
+	else if (index == CPUTIME_IOWAIT)
+		time = get_iowait_time(cpu);

I don't know if I understand it correctly. Looking forward to your answer.




On 2019/8/20 19:04, Peter Zijlstra wrote:
> On Mon, Aug 19, 2019 at 03:12:24PM +0800, c00423981 wrote:
>> +static u64 cpustat_curr_cputime(int cpu, int index)
>> +{
>> +	u64 time;
>> +
>> +	if (index == CPUTIME_IDLE)
>> +		time = get_idle_time(cpu);
>> +	else if (index == CPUTIME_IOWAIT)
>> +		time = get_iowait_time(cpu);
> 
> NAK; don't add new users of this terminally broken interface.
> 
> 

