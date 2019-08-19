Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D03C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AB922CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="XRWESt2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfHSXNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:13:51 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:49494 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728204AbfHSXNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:13:51 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7JNCi5V004076;
        Tue, 20 Aug 2019 00:13:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=+/miGxjtSjHlEdb85fU70kZXbxy/gmLdzzZNq/JYmeg=;
 b=XRWESt2ZmeVVKnT2vHMWqCTqkWeKe2xSOlgGMkvxz7xkOpq7tJYHYnPy0hOCRL2myU4h
 ux7BHb68Ev98hmeBPZ7Vrm7RxrXYJ5kUO+VZJMWKJwzI3Sn4OAhlqoIj3qLtIQGqyxBC
 P55RP/BtzdppZ/OBRXMkSaT1Tg5z3ebAHYwv7wi/reAvzOrhLhRF7sKC0WmHXQuj1qq+
 F0YdcTNsNKIJyRguu6sDfdfh6Fpqprap2IUIqBEe/mjQ+KNhzr0RKPD6wlNM+HwQ7X8q
 GPuINRlV1TY9ovW2ii+6GQoVf+0npq16KAID3RpHXIRYyaBjcT8rYJcf1RX2uHP35FbH ag== 
Received: from prod-mail-ppoint7 (prod-mail-ppoint7.akamai.com [96.6.114.121] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2ue6esbh87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 00:13:27 +0100
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x7JN2j0j027557;
        Mon, 19 Aug 2019 19:13:26 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint7.akamai.com with ESMTP id 2uecww0h5y-1;
        Mon, 19 Aug 2019 19:13:26 -0400
Received: from bos-lpwg1 (bos-lpwg1.kendall.corp.akamai.com [172.29.171.203])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id 3F69E80D1A;
        Mon, 19 Aug 2019 23:13:26 +0000 (GMT)
Received: from johunt by bos-lpwg1 with local (Exim 4.86_2)
        (envelope-from <johunt@akamai.com>)
        id 1hzqqN-0000jL-3R; Mon, 19 Aug 2019 19:13:43 -0400
From:   Josh Hunt <johunt@akamai.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, bpuranda@akamai.com,
        Josh Hunt <johunt@akamai.com>
Subject: [PATCH] perf/x86/intel: restrict period on Nehalem
Date:   Mon, 19 Aug 2019 19:13:31 -0400
Message-Id: <1566256411-18820-1-git-send-email-johunt@akamai.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908190227
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-19_05:2019-08-19,2019-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908190229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We see our Nehalem machines reporting 'perfevents: irq loop stuck!' in
some cases when using perf:

perfevents: irq loop stuck!
WARNING: CPU: 0 PID: 3485 at arch/x86/events/intel/core.c:2282 intel_pmu_handle_irq+0x37b/0x530
...
RIP: 0010:intel_pmu_handle_irq+0x37b/0x530
...
Call Trace:
<NMI>
? perf_event_nmi_handler+0x2e/0x50
? intel_pmu_save_and_restart+0x50/0x50
perf_event_nmi_handler+0x2e/0x50
nmi_handle+0x6e/0x120
default_do_nmi+0x3e/0x100
do_nmi+0x102/0x160
end_repeat_nmi+0x16/0x50
...
? native_write_msr+0x6/0x20
? native_write_msr+0x6/0x20
</NMI>
intel_pmu_enable_event+0x1ce/0x1f0
x86_pmu_start+0x78/0xa0
x86_pmu_enable+0x252/0x310
__perf_event_task_sched_in+0x181/0x190
? __switch_to_asm+0x41/0x70
? __switch_to_asm+0x35/0x70
? __switch_to_asm+0x41/0x70
? __switch_to_asm+0x35/0x70
finish_task_switch+0x158/0x260
__schedule+0x2f6/0x840
? hrtimer_start_range_ns+0x153/0x210
schedule+0x32/0x80
schedule_hrtimeout_range_clock+0x8a/0x100
? hrtimer_init+0x120/0x120
ep_poll+0x2f7/0x3a0
? wake_up_q+0x60/0x60
do_epoll_wait+0xa9/0xc0
__x64_sys_epoll_wait+0x1a/0x20
do_syscall_64+0x4e/0x110
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fdeb1e96c03
...
---[ end trace 7a8f0b2beff82ee0 ]---

CPU#0: ctrl:       0000000000000000
CPU#0: status:     0000000400000000
CPU#0: overflow:   0000000000000000
CPU#0: fixed:      0000000000000bb0
CPU#0: pebs:       0000000000000000
CPU#0: debugctl:   0000000000000000
CPU#0: active:     0000000600000000
CPU#0:   gen-PMC0 ctrl:  0000000000000000
CPU#0:   gen-PMC0 count: 0000000000000000
CPU#0:   gen-PMC0 left:  0000000000000000
CPU#0:   gen-PMC1 ctrl:  0000000000000000
CPU#0:   gen-PMC1 count: 0000000000000000
CPU#0:   gen-PMC1 left:  0000000000000000
CPU#0:   gen-PMC2 ctrl:  0000000000000000
CPU#0:   gen-PMC2 count: 0000000000000000
CPU#0:   gen-PMC2 left:  0000000000000000
CPU#0:   gen-PMC3 ctrl:  0000000000000000
CPU#0:   gen-PMC3 count: 0000000000000000
CPU#0:   gen-PMC3 left:  0000000000000000
CPU#0: fixed-PMC0 count: 0000000000000000
CPU#0: fixed-PMC1 count: 0000ffffd22ebd19
CPU#0: fixed-PMC2 count: 0000fffffffffff1
core: clearing PMU state on CPU#0

I found that a period limit of 32 was the lowest I could set it to without
the problem reoccurring. The idea for the patch and approach to find the
target value were suggested by Ingo and Thomas.

Signed-off-by: Josh Hunt <johunt@akamai.com>
Reported-by: Bhupesh Purandare <bpuranda@akamai.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Link: https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1908122133310.7324@nanos.tec.linutronix.de/
---
 arch/x86/events/intel/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 648260b5f367..e4c2cb65ea50 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3572,6 +3572,11 @@ static u64 bdw_limit_period(struct perf_event *event, u64 left)
 	return left;
 }
 
+static u64 nhm_limit_period(struct perf_event *event, u64 left)
+{
+	return max(left, 32ULL);
+}
+
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
 PMU_FORMAT_ATTR(umask,	"config:8-15"	);
 PMU_FORMAT_ATTR(edge,	"config:18"	);
@@ -4606,6 +4611,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
 		x86_pmu.enable_all = intel_pmu_nhm_enable_all;
 		x86_pmu.extra_regs = intel_nehalem_extra_regs;
+		x86_pmu.limit_period = nhm_limit_period;
 
 		mem_attr = nhm_mem_events_attrs;
 
-- 
2.7.4

