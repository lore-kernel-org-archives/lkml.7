Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D44A20678
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKZRzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:55:20 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:46118 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKZRzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:55:20 -0500
To:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
From:   Meelis Roos <mroos@linux.ee>
Subject: UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
Message-ID: <02f44ed5-13ac-f9c6-1f35-129c41006900@linux.ee>
Date:   Tue, 26 Nov 2019 19:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing 5.4 on a Dell D600 (32-bit), I noticed the old UBSAN warnings from p6 perf events.
I remember having seen these warnings on other p6 era computers too.

[    2.795167] ================================================================================
[    2.795206] UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
[    2.795235] index 8 is out of range for type 'u64 [8]'
[    2.795265] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-03419-g386403a115f9-dirty #18
[    2.795266] Hardware name: Dell Computer Corporation Latitude D600                   /0X2034, BIOS A16 06/29/2005
[    2.795268] Call Trace:
[    2.795283]  dump_stack+0x16/0x19
[    2.795290]  ubsan_epilogue+0xb/0x29
[    2.795293]  __ubsan_handle_out_of_bounds.cold+0x43/0x48
[    2.795299]  ? sysfs_add_file_mode_ns+0xad/0x180
[    2.795304]  p6_pmu_event_map+0x3b/0x50
[    2.795306]  is_visible+0x25/0x30
[    2.795308]  ? collect_events+0x150/0x150
[    2.795310]  internal_create_group+0xd8/0x3e0
[    2.795312]  ? collect_events+0x150/0x150
[    2.795314]  internal_create_groups.part.0+0x34/0x80
[    2.795317]  sysfs_create_groups+0x10/0x20
[    2.795321]  device_add+0x536/0x5a0
[    2.795326]  ? kvasprintf_const+0x59/0x90
[    2.795331]  ? kfree_const+0xf/0x30
[    2.795334]  ? kobject_set_name_vargs+0x6a/0xa0
[    2.795338]  pmu_dev_alloc+0x8e/0xe0
[    2.795344]  perf_event_sysfs_init+0x40/0x78
[    2.795346]  ? stack_map_init+0x17/0x17
[    2.795347]  do_one_initcall+0x7a/0x1b3
[    2.795351]  ? do_early_param+0x75/0x75
[    2.795354]  kernel_init_freeable+0x1ae/0x230
[    2.795357]  ? rest_init+0x6d/0x6d
[    2.795359]  kernel_init+0x9/0xf3
[    2.795361]  ? rest_init+0x6d/0x6d
[    2.795363]  ret_from_fork+0x2e/0x38
[    2.795364] ================================================================================
[    2.795396] ================================================================================
[    2.795427] UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
[    2.795456] load of address (ptrval) with insufficient space
[    2.795483] for an object of type 'const u64'
[    2.795510] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-03419-g386403a115f9-dirty #18
[    2.795511] Hardware name: Dell Computer Corporation Latitude D600                   /0X2034, BIOS A16 06/29/2005
[    2.795512] Call Trace:
[    2.795514]  dump_stack+0x16/0x19
[    2.795517]  ubsan_epilogue+0xb/0x29
[    2.795519]  ubsan_type_mismatch_common.cold+0xd6/0xdb
[    2.795522]  __ubsan_handle_type_mismatch_v1+0x2d/0x40
[    2.795524]  p6_pmu_event_map+0x4b/0x50
[    2.795525]  is_visible+0x25/0x30
[    2.795527]  ? collect_events+0x150/0x150
[    2.795529]  internal_create_group+0xd8/0x3e0
[    2.795531]  ? collect_events+0x150/0x150
[    2.795533]  internal_create_groups.part.0+0x34/0x80
[    2.795536]  sysfs_create_groups+0x10/0x20
[    2.795537]  device_add+0x536/0x5a0
[    2.795540]  ? kvasprintf_const+0x59/0x90
[    2.795542]  ? kfree_const+0xf/0x30
[    2.795543]  ? kobject_set_name_vargs+0x6a/0xa0
[    2.795546]  pmu_dev_alloc+0x8e/0xe0
[    2.795548]  perf_event_sysfs_init+0x40/0x78
[    2.795550]  ? stack_map_init+0x17/0x17
[    2.795551]  do_one_initcall+0x7a/0x1b3
[    2.795553]  ? do_early_param+0x75/0x75
[    2.795556]  kernel_init_freeable+0x1ae/0x230
[    2.795558]  ? rest_init+0x6d/0x6d
[    2.795560]  kernel_init+0x9/0xf3
[    2.795561]  ? rest_init+0x6d/0x6d
[    2.795563]  ret_from_fork+0x2e/0x38
[    2.795565] ================================================================================


-- 
Meelis Roos <mroos@linux.ee>
