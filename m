Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41384C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17133206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380760;
	bh=PerjJq8RtcCHS4m1Bz+YroaFuFXujxQwpgh+O0P6CYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=InFena7L7DKbfCN3tWkOMoPvU/7wkFWBCV/Dh+ddVmSuGvGP6RVpagYTthvREvePv
	 eeXPKWdducNZd+wdalGieYFDnPEtnPSU5gbFi7tfUz1oKJ5xfqvI8MxgTs3dw1ALtH
	 vk3Hf9OAK2cbKnWK+u+Dz6x63LncaTopoJCumE1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbfIMNTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390356AbfIMNTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:19:17 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E26CA206A5;
        Fri, 13 Sep 2019 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380756;
        bh=PerjJq8RtcCHS4m1Bz+YroaFuFXujxQwpgh+O0P6CYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRskDQvWZfGC9pbDXbH/Vv0rda1Ddspu4zqiYUqxSvEd/HWemVC8Ir+m1WzKKI8uu
         IixIruIyO2EsZ+Vumi0Dmk6GloO1HExpEof8i7tjcejjot0zq9iY59v5rVtSMD1eNx
         3L6EyajUywV01OxYzElv079IuLxiTAhVKvAbwkKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Louis Li <Ching-shih.Li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 137/190] drm/amdgpu: fix ring test failure issue during s3 in vce 3.0 (V2)
Date:   Fri, 13 Sep 2019 14:06:32 +0100
Message-Id: <20190913130610.950072079@linuxfoundation.org>
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

[ Upstream commit ce0e22f5d886d1b56c7ab4347c45b9ac5fcc058d ]

[What]
vce ring test fails consistently during resume in s3 cycle, due to
mismatch read & write pointers.
On debug/analysis its found that rptr to be compared is not being
correctly updated/read, which leads to this failure.
Below is the failure signature:
	[drm:amdgpu_vce_ring_test_ring] *ERROR* amdgpu: ring 12 test failed
	[drm:amdgpu_device_ip_resume_phase2] *ERROR* resume of IP block <vce_v3_0> failed -110
	[drm:amdgpu_device_resume] *ERROR* amdgpu_device_ip_resume failed (-110).

[How]
fetch rptr appropriately, meaning move its read location further down
in the code flow.
With this patch applied the s3 failure is no more seen for >5k s3 cycles,
which otherwise is pretty consistent.

V2: remove reduntant fetch of rptr

Signed-off-by: Louis Li <Ching-shih.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 5f3f540738187..17862b9ecccd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1070,7 +1070,7 @@ void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	uint32_t rptr = amdgpu_ring_get_rptr(ring);
+	uint32_t rptr;
 	unsigned i;
 	int r, timeout = adev->usec_timeout;
 
@@ -1084,6 +1084,9 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
 			  ring->idx, r);
 		return r;
 	}
+
+	rptr = amdgpu_ring_get_rptr(ring);
+
 	amdgpu_ring_write(ring, VCE_CMD_END);
 	amdgpu_ring_commit(ring);
 
-- 
2.20.1



