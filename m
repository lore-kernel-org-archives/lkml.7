Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427DC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF2F2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfDQG4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:56:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:3634 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730691AbfDQG4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:56:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 23:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="165437887"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2019 23:56:43 -0700
Subject: Re: [PATCH 11/12] perf tools: Reuse shared eBPF dso objects
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-12-jolsa@kernel.org>
 <746f02e3-a509-5081-8427-b610e52c1fb0@intel.com>
 <20190417065127.GA17024@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ed2f881b-c1b2-e6da-5c23-fc1eb4db131f@intel.com>
Date:   Wed, 17 Apr 2019 09:55:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417065127.GA17024@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/19 9:51 AM, Jiri Olsa wrote:
> On Wed, Apr 17, 2019 at 09:35:32AM +0300, Adrian Hunter wrote:
>> On 16/04/19 7:01 PM, Jiri Olsa wrote:
>>> The eBPF program can be loaded multiple times
>>> with the same name (tag). We can share dso
>>> objects for those programs.
>>
>> Doesn't a eBPF program get recompiled differently every time it is loaded?
> 
> yes, but those with same tag are identical

But won't recompiled eBPF programs be different due to blinded constants?
Or perhaps in the future other code randomization?

> 
> jirka
> 
>>
>>>
>>> Link: http://lkml.kernel.org/n/tip-3damf8vq1dryhtpbk5b06jpt@git.kernel.org
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>  tools/perf/util/machine.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>>> index d4aa44489011..a60653827891 100644
>>> --- a/tools/perf/util/machine.c
>>> +++ b/tools/perf/util/machine.c
>>> @@ -23,6 +23,7 @@
>>>  #include "linux/hash.h"
>>>  #include "asm/bug.h"
>>>  #include "bpf-event.h"
>>> +#include "dso.h"
>>>  
>>>  #include "sane_ctype.h"
>>>  #include <symbol/kallsyms.h>
>>> @@ -699,11 +700,18 @@ static int machine__process_ksymbol_register(struct machine *machine,
>>>  
>>>  	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
>>>  	if (!map) {
>>> -		map = dso__new_map(event->ksymbol_event.name);
>>> -		if (!map)
>>> +		struct dso *dso;
>>> +
>>> +		dso = dsos__findnew(&machine->dsos, event->ksymbol_event.name);
>>> +		if (!dso)
>>>  			return -ENOMEM;
>>>  
>>> -		map->start = event->ksymbol_event.addr;
>>> +		map = map__new2(event->ksymbol_event.addr, dso);
>>> +		if (!map) {
>>> +			dso__put(dso);
>>> +			return -ENOMEM;
>>> +		}
>>> +
>>>  		map->end = map->start + event->ksymbol_event.len;
>>>  		map_groups__insert(&machine->kmaps, map);
>>>  	}
>>>
>>
> 

