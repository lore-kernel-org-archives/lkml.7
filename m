Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF6C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413789;
	bh=iasUKDSTjTCVxJPymSyyokGTUyI5zyrJ8klrcKJsIso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YcCVBymm1n161kEjnKtRd5FfUIkIzq7Z6TYDw+c8/GhuIPRgxB8O8zATbE182LWdB
	 rxJeodKaxtP82HR12f6zaICshi94jW4rW8xfEFST0Q1hr/jHvkmPcj4Wz3wupKEEP0
	 jR5ysITtUc9pfgpD59QsCEuzwrvS4OZ1o7IY4Gxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfCLSDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfCLRM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:57 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7334F2183E;
        Tue, 12 Mar 2019 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410776;
        bh=iasUKDSTjTCVxJPymSyyokGTUyI5zyrJ8klrcKJsIso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhswaRKf5FEpJP+d5aDY62wFJroZ7SNRm0J04nC6OzfcVNtoPoZrA1TcgxnvyDe1b
         MkL6B7jM//1VbOQg7I7EFIF+6cGRsXlAFP9QIBZ4ujEsZhylQ4zBJYwAu7+3OArlEt
         OEpy3L5Sck22JAZYLwSWkMF9swNkM9+ae1vb8qcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Cornwall <Jay.Cornwall@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 115/171] drm/amdgpu: Implement doorbell self-ring for NBIO 7.4
Date:   Tue, 12 Mar 2019 10:08:15 -0700
Message-Id: <20190312170357.787336917@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

[ Upstream commit 12292519d919ecde92e7e7c8acbcdb9f0c7c6013 ]

Fixes doorbell reflection on Vega20.

Change-Id: I0495139d160a9032dff5977289b1eec11c16f781
Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index f8cee95d61cc..7d5cbadbe1cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -92,7 +92,20 @@ static void nbio_v7_4_enable_doorbell_aperture(struct amdgpu_device *adev,
 static void nbio_v7_4_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
 							bool enable)
 {
+	u32 tmp = 0;
 
+	if (enable) {
+		tmp = REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_EN, 1) |
+		      REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+		      REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+
+		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			     lower_32_bits(adev->doorbell.base));
+		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			     upper_32_bits(adev->doorbell.base));
+	}
+
+	WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_CNTL, tmp);
 }
 
 static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
-- 
2.19.1



