Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D3C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D633C20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688770;
	bh=OchKs05qdkjClU5WOqV2loJQE5fk7oCW8/Jw1KUXi7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgzodcgIlFzTCIIYN2lqiBVSmiARYiUuOtHVSmCYdiGkLl2qOR8QKfar+9KRyvdXI
	 OG5FdRZBh3EL5/4B2TqkJbTWJiZI0ArYN8eOPp7Vv7I3jM0ePQ5kN0Mw1KOyel7uda
	 TevEJs2VKAVd/hbIsw5W5eWla8uY8PrIIViRak0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfCDIdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbfCDIdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:33:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3531420836;
        Mon,  4 Mar 2019 08:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688420;
        bh=OchKs05qdkjClU5WOqV2loJQE5fk7oCW8/Jw1KUXi7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwvTTRtca2K/p9goGruKcpfJ76HB6RuAiLMFZtuHQhzKeIPDMH9fwDNByAPdynASb
         6pxxnKUnfoKjfZFIsEirVp9M3MCQ5MXyBWHEe4dTnUjviZVQqDVv2dsFLkWuRY/RHo
         ljHFst4Q2i3z6muIn2OZPhpQWtvpdgNrNMYBzuzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 39/88] drm/amd/powerplay: OD setting fix on Vega10
Date:   Mon,  4 Mar 2019 09:22:22 +0100
Message-Id: <20190304081632.126851076@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6d87dc97eb3341de3f7b1efa3156cb0e014f4a96 ]

gfxclk for OD setting is limited to 1980M for non-acg
ASICs of Vega10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../powerplay/hwmgr/vega10_processpptables.c  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
index b8747a5c9204d..99d596dc0e897 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
@@ -32,6 +32,7 @@
 #include "vega10_pptable.h"
 
 #define NUM_DSPCLK_LEVELS 8
+#define VEGA10_ENGINECLOCK_HARDMAX 198000
 
 static void set_hw_cap(struct pp_hwmgr *hwmgr, bool enable,
 		enum phm_platform_caps cap)
@@ -258,7 +259,26 @@ static int init_over_drive_limits(
 		struct pp_hwmgr *hwmgr,
 		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)
 {
-	hwmgr->platform_descriptor.overdriveLimit.engineClock =
+	const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =
+			(const ATOM_Vega10_GFXCLK_Dependency_Table *)
+			(((unsigned long) powerplay_table) +
+			le16_to_cpu(powerplay_table->usGfxclkDependencyTableOffset));
+	bool is_acg_enabled = false;
+	ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_v2;
+
+	if (gfxclk_dep_table->ucRevId == 1) {
+		patom_record_v2 =
+			(ATOM_Vega10_GFXCLK_Dependency_Record_V2 *)gfxclk_dep_table->entries;
+		is_acg_enabled =
+			(bool)patom_record_v2[gfxclk_dep_table->ucNumEntries-1].ucACGEnable;
+	}
+
+	if (powerplay_table->ulMaxODEngineClock > VEGA10_ENGINECLOCK_HARDMAX &&
+		!is_acg_enabled)
+		hwmgr->platform_descriptor.overdriveLimit.engineClock =
+			VEGA10_ENGINECLOCK_HARDMAX;
+	else
+		hwmgr->platform_descriptor.overdriveLimit.engineClock =
 			le32_to_cpu(powerplay_table->ulMaxODEngineClock);
 	hwmgr->platform_descriptor.overdriveLimit.memoryClock =
 			le32_to_cpu(powerplay_table->ulMaxODMemoryClock);
-- 
2.19.1



