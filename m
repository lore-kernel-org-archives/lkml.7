Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2328FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F066A24A35
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186660;
	bh=iGxECOeYoMheEdkjkj36hyuYRAMoQSKnz47vNcgJL9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7EA7R32ZFds5iBzSb9e7Jq7b+M65syukeWD/jqXVBPluMUuGqLqBDu2FgQcFHY7w
	 5kzPXsM2CXdujDsttAxwEYUutG2oDJdZ2c6mrMp06Ob+/etCREHApv3Tev99fUc2fy
	 aunx5bUh/Rvg8HZYQFd3qOaFdY3Lu3hLdvTXbipE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbfE3DYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731307AbfE3DRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:53 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDDA24733;
        Thu, 30 May 2019 03:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186272;
        bh=iGxECOeYoMheEdkjkj36hyuYRAMoQSKnz47vNcgJL9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQAw5qDiUa0a0FPmJI6xh9XQ2ppv7FB97YPwQXFYiAOdc6uDsNDzSEqSK8OvNGvJl
         cFYWbyKUZd4wsN3i3HRIY77HF2CvpNRonQNMNIPSEcFg9H8YSDNTfeHRc06uGCo8L8
         +6qFkWhkeLbPxy4LZjxb/OFWXaUWp0HaEnfsUUn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 177/276] selftests: cgroup: fix cleanup path in test_memcg_subtree_control()
Date:   Wed, 29 May 2019 20:05:35 -0700
Message-Id: <20190530030536.382969778@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e14d314c7a489f060d6d691866fef5f131281718 ]

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
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/cgroup/test_memcontrol.c        | 38 ++++++++++---------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 28d321ba311b4..6f339882a6ca1 100644
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
2.20.1



