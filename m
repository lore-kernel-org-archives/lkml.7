Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87130C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA2D2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hu1e9qbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfDHVpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:45:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60606 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbfDHVpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:45:19 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LWXo2014300
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:45:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ITdC+1ADsiB4y9MMRmP6Bmclm291PtUrCVKrjn/cGuY=;
 b=hu1e9qbFortF1Ec6lCTK7voHZO0or0zZrXIvKIWFUgMIf2bxzz/3TMy1KwaIefxGRKxt
 WOTGXdi9zXcktzsU5sBMXzAnZqZajmOy+3RMm2K3ZqT82XCBOoW1kDibq33+CpjerIdx
 HYrlxZpjmpqQ3etIpk7IEdH7OVirXDfaskA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rr8d41n2v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:45:18 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 8 Apr 2019 14:45:17 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 2068710968F1D; Mon,  8 Apr 2019 14:45:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] selftests: cgroup: fix cleanup path in test_memcg_subtree_control()
Date:   Mon, 8 Apr 2019 14:45:12 -0700
Message-ID: <20190408214512.1815060-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
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

Dan reported, that cleanup path in test_memcg_subtree_control()
triggers a static checker warning:
  ./tools/testing/selftests/cgroup/test_memcontrol.c:76 \
  test_memcg_subtree_control()
  error: uninitialized symbol 'child2'.

Fix this by initializing child2 and parent2 variables and
split the cleanup path into few stages.

Signed-off-by: Roman Gushchin <guro@fb.com>
Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 38 ++++++++++---------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 28d321ba311b..6f339882a6ca 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -26,7 +26,7 @@
  */
 static int test_memcg_subtree_control(const char *root)
 {
-	char *parent, *child, *parent2, *child2;
+	char *parent, *child, *parent2 = NULL, *child2 = NULL;
 	int ret = KSFT_FAIL;
 	char buf[PAGE_SIZE];
 
@@ -34,50 +34,54 @@ static int test_memcg_subtree_control(const char *root)
 	parent = cg_name(root, "memcg_test_0");
 	child = cg_name(root, "memcg_test_0/memcg_test_1");
 	if (!parent || !child)
-		goto cleanup;
+		goto cleanup_free;
 
 	if (cg_create(parent))
-		goto cleanup;
+		goto cleanup_free;
 
 	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
-		goto cleanup;
+		goto cleanup_parent;
 
 	if (cg_create(child))
-		goto cleanup;
+		goto cleanup_parent;
 
 	if (cg_read_strstr(child, "cgroup.controllers", "memory"))
-		goto cleanup;
+		goto cleanup_child;
 
 	/* Create two nested cgroups without enabling memory controller */
 	parent2 = cg_name(root, "memcg_test_1");
 	child2 = cg_name(root, "memcg_test_1/memcg_test_1");
 	if (!parent2 || !child2)
-		goto cleanup;
+		goto cleanup_free2;
 
 	if (cg_create(parent2))
-		goto cleanup;
+		goto cleanup_free2;
 
 	if (cg_create(child2))
-		goto cleanup;
+		goto cleanup_parent2;
 
 	if (cg_read(child2, "cgroup.controllers", buf, sizeof(buf)))
-		goto cleanup;
+		goto cleanup_all;
 
 	if (!cg_read_strstr(child2, "cgroup.controllers", "memory"))
-		goto cleanup;
+		goto cleanup_all;
 
 	ret = KSFT_PASS;
 
-cleanup:
-	cg_destroy(child);
-	cg_destroy(parent);
-	free(parent);
-	free(child);
-
+cleanup_all:
 	cg_destroy(child2);
+cleanup_parent2:
 	cg_destroy(parent2);
+cleanup_free2:
 	free(parent2);
 	free(child2);
+cleanup_child:
+	cg_destroy(child);
+cleanup_parent:
+	cg_destroy(parent);
+cleanup_free:
+	free(parent);
+	free(child);
 
 	return ret;
 }
-- 
2.17.2

