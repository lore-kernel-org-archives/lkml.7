Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BB6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045721874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103076;
	bh=wqUIqAOQdZDZwLQhc3zJBFZ+4LlvNbuhEy1DRGKsDUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l7DsqFiaRYoCLHq4fQs9qSPGFb6EF25S5uiuOsIZXi9P1veAhDBD3485x1vdgMYNL
	 Ht7RvOWLUh8kGCQmBgyDDBYOwinttVDNntKG5utI6yeuKjHZ1UICbjIrfGql//WPKP
	 Ipi6VAdfp+MGk1moYBb6xhXZugSWngUfuKMzBkk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfH2SYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbfH2SQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2357B2189D;
        Thu, 29 Aug 2019 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102585;
        bh=wqUIqAOQdZDZwLQhc3zJBFZ+4LlvNbuhEy1DRGKsDUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cO46U0SVioCJUqlIVdNO0qoNuIQ9xV82RfYLGxzWZt6TPM2rhWLOarb1dg8Poeo1h
         LpFkKAbFrho5HTk00buaITMEMLqR/9xAzvGgmiDcYaUFzhJzuU9u2cDSJiRpRJygUZ
         0kyBrnWgiF+UwUpjit7fKcXAj44xGDg49xdtK+Rs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 26/45] net: cavium: fix driver name
Date:   Thu, 29 Aug 2019 14:15:26 -0400
Message-Id: <20190829181547.8280-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 3434341004a380f4e47c3a03d4320d43982162a0 ]

The driver name gets exposed in sysfs under /sys/bus/pci/drivers
so it should look like other devices. Change it to be common
format (instead of "Cavium PTP").

This is a trivial fix that was observed by accident because
Debian kernels were building this driver into kernel (bug).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 6aeb1045c302a..1ab40c97403ba 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -10,7 +10,7 @@
 
 #include "cavium_ptp.h"
 
-#define DRV_NAME	"Cavium PTP Driver"
+#define DRV_NAME "cavium_ptp"
 
 #define PCI_DEVICE_ID_CAVIUM_PTP	0xA00C
 #define PCI_DEVICE_ID_CAVIUM_RST	0xA00E
-- 
2.20.1

