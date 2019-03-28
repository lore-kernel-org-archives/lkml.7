Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ACAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B0E2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHd5Xnk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfC1C5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:57:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45734 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC1C5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:57:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so9787940pfi.12;
        Wed, 27 Mar 2019 19:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ITdC+1ADsiB4y9MMRmP6Bmclm291PtUrCVKrjn/cGuY=;
        b=sHd5Xnk2TX/SxhXIXdfId7qONl55fRdC2JETfc8X4jEllj1Vzu1cw83f9fpAN90zjY
         v8qNj0Gz5Ax3UDfTWw/nWs1KeSw5ek+ZMcljfs7Vyrlw5IAUCshKN0TrcBABfoPY20Fw
         2LqTLewGMzrbrnPHIPIoYT3LS8sdXvc4MOBRW0Ddz0ntGg8J2tm41YCceSOFNQK6qeQO
         gb0/2IrEyjCx3BXNsRN0auJmw9OopTD96hJWd9fRr9fxiFRemSgEu3lySnLTiOxL72Il
         g++T4CLWvWpFzwBiNK+ux2C+PAO1iUZsNd4AnNJOKvB3sSPh4i1mSMnJBB+Z6nEF911F
         HYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ITdC+1ADsiB4y9MMRmP6Bmclm291PtUrCVKrjn/cGuY=;
        b=BtMxM4UxArsbpStia2CyXqCwICjZQ2+jyOC4EkQ0/vA3jFnHtr7EFUntOWU2fvaBa5
         scAb/JkzyDqniO6GpBLH2MMLq6OF1aVA7nUaVGJ33trwqRKZ6Pah3qApjuxjCTghiize
         A7HEXzL97JUu47aywdi9Wm+4HczBwMM53bXvFUZgdHgxysjYd4SGDoQvaRAsGucCG3OA
         jLr+vtwY4pRcaH46QHb1T/MEPq+shJgEBFBh5KRWhBmc9cCVK0EdRBb4pXMb6tJ2f0lJ
         W7lV6GlsPOzYtdrgh7C6xpj7awkIqWgeZ0S3NRQMB812/3rlptt76ikpU4aULdbe/YcA
         PHGg==
X-Gm-Message-State: APjAAAUNy9J5N+7m+Rbu2GB2t+LtZH4a9vegD2iTi3pL8YOCf+QvAuIk
        P2ClinATPMaaG1jk3n5ZH4TFLfEsAIk=
X-Google-Smtp-Source: APXvYqw1DkA44OCD3cybhXDcR0c7kBBf+fEFjN8edsaX+WmPRj2rfuJlhqLXp4VOJ9dnOK/yJQ+UCQ==
X-Received: by 2002:a62:1197:: with SMTP id 23mr38515737pfr.210.1553741835113;
        Wed, 27 Mar 2019 19:57:15 -0700 (PDT)
Received: from castle.tfbnw.net ([2620:10d:c090:180::2396])
        by smtp.gmail.com with ESMTPSA id a3sm16853813pfn.182.2019.03.27.19.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 19:57:14 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH kselftest-next] selftests: cgroup: fix cleanup path in test_memcg_subtree_control()
Date:   Wed, 27 Mar 2019 19:56:59 -0700
Message-Id: <20190328025659.25684-1-guro@fb.com>
X-Mailer: git-send-email 2.17.2
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

