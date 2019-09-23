Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B789C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD8920882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406595AbfIWINL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:13:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406068AbfIWINL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:13:11 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E0579FB19B0FFC506F4;
        Mon, 23 Sep 2019 16:13:09 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.188.167) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Sep 2019 16:13:08 +0800
From:   wangxu <wangxu72@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <tglx@linutronix.de>, <rfontana@redhat.com>, <allison@lohutok.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] sample/hw_breakpoint: avoid sample hw_breakpoint recursion for arm/arm64
Date:   Mon, 23 Sep 2019 16:09:35 +0800
Message-ID: <1569226175-101782-1-git-send-email-wangxu72@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.188.167]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Xu <wangxu72@huawei.com>

For x86/ppc, hw_breakpoint is triggered after the instruction is
executed.

For arm/arm64, which is triggered before the instruction executed.
Arm/arm64 skips the instruction by using single step. But it only
supports default overflow_handler.

This patch provides a chance to avoid sample hw_breakpoint recursion
for arm/arm64 by adding 'struct perf_event_attr.bp_step'.

Signed-off-by: Wang Xu <wangxu72@huawei.com>
---
 include/linux/perf_event.h              | 3 +++
 include/uapi/linux/perf_event.h         | 3 ++-
 samples/hw_breakpoint/data_breakpoint.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c1..f270eb7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1024,6 +1024,9 @@ extern int perf_event_output(struct perf_event *event,
 		return true;
 	if (unlikely(event->overflow_handler == perf_event_output_backward))
 		return true;
+	/* avoid sample hw_breakpoint recursion */
+	if (unlikely(event->attr.bp_step))
+		return true;
 	return false;
 }
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271..95b81c2 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -375,7 +375,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				bp_step        :  1,
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index c585047..9fe1351 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -46,6 +46,7 @@ static int __init hw_break_module_init(void)
 	attr.bp_addr = kallsyms_lookup_name(ksym_name);
 	attr.bp_len = HW_BREAKPOINT_LEN_4;
 	attr.bp_type = HW_BREAKPOINT_W | HW_BREAKPOINT_R;
+	attr.bp_step = true;
 
 	sample_hbp = register_wide_hw_breakpoint(&attr, sample_hbp_handler, NULL);
 	if (IS_ERR((void __force *)sample_hbp)) {
-- 
1.8.5.6

