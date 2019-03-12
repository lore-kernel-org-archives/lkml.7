Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95259C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0C72087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413007;
	bh=gQJzTtI+0f7N0gIaDYA4XGckxaqMTL7bhzw/uQYC8Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w09cQRGe3GM2p6CvdaTPTFcePBy6JZZ1sxM9MFSo+varFsb1yYBhrn4USpXlZye74
	 suxQ55QrFcQ3nlsk2QWunASrdk5yVWL300mouh0kU4WznVlzqKTcvP2YQHOQPMhYF3
	 6k/XWTvVEt9rE8jfmGZbLrfMEcVJb02oFPkll3lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfCLRuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbfCLROq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:46 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D91C21872;
        Tue, 12 Mar 2019 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410885;
        bh=gQJzTtI+0f7N0gIaDYA4XGckxaqMTL7bhzw/uQYC8Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wlTxa3lCsPWUpddbQZDT/6HIAqCP/gtzNUr7OiJ3oC59bmHuX1kK4HHrap6yZ18e
         lb+6B8xQ/5Q7ayMJfhlnJKIZpe8RyuGHfw/Cm3VpPUsrt1egMwoTv3HyTK+OlqmUHL
         Q1296KmNBo4SxR3L8Ec2siIVlYr/GSSMmGmzqKZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martynas Pumputis <m@lambda.lt>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 093/149] bpf, selftests: fix handling of sparse CPU allocations
Date:   Tue, 12 Mar 2019 10:08:31 -0700
Message-Id: <20190312170357.466732303@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 315a44fa32af..84fd6f1bf33e 100644
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



