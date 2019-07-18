Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E25C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8316821783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="yDAMvNM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbfGRCJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:09:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37114 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388266AbfGRCJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:09:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so27293825otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 19:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OcGPHgnMxbI2wU1xT/V0QozYnY7nlRi/cdJFTvYjEvI=;
        b=yDAMvNM9G2xW3IW0xmzcT8InMI5MERjBNmrSwp51Hoa420m8Mm9XuRTbqtYfvP7vK0
         nlkEPsiLCpiErLfpG+gJtl3Guy6jngjiT3ZTKfMf16ZJC/otStBMZNEKqb8CyzPiVwqG
         eGTG+Dh9AkuARboDvIy7rL4h8mc3x1Gm+V8s9t5PVRI2SiFgaAeBb3q6jTV3YAE8q38B
         MhCZoirfl2ymkkF6+xbDMfjTeWcLQX4bFHMOuBkIW4V1LDEMZCrn9jhBWezqGK5jUD5Q
         LOlUrLPSUSoBQcbHzEHqC+SIWA05MhZj0YvzSwtA/XKCMrdMXMSMNsdKLHR5PALS2nCg
         q5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OcGPHgnMxbI2wU1xT/V0QozYnY7nlRi/cdJFTvYjEvI=;
        b=oOWJxHedY6wgtxOb6ZG7qrEB/+6TmlKqcWKP/pO4AXk/UEFUAD3f6sJz0jI/NELwym
         6+jCptHyueSaiktXRQLK9sKvp4ECqnrTcbkFFYnITjQ2O199lIips8YCho1A39Pef//j
         CKqPg2qI4NvTFTc5muY4pg81pcsX+LuVjUo/B2eVpHTN9DAeCi14hgtJ+PC1EfTCSeA1
         D5Se0sNejKm9vNCX9BgaRhk9MFONytEA8JiA4VNdyCjl4wgTmgv4xsuBniZmNRMSV+bE
         VKZX9Wg4KxuKV1mrbJ33lqb6n0dV+VoDWNwocotWAOyuUC94+SBUOJwMh8jqRSHtXu1H
         ljAA==
X-Gm-Message-State: APjAAAWLypLWW838rVo0qvTnuHwY918Zyn0uYNT3l9AKg/DJcqfoB9Js
        toXh0ByUWTaJwBwRBQMNEl8=
X-Google-Smtp-Source: APXvYqw92JOeNlZ+0UGonsrxs8jupsg1Scl+YF7mhKztA9j+fbMlWUdrC7J/HxDXpZF3dwfzi5CNgA==
X-Received: by 2002:a9d:70da:: with SMTP id w26mr30907101otj.270.1563415748819;
        Wed, 17 Jul 2019 19:09:08 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:18af:e893:6cb0:139a])
        by smtp.gmail.com with ESMTPSA id i11sm8985651oia.9.2019.07.17.19.09.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 19:09:08 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     aelior@marvell.com, GR-everest-linux-l2@marvell.com
Cc:     Frederick Lawler <fred@fredlawl.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: [PATCH] qed: Prefer pcie_capability_read_word()
Date:   Wed, 17 Jul 2019 21:07:42 -0500
Message-Id: <20190718020745.8867-7-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718020745.8867-1-fred@fredlawl.com>
References: <20190718020745.8867-1-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 7873d6dfd91f..8d8a920c3195 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -530,9 +530,8 @@ static void qed_rdma_init_devinfo(struct qed_hwfn *p_hwfn,
 	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_LOCAL_INV_FENCE, 1);
 
 	/* Check atomic operations support in PCI configuration space. */
-	pci_read_config_dword(cdev->pdev,
-			      cdev->pdev->pcie_cap + PCI_EXP_DEVCTL2,
-			      &pci_status_control);
+	pcie_capability_read_dword(cdev->pdev, PCI_EXP_DEVCTL2,
+				   &pci_status_control);
 
 	if (pci_status_control & PCI_EXP_DEVCTL2_LTR_EN)
 		SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_ATOMIC_OP, 1);
-- 
2.17.1

