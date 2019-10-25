Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED5CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA52166E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbfJYCnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:43:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40876 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728416AbfJYCnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:43:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE9FAA2158D1DA85FDC8;
        Fri, 25 Oct 2019 10:43:03 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.182) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 10:42:54 +0800
Subject: Re: [RFC v2 4/4] perf tools: Support "branch-misses:pp" on arm64
To:     James Clark <James.Clark@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@arm.com>,
        "Jeremy Linton" <Jeremy.Linton@arm.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>
References: <20191024144830.16534-1-tanxiaojun@huawei.com>
 <20191024144830.16534-5-tanxiaojun@huawei.com>
 <AM4PR0802MB224263700592195B3BAE9D5AE26A0@AM4PR0802MB2242.eurprd08.prod.outlook.com>
From:   Tan Xiaojun <tanxiaojun@huawei.com>
Message-ID: <38c18a3e-1b9a-05fe-63f6-920af2f53fc7@huawei.com>
Date:   Fri, 25 Oct 2019 10:42:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <AM4PR0802MB224263700592195B3BAE9D5AE26A0@AM4PR0802MB2242.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.215.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/25 0:29, James Clark wrote:
> Hi Xiaojun,
> 
> This looks really good. I tried this, but got an error:
> 
>     ./perf record -e branch-misses:p ls
>     Error:
>     The branch-misses:p event is not supported.

Hi, James,

I can't reproduce this problem. If the current system doesn't support spe, it shouldn't report an error. I use the latest codes of the mainline:

commit f116b96685a046a89c25d4a6ba2da489145c8888 (mainline/master)
Merge: f632bfaa33ed 603d9299da32
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Oct 24 06:13:45 2019 -0400

    Merge tag 'mfd-fixes-5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd

I will go and see why this will be reported.

> 
> 
> I would have expected to use the event name that is listed in the SPE documentation for branch misses which is br_mis_pred or br_mis_pred_retired:
> 
>     E[7], byte 0 bit [7]
>     Mispredicted. The defined values of this bit are:
>     0 Did not cause correction to the predicted program flow.
>     1 A branch that caused a correction to the predicted program flow.
> 
>     If PMUv3 is implemented this Event is required to be implemented consistently with either BR_MIS_PRED or BR_MIS_PRED_RETIRED.
> 

Do you mean that I can add these as new events to perf? If we think of them as new events, what should we do if the user does not add :pp for them?
(Or for these events, users can only add :pp to use them?)

> 
> +       if (!strcmp(perf_env__arch(evlist->env), "arm64")
> +                       && evsel->core.attr.config == PERF_COUNT_HW_BRANCH_MISSES
> +                       && evsel->core.attr.precise_ip) {
> 
> As I mentioned above PERF_COUNT_HW_BRANCH_MISSESdoesn't seem to match up with the actual event counter that is associated with this SPE event (BR_MIS_PRED). The fix for this is probably as simple as adding an OR for the other aliases for branch mispredicts.

What you mean is that we can filter with spe events(like BR_MIS_PRED) first, and if we have other events that are exactly the same(no more for now), then we can handle them by adding OR in the future?

> 
> +               pmu = perf_pmu__find("arm_spe_0");
> +               if (pmu) {
> +                       evsel->pmu_name = pmu->name;
> +                       evsel->core.attr.type = PERF_RECORD_AUXTRACE;
> +                       evsel->core.attr.config = SPE_ATTR_TS_ENABLE
> +                                               | SPE_ATTR_PA_ENABLE
> 
> I wouldn't set physical addresses by default as this requires root. I would leave that to the user if they want to manually configure SPE.

Yes. You are right. I got a error for this case. I will fix it.

------------------
./perf record -e branch-misses:p ls
Error:
You may not have permission to collect stats.
...
------------------

Thanks.
Xiaojun.

> 
> I have only looked briefly and I will do some more testing.
> 
> 
> Thanks
> James
> 
> 


