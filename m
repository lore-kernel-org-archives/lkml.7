Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1255C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 07:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0722146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 07:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLBHHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 02:07:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfLBHHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 02:07:55 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 675DD3D046B9D697FAD3;
        Mon,  2 Dec 2019 15:07:49 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 15:07:41 +0800
Subject: Re: [RFC v3 0/5] perf tools: Add support for some spe events and
 precise ip
To:     Tan Xiaojun <tanxiaojun@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>, <James.Clark@arm.com>,
        <jeremy.linton@arm.com>
References: <20191123101118.12635-1-tanxiaojun@huawei.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <huawei.libin@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
From:   Qi Liu <liuqi115@hisilicon.com>
Message-ID: <07717318-ddab-e57d-e356-52dff683ac76@hisilicon.com>
Date:   Mon, 2 Dec 2019 15:07:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191123101118.12635-1-tanxiaojun@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tested-by: Qi Liu <liuqi115@hisilicon.com>


On 2019/11/23 18:11, Tan Xiaojun wrote:
> After the commit ffd3d18c20b8 ("perf tools: Add ARM Statistical
> Profiling Extensions (SPE) support") is merged, "perf record" and
> "perf report --dump-raw-trace" have been supported. However, the
> raw data that is dumped cannot be used without parsing.
> 
> This patchset is to improve the "perf report" support for spe, and
> further process the data. Currently, support for the three events
> of llc-miss, tlb-miss, branch-miss and remote-access is added.
> 
> v1->v2:
> Some cleanup and bugfix fixes were made, and support for the precise
> ip of branch-misses was added. Thanks for the suggestions of Jeremy
> and James.
> 
> v2->v3:
> Mainly add four spe precise ip events, you can see through perf list.
> More details in [5/5].
> 
> Tan Xiaojun (5):
>   perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
>   perf tools: Add support for "report" for some spe events
>   perf report: Add --spe options for arm-spe
>   drivers: perf: add some arm spe events
>   perf tools: Add support to process multi spe events
> 
>  drivers/perf/arm_spe_pmu.c                    |  44 +
>  tools/perf/Documentation/perf-report.txt      |  10 +
>  tools/perf/arch/arm64/util/arm-spe.c          |  47 +-
>  tools/perf/builtin-report.c                   |   5 +
>  tools/perf/util/Build                         |   2 +-
>  tools/perf/util/arm-spe-decoder/Build         |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 +++++
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
>  .../arm-spe-pkt-decoder.c                     |   0
>  .../arm-spe-pkt-decoder.h                     |   2 +
>  tools/perf/util/arm-spe.c                     | 771 +++++++++++++++++-
>  tools/perf/util/arm-spe.h                     |  20 +
>  tools/perf/util/auxtrace.c                    |  49 ++
>  tools/perf/util/auxtrace.h                    |  29 +
>  tools/perf/util/session.h                     |   2 +
>  15 files changed, 1231 insertions(+), 42 deletions(-)
>  create mode 100644 tools/perf/util/arm-spe-decoder/Build
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)
> 

