Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BDACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A320221928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407143AbfJWQQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:16:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:21240 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404332AbfJWQQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:16:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 09:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="210087290"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2019 09:16:17 -0700
Received: from [10.249.230.188] (abudanko-mobl.ccr.corp.intel.com [10.249.230.188])
        by linux.intel.com (Postfix) with ESMTP id 1899B580107;
        Wed, 23 Oct 2019 09:16:14 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] perf affinity: Add infrastructure to save/restore
 affinity
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <andi@firstfloor.org>,
        acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com, peterz@infradead.org
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-5-andi@firstfloor.org> <20191023095911.GJ22919@krava>
 <20191023130235.GF4660@tassilo.jf.intel.com> <20191023143049.GS22919@krava>
 <20191023145206.GH4660@tassilo.jf.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6ac1024c-bc73-87cd-31d2-819abee60137@linux.intel.com>
Date:   Wed, 23 Oct 2019 19:16:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023145206.GH4660@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.10.2019 17:52, Andi Kleen wrote:
> On Wed, Oct 23, 2019 at 04:30:49PM +0200, Jiri Olsa wrote:
>> On Wed, Oct 23, 2019 at 06:02:35AM -0700, Andi Kleen wrote:
>>> On Wed, Oct 23, 2019 at 11:59:11AM +0200, Jiri Olsa wrote:
>>>> On Sun, Oct 20, 2019 at 10:51:57AM -0700, Andi Kleen wrote:
>>>>
>>>> SNIP
>>>>
>>>>> +}
>>>>> diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
>>>>> new file mode 100644
>>>>> index 000000000000..e56148607e33
>>>>> --- /dev/null
>>>>> +++ b/tools/perf/util/affinity.h
>>>>> @@ -0,0 +1,15 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +#ifndef AFFINITY_H
>>>>> +#define AFFINITY_H 1
>>>>> +
>>>>> +struct affinity {
>>>>> +	unsigned char *orig_cpus;
>>>>> +	unsigned char *sched_cpus;
>>>>
>>>> why not use cpu_set_t directly?
>>>
>>> Because it's too small in glibc (only 1024 CPUs) and perf already 
>>> supports more.
>>
>> nice, we're using it all over the place.. how about using bitmap_alloc?
> 
> Okay.
> 
> The other places is mainly perf record from Alexey's recent affinity changes.
> These probably need to be fixed.
> 
> +Alexey

Despite the issue indeed looks generic for stat and record modes,
have you already observed record startup overhead somewhere in your setups?
I would, first, prefer to reproduce the overhead, to have stable use case 
for evaluation and then, possibly, improvement.

~Alexey
