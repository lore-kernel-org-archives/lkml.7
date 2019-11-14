Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E8EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A58206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNNq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:46:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:40485 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfKNNq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:46:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 05:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="207792492"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2019 05:46:55 -0800
Received: from [10.251.18.41] (kliang2-mobl.ccr.corp.intel.com [10.251.18.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A52175801E3;
        Thu, 14 Nov 2019 05:46:52 -0800 (PST)
Subject: Re: [PATCH v3 10/10] perf/cgroup: Do not switch system-wide events in
 cgroup switch
To:     Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-11-irogers@google.com>
 <20191114104340.GT4131@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <710edaf6-2562-0f53-15d6-dc50885b8e08@linux.intel.com>
Date:   Thu, 14 Nov 2019 08:46:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191114104340.GT4131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2019 5:43 AM, Peter Zijlstra wrote:
> On Wed, Nov 13, 2019 at 04:30:42PM -0800, Ian Rogers wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> When counting system-wide events and cgroup events simultaneously, the
>> system-wide events are always scheduled out then back in during cgroup
>> switches, bringing extra overhead and possibly missing events. Switching
>> out system wide flexible events may be necessary if the scheduled in
>> task's cgroups have pinned events that need to be scheduled in at a higher
>> priority than the system wide flexible events.
> 
> I'm thinking this patch is actively broken. groups->index 'group' wide
> and therefore across cpu/cgroup boundaries.
> 
> There is no !cgroup to cgroup hierarchy as this patch seems to assume,
> specifically look at how the merge sort in visit_groups_merge() allows
> cgroup events to be picked before !cgroup events.


No, the patch intends to avoid switch !cgroup during cgroup context 
switch.

In perf_cgroup_switch(), when the cgroup is scheduled out, current 
implementation schedule out everything including !cgroup. I think it 
definitely breaks the semantics of !cgroup aka system-wide event.

The patch itself doesn't touch the merge sort in visit_groups_merge().
The perf_cgroup_skip_switch() just skips the !cgroup in schedule_in().
Because !cgroup wasn't scheduled out. We don't want to schedule !cgroup 
in again.
The cgroup events must be after !cgroup events, since !cgroup never be 
switched.

Thanks,
Kan
