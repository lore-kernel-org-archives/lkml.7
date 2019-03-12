Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8602087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412212;
	bh=uW6YNtrzL4IoEdhZ93o1IBsXh+OFmvejpFNusd+sJRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SAQK42xZFzOS+jib3f86n2juBMVLm19DTRW2nzM7pdsOnsQfx8bUy3mXbjzD2q+CF
	 a3XsutY96Xne6YGBWo0cQkvsLJ7wK0g6Ne+q/jclJT3z5Ov9nYcVdKImcC5AySA5E+
	 HSDt1QolPQLh4RdAqkRKQN+wjG+XfEzkZjFcLLkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfCLRgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfCLRQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:41 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9ADD206DF;
        Tue, 12 Mar 2019 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411001;
        bh=uW6YNtrzL4IoEdhZ93o1IBsXh+OFmvejpFNusd+sJRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yaPha1uKzaFA/opIjHG9sJZbau7cBp/axlNf4I5jRptM/98DhtB0dC2JRi02sCDxB
         EN+74ZOstcpg0WERglIWXWhyTkOpVnv5mvYv0K6Mi+x6l+izVcBt4n3IrCAwiuQOM6
         oObodztLoYAQg2CK4ygDTGMyXhrq14uRG1Hv1kPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martynas Pumputis <m@lambda.lt>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 101/135] bpf, selftests: fix handling of sparse CPU allocations
Date:   Tue, 12 Mar 2019 10:09:08 -0700
Message-Id: <20190312170350.476476039@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d0811b3d6a6f..4bf720364934 100644
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



