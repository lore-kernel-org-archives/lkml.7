Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EC4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8052148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDHWti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:49:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:59932 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfDHWti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:49:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 15:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="289856923"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2019 15:49:37 -0700
Received: from [10.254.87.204] (kliang2-mobl.ccr.corp.intel.com [10.254.87.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 83FB15807AA;
        Mon,  8 Apr 2019 15:49:36 -0700 (PDT)
Subject: Re: [PATCH V5 00/12] perf: Add Icelake support (kernel only, except
 Topdown)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190408154112.GW12232@hirez.programming.kicks-ass.net>
 <ec9e3a07-4b29-b698-83d7-5b8bbcd48dc4@linux.intel.com>
Message-ID: <02e4ddaf-b5a0-a2cb-b829-5720f0bb10d4@linux.intel.com>
Date:   Mon, 8 Apr 2019 18:49:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ec9e3a07-4b29-b698-83d7-5b8bbcd48dc4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2019 12:06 PM, Liang, Kan wrote:
> @@ -1875,7 +1868,7 @@ static void intel_pmu_drain_pebs_nhm(str
>            counts[bit]++;
>        }
> -    for (bit = 0; bit < size; bit++) {
> +    for_each_set_bit(bit, (unsigned long *)&mask, size) {
>            if ((counts[bit] == 0) && (error[bit] == 0))
>                continue;
> @@ -1939,7 +1932,7 @@ static void intel_pmu_drain_pebs_icl(str
>                counts[bit]++;
>        }
> -    for (bit = 0; bit < size; bit++) {
> +    for_each_set_bit(bit, (unsigned long *)mask, size) {
>            if (counts[bit] == 0)
>                continue;

I have finished the tests for the changes. There is one more regression 
found by another typo on ICL.

Should be "for_each_set_bit(bit, (unsigned long *)&mask, size) {"

Thanks,
Kan
