Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B67C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809FD208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380408;
	bh=lJB9KIomI+1Fk61KEPWZosRWpIMwyWCXx3FH6649FOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vFzPtAOp7Sz4ChYP58tF6pfPxeNb0NDWXVcgLbYGWb8nbC0AFpMNklKb6oVDlHVaC
	 k0GAIrzlFbgvjsBGzP1bt09EIsNPNyCw4imBiKNa6ErdRV7pt5lbd3cmxm228Y576Q
	 YP6CP/y+a0Jd0Mk1r1vyQsgFzWXCJT7im0gEO38k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbfIMNN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389309AbfIMNNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:13:22 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09010208C0;
        Fri, 13 Sep 2019 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380401;
        bh=lJB9KIomI+1Fk61KEPWZosRWpIMwyWCXx3FH6649FOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaSWJE38w6jGyPepaSNJK+fAdVCcePRrk3PqSxUsl7ZxzeeJybGm+mqsZqPhweR/D
         DTVdp0dpn8b5cl0LdOuPzsNxnsE6r9tIH14G53Q9ktoO7okfeNgYFFQcyyIj6XDRGX
         fyLbf+BTOe+DGL1vW03Qnd6zkhpI/13z0Y6OJFRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/190] drm/amd/dm: Understand why attaching path/tile properties are needed
Date:   Fri, 13 Sep 2019 14:05:08 +0100
Message-Id: <20190913130604.014601048@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 04ac4b0ed412f65230b456fcd9aa07e13befff89 ]

Path property is used for userspace to know what MST connector goes to what actual DRM DisplayPort connector, the tiling property is for tiling configurations. Not sure what else there is to figure out.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 59445c83f0238..c85bea70d9652 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -377,9 +377,6 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	drm_connector_attach_encoder(&aconnector->base,
 				     &aconnector->mst_encoder->base);
 
-	/*
-	 * TODO: understand why this one is needed
-	 */
 	drm_object_attach_property(
 		&connector->base,
 		dev->mode_config.path_property,
-- 
2.20.1



