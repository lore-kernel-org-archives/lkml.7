Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B29AC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373602084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mYJY8vFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfDHVqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:46:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35120 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728827AbfDHVqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:46:16 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LWR3T029662
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:46:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=o7WC2UlvTAvUeO79W7+2V8nqP7IPlMcT5D5D+dySPw8=;
 b=mYJY8vFuK2te6xBy3hUDF4h3SMOQhFpe+czVcXurdOoT15pn1044kduvVwijWGgwXrza
 0OYkvvHXPDtfoC8BOGaEHLAv4+/JnZVfLsPdnfnBP5IejjeqpvJ+7o083AYgk0OtDxIa
 qGs1k2wCRG5TZ1TDOexeMObpFkudbbFZRUk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rraew1437-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:46:16 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 8 Apr 2019 14:46:11 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DF53462E1F66; Mon,  8 Apr 2019 14:46:09 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <tglx@linutronix.de>,
        <morten.rasmussen@arm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 7/7] Documentation: cgroup-v2: add information for cpu.headroom
Date:   Mon, 8 Apr 2019 14:45:39 -0700
Message-ID: <20190408214539.2705660-8-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408214539.2705660-1-songliubraving@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds simple explanation of the new cpu.headroom knob.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 20f92c16ffbf..5007076d6611 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -916,6 +916,10 @@ have placed RT processes into nonroot cgroups during the system boot
 process, and these processes may need to be moved to the root cgroup
 before the cpu controller can be enabled.
 
+Some latency sensitive applications experience high latency when the
+CPU is fully utilized. cpu.headroom knob provides mechanism to reserve
+CPU headroom that are only available to certain applications.
+
 
 CPU Interface Files
 ~~~~~~~~~~~~~~~~~~~
@@ -968,6 +972,20 @@ All time durations are in microseconds.
 	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
 	one number is written, $MAX is updated.
 
+  cpu.headroom
+	A read-write two value file which exists on non-root cgroups.
+	The default is "0.00 max".
+
+	The idle CPU headroom claimed by the cgroup. It's is in the
+	following format::
+
+	  $HEADROOM $TOLERANCE
+
+	which indicates that other cgroups should be throttled to
+	yield $HEADROOM % idle CPU. If it is not possible to maintain
+	$HEADROOM % idle CPU, other cgroups will consume at most
+	$TOLERANCE % CPU.
+
   cpu.pressure
 	A read-only nested-key file which exists on non-root cgroups.
 
-- 
2.17.1

