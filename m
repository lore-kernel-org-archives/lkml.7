Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA1CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CE9222D3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfKDJSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:18:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727138AbfKDJSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:18:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9CEA40EDF38CDC4749A;
        Mon,  4 Nov 2019 17:18:09 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 17:18:00 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [RFC] About perf-mem command support on arm64 platform
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, <liuqi115@hisilicon.com>,
        <huangdaode@hisilicon.com>, <john.garry@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <74f8ddb5-13cc-5dce-82a6-ca8bd02f8175@hisilicon.com>
Date:   Mon, 4 Nov 2019 17:18:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

perf-mem is used to profile memory access which has been implemented on x86
platform. It needs mem-stores events and mem-loads/load-latency.
For mem-stores events, it is MEM_INST_RETIRED_ALL_STORES whose raw number
is r82d0, and mem-loads/load-latency is from PEBS if I follow its code.

Now, for some arm64 cores, like HiSilicon's tsv110 and ARM's Neoverse N1,
has supported the SPE(Statistical Profiling Extensions), so is it a
possibility that perf-mem is supported on arm64?
https://developer.arm.com/ip-products/processors/neoverse/neoverse-n1

For arm64 PMU, it has 'st_retired' event that the event number is 0x0007
which is equal to mem-stores on x86, if we want support perf-mem, it seems
that 'st_retired' shall be replaced by 'mem-stores'
in arch/arm64/kernel/perf_event.c file. Of course, the cpu core should
support st_retired event. I'm not sure Will/Mark are happy on this.;-)

For mem-loads/load-latency, we can derive them from SPE sampled data which
supports by load_filter and min_latency in SPE driver. and we may do some
work on tools/perf/builtin-mem.c.

From the above conditions, it seems that we may have the opportunity to
support the perf-mem command on arm64.
I'm not very sure about it, so I send this RFC and any comments are welcome.

Thanks,
Shaokun


