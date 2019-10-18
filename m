Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1518CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765A5222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436348;
	bh=iFIf0wFFOUOAcciDtYRpAE39yuJj+gPS2RjdgrQPWrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QtO4VwBAnBITaPbY68PUebTTvfrn2XZhuBbXaHuEk4wDYwFxSO+vHpthfYEx5U3LU
	 XUkuhSWwlPv279EMU5f117OUksYjlT++uNxtHbHVU8igy/HF1p+aADyYpKSsPffknR
	 7FW4ojQ5e0/zoiaAHj440StuJ3p915OBNesY6BSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfJRWFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbfJRWFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:05:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E8B5222C6;
        Fri, 18 Oct 2019 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436343;
        bh=iFIf0wFFOUOAcciDtYRpAE39yuJj+gPS2RjdgrQPWrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLO1HDkiflEV4iTkPp0ETEJUsgeAFfuHa7SjFrBZ4YvOoGvXtg3pXwlxzh8zKp2T7
         3zdou2pp61xIUi/PkAh6xUnoGRJbnfmQ04jSJI6VrJJ5Ctg8rXWRKsNPZ0jpm2ni7N
         N7Yv27uTESfGi4gDmI/A1mfqouey2FzVznfasDCA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 010/100] tools/power turbostat: fix goldmont C-state limit decoding
Date:   Fri, 18 Oct 2019 18:03:55 -0400
Message-Id: <20191018220525.9042-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

[ Upstream commit 445640a563493f28d15f47e151e671281101e7dc ]

When the C-state limit is 8 on Goldmont, PC10 is enabled.
Previously turbostat saw this as "undefined", and thus assumed
it should not show some counters, such as pc3, pc6, pc7.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 71cf7e77291ad..823bbc741ad7a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1953,11 +1953,12 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 #define PCL_7S 11 /* PC7 Shrink */
 #define PCL__8 12 /* PC8 */
 #define PCL__9 13 /* PC9 */
-#define PCLUNL 14 /* Unlimited */
+#define PCL_10 14 /* PC10 */
+#define PCLUNL 15 /* Unlimited */
 
 int pkg_cstate_limit = PCLUKN;
 char *pkg_cstate_limit_strings[] = { "reserved", "unknown", "pc0", "pc1", "pc2",
-	"pc3", "pc4", "pc6", "pc6n", "pc6r", "pc7", "pc7s", "pc8", "pc9", "unlimited"};
+	"pc3", "pc4", "pc6", "pc6n", "pc6r", "pc7", "pc7s", "pc8", "pc9", "pc10", "unlimited"};
 
 int nhm_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCL__3, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int snb_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCL__7, PCL_7S, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
@@ -1965,7 +1966,7 @@ int hsw_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL__3, PCL__6, PCL__7, PCL_7S,
 int slv_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7};
 int amt_pkg_cstate_limits[16] = {PCLUNL, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
-int bxt_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int glm_pkg_cstate_limits[16] = {PCLUNL, PCL__1, PCL__3, PCL__6, PCL__7, PCL_7S, PCL__8, PCL__9, PCL_10, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int skx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 
 
@@ -3165,7 +3166,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
-		pkg_cstate_limits = bxt_pkg_cstate_limits;
+		pkg_cstate_limits = glm_pkg_cstate_limits;
 		break;
 	default:
 		return 0;
-- 
2.20.1

