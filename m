Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178BA218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366741;
	bh=eGEJ44wAVgpuhd9UmYjrlHvfG+utswhJaIZ2GcAwn3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kckt2jZ7YmOjFjQmZa6qFYM7+WQmNhjAVHxE5tVFPOxMU7ldVj7+xaYOEENosQNhu
	 Cny3Wz14PU7/y4XQYcTTD5mPLhWmHiy6sYWswtA/9sDf1rWZiPjGg44FaCuiayoSo+
	 6dQxWO+OXV/qQdmYjcyUGx64tzbQa2LoCZ38+yQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbfB1PMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388204AbfB1PMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:12:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320C1218D9;
        Thu, 28 Feb 2019 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366735;
        bh=eGEJ44wAVgpuhd9UmYjrlHvfG+utswhJaIZ2GcAwn3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGE0BFfVNU4VV68TAkFJur4BIwHdezL+QHSdeBVcdLQJxO10MlmnKgW3/hIfzuKLH
         tv0vwYH2EYMq3yM+/r6n+otbM3FuizLGrttNJB/ohzljCDpyYhm1mhtQU9eTrjL53/
         aiecnJw4HOMpNCxu5/F4Y7gj/WdVON3pyVxQMKSU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martynas Pumputis <m@lambda.lt>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 35/64] bpf, selftests: fix handling of sparse CPU allocations
Date:   Thu, 28 Feb 2019 10:10:36 -0500
Message-Id: <20190228151105.11277-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martynas Pumputis <m@lambda.lt>

[ Upstream commit 1bb54c4071f585ebef56ce8fdfe6026fa2cbcddd ]

Previously, bpf_num_possible_cpus() had a bug when calculating a
number of possible CPUs in the case of sparse CPU allocations, as
it was considering only the first range or element of
/sys/devices/system/cpu/possible.

E.g. in the case of "0,2-3" (CPU 1 is not available), the function
returned 1 instead of 3.

This patch fixes the function by making it parse all CPU ranges and
elements.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/bpf_util.h | 30 +++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 315a44fa32af3..84fd6f1bf33e7 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -13,7 +13,7 @@ static inline unsigned int bpf_num_possible_cpus(void)
 	unsigned int start, end, possible_cpus = 0;
 	char buff[128];
 	FILE *fp;
-	int n;
+	int len, n, i, j = 0;
 
 	fp = fopen(fcpu, "r");
 	if (!fp) {
@@ -21,17 +21,27 @@ static inline unsigned int bpf_num_possible_cpus(void)
 		exit(1);
 	}
 
-	while (fgets(buff, sizeof(buff), fp)) {
-		n = sscanf(buff, "%u-%u", &start, &end);
-		if (n == 0) {
-			printf("Failed to retrieve # possible CPUs!\n");
-			exit(1);
-		} else if (n == 1) {
-			end = start;
+	if (!fgets(buff, sizeof(buff), fp)) {
+		printf("Failed to read %s!\n", fcpu);
+		exit(1);
+	}
+
+	len = strlen(buff);
+	for (i = 0; i <= len; i++) {
+		if (buff[i] == ',' || buff[i] == '\0') {
+			buff[i] = '\0';
+			n = sscanf(&buff[j], "%u-%u", &start, &end);
+			if (n <= 0) {
+				printf("Failed to retrieve # possible CPUs!\n");
+				exit(1);
+			} else if (n == 1) {
+				end = start;
+			}
+			possible_cpus += end - start + 1;
+			j = i + 1;
 		}
-		possible_cpus = start == 0 ? end + 1 : 0;
-		break;
 	}
+
 	fclose(fp);
 
 	return possible_cpus;
-- 
2.19.1

