Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F5D216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127785;
	bh=NK3Gu0440IlcmUfslpeJUoyzrVonh+nts5KJQ4s0wiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rzJ6yyPYWfX83uMxvK6gNcgMGUOF4qUtz/K7k0RjJ4TR0sOPdhfyLkYrL3fMcKaJk
	 bCIk9TgFKz7DdRL9oNDhQchpQUSGYqpCq4t5PDRx9LNVdhHVszZHnvMIXCFZXGzUMJ
	 llxyqNqOSdMuFJ0LmwitS6p9CTVa8N1RuJP75Hg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfHFVnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfHFVe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:34:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E9C2089E;
        Tue,  6 Aug 2019 21:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127297;
        bh=NK3Gu0440IlcmUfslpeJUoyzrVonh+nts5KJQ4s0wiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xaesQYG/jCLbLYe8a4Sqc30N8fyxOlnqSHb3EM699B+4gB3E1KgTPdeGY04n5lS75
         AVXu5FbqCTYj3E6fKHEBfhL/ZTfwfgSzhUwiwar+d2S9dzQIw+mmBSCrwIO0GzT2rz
         SAeMEoIxd2NWHhK9+RTIirXyrjFqRqiYgyVUrzhg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 49/59] drm: msm: Fix add_gpu_components
Date:   Tue,  6 Aug 2019 17:33:09 -0400
Message-Id: <20190806213319.19203-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit 9ca7ad6c7706edeae331c1632d0c63897418ebad ]

add_gpu_components() adds found GPU nodes from the DT to the match list,
regardless of the status of the nodes.  This is a problem, because if the
nodes are disabled, they should not be on the match list because they will
not be matched.  This prevents display from initing if a GPU node is
defined, but it's status is disabled.

Fix this by checking the node's status before adding it to the match list.

Fixes: dc3ea265b856 (drm/msm: Drop the gpu binding)
Reviewed-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190626180015.45242-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 4a0fe8a25ad77..a56eef3cfee78 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1267,7 +1267,8 @@ static int add_gpu_components(struct device *dev,
 	if (!np)
 		return 0;
 
-	drm_of_component_match_add(dev, matchptr, compare_of, np);
+	if (of_device_is_available(np))
+		drm_of_component_match_add(dev, matchptr, compare_of, np);
 
 	of_node_put(np);
 
-- 
2.20.1

