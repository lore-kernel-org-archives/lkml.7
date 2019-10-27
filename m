Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E10BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216D8205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211865;
	bh=1oXKVfkAFl97KrAILvEm5RI32+UeZ6F9r+7sJe2Yyx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4OjkO2zhsqVB7iFM4ieeAWpjbykhe1Pu211qq2IhBBX6ydyskkw4QzDZ5B2OIy7d
	 0bwtw0m5DquQAQc5DyVyLhvYI3DjP1xUmVVh0izviIX5AH1ITyTSMWM6vVwDC+jfNU
	 hOTZfja5Qh0MFPSLFFVkL3fuawZGqAQisPLdn5D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfJ0VRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbfJ0VRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:17:49 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6739C2070B;
        Sun, 27 Oct 2019 21:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211069;
        bh=1oXKVfkAFl97KrAILvEm5RI32+UeZ6F9r+7sJe2Yyx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJhBzu9C94hD9LQMeKrkW953gmtU4vu14bct3HOgDuOgXy6f6HFGB1MrEdNlqaPSv
         duZ5FRBW+I3E9sZppV7WlYpQTx5QFaI7ScEunLbLe3REkkv9Wa0sZofHlDz3otG6UP
         eJ38hVQr2AZ10zrFCPLd4n1bmhL+DCf9AAsdeFFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gabriel Craciunescu <nix.or.die@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 021/197] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
Date:   Sun, 27 Oct 2019 21:58:59 +0100
Message-Id: <20191027203352.817988884@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Craciunescu <nix.or.die@gmail.com>

[ Upstream commit f03e42c6af60f778a6d1ccfb857db9b2ec835279 ]

Booting with default_ps_max_latency_us >6000 makes the device fail.
Also SUBNQN is NULL and gives a warning on each boot/resume.
 $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
   subnqn    : (null)

I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
To be sure is not a Laptop issue only, I tested the device on
my server board  with the same results.
( with 2x,4x link on the board and 4x link on a PCI-E card ).

Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 19458e85dab34..86763969e7cb0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3041,6 +3041,9 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.20.1



