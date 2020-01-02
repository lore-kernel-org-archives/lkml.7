Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B97C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D5D21582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003303;
	bh=kk9yOZTwuv8VYKJ05BvJm+gyiXuuNdCaC8RdEZ+r5Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wgxsJ24RhOSUGuyUB4Tb1p8NhY1v+9KgkzS1+M7Ug7bgIjr2VpBcDmN0F2luCaDTK
	 41j+Gw/ysxvERFZPJsjy2pkKjr3DyBsWX5V2dNWFmJaeCoLZTlIt3duu5pz5Aa+1TT
	 RF/gj7bOzD3QjwQsjSlzsNWVDQslxCKEXzzydMAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgABWPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgABWO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:14:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57DB8227BF;
        Thu,  2 Jan 2020 22:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003296;
        bh=kk9yOZTwuv8VYKJ05BvJm+gyiXuuNdCaC8RdEZ+r5Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuMeN+0rAU5tkdPvfkjiaUPViYF5Qgqb6h8zrV4QST2X7pY5mAfmJBL81A5HcCO57
         5MNs5sh8KgIO62KjNFd7QRE7oO/mX/7pb/mbNlcSxyuXRB5XWiqRWKv3O6tIv+gFzn
         23x+5Penk5M3Lgc6sEPCt1N6JNq689k5XuYl/1XE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 102/191] tools/power/x86/intel-speed-select: Ignore missing config level
Date:   Thu,  2 Jan 2020 23:06:24 +0100
Message-Id: <20200102215840.854346558@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 6dee5332c9d3..fde3f9cefc6d 100644
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
index 40346d534f78..b11575c3e886 100644
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



