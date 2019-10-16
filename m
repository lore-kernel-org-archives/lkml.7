Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF87DFA372C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C96B207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264295;
	bh=f6t4c88a69fuHzhV8io9AVBJIcK7SkSDMOV9GaanKkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HoeHRhk4cGXbktZBrT9AxNSuPycA6IbMx+J0cvzrtRdoFR0/6NAa/ylf75VexvcfJ
	 8L0OKEKWO+Xc16vkd+sdPEt1LpoWFsRb7geMRVcpPG8wiY2286DmAzUifKjcKZBqfu
	 QVz5r427MgZwyNt8qJ6rj7rxdU8EFBCotQwn0RR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbfJPVyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394952AbfJPVyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:15 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005EE21925;
        Wed, 16 Oct 2019 21:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262855;
        bh=f6t4c88a69fuHzhV8io9AVBJIcK7SkSDMOV9GaanKkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2d5ps6xO5jN95Rr9xsLYnNx7RWcQKJLhxCJFoxms/k3JS08GFVDpeaWLjTGf9m6g
         PqS5cMOdilzbGfFYn6NtwGWGmXcC0fRSpY/g+dSqm0rorE5eeqOJ23KLK6L+90kdjg
         DLtkViwZdt0PQ+ZjZNqhe87HGbUNw7L/EE03vyDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Trek <trek00@inbox.ru>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/92] drm/amdgpu: Check for valid number of registers to read
Date:   Wed, 16 Oct 2019 14:49:54 -0700
Message-Id: <20191016214818.171084892@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trek <trek00@inbox.ru>

[ Upstream commit 73d8e6c7b841d9bf298c8928f228fb433676635c ]

Do not try to allocate any amount of memory requested by the user.
Instead limit it to 128 registers. Actually the longest series of
consecutive allowed registers are 48, mmGB_TILE_MODE0-31 and
mmGB_MACROTILE_MODE0-15 (0x2644-0x2673).

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=111273
Signed-off-by: Trek <trek00@inbox.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3938fca1ea8e5..24941a7b659f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -430,6 +430,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
 			sh_num = 0xffffffff;
 
+		if (info->read_mmr_reg.count > 128)
+			return -EINVAL;
+
 		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
 		if (!regs)
 			return -ENOMEM;
-- 
2.20.1



