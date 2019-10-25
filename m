Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D083CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2833921D82
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572011767;
	bh=YHnkUtw/XFK3xLZfVX45y1vkAAIo5c2SU20QP3kvqz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y68Vp/oP2ThpFI/6u+zIWRpOBVmmBFgvcXClZZJ+gRrspffo5bHZjGcLa8XpFSt4V
	 FfuMjMRyO0snZvwil6a7rxFMV9gaP4/A5lsLKh7LC0Re6XZWvTCr3UHOHO2jRltxxY
	 MxrCzSF8IJTblkeLpwCzMr850cDiSIReKdhrKyf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505231AbfJYN4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505204AbfJYNz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:55:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DE121E6F;
        Fri, 25 Oct 2019 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011757;
        bh=YHnkUtw/XFK3xLZfVX45y1vkAAIo5c2SU20QP3kvqz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGwWxYJP6lUgbX8jY5COVBfApoiUAEcB3UQbq4S+BTlz4lAQwF0/5veIsOzQk72tm
         vvNXAzFuZtnsqiANaCV2iLMRj10gSjysSQ7QZmFQatrUuJZZY4H8+cBEoDiD+PCPId
         IWBnHwkEIoMhc2OwJmE29HdFcqHYs8HD9UDMKcIY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.3 33/33] nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T
Date:   Fri, 25 Oct 2019 09:55:05 -0400
Message-Id: <20191025135505.24762-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025135505.24762-1-sashal@kernel.org>
References: <20191025135505.24762-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

[ Upstream commit 19ea025e1d28c629b369c3532a85b3df478cc5c6 ]

Kingston NVME SSD with firmware version E8FK11.T has no interrupt after
resume with actions related to suspend to idle. This patch applied
NVME_QUIRK_SIMPLE_SUSPEND quirk to fix this issue.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204887
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7bd69033..079da1c613f04 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2267,6 +2267,16 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
+	},
+	{
+		/*
+		 * This Kingston E8FK11.T firmware version has no interrupt
+		 * after resume with actions related to suspend to idle
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=204887
+		 */
+		.vid = 0x2646,
+		.fr = "E8FK11.T",
+		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
 	}
 };
 
-- 
2.20.1

