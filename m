Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40CEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DBF2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKOSdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:33:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:44102 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfKOSdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:33:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 10:33:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="203460847"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2019 10:33:41 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C24633010AB; Fri, 15 Nov 2019 10:33:41 -0800 (PST)
Date:   Fri, 15 Nov 2019 10:33:41 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH] perf/x86/intel: Avoid PEBS_ENABLE MSR access in PMI
Message-ID: <20191115183341.GB22747@tassilo.jf.intel.com>
References: <20191115133917.24424-1-kan.liang@linux.intel.com>
 <20191115140739.GM4131@hirez.programming.kicks-ass.net>
 <c0f562aa-39f3-1291-edd7-17c46178d1e3@linux.intel.com>
 <3e117702-c07f-bd58-9931-766c2698b5d7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e117702-c07f-bd58-9931-766c2698b5d7@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2620,6 +2624,15 @@ static int handle_pmi_common(struct pt_regs *regs,
> u64 status)
>                 handled++;
>                 x86_pmu.drain_pebs(regs);
>                 status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
> +
> +               /*
> +                * PMI may land after cpuc->enabled=0 in x86_pmu_disable()
> and
> +                * PMI throttle may be triggered for the PMI.
> +                * For this rare case, intel_pmu_pebs_disable() will not
> touch
> +                * MSR_IA32_PEBS_ENABLE. Explicitly disable the PEBS here.
> +                */
> +               if (unlikely(!cpuc->enabled && !cpuc->pebs_enabled))
> +                       wrmsrl(MSR_IA32_PEBS_ENABLE, 0);

How does the enable_all() code know to reenable it in this case?

-Andi
