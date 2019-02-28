Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E7D21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nsHDUH01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbfB1JnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:43:11 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14778 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1JnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:43:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c77ad370000>; Thu, 28 Feb 2019 01:43:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Feb 2019 01:43:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Feb 2019 01:43:10 -0800
Received: from [10.24.230.224] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Feb
 2019 09:43:06 +0000
Subject: Re: [PATCH] sched/cputime: Remove unnecessary assignment statement
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <snikam@nvidia.com>,
        <bnihalani@nvidia.com>, <byan@nvidia.com>,
        <sgurrappadi@nvidia.com>, <treding@nvidia.com>, <talho@nvidia.com>
References: <1551248002-27303-1-git-send-email-ketanp@nvidia.com>
 <20190227103230.GM32494@hirez.programming.kicks-ass.net>
From:   Ketan Patil <ketanp@nvidia.com>
X-Nvconfidentiality: Public
Message-ID: <9bce6378-2221-f358-dc97-f15ee7ab546b@nvidia.com>
Date:   Thu, 28 Feb 2019 15:12:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227103230.GM32494@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551346999; bh=hmVqqkIuaRpOxFpQRZZp/ZZZRrKqSJXrAOIwDCjT8MM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=nsHDUH01bim0Rq33rcGduYBI4N6fpqAJsfPmyDCe6eEk2SAmF2peGkVvsEgrwRTQW
         h+uWCqEWC6dAPhqGUTZ86uI2sDCdFSBbbG0rvETdCoL2o7g9CTjnPmVg1j8au5y/6a
         3yRZ1/1+NnDPBbG9XGaIX3heRSN7tA1e7ZkcG2+GdSehPrsO0T7Gy1OpdiQ3G+4hp+
         yIDOGPsdzIqWZu5elX24IvYmikjApah8S4ZZV+ygYlVddnxYB0xx5yT0XZ221dTM/0
         prlrTxvTNnlpsv0YOkn0wcznGwO91c+ftW2C4blTH1IHtO8EUpSfLt70oC8AeWb4l1
         fg6KfEtCgctKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coverity tool has detected this issue as an unused value, since

the code assigns the value to utime variable and then after the jump, the

value of utime again gets updated, hence the previous value is not at all

useful and this patch removes that first assignment.

On 27/02/19 4:02 PM, Peter Zijlstra wrote:
> On Wed, Feb 27, 2019 at 11:43:22AM +0530, Ketan Patil wrote:
>> The original code assigns the value from rtime to utime variable,
>> and then jumps to the update label. And the value of utime is then
>> updated, so the earlier value of utime is not used. Hence remove
>> that unnecessary assignment statement.
>>
>> This fixes one of the coverity defects.
> Why does coverity care? I like the way the code is now, it makes
> conceptual sense. Removing that assignment makes the code harder to read
> and less symmetric (see the utime case right below).
>
> Any sensible compiler will 'fix' this for us anyway.
>
>> Based on work by Ishan Mittal <imittal@nvidia.com>
>> Signed-off-by: Ketan Patil <ketanp@nvidia.com>
>> ---
>>   kernel/sched/cputime.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
>> index ba4a143..ad64771 100644
>> --- a/kernel/sched/cputime.c
>> +++ b/kernel/sched/cputime.c
>> @@ -616,10 +616,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>>   	 * Once a task gets some ticks, the monotonicy code at 'update:'
>>   	 * will ensure things converge to the observed ratio.
>>   	 */
>> -	if (stime == 0) {
>> -		utime = rtime;
>> +	if (stime == 0)
>>   		goto update;
>> -	}
>>   
>>   	if (utime == 0) {
>>   		stime = rtime;
