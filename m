Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8405A218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCOXHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:07:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:20128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfCOXHV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:07:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 16:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="155476113"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.211.155]) ([10.254.211.155])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2019 16:07:18 -0700
Subject: Re: [PATCH v1 0/3] perf: Support a new coresum event qualifier
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
 <20190315133443.GA5200@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1d1d6263-9842-7d44-8edb-dcfbb5a2e6cc@linux.intel.com>
Date:   Sat, 16 Mar 2019 07:07:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190315133443.GA5200@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2019 9:34 PM, Jiri Olsa wrote:
> On Sat, Mar 16, 2019 at 12:04:13AM +0800, Jin Yao wrote:
>> The coresum event qualifier which sums up the event counts for both
>> hardware threads in a core. For example,
>>
>> perf stat -e cpu/event=0,umask=0x3,coresum=1/,cpu/event=0,umask=0x3/
>>
>> In this example, we count the event 'ref-cycles' per-core and per-CPU in
>> one perf stat command-line.
>>
>> We can already support per-core counting with --per-core, but it's
>> often useful to do this together with other metrics that are collected
>> per CPU (per hardware thread). So this patch series supports this
>> per-core counting on a event level.
> 
> seems useful, but perhaps we should follow the --per-core option
> we already have and call it 'per-core' instead of coresum
> 
> jirka
> 

Yes, the coresum's behavior is similar as --per-core option, just 
supports at the event level. I'm OK with calling it 'per-core'.

For example,
perf stat -e cpu/event=0,umask=0x3,per-core=1/

Thanks
Jin Yao

>>
>> Jin Yao (3):
>>    perf: Add a coresum event qualifier
>>    perf stat: Support coresum event qualifier
>>    perf test: Add a simple test for term coresum
>>
>>   tools/perf/Documentation/perf-stat.txt |   4 ++
>>   tools/perf/builtin-stat.c              |  21 +++++++
>>   tools/perf/tests/parse-events.c        |  10 ++-
>>   tools/perf/util/evsel.c                |   2 +
>>   tools/perf/util/evsel.h                |   3 +
>>   tools/perf/util/parse-events.c         |  27 +++++++++
>>   tools/perf/util/parse-events.h         |   1 +
>>   tools/perf/util/parse-events.l         |   1 +
>>   tools/perf/util/stat-display.c         | 108 ++++++++++++++++++++++++---------
>>   tools/perf/util/stat.c                 |   8 ++-
>>   10 files changed, 151 insertions(+), 34 deletions(-)
>>
>> -- 
>> 2.7.4
>>
