Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DE9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFE821929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504596AbfJYMwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:52:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:17198 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501908AbfJYMwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:52:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 05:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="204545696"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Oct 2019 05:52:34 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2 1/4] perf: Allow using AUX data in perf samples
In-Reply-To: <20191024140139.GF4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com> <20191022095812.67071-2-alexander.shishkin@linux.intel.com> <20191024140139.GF4114@hirez.programming.kicks-ass.net>
Date:   Fri, 25 Oct 2019 15:52:33 +0300
Message-ID: <875zkdgf72.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Oct 22, 2019 at 12:58:09PM +0300, Alexander Shishkin wrote:
>> @@ -11213,6 +11367,9 @@ SYSCALL_DEFINE5(perf_event_open,
>>  	if (event->attr.aux_output && !perf_get_aux_event(event, group_leader))
>>  		goto err_locked;
>>  
>> +	if (event->attr.aux_sample_size && !perf_get_aux_event(event, group_leader))
>> +		goto err_locked;
>> +
>
> Either aux_sample_size and aux_output are mutually exclusive, or you're
> leaking a refcount on group_leader. The first wants a check, the second
> wants error path fixes.

Now you mention it, it should be possible to have both. Whether that's
useful is another question. But we only need one reference either way.

Thanks,
--
Alex
