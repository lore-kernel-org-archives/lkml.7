Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79091C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F5220850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfDJOPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:15:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:51298 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbfDJOPl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:15:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 07:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="222238048"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.213.211]) ([10.254.213.211])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2019 07:15:37 -0700
Subject: Re: [PATCH v3 1/4] perf: Add a 'percore' event qualifier
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
 <1552985816-20915-2-git-send-email-yao.jin@linux.intel.com>
 <20190410123641.GA13888@kernel.org> <20190410125431.GC13888@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <5c9322d4-e467-12a4-c01c-a0c2f68fa6bf@linux.intel.com>
Date:   Wed, 10 Apr 2019 22:15:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410125431.GC13888@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2019 8:54 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 10, 2019 at 09:36:41AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Tue, Mar 19, 2019 at 04:56:53PM +0800, Jin Yao escreveu:
>>> Add a 'percore' event qualifier, like cpu/event=0,umask=0x3,percore=1/,
>>> that sums up the event counts for both hardware threads in a core.
>>>
>>> We can already do this with --per-core, but it's often useful to do
>>> this together with other metrics that are collected per hardware thread.
>>> So we need to support this per-core counting on a event level.
>>>
>>> This can be implemented in only the user tool, no kernel support needed.
>>>
>>>   v3:
>>>   ---
>>>   Simplify the code according to Jiri's comments.
>>>   Before:
>>>     "return term->val.percore ? true : false;"
>>>   Now:
>>>     "return term->val.percore;"
>>>
>>>   v2:
>>>   ---
>>>   Change the qualifier name from 'coresum' to 'percore' according to
>>>   comments from Jiri and Andi.
>>
>> I'm applying this, but please, don't forget to, when adding a new
>> qualifier, to update the documentation... I'm doing this for you this
>> time.
> 
> The first patch didn't apply with 'git am', I did it manually, and added
> the patch below
> 
> But then the second doesn't apply to my perf/core branch as well, please
> refresh and resend a v4, thanks.
> 
> - Arnaldo
> 

Thanks Arnaldo! I will rebase the patch to latest perf/core branch and 
then send v4.

Thanks
Jin Yao

> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 138fb6e94b3c..18ed1b0fceb3 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -199,6 +199,18 @@ also be supplied. For example:
>   
>     perf stat -C 0 -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
>   
> +EVENT QUALIFIERS:
> +
> +It is also possible to add extra qualifiers to an event:
> +
> +percore:
> +
> +Sums up the event counts for all hardware threads in a core, e.g.:
> +
> +
> +  perf stat -e cpu/event=0,umask=0x3,percore=1/
> +
> +
>   EVENT GROUPS
>   ------------
>   
> 
