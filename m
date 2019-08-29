Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF87C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649AD20578
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103246;
	bh=daF/PX4Ijm80cFU8SbPUPm1tciP79fQ1UuLIBgd+6cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dIrVRQ4tOxep02cuxp2QqAKMdTMd5dCeJqQjo698wjPLI3u5AgShK7rZCmZwNui8Z
	 TsmssRgYYdvkoscI5MuO2l3qppd/1IUR5ZDy6mbQQKFmmhc1K8y9CQxfpoC/RcS3Dv
	 V5huRB/6cYIlle25RR4mZQgudetpWPMDZ7C6ZHRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfH2SPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbfH2SPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:15:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09DAC23403;
        Thu, 29 Aug 2019 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102529;
        bh=daF/PX4Ijm80cFU8SbPUPm1tciP79fQ1UuLIBgd+6cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekIR7PTNPIiLkcRN2lZpzqWOCTeHU+qlFkpxr2MdvtnRkJ6pn+/Nv/GQec1BcJWip
         7yz0/Nn48qGiWXJxEscfPPH2sFkaJqQhSsXZHjNvL6i6qB1490zz0jq/mwEFD37Pgc
         bJvC2HxvjJ3ARCH+/5yVhP9j76q5GRqLU9Z6YU+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 65/76] drm/amdgpu: prevent memory leaks in AMDGPU_CS ioctl
Date:   Thu, 29 Aug 2019 14:13:00 -0400
Message-Id: <20190829181311.7562-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolai Hähnle <nicolai.haehnle@amd.com>

[ Upstream commit 1a701ea924815b0518733aa8d5d05c1f6fa87062 ]

Error out if the AMDGPU_CS ioctl is called with multiple SYNCOBJ_OUT and/or
TIMELINE_SIGNAL chunks, since otherwise the last chunk wins while the
allocated array as well as the reference counts of sync objects are leaked.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fe028561dc0e6..bc40d6eabce7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1192,6 +1192,9 @@ static int amdgpu_cs_process_syncobj_out_dep(struct amdgpu_cs_parser *p,
 	num_deps = chunk->length_dw * 4 /
 		sizeof(struct drm_amdgpu_cs_chunk_sem);
 
+	if (p->post_deps)
+		return -EINVAL;
+
 	p->post_deps = kmalloc_array(num_deps, sizeof(*p->post_deps),
 				     GFP_KERNEL);
 	p->num_post_deps = 0;
@@ -1215,8 +1218,7 @@ static int amdgpu_cs_process_syncobj_out_dep(struct amdgpu_cs_parser *p,
 
 
 static int amdgpu_cs_process_syncobj_timeline_out_dep(struct amdgpu_cs_parser *p,
-						      struct amdgpu_cs_chunk
-						      *chunk)
+						      struct amdgpu_cs_chunk *chunk)
 {
 	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps;
 	unsigned num_deps;
@@ -1226,6 +1228,9 @@ static int amdgpu_cs_process_syncobj_timeline_out_dep(struct amdgpu_cs_parser *p
 	num_deps = chunk->length_dw * 4 /
 		sizeof(struct drm_amdgpu_cs_chunk_syncobj);
 
+	if (p->post_deps)
+		return -EINVAL;
+
 	p->post_deps = kmalloc_array(num_deps, sizeof(*p->post_deps),
 				     GFP_KERNEL);
 	p->num_post_deps = 0;
-- 
2.20.1

