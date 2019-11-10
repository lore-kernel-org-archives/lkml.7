Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C5C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59A322583
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354224;
	bh=H/QK2cUXjuCxu5n5CCGkede3gAy2IzrRCqu9ad+BuOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rk7C6ValAuNiK5rt6D0+OXeXHUKjYXDot4FQ0MXFGV/TzhYxp9Sqi0/2CtKjPpoVS
	 My3+gaUAatrI0EFoRThifk5qA4ZzYtXFi4j8j+d8hNxmdRBgY16G3TohTzYWAhzDJn
	 DsqLMkj7wi6K0Fi07agc3PbPiJ+mN5HAuglgnakU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfKJCuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbfKJCt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A2C22581;
        Sun, 10 Nov 2019 02:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354196;
        bh=H/QK2cUXjuCxu5n5CCGkede3gAy2IzrRCqu9ad+BuOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/mtaSpxkKCeEdn7o+Lq6CKQbjU9pMzfyYT61MBWTyRCv1pbYBqWSjw71vqyIxpkp
         3XMWtiFUsjRZGUhSb7P7EDAZJu2X4IXUrnUNnwLLUgXuRpg0xWLTQ+8+K6ywdxvZ00
         tVBDaZO2ZscsoMA3rordQc73NuGZ06EfTWX7NpZ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Qiang <liq3ea@gmail.com>, Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 43/66] vfio/pci: Fix potential memory leak in vfio_msi_cap_len
Date:   Sat,  9 Nov 2019 21:48:22 -0500
Message-Id: <20191110024846.32598-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Qiang <liq3ea@gmail.com>

[ Upstream commit 30ea32ab1951c80c6113f300fce2c70cd12659e4 ]

Free allocated vdev->msi_perm in error path.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 7b8a957b008d2..06a20ea183dd6 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1182,8 +1182,10 @@ static int vfio_msi_cap_len(struct vfio_pci_device *vdev, u8 pos)
 		return -ENOMEM;
 
 	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
-	if (ret)
+	if (ret) {
+		kfree(vdev->msi_perm);
 		return ret;
+	}
 
 	return len;
 }
-- 
2.20.1

