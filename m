Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0668C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CF52077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfDJSW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:22:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:20120 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727583AbfDJSWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:22:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 11:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="139179444"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2019 11:22:23 -0700
Received: from [10.251.26.102] (kliang2-mobl.ccr.corp.intel.com [10.251.26.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D47E0580310;
        Wed, 10 Apr 2019 11:22:22 -0700 (PDT)
Subject: Re: [PATCH V5 08/12] perf/x86/intel: Add Icelake support
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190402194509.2832-9-kan.liang@linux.intel.com>
 <20190408150654.GV12232@hirez.programming.kicks-ass.net>
 <4ff8fec9-fb41-b11d-b7ed-4c716b558adc@linux.intel.com>
Message-ID: <688804aa-b6eb-0f19-828c-99b901bbe554@linux.intel.com>
Date:   Wed, 10 Apr 2019 14:22:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4ff8fec9-fb41-b11d-b7ed-4c716b558adc@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2019 11:45 AM, Liang, Kan wrote:
> 
> 
> On 4/8/2019 11:06 AM, Peter Zijlstra wrote:
>> On Tue, Apr 02, 2019 at 12:45:05PM -0700, kan.liang@linux.intel.com 
>> wrote:
>>> +static struct event_constraint *
>>> +icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>> +              struct perf_event *event)
>>> +{
>>> +    /*
>>> +     * Fixed counter 0 has less skid.
>>> +     * Force instruction:ppp in Fixed counter 0
>>> +     */
>>> +    if ((event->attr.precise_ip == 3) &&
>>> +        ((event->hw.config & X86_RAW_EVENT_MASK) == 0x00c0))
>>> +        return &fixed_counter0_constraint;
>>
>> Does that want to be:
>>
>>         event->hw.config == X86_CONFIG(.event=0xc0)
>>
>> ?
>>
>> That is, are there really bits we want to mask in there?
> 
> For instruction event, right, we don't need mask it.
> I will change it.
> 

Actually, we have to mask some bits here, e.g. 
ARCH_PERFMON_EVENTSEL_INT, ARCH_PERFMON_EVENTSEL_USR and 
ARCH_PERFMON_EVENTSEL_OS. Those bits will be set in hw_config().

Also, other filds, e.g the INV, ANY, E, or CMASK fields are not allowed 
for reduced Skid PEBS.


diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dae3d84..3fa36c9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3463,6 +3463,9 @@ hsw_get_event_constraints(struct cpu_hw_events 
*cpuc, int idx,
  	return c;
  }

+#define EVENT_CONFIG(config)		\
+	(config & (X86_ALL_EVENT_FLAGS | INTEL_ARCH_EVENT_MASK))
+
  static struct event_constraint *
  icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
  			  struct perf_event *event)
@@ -3472,7 +3475,7 @@ icl_get_event_constraints(struct cpu_hw_events 
*cpuc, int idx,
  	 * Force instruction:ppp in Fixed counter 0
  	 */
  	if ((event->attr.precise_ip == 3) &&
-	    (event->hw.config == X86_CONFIG(.event=0xc0)))
+	    (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0)))
  		return &fixed_counter0_constraint;

  	return hsw_get_event_constraints(cpuc, idx, event);

Thanks,
Kan
