Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08034C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F2B20644
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752203;
	bh=UurlDe7i5B6n4JttlHhN5xV2ui01PpBCGDYbfiv+K80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ALy+lmIDIOLSoxfY1BF8An/xXUUFn/yLb0H17pMssQU/YxMcQVoONPmcl6N6220/H
	 SLneHdAhssA6LXfOyjEofzpCzSJb9v/vzDIrs5p0wwC3IeDjzK6u/5Mu1FXU16C6av
	 6kFBo3jFSXbE3z/h8SIgkryD9BlbkTQsBq5LcANk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393967AbfHBNXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393936AbfHBNXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:23:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF9120644;
        Fri,  2 Aug 2019 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752195;
        bh=UurlDe7i5B6n4JttlHhN5xV2ui01PpBCGDYbfiv+K80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHvZzE7mgpCkKsyTyHF5fopY8G54FwAlgDrCy/P0f6bc+sqDu/lxSh5/qFbofSf7I
         5l58509lkfF0swGxJ1QA+nSJzrDnfdH9zgml7sZFlwOJArX+cTIq5qMIt91fuLAWOz
         EJmRLhGH6F0h5LGtEXd4KBeOFNHEazVKrpZd+Keg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 07/42] drm/amd/display: Wait for backlight programming completion in set backlight level
Date:   Fri,  2 Aug 2019 09:22:27 -0400
Message-Id: <20190802132302.13537-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132302.13537-1-sashal@kernel.org>
References: <20190802132302.13537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>

[ Upstream commit c7990daebe71d11a9e360b5c3b0ecd1846a3a4bb ]

[WHY]
Currently we don't wait for blacklight programming completion in DMCU
when setting backlight level. Some sequences such as PSR static screen
event trigger reprogramming requires it to be complete.

[How]
Add generic wait for dmcu command completion in set backlight level.

Signed-off-by: SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 070ab56a8aca7..da8b198538e5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -242,6 +242,10 @@ static void dmcu_set_backlight_level(
 	s2 |= (level << ATOM_S2_CURRENT_BL_LEVEL_SHIFT);
 
 	REG_WRITE(BIOS_SCRATCH_2, s2);
+
+	/* waitDMCUReadyForCmd */
+	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT,
+			0, 1, 80000);
 }
 
 static void dce_abm_init(struct abm *abm)
-- 
2.20.1

