Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD3FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BA02073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080030;
	bh=XVLFkUxvPr4SxI4Dxl0LIajKkAizRQoeefyUhnfbFRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TcM1xK1DcWaB7aH1G4SLj5mRvh08BMtAqUlDQXtwH3ehQ4gRuO48jYK/fcmAKY5Sx
	 Tbx3OcAuXFnE0mu8q6Vc58eOO8d8BRgV6Dnw8kxut0ovZiMP/CyGk1MGaLRJAW0s/b
	 v2lyIBnqH3KyHv4z25TCwc5FrKF0JUdeji4V+VQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbfLKQAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730981AbfLKPNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B28822B48;
        Wed, 11 Dec 2019 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077227;
        bh=XVLFkUxvPr4SxI4Dxl0LIajKkAizRQoeefyUhnfbFRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yd/Vh+eFNp1LT7KiLPAf0cTZDtR3XOXwpuVXHW0CdmckMdG8RhBw4tnGVe02AQ8we
         DekCnV2SuQ4JyHcFtm4BGsmefl4N/C+8D81yrRX8pqFKQ2LMhJHnuuFD7PB83l3EIb
         lEYhbqY6g00X2UMsfaOoeQAnBzSiuBPx6WZ/FEc4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 106/134] tools/power/x86/intel-speed-select: Ignore missing config level
Date:   Wed, 11 Dec 2019 10:11:22 -0500
Message-Id: <20191211151150.19073-106-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 20183ccd3e4d01d23b0a01fe9f3ee73fbae312fa ]

It is possible that certain config levels are not available, even
if the max level includes the level. There can be missing levels in
some platforms. So ignore the level when called for information dump
for all levels and fail if specifically ask for the missing level.

Here the changes is to continue reading information about other levels
even if we fail to get information for the current level. But use the
"processed" flag to indicate the failure. When the "processed" flag is
not set, don't dump information about that level.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/intel-speed-select/isst-core.c    | 8 ++++----
 tools/power/x86/intel-speed-select/isst-display.c | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 6dee5332c9d37..fde3f9cefc6db 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -553,7 +553,6 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 			     i);
 		ctdp_level = &pkg_dev->ctdp_level[i];
 
-		ctdp_level->processed = 1;
 		ctdp_level->level = i;
 		ctdp_level->control_cpu = cpu;
 		ctdp_level->pkg_id = get_physical_package_id(cpu);
@@ -561,7 +560,10 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 
 		ret = isst_get_ctdp_control(cpu, i, ctdp_level);
 		if (ret)
-			return ret;
+			continue;
+
+		pkg_dev->processed = 1;
+		ctdp_level->processed = 1;
 
 		ret = isst_get_tdp_info(cpu, i, ctdp_level);
 		if (ret)
@@ -614,8 +616,6 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 		}
 	}
 
-	pkg_dev->processed = 1;
-
 	return 0;
 }
 
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 40346d534f789..b11575c3e8864 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -314,7 +314,8 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 	char value[256];
 	int i, base_level = 1;
 
-	print_package_info(cpu, outf);
+	if (pkg_dev->processed)
+		print_package_info(cpu, outf);
 
 	for (i = 0; i <= pkg_dev->levels; ++i) {
 		struct isst_pkg_ctdp_level_info *ctdp_level;
-- 
2.20.1

