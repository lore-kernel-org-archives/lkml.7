Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB8422BE9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997401;
	bh=HP3/a2oZIL74Jk6LrFo/J/9++kAyvAYs/l+UguAunkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YQ3pvTf1skogC2NAPK+CPe2UmvbmVltK+PssSIL2oHNbQHMrklscjN17uK6GNp9zo
	 VipstUyI1IBmNCqeVu+0s6shMLueHF9NBYNlCed9GIWJ7GIVrHVgg0iBhZT9CQ3avj
	 Mc+DvmOzM11WzLfbswf6/NBxbenLzUShkZ5+pdoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390524AbfGXTnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390073AbfGXTnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:43:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD77229F4;
        Wed, 24 Jul 2019 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997396;
        bh=HP3/a2oZIL74Jk6LrFo/J/9++kAyvAYs/l+UguAunkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUuWZvXAd+Dz0uXed+sdSqLrmQOOl664BaVT1lA+01z1LMiGQ5VebVQgJmQMJDXlh
         pi5X5d5OVkix5f3Jw8PPmQsb3rCuP2Wqbj6+A+fpkfDG3OkGc1bndKVtRvfKYe+5SO
         nXDjnjK2ApPwKjWFUIeWDeL+tVT+em3eCsMdCyxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Hellermann <stefan@the2masters.de>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 001/371] MIPS: ath79: fix ar933x uart parity mode
Date:   Wed, 24 Jul 2019 21:15:53 +0200
Message-Id: <20190724191724.521675033@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



