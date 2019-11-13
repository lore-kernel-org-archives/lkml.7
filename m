Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABD5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260D221D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfKMKp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:45:58 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2093 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfKMKp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:45:58 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E888C4C444F589C77A84;
        Wed, 13 Nov 2019 10:45:56 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Nov 2019 10:45:56 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 10:45:55 +0000
Subject: Re: [QUESTION]perf stat: comment of miss ratio
To:     Andi Kleen <ak@linux.intel.com>,
        "liuqi (BA)" <liuqi115@hisilicon.com>
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
        linyunsheng <linyunsheng@huawei.com>
References: <F57F094935A66448B135517D3F6EA397F35063@DGGEMA504-MBS.china.huawei.com>
 <20191109024754.GA573472@tassilo.jf.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <71f30f49-d8b4-abff-9f75-674dcbb7fad0@huawei.com>
Date:   Wed, 13 Nov 2019 10:45:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191109024754.GA573472@tassilo.jf.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2019 02:47, Andi Kleen wrote:
>>     Relevant code is checked to make sure that the ratio is calculated by
>>
>>     L1-dcache-load-misses/L1-dcache-loads, data "7.58%=30249/399189*100%" also
>>
>>     proves this conclusion.
>>
>>     So, I'm not sure why we use "of all L1-dcache hits" here to describe miss
>>     ratio,
> 
> Yes you're right it should be "of all L1-dcache accesses"
> 
> Please send a patch to fix the string and also check if this isn't wrong with some other
> ratio too.
> 

"    399,189      L1-dcache-loads           #  246.396 M/sec
      30,249      L1-dcache-load-misses     #    7.58% of all L1-dcache 
hits    (18.04%)"


If accesses and loads are equivalent, could we use consistent terminology?

Thanks,
John
