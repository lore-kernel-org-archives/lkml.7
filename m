Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2351C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7106E2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfDJCcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:32:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:51914 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfDJCcP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:32:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 19:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="162914179"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.62]) ([10.239.196.62])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2019 19:32:12 -0700
Subject: Re: [PATCH v3 0/4] perf: Support a new 'percore' event qualifier
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
 <20190319102025.GA20602@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <56d48bbb-456d-b62f-bda8-a6e84b1632f9@linux.intel.com>
Date:   Wed, 10 Apr 2019 10:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190319102025.GA20602@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Can this patch be accepted?

Thanks
Jin Yao

On 3/19/2019 6:20 PM, Jiri Olsa wrote:
> On Tue, Mar 19, 2019 at 04:56:52PM +0800, Jin Yao wrote:
>> The 'percore' event qualifier which sums up the event counts for both
>> hardware threads in a core. For example,
>>
>> perf stat -e cpu/event=0,umask=0x3,percore=1/,cpu/event=0,umask=0x3/
>>
>> In this example, we count the event 'ref-cycles' per-core and per-CPU in
>> one perf stat command-line.
>>
>> We can already support per-core counting with --per-core, but it's
>> often useful to do this together with other metrics that are collected
>> per CPU (per hardware thread). So this patch series supports this
>> per-core counting on a event level.
>>
>>   v3:
>>   ---
>>   Simplify the patch: "perf: Add a 'percore' event qualifier"
>>   Other patches don't have changes.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
>>
>>   v2:
>>   ---
>>   1. Change 'coresum' to 'percore'.
>>   2. Move the aggregate counts printing to a seperate patch.
>>
>> Jin Yao (4):
>>    perf: Add a 'percore' event qualifier
>>    perf stat: Factor out aggregate counts printing
>>    perf stat: Support 'percore' event qualifier
>>    perf test: Add a simple test for term 'percore'
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
