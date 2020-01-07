Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A073C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4892072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431860;
	bh=0FPrfAYWfgPDqfXViR1QyGsDfKHNqmkdGpwuoIeIgPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U2+VjiaGlxXfHiPaTCWzrCEJRh62yZXqdDi1Y8Vxn7+K6jIQbr0cNa4w7gJzIJexC
	 aJU8b6L7DDfh8NZVkWG8xBO+EN988Ji4IQnZLS0Mp27fznrjMOwHfpsSVj9zp+DC+w
	 1Hmfrp49AiFdLgZbn8gW1qP4u9GqwrcvlEOPl1Ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgAGVRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:17:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgAGVFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:05:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942C92187F;
        Tue,  7 Jan 2020 21:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431141;
        bh=0FPrfAYWfgPDqfXViR1QyGsDfKHNqmkdGpwuoIeIgPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UlEMdEeg2bpMB1SI8f2hkqlWRGEXRV7Yz/owQWaWZIqHCz6Fu5zo2pbIo+JtGZOwr
         KI2FPOzJmixd1SVeXwuT0oMgk84guxclNHNMyQoUn9dRj3MGuWl6uzJwKvSUpp3vso
         N14CCJxWmhdELmC/NCIeiFBOoRN9ELiW+S38eL6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 004/115] drm/amdgpu: add cache flush workaround to gfx8 emit_fence
Date:   Tue,  7 Jan 2020 21:53:34 +0100
Message-Id: <20200107205243.168256216@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit bf26da927a1cd57c9deb2db29ae8cf276ba8b17b ]

The same workaround is used for gfx7.
Both PAL and Mesa use it for gfx8 too, so port this commit to
gfx_v8_0_ring_emit_fence_gfx.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5a9534a82d40..e1cb7fa89e4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6405,7 +6405,23 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 
-	/* EVENT_WRITE_EOP - flush caches, send int */
+	/* Workaround for cache flush problems. First send a dummy EOP
+	 * event down the pipe with seq one below.
+	 */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
+	amdgpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
+				 EOP_TC_ACTION_EN |
+				 EOP_TC_WB_ACTION_EN |
+				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
+				 EVENT_INDEX(5)));
+	amdgpu_ring_write(ring, addr & 0xfffffffc);
+	amdgpu_ring_write(ring, (upper_32_bits(addr) & 0xffff) |
+				DATA_SEL(1) | INT_SEL(0));
+	amdgpu_ring_write(ring, lower_32_bits(seq - 1));
+	amdgpu_ring_write(ring, upper_32_bits(seq - 1));
+
+	/* Then send the real EOP event down the pipe:
+	 * EVENT_WRITE_EOP - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
 	amdgpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
 				 EOP_TC_ACTION_EN |
@@ -7154,7 +7170,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 		5 +  /* COND_EXEC */
 		7 +  /* PIPELINE_SYNC */
 		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 9 + /* VM_FLUSH */
-		8 +  /* FENCE for VM_FLUSH */
+		12 +  /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		4 + /* double SWITCH_BUFFER,
 		       the first COND_EXEC jump to the place just
@@ -7166,7 +7182,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 		31 + /*	DE_META */
 		3 + /* CNTX_CTRL */
 		5 + /* HDP_INVL */
-		8 + 8 + /* FENCE x2 */
+		12 + 12 + /* FENCE x2 */
 		2, /* SWITCH_BUFFER */
 	.emit_ib_size =	4, /* gfx_v8_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v8_0_ring_emit_ib_gfx,
-- 
2.20.1



