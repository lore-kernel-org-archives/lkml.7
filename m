Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA6CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6CD20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfCZWYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:24:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:9203 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfCZWYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:24:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 15:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="217815521"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2019 15:24:41 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 981BF301BD4; Tue, 26 Mar 2019 15:24:41 -0700 (PDT)
Date:   Tue, 26 Mar 2019 15:24:41 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V4 04/23] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190326222441.GP18020@tassilo.jf.intel.com>
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
 <20190326160901.4887-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326160901.4887-5-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	for (at = base; at < top; at += cpuc->pebs_record_size) {
> +		u64 pebs_status;
> +
> +		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
> +		pebs_status &= mask;
> +
> +		for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
> +			counts[bit]++;
> +	}

On Icelake pebs_status is always reliable, so I don't think we need
the two pass walking.

-Andi

> +
> +	for (bit = 0; bit < size; bit++) {
> +		if (counts[bit] == 0)
> +			continue;
> +
> +		event = cpuc->events[bit];
> +		if (WARN_ON_ONCE(!event))
> +			continue;
> +
> +		if (WARN_ON_ONCE(!event->attr.precise_ip))
> +			continue;
> +
> +		__intel_pmu_pebs_event(event, iregs, base,
> +				       top, bit, counts[bit],
> +				       setup_pebs_adaptive_sample_data);
> +	}
> +}
