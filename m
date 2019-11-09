Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED52C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A613F20865
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfKIDTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:19:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbfKIDTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:19:39 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ABAD68DB13AE377A856F;
        Sat,  9 Nov 2019 11:19:36 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 11:19:30 +0800
Subject: Re: [QUESTION]perf stat: comment of miss ratio
To:     Andi Kleen <ak@linux.intel.com>
References: <F57F094935A66448B135517D3F6EA397F35063@DGGEMA504-MBS.china.huawei.com>
 <20191109024754.GA573472@tassilo.jf.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        huangdaode <huangdaode@hisilicon.com>,
        linyunsheng <linyunsheng@huawei.com>,
        John Garry <john.garry@huawei.com>
From:   Qi Liu <liuqi115@hisilicon.com>
Message-ID: <b7e93eb7-2ef9-1448-c4ca-7495bc934b32@hisilicon.com>
Date:   Sat, 9 Nov 2019 11:19:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191109024754.GA573472@tassilo.jf.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/9 10:47, Andi Kleen wrote:
>>    Relevant code is checked to make sure that the ratio is calculated by
>>
>>    L1-dcache-load-misses/L1-dcache-loads, data "7.58%=30249/399189*100%" also
>>
>>    proves this conclusion.
>>
>>    So, I'm not sure why we use "of all L1-dcache hits" here to describe miss
>>    ratio,
> 
> Yes you're right it should be "of all L1-dcache accesses"
> 
> Please send a patch to fix the string and also check if this isn't wrong with some other
> ratio too.
> 
> -Andi
> 
> .
> 
Hi Andi:
Thanks for your reply firstly.
I check the code and find that "of all...hits" is also used to describe miss ratio of
L1-icache, dTLB cache, iTLB cache, LL-cache. Relevant code as follow:

stat-shadow.c:509:      out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
stat-shadow.c:530:      out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
stat-shadow.c:550:      out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
stat-shadow.c:570:      out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
stat-shadow.c:590:      out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
stat-shadow.c:875:                      print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
stat-shadow.c:885:                      print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
stat-shadow.c:895:                      print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
stat-shadow.c:905:                      print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
stat-shadow.c:915:                      print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);

So, may I send a patch to fix all these strings?

Thanks,
liuqi


