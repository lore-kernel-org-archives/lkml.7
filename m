Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C7DC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D592087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240036;
	bh=IES2gzjHh5bR0nlAMDeCGbP3OJIayupcImNl0I8uaNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bhg8a31ZdpsICUHbJKbqUf8JBrq+x4nv3iPw186XL8+mhyMa4BTrtc00egpmEtdr5
	 ABBm5A9+x+QFouWByzz6PUntdHAYqA/sYSjNI0+61I0kusdPLukuzyjDknMTH4oyEF
	 qcvGNFXSnFkEZhRQI/IiFITZ8xlP5yygdxxgR5sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391420AbfKHTHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:07:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387807AbfKHTHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:07:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 933392087E;
        Fri,  8 Nov 2019 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240029;
        bh=IES2gzjHh5bR0nlAMDeCGbP3OJIayupcImNl0I8uaNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+FY/TbX4Nsmslxnrz+spB6EyUrcizv7JgYvGb4JCZuwBhij5rZGf4NgwGf6FyDyH
         BmGze2Gv9R0VwsWmFelow6N9LB+oUwl22lf9JUZ51mSL4h0G6R2wGuw4Rev+W8wuX1
         4vIvehPBef35IVuSdDb9dc92Lgyj2dmSiv1eBrJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 063/140] drm/komeda: Dont flush inactive pipes
Date:   Fri,  8 Nov 2019 19:49:51 +0100
Message-Id: <20191108174909.213582489@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihail Atanassov <Mihail.Atanassov@arm.com>

[ Upstream commit b88639b8e3808c948169af390bd7e84e909bde8d ]

HW doesn't allow flushing inactive pipes and raises an MERR interrupt
if you try to do so. Stop triggering the MERR interrupt in the
middle of a commit by calling drm_atomic_helper_commit_planes
with the ACTIVE_ONLY flag.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191010102950.56253-1-mihail.atanassov@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index 69d9e26c60c81..9e110d51dc1f3 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -85,7 +85,8 @@ static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
-	drm_atomic_helper_commit_planes(dev, old_state, 0);
+	drm_atomic_helper_commit_planes(dev, old_state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY);
 
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
 
-- 
2.20.1



