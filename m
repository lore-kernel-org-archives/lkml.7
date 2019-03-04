Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFD621734
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="cznaj45I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfCDW3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:29:13 -0500
Received: from tomli.me ([153.92.126.73]:44168 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfCDW3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:29:11 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 88e7bcfd;
        Mon, 4 Mar 2019 22:29:08 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Mar 2019 22:29:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=g98gt4epZhMmQBBYY5nZu5LNFHdlzQA76yj3bYjm22E=; b=cznaj45InNEOW9lOyAEKvryCdL+aYjYIpiC/cruUsNyBSAcWA/1DlR6ogQjETe82x+yQgqjUr/AgAhkmAQilnPW10QSowlGxWBiSqNegJdF5Eyrx//ZDgJvwQjL6wSDszH2NBCHBfvYGHzvOl7RmbEJq+8exDAblJMlfWVoNJjFcFzYSOJ3E2z285Omajpg1aSkqknee1WEgb3I2JiW7b14V7eYZafUbvpibESZZPY9MHzo3pu6Fw6TWa+kp18aRK+tmibjC+w0DsUH1GPko+PvZZsjuA7IOYmQJSRrQmg9HACZCIm58aNEgchNTyHOJhf4ar/+2jI8/GgCFYww9qg==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] mips: loongson64: select MFD_YEELOONG_KB3310B for LEMOTE_MACH2F.
Date:   Tue,  5 Mar 2019 06:28:43 +0800
Message-Id: <20190304222848.25037-3-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304222848.25037-1-tomli@tomli.me>
References: <20190304222848.25037-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ease the support of platform drivers on Lemote Yeeloong laptop,
code for accessing the embedded controller has been separated from
arch/mips, as a MFD driver. Since the board files here still need
to access the EC directly to handle reboot/shutdown and interrupts,
we make MFD_YEELOONG_KB3310B as a mandatory dependency.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 arch/mips/loongson64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 4c14a11525f4..b423d5bba812 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -56,6 +56,7 @@ config LEMOTE_MACH2F
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select LOONGSON_MC146818
+	select MFD_YEELOONG_KB3310B
 	help
 	  Lemote Loongson 2F family machines utilize the 2F revision of
 	  Loongson processor and the AMD CS5536 south bridge.
-- 
2.20.1

