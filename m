Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229A1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E085C2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103392;
	bh=H7hw6DxGbtamZt0t1x6Acdh2B9KOhUSrzHM4QgelhzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W846JMpaijX7om99EEsHEHYMIpVMSqqZlpeAsJ3Dpw+ktkVcrSXJALmiI5DuTzn+e
	 e6CMeemEa12HHKbI4b3iuiYnDavgAQRQAr9L/wFL2mRgDmIdGNiJwiriAJPWdAMZom
	 RbnkyKQMvXiSHPGd0JFGzB5Spnr9Imr4ZNUcDhsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfH2S3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbfH2SOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:14:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9673F233FF;
        Thu, 29 Aug 2019 18:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102486;
        bh=H7hw6DxGbtamZt0t1x6Acdh2B9KOhUSrzHM4QgelhzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yr8nMhZ+GyRXTJpYKf9pkDjTB+XiNwm8o9OP7iQ/N6rPZgJi161RKRUqgzYpj1fk4
         JOSzCkZ3dSecyodw6rYUV7vZTjTdhRkxB0O5GHDxSMmzmFAwnsd1fG7inU7K28gPhm
         ayNFVAlTgdefhHisyPsWTWE6+D2rInJrYt9WBxy8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 44/76] net: cavium: fix driver name
Date:   Thu, 29 Aug 2019 14:12:39 -0400
Message-Id: <20190829181311.7562-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
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
index 73632b8437498..b821c9e1604cf 100644
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

