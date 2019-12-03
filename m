Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE2BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D2A206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCNjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:39:44 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:58685 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfLCNjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:39:44 -0500
Subject: Re: UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <02f44ed5-13ac-f9c6-1f35-129c41006900@linux.ee>
 <20191202170633.GN2844@hirez.programming.kicks-ass.net>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <0676c6ec-4475-62dc-b202-a62deaedd2dd@linux.ee>
Date:   Tue, 3 Dec 2019 15:39:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202170633.GN2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Does something like so fix it?

Unfortunately not (tested on top of todays git):

[    0.000000] Linux version 5.4.0-11180-g76bb8b05960c-dirty (mroos@d600) (gcc version 9.2.1 20191109 (Debian 9.2.1-19)) #20 Tue Dec 3 15:14:51 EET 2019
[...]
[    8.774201] ================================================================================
[    8.774256] UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
[    8.774297] index 8 is out of range for type 'u64 [8]'
[    8.774341] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-11180-g76bb8b05960c-dirty #20
[    8.774345] Hardware name: Dell Computer Corporation Latitude D600                   /0X2034, BIOS A16 06/29/2005
[    8.774349] Call Trace:
[    8.774368]  dump_stack+0x16/0x19
[    8.774377]  ubsan_epilogue+0xb/0x29
[    8.774384]  __ubsan_handle_out_of_bounds.cold+0x43/0x48
[    8.774396]  ? sysfs_add_file_mode_ns+0xad/0x180
[    8.774406]  p6_pmu_event_map+0x3b/0x50
[    8.774413]  is_visible+0x25/0x30
[    8.774419]  ? collect_events+0x150/0x150
[    8.774425]  internal_create_group+0xd8/0x3e0
[    8.774431]  ? collect_events+0x150/0x150
[    8.774438]  internal_create_groups.part.0+0x34/0x80
[    8.774444]  sysfs_create_groups+0x10/0x20
[    8.774454]  device_add+0x62a/0x710
[    8.774463]  ? kvasprintf_const+0x59/0x90
[    8.774471]  ? kfree_const+0xf/0x30
[    8.774479]  ? kobject_set_name_vargs+0x6a/0xa0
[    8.774489]  pmu_dev_alloc+0x8e/0xe0
[    8.774497]  perf_event_sysfs_init+0x40/0x78
[    8.774503]  ? stack_map_init+0x17/0x17
[    8.774508]  do_one_initcall+0x7a/0x1b3
[    8.774519]  ? do_early_param+0x75/0x75
[    8.774528]  kernel_init_freeable+0x1ae/0x230
[    8.774537]  ? rest_init+0x6d/0x6d
[    8.774544]  kernel_init+0x9/0xf3
[    8.774550]  ? rest_init+0x6d/0x6d
[    8.774556]  ret_from_fork+0x2e/0x38
[    8.774562] ================================================================================
[    8.774606] ================================================================================
[    8.774649] UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
[    8.774690] load of address (ptrval) with insufficient space
[    8.774727] for an object of type 'const u64'
[    8.774765] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-11180-g76bb8b05960c-dirty #20
[    8.774768] Hardware name: Dell Computer Corporation Latitude D600                   /0X2034, BIOS A16 06/29/2005
[    8.774771] Call Trace:
[    8.774777]  dump_stack+0x16/0x19
[    8.774783]  ubsan_epilogue+0xb/0x29
[    8.774789]  ubsan_type_mismatch_common.cold+0xd6/0xdb
[    8.774797]  __ubsan_handle_type_mismatch_v1+0x2d/0x40
[    8.774804]  p6_pmu_event_map+0x4b/0x50
[    8.774809]  is_visible+0x25/0x30
[    8.774815]  ? collect_events+0x150/0x150
[    8.774820]  internal_create_group+0xd8/0x3e0
[    8.774826]  ? collect_events+0x150/0x150
[    8.774833]  internal_create_groups.part.0+0x34/0x80
[    8.774839]  sysfs_create_groups+0x10/0x20
[    8.774846]  device_add+0x62a/0x710
[    8.774854]  ? kvasprintf_const+0x59/0x90
[    8.774859]  ? kfree_const+0xf/0x30
[    8.774865]  ? kobject_set_name_vargs+0x6a/0xa0
[    8.774873]  pmu_dev_alloc+0x8e/0xe0
[    8.774879]  perf_event_sysfs_init+0x40/0x78
[    8.774884]  ? stack_map_init+0x17/0x17
[    8.774890]  do_one_initcall+0x7a/0x1b3
[    8.774897]  ? do_early_param+0x75/0x75
[    8.774906]  kernel_init_freeable+0x1ae/0x230
[    8.774913]  ? rest_init+0x6d/0x6d
[    8.774920]  kernel_init+0x9/0xf3
[    8.774926]  ? rest_init+0x6d/0x6d
[    8.774932]  ret_from_fork+0x2e/0x38
[    8.774937] ================================================================================

