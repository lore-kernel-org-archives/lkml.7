Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B71CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F172070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408099AbfJYMVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:21:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:13927 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404706AbfJYMVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:21:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 05:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="223904396"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 05:21:14 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2 1/4] perf: Allow using AUX data in perf samples
In-Reply-To: <20191024140624.GG4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com> <20191022095812.67071-2-alexander.shishkin@linux.intel.com> <20191024140624.GG4114@hirez.programming.kicks-ass.net>
Date:   Fri, 25 Oct 2019 15:21:13 +0300
Message-ID: <878sp9ggna.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

>> @@ -6511,6 +6629,13 @@ void perf_output_sample(struct perf_output_handle *handle,
>>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>>  		perf_output_put(handle, data->phys_addr);
>>  
>> +	if (sample_type & PERF_SAMPLE_AUX) {
>> +		perf_output_put(handle, data->aux_size);
>> +
>> +		if (data->aux_size)
>> +			perf_aux_sample_output(event, handle, data);
>> +	}
>> +
>>  	if (!event->attr.watermark) {
>>  		int wakeup_events = event->attr.wakeup_events;
>
>
> So, afaict, you can simply remove the line in perf_sample_data_init().

That's right, thanks for catching this.

Regards,
--
Alex
