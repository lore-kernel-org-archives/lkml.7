Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E49C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2882420675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557209246;
	bh=aOZj36Ff2NYl8WpZPWLGsNfaoe7Tvd0HAD3zK15Sy94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNhR3MS3kNKcq++vGsA18UlVbWd+d7bUCtPb7zM4+g9MQw5/4Dk4ZgLrkwi3UvFL6
	 XrPCpBrjzjtSnctnWNihN1Ls9rjQOVo9wIIQVijtJUluXP3QlcQgYKB/nV0jIw9vrI
	 Bte5jo9XjbwGTMmD9sN6yRAnT0ltdL1l08irgYYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfEGGHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfEGFde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:33:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217EF214AE;
        Tue,  7 May 2019 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207213;
        bh=aOZj36Ff2NYl8WpZPWLGsNfaoe7Tvd0HAD3zK15Sy94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vg93EXEIMsbUwEISVZP6cJZJn3E0VFQe7Oj2fUbEI+UABXym6I2CYiBWuvZKH8Xm+
         T54Mpg03QX6w7S5hrDjtJCNlESBx2Iju1NDjxGHBNiGQMc3yUjSkfc0VfEBXWGX6ZW
         ku/+v3xy0u72GbTE+vM2Ex2ElPtSWndShDoiIUSg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 29/99] vxge: fix return of a free'd memblock on a failed dma mapping
Date:   Tue,  7 May 2019 01:31:23 -0400
Message-Id: <20190507053235.29900-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 0a2c34f18c94b596562bf3d019fceab998b8b584 ]

Currently if a pci dma mapping failure is detected a free'd
memblock address is returned rather than a NULL (that indicates
an error). Fix this by ensuring NULL is returned on this error case.

Addresses-Coverity: ("Use after free")
Fixes: 528f727279ae ("vxge: code cleanup and reorganization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 7cde387e5ec6..51cd57ab3d95 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -2366,6 +2366,7 @@ static void *__vxge_hw_blockpool_malloc(struct __vxge_hw_device *devh, u32 size,
 				dma_object->addr))) {
 			vxge_os_dma_free(devh->pdev, memblock,
 				&dma_object->acc_handle);
+			memblock = NULL;
 			goto exit;
 		}
 
-- 
2.20.1

