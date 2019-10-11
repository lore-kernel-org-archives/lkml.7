Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2344C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 02:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2C1214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 02:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfJKCuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 22:50:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:51685 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfJKCui (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 22:50:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 19:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="224193678"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.78]) ([10.239.196.78])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2019 19:50:35 -0700
Subject: Re: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
 <20190929151022.GA16309@krava> <20190930182136.GD8560@tassilo.jf.intel.com>
 <20190930192800.GA13904@kernel.org>
 <20191001021755.GF8560@tassilo.jf.intel.com>
 <8a1cbcf6-2de7-3036-1c86-f3af6af077e2@linux.intel.com>
 <20191010080052.GB9616@krava>
 <9df9e60f-4998-32f2-f743-ebb0fdea4c0a@linux.intel.com>
 <20191010123309.GB19434@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <03b5fffb-fedf-19e6-5a23-bcf2bbf4ef98@linux.intel.com>
Date:   Fri, 11 Oct 2019 10:50:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010123309.GB19434@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2019 8:33 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 10, 2019 at 04:33:57PM +0800, Jin, Yao escreveu:
>>
>>
>> On 10/10/2019 4:00 PM, Jiri Olsa wrote:
>>> On Thu, Oct 10, 2019 at 02:46:36PM +0800, Jin, Yao wrote:
>>>>
>>>>
>>>> On 10/1/2019 10:17 AM, Andi Kleen wrote:
>>>>>>> I think it's useful. Makes it easy to do kernel/user break downs.
>>>>>>> perf record should support the same.
>>>>>>
>>>>>> Don't we have this already with:
>>>>>>
>>>>>> [root@quaco ~]# perf stat -e cycles:u,instructions:u,cycles:k,instructions:k -a -- sleep 1
>>>>>
>>>>> This only works for simple cases. Try it for --topdown or multiple -M metrics.
>>>>>
>>>>> -Andi
>>>>>
>>>>
>>>> Hi Arnaldo, Jiri,
>>>>
>>>> We think it should be very useful if --all-user / --all-kernel can be
>>>> specified together, so that we can get a break down between user and kernel
>>>> easily.
>>>>
>>>> But yes, the patches for supporting this new semantics is much complicated
>>>> than the patch which just follows original perf-record behavior. I fully
>>>> understand this concern.
>>>>
>>>> So if this new semantics can be accepted, that would be very good. But if
>>>> you think the new semantics is too complicated, I'm also fine for posting a
>>>> new patch which just follows the perf-record behavior.
>>>
>>> I still need to think a bit more about this.. did you consider
>>> other options like cloning of the perf_evlist/perf_evsel and
>>> changing just the exclude* bits? might be event worse actualy ;-)
>>>
>>
>> That should be another approach, but it might be a bit more complicated than
>> just appending ":u"/":k" modifiers to the event name string.
>>
>>> or maybe if we add modifier we could add extra events/groups
>>> within the parser.. like:
>>>
>>>     "{cycles,instructions}:A,{cache-misses,cache-references}:A,cycles:A"
>>>
>>> but that might be still more complicated then what you did
>>>
>>
>> Yes agree.
>>
>>> also please add the perf record changes so we have same code
>>> and logic for both if we are going to change it
>   
>> If this new semantics can be accepted, I'd like to add perf record
>> supporting as well. :)
> 
> Changes in semantics should be avoided, when we add an option already
> present in some other tool, we should strive to keep the semantics, so
> that people can reuse their knowledge and just switch tools to go from
> sampling to counting, say.
>

Yes, that makes sense. We need to try our best to keep the original 
semantics. I will post a patch for perf-stat which just follows the 
semantics in perf-record.

> So if at all possible, and without having really looked deep in this
> specific case, I would prefer that new semantics come with a new syntax,
> would that be possible?
> 

Yes, that's possible. Maybe we can use a new option for automatically 
adding two copies of the events (one copy for user and the other copy 
for kernel). The option something like "--all-space"?

Thanks
Jin Yao

> - Arnaldo
>   



>> Another difficulty for the new semantics is we need to create user and
>> kernel stat type in runtime_stat rblist (see patch "perf stat: Support
>> topdown with --all-kernel/--all-user"). That has to bring extra complexity.
>>
>> Thanks
>> Jin Yao
>>
>>> jirka
>>>
> 
