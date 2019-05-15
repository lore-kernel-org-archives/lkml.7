Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF3AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A076220843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919754;
	bh=j61LhSmK9TMQDLxOBZSEwT2LYqrNx4PDVEZ88ReSy0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+rOqbp8yWO3R72usnpST5xvsiNuDQF8qO3i1jOUFpD+vs1WNq/N540rWGO20TZIG
	 naXt16NX5AwVzQy+hYSMp1vDKRzVfmj54CzaC64F9ppyIu2vltrkafgtrGa69EQthI
	 ID3f8w8Mg/hq1nF3DejXshkbqceUi1TonpzU/8Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbfEOL3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732494AbfEOL3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:29:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08597206BF;
        Wed, 15 May 2019 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919749;
        bh=j61LhSmK9TMQDLxOBZSEwT2LYqrNx4PDVEZ88ReSy0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jy4pb13BbEP3oTyapBNSmNM3XO49ZYglXqdidICA/XBjWq6mdIbtRuxYRxqxB0Kj1
         k+fc7TIK8y7Cc/lJbQkqUc8EmMCbiGzS99FiO3tmjKqyJCMgQ5QfVf3W4/TxN2D0SA
         GZmZdbpQhl3T0M9vPlnLendDGlZEvw4Wu7paIcRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wentao Lou <Wentao.Lou@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 035/137] drm/amdgpu: shadow in shadow_list without tbo.mem.start cause page fault in sriov TDR
Date:   Wed, 15 May 2019 12:55:16 +0200
Message-Id: <20190515090655.911697440@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b575f10dbd6f84c2c8744ff1f486bfae1e4f6f38 ]

shadow was added into shadow_list by amdgpu_bo_create_shadow.
meanwhile, shadow->tbo.mem was not fully configured.
tbo.mem would be fully configured by amdgpu_vm_sdma_map_table until calling amdgpu_vm_clear_bo.
If sriov TDR occurred between amdgpu_bo_create_shadow and amdgpu_vm_sdma_map_table,
amdgpu_device_recover_vram would deal with shadow without tbo.mem.start.

Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d55dd570a7023..27baac26d8e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3150,6 +3150,7 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.mem.mem_type != TTM_PL_TT ||
+		    shadow->tbo.mem.start == AMDGPU_BO_INVALID_OFFSET ||
 		    shadow->parent->tbo.mem.mem_type != TTM_PL_VRAM)
 			continue;
 
-- 
2.20.1



