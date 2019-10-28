Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1104CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE04521848
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfJ1DQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:16:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40288 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbfJ1DQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:16:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A5D31A0B42;
        Mon, 28 Oct 2019 04:16:16 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A3A11A0B20;
        Mon, 28 Oct 2019 04:16:12 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 592FD40334;
        Mon, 28 Oct 2019 11:16:03 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 6/9] ARM: imx: Add serial number support for i.MX6ULZ
Date:   Mon, 28 Oct 2019 11:12:47 +0800
Message-Id: <1572232370-31580-7-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572232370-31580-1-git-send-email-Anson.Huang@nxp.com>
References: <1572232370-31580-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULZ has a 64-bit SoC unique ID stored in OCOTP, it can be used
as SoC serial number, see below example:

root@imx6ul7d:~# cat /sys/devices/soc0/serial_number
8797AEF098CAB901

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 1e8150e..1274b52 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -150,6 +150,7 @@ struct device * __init imx_soc_device_init(void)
 		soc_id = "i.MX6ULL";
 		break;
 	case MXC_CPU_IMX6ULZ:
+		ocotp_compat = "fsl,imx6ul-ocotp";
 		soc_id = "i.MX6ULZ";
 		break;
 	case MXC_CPU_IMX6SLL:
-- 
2.7.4

