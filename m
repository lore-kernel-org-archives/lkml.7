Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0728C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2CB21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600941;
	bh=GOQxWeZsz605KEGKjrEskT5ZXPhExynzzn/kr1UpyCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yaIrbtnrz0l0zv6YliHTZQxpw4AStpdRjANm7ODHCI9T4sYUvCUHaE2W7wzEGq7iH
	 uuOwJ8F8l3Jp8B4Atv62FrahWNvVBCxviphnhMmZDlpk1EclQnX0dwUMM+cZd/bQn2
	 hjmg75PEOJ8eGi5QmoAbW9NlfK4NVRqogu+UIovA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfGHPtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:49:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732799AbfGHPRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:17:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF29A21707;
        Mon,  8 Jul 2019 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599042;
        bh=GOQxWeZsz605KEGKjrEskT5ZXPhExynzzn/kr1UpyCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRodN9cErH0xoiryrMm8pQE3W3jh6tT4sVChZy5z+qa91clIN/cBEY8Ddi2Clrjwu
         OTda9/8BuOni9yIphG4wnpqkI/bqGYes0zX3whd8UxqAhw3rIKspDv2AfUCIIKmRBP
         BlVlhKX5h37bgRSFq8S8m0KLtBy5MJjSWN7VQkW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 58/73] mfd: omap-usb-tll: Fix register offsets
Date:   Mon,  8 Jul 2019 17:13:08 +0200
Message-Id: <20190708150524.402102929@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 993dc737c0996c163325961fb62a0ed9fd0308b4 ]

gcc-8 notices that the register number calculation is wrong
when the offset is an 'u8' but the number is larger than 256:

drivers/mfd/omap-usb-tll.c: In function 'omap_tll_init':
drivers/mfd/omap-usb-tll.c:90:46: error: overflow in conversion from 'int' to 'u8 {aka unsigned char}' chages value from 'i * 256 + 2070' to '22' [-Werror=overflow]

This addresses it by always using a 32-bit offset number for
the register. This is apparently an old problem that previous
compilers did not find.

Fixes: 16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/omap-usb-tll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index fe51e9709210..1093d8ad232b 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -129,12 +129,12 @@ static inline u32 usbtll_read(void __iomem *base, u32 reg)
 	return readl_relaxed(base + reg);
 }
 
-static inline void usbtll_writeb(void __iomem *base, u8 reg, u8 val)
+static inline void usbtll_writeb(void __iomem *base, u32 reg, u8 val)
 {
 	writeb_relaxed(val, base + reg);
 }
 
-static inline u8 usbtll_readb(void __iomem *base, u8 reg)
+static inline u8 usbtll_readb(void __iomem *base, u32 reg)
 {
 	return readb_relaxed(base + reg);
 }
-- 
2.20.1



