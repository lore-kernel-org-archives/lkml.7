Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE69E2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410814;
	bh=t5FtK1B9FNoYPqzwuTajciMWRh0r9raKIMMoioKWTgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z2q91SoUIIa+q7DoDA15+ycEdiXpI710emImSG/+UYKyGjCIuUiQhv4eZPZb93gX1
	 nfPrwxzTsscC+a256CtP8LthtyEPRtfko4tYgGrdFbKg5nm70RDp/q6J13JolmHN8j
	 QdhV0q27B8mQYGaRWNyCCrkCx6P9UwXNSRBeOCQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfCLRNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfCLRM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:58 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E8C9217F5;
        Tue, 12 Mar 2019 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410777;
        bh=t5FtK1B9FNoYPqzwuTajciMWRh0r9raKIMMoioKWTgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fRiTQV9uPGqzESCdILgA4Ac/a7m1SMb/kb/Iu/6ov5iFNappTnssM0zV/jHZRSC3
         QGARQaIgdmEsuaIMCO7xXctMERkKfwba6X7bVw7S3cOsibc3+5V/0o3nSuT1SxVZVk
         W8Xic7cWfxJYn1bMzL9PMhqUf4B01xJ66Vv7hE/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Crystal Jin <Crystal.Jin@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 116/171] drm/amdgpu: fix the incorrect external id for raven series
Date:   Tue, 12 Mar 2019 10:08:16 -0700
Message-Id: <20190312170357.858266053@linuxfoundation.org>
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

[ Upstream commit 7e4545d372b560df10fa47281ef0783a479ce435 ]

This patch fixes the incorrect external id that kernel reports to user mode
driver. Raven2's rev_id is starts from 0x8, so its external id (0x81) should
start from rev_id + 0x79 (0x81 - 0x8). And Raven's rev_id should be 0x21 while
rev_id == 1.

Reported-by: Crystal Jin <Crystal.Jin@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4cc0dcb1a187..825d1cae85ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -705,11 +705,13 @@ static int soc15_common_early_init(void *handle)
 		break;
 	case CHIP_RAVEN:
 		if (adev->rev_id >= 0x8)
-			adev->external_rev_id = adev->rev_id + 0x81;
+			adev->external_rev_id = adev->rev_id + 0x79;
 		else if (adev->pdev->device == 0x15d8)
 			adev->external_rev_id = adev->rev_id + 0x41;
+		else if (adev->rev_id == 1)
+			adev->external_rev_id = adev->rev_id + 0x20;
 		else
-			adev->external_rev_id = 0x1;
+			adev->external_rev_id = adev->rev_id + 0x01;
 
 		if (adev->rev_id >= 0x8) {
 			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-- 
2.19.1



