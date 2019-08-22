Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4BDC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AE422D6D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfHVBpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:45:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfHVBpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:45:05 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8E1A0A1C88A3041707B7;
        Thu, 22 Aug 2019 09:45:02 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.182) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 09:44:53 +0800
Subject: Re: [RFC PATCH 3/3] perf report: add --spe options for arm-spe
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
        Kim Phillips <Kim.Phillips@arm.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-4-git-send-email-tanxiaojun@huawei.com>
 <8e8deead-6d59-9203-a01a-fe63362ebdf0@arm.com>
From:   Tan Xiaojun <tanxiaojun@huawei.com>
Message-ID: <184ef2f7-654c-4f24-952b-37cfa3681387@huawei.com>
Date:   Thu, 22 Aug 2019 09:44:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <8e8deead-6d59-9203-a01a-fe63362ebdf0@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.215.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/21 20:38, James Clark wrote:
> Hi,
> 
> I also had a look at this and had a question about the --spe option.
> It seems that whatever options I give it, the output is the same:
> 
> 	perf report 
> And
> 	perf report --spe=t
> 
> Both give the same result:
> 
> 	# Samples: 4  of event 'llc-miss'
> 	# Event count (approx.): 4
> 	#
> 	# Children      Self  Command  Shared Object      Symbol                    
> 	# ........  ........  .......  .................  ..........................
> 	#
> 	...
> 	# Samples: 0  of event 'tlb-miss'
> 	# Event count (approx.): 0
> 	#
> 	# Children      Self  Command  Shared Object  Symbol
> 	# ........  ........  .......  .............  ......
> 	#
> 
> 	# Samples: 83  of event 'branch-miss'
> 	# Event count (approx.): 83
> 	#
> 	# Children      Self  Command  Shared Object      Symbol                   
> 	# ........  ........  .......  .................  .........................
> 	#
> 	...
> 
> I would have expected it to not include the branch and LLC sections for the second
> command with --spe=t.
> 

Hi,

Sorry, this should be a bug in my code.

> And that leads me to another point. Does it make sense to have this option as a post
> processing step? SPE already has support for filtering events at collection time with
> the PMSFCR_EL1 register.
> 
> Should we try to make the interface more like PEBS, where you specify which events you
> are interested in doing precise tracing on like this?
> 
> 	perf record -e branch-misses:pp
> 
> And then perf could use the modifier to configure SPE so that it only records branch
> misses? The benefits of this would be keeping the user interface for precise tracing
> similar between platforms.
> 

Good suggestion. And I need to spend some time thinking about how to implement it.

Thank you for your reply.
Xiaojun.

> Thanks
> James
> 
> On 02/08/2019 10:40, Tan Xiaojun wrote:
>> The previous patch added support in "perf report" for some arm-spe
>> events(llc-miss, tlb-miss, branch-miss). This patch adds their help
>> instructions.
>>
>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>> ---
>>  tools/perf/Documentation/perf-report.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
>> index 987261d..d998d4b 100644
>> --- a/tools/perf/Documentation/perf-report.txt
>> +++ b/tools/perf/Documentation/perf-report.txt
>> @@ -445,6 +445,15 @@ include::itrace.txt[]
>>  
>>  	To disable decoding entirely, use --no-itrace.
>>  
>> +--spe::
>> +	Options for decoding arm-spe tracing data. The options are:
>> +
>> +		l	synthesize llc miss events
>> +		t	synthesize tlb miss events
>> +		b	synthesize branch miss events
>> +
>> +	The default is all events i.e. the same as --spe=ltb
>> +
>>  --full-source-path::
>>  	Show the full path for source files for srcline output.
>>  
>>


