Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FBAC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39192084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ws37Eh+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfILR4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:56:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbfILR4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:56:49 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CHslHM014798
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 10:56:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=JHcGIr6DfeeZGfRlp0Bw8MSSseCy7tNcl4Zfer3yjas=;
 b=Ws37Eh+4it10LaEbzqprrRYoR6i8fyBwmbB70feddo3KvOnHh2Ev0c0EM7XHb9TEqslA
 /MJbRaOrckgrmUOtNmfr62EObwVA3ajdVceCbAEhzZVlTzOReprBcrp8ne7bIRs/zxm0
 Ks4NZE4CCTU0VenxfprPN4jzLDkXeNDah6Y= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uytdg05n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 10:56:47 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 12 Sep 2019 10:56:47 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id DA16717690C09; Thu, 12 Sep 2019 10:56:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>, <cgroups@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Mark Crossen <mcrossen@fb.com>, Roman Gushchin <guro@fb.com>,
        <stable@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 2/2] cgroup: freezer: fix frozen state inheritance
Date:   Thu, 12 Sep 2019 10:56:45 -0700
Message-ID: <20190912175645.2841713-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912175645.2841713-1-guro@fb.com>
References: <20190912175645.2841713-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_09:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=5 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxscore=5 malwarescore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=132
 spamscore=5 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909120188
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a new child cgroup is created in the frozen cgroup hierarchy
(one or more of ancestor cgroups is frozen), the CGRP_FREEZE cgroup
flag should be set. Otherwise if a process will be attached to the
child cgroup, it won't become frozen.

The problem can be reproduced with the test_cgfreezer_mkdir test.

This is the output before this patch:
  ~/test_freezer
  ok 1 test_cgfreezer_simple
  ok 2 test_cgfreezer_tree
  ok 3 test_cgfreezer_forkbomb
  Cgroup /sys/fs/cgroup/cg_test_mkdir_A/cg_test_mkdir_B isn't frozen
  not ok 4 test_cgfreezer_mkdir
  ok 5 test_cgfreezer_rmdir
  ok 6 test_cgfreezer_migrate
  ok 7 test_cgfreezer_ptrace
  ok 8 test_cgfreezer_stopped
  ok 9 test_cgfreezer_ptraced
  ok 10 test_cgfreezer_vfork

And with this patch:
  ~/test_freezer
  ok 1 test_cgfreezer_simple
  ok 2 test_cgfreezer_tree
  ok 3 test_cgfreezer_forkbomb
  ok 4 test_cgfreezer_mkdir
  ok 5 test_cgfreezer_rmdir
  ok 6 test_cgfreezer_migrate
  ok 7 test_cgfreezer_ptrace
  ok 8 test_cgfreezer_stopped
  ok 9 test_cgfreezer_ptraced
  ok 10 test_cgfreezer_vfork

Reported-by: Mark Crossen <mcrossen@fb.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/cgroup/cgroup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 753afbca549f..8be1da1ebd9a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5255,8 +5255,16 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	 * if the parent has to be frozen, the child has too.
 	 */
 	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
-	if (cgrp->freezer.e_freeze)
+	if (cgrp->freezer.e_freeze) {
+		/*
+		 * Set the CGRP_FREEZE flag, so when a process will be
+		 * attached to the child cgroup, it will become frozen.
+		 * At this point the new cgroup is unpopulated, so we can
+		 * consider it frozen immediately.
+		 */
+		set_bit(CGRP_FREEZE, &cgrp->flags);
 		set_bit(CGRP_FROZEN, &cgrp->flags);
+	}
 
 	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
-- 
2.21.0

