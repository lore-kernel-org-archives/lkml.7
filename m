Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83875C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB6D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562770987;
	bh=/vtEnW8CheOg/PZakRy0pEmXXolFD9Kz9w6eiA82Mds=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y1alHPleuWiV6vH7f97OJ9q2BY552GV7biNjcsuq12FIJRIamskFEe8/QVzXnn3Y6
	 FVOtFd9tpyq3RO9STAVQdRZXUr60orBjl7OZVdqiVH/txlnCrqOvblv3kmpUrXfWw+
	 OE+2jiZZWTZZtGvCAxnfEE55LVUuuL6ev+4aqOG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGJPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfGJPDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:03:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D3E2064B;
        Wed, 10 Jul 2019 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562770983;
        bh=/vtEnW8CheOg/PZakRy0pEmXXolFD9Kz9w6eiA82Mds=;
        h=From:To:Cc:Subject:Date:From;
        b=aO9kbZTfCvbs6dXSxrjRz9TfL1cfQLi2UjJxat08xiP956Vo10A1sOZRg5TAS2aF2
         UGnKckIX7lQavyEWpwhkJjan+AO+IAxmr1cCVdpz1zWStzrQWZstBo5FbCURyeu4Xo
         3MAkwY5U4G36fNUc83vt9ZMMYgpGadd8688IJOZ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Hellermann <stefan@the2masters.de>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 1/9] MIPS: ath79: fix ar933x uart parity mode
Date:   Wed, 10 Jul 2019 11:02:51 -0400
Message-Id: <20190710150301.7129-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hellermann <stefan@the2masters.de>

[ Upstream commit db13a5ba2732755cf13320f3987b77cf2a71e790 ]

While trying to get the uart with parity working I found setting even
parity enabled odd parity insted. Fix the register settings to match
the datasheet of AR9331.

A similar patch was created by 8devices, but not sent upstream.
https://github.com/8devices/openwrt-8devices/commit/77c5586ade3bb72cda010afad3f209ed0c98ea7c

Signed-off-by: Stefan Hellermann <stefan@the2masters.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mach-ath79/ar933x_uart.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath79/ar933x_uart.h b/arch/mips/include/asm/mach-ath79/ar933x_uart.h
index c2917b39966b..bba2c8837951 100644
--- a/arch/mips/include/asm/mach-ath79/ar933x_uart.h
+++ b/arch/mips/include/asm/mach-ath79/ar933x_uart.h
@@ -27,8 +27,8 @@
 #define AR933X_UART_CS_PARITY_S		0
 #define AR933X_UART_CS_PARITY_M		0x3
 #define	  AR933X_UART_CS_PARITY_NONE	0
-#define	  AR933X_UART_CS_PARITY_ODD	1
-#define	  AR933X_UART_CS_PARITY_EVEN	2
+#define	  AR933X_UART_CS_PARITY_ODD	2
+#define	  AR933X_UART_CS_PARITY_EVEN	3
 #define AR933X_UART_CS_IF_MODE_S	2
 #define AR933X_UART_CS_IF_MODE_M	0x3
 #define	  AR933X_UART_CS_IF_MODE_NONE	0
-- 
2.20.1

