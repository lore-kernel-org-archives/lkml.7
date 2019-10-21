Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F0CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C91214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJUIeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:34:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbfJUIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:34:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9L8XLSD139360
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:34:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vs721wett-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:34:13 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 21 Oct 2019 09:34:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Oct 2019 09:34:08 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9L8Y7Ya39321756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 08:34:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E167A405B;
        Mon, 21 Oct 2019 08:34:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDBCAA405F;
        Mon, 21 Oct 2019 08:34:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Oct 2019 08:34:06 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        songliubraving@fb.com, hechaol@fb.com, acme@kernel.org,
        mingo@redhat.com, peterz@infradead.org
Cc:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/core: Fix tracking of auxiliary trace buffer allocation
Date:   Mon, 21 Oct 2019 10:33:54 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19102108-0016-0000-0000-000002BACC36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102108-0017-0000-0000-0000331C0016
Message-Id: <20191021083354.67868-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910210080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")
breaks auxiliary trace buffer tracking.

I run command 'perf record -e rbd000' to record samples and saving
them in the **auxiliary** trace buffer. The value of 'locked_vm' becomes
negative after all trace buffers have been allocated and released:

During allocation the values increase
[52.250027] perf_mmap user->locked_vm:0x87 pinned_vm:0x0 ret:0
[52.250115] perf_mmap user->locked_vm:0x107 pinned_vm:0x0 ret:0
[52.250251] perf_mmap user->locked_vm:0x188 pinned_vm:0x0 ret:0
[52.250326] perf_mmap user->locked_vm:0x208 pinned_vm:0x0 ret:0
[52.250441] perf_mmap user->locked_vm:0x289 pinned_vm:0x0 ret:0
[52.250498] perf_mmap user->locked_vm:0x309 pinned_vm:0x0 ret:0
[52.250613] perf_mmap user->locked_vm:0x38a pinned_vm:0x0 ret:0
[52.250715] perf_mmap user->locked_vm:0x408 pinned_vm:0x2 ret:0
[52.250834] perf_mmap user->locked_vm:0x408 pinned_vm:0x83 ret:0
[52.250915] perf_mmap user->locked_vm:0x408 pinned_vm:0x103 ret:0
[52.251061] perf_mmap user->locked_vm:0x408 pinned_vm:0x184 ret:0
[52.251146] perf_mmap user->locked_vm:0x408 pinned_vm:0x204 ret:0
[52.251299] perf_mmap user->locked_vm:0x408 pinned_vm:0x285 ret:0
[52.251383] perf_mmap user->locked_vm:0x408 pinned_vm:0x305 ret:0
[52.251544] perf_mmap user->locked_vm:0x408 pinned_vm:0x386 ret:0
[52.251634] perf_mmap user->locked_vm:0x408 pinned_vm:0x406 ret:0
[52.253018] perf_mmap user->locked_vm:0x408 pinned_vm:0x487 ret:0
[52.253197] perf_mmap user->locked_vm:0x408 pinned_vm:0x508 ret:0
[52.253374] perf_mmap user->locked_vm:0x408 pinned_vm:0x589 ret:0
[52.253550] perf_mmap user->locked_vm:0x408 pinned_vm:0x60a ret:0
[52.253726] perf_mmap user->locked_vm:0x408 pinned_vm:0x68b ret:0
[52.253903] perf_mmap user->locked_vm:0x408 pinned_vm:0x70c ret:0
[52.254084] perf_mmap user->locked_vm:0x408 pinned_vm:0x78d ret:0
[52.254263] perf_mmap user->locked_vm:0x408 pinned_vm:0x80e ret:0

The value of user->locked_vm increases to a limit then the memory
is tracked by pinned_vm.

During deallocation the size is subtracted from pinned_vm until
it hits a limit. Then a larger value is subtracted from locked_vm
leading to a large number (because of type unsigned):
[64.267797] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x78d
[64.267826] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x70c
[64.267848] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x68b
[64.267869] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x60a
[64.267891] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x589
[64.267911] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x508
[64.267933] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x487
[64.267952] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x406
[64.268883] perf_mmap_close mmap_user->locked_vm:0x307 pinned_vm:0x406
[64.269117] perf_mmap_close mmap_user->locked_vm:0x206 pinned_vm:0x406
[64.269433] perf_mmap_close mmap_user->locked_vm:0x105 pinned_vm:0x406
[64.269536] perf_mmap_close mmap_user->locked_vm:0x4 pinned_vm:0x404
[64.269797] perf_mmap_close mmap_user->locked_vm:0xffffffffffffff84 pinned_vm:0x303
[64.270105] perf_mmap_close mmap_user->locked_vm:0xffffffffffffff04 pinned_vm:0x202
[64.270374] perf_mmap_close mmap_user->locked_vm:0xfffffffffffffe84 pinned_vm:0x101
[64.270628] perf_mmap_close mmap_user->locked_vm:0xfffffffffffffe04 pinned_vm:0x0

This value sticks for the user until system is rebooted, causing
follow-on system calls using locked_vm resource limit to fail.

Note: There is no issue using the normal trace buffer.

In fact the issue is in perf_mmap_close(). During allocation auxiliary
trace buffer memory is either traced as 'extra' and added to 'pinned_vm'
or trace as 'user_extra' and added to 'locked_vm'. This applies for
normal trace buffers and auxiliary trace buffer.

However in function perf_mmap_close() all auxiliary trace buffer is
subtraced from 'locked_vm' and never from 'pinned_vm'. This breaks the
ballance.

Fixes: d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 kernel/events/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ec0b0bfddbd..90ba23043af0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5607,8 +5607,12 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
-		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		if (!rb->aux_mmap_locked)
+			atomic_long_sub(rb->aux_nr_pages,
+					&mmap_user->locked_vm);
+		else
+			atomic64_sub(rb->aux_mmap_locked,
+				     &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
-- 
2.21.0

