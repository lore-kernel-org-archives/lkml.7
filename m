Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA976C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F58922B48
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468612;
	bh=V4IO6kOWJmt05tF5obmitFkuflGbBRrOd2f4vBuEhxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uWio70yl2Li8yf1U7rAkbN1BEixoJPfL2nguNCm598YFmIYHmml7BSwK6OOfEfwx0
	 FqL6JdqQj/xQLWIgiCzqkU9KDKL7s7UyBjKYP1JBmI2Tr74mU4PXCbA0Dhr6a31t2t
	 uKJtfod9KcSxtstKBn41ENq244shFs5nDAS8utIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfL0Rnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbfL0RnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:43:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE08721744;
        Fri, 27 Dec 2019 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468600;
        bh=V4IO6kOWJmt05tF5obmitFkuflGbBRrOd2f4vBuEhxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDCqRBoxRTLivkVMn0Mnhy5KW2iB8LcuKWhM2W0vkMsblEoOS6F+eRxl7nu8hs0Dv
         SZhg/X1HEOaxdekWNQYV8vEAakOZaXN+it0S8xbQRl1H1+cOPF1zWJ05VOBtwXtN13
         NSxneasjNm3Sl2bZ8Om4JroGLaZZPZWD8z8uC1vA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 121/187] parisc: add missing __init annotation
Date:   Fri, 27 Dec 2019 12:39:49 -0500
Message-Id: <20191227174055.4923-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@stackframe.org>

[ Upstream commit aeea5eae4fd54e94d820ed17ea3b238160be723e ]

compilation failed with:

MODPOST vmlinux.o
WARNING: vmlinux.o(.text.unlikely+0xa0c): Section mismatch in reference from the function walk_lower_bus() to the function .init.text:walk_native_bus()
The function walk_lower_bus() references
the function __init walk_native_bus().
This is often because walk_lower_bus lacks a __init
annotation or the annotation of walk_native_bus is wrong.

FATAL: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
make[2]: *** [/home/svens/linux/parisc-linux/src/scripts/Makefile.modpost:64: __modpost] Error 1
make[1]: *** [/home/svens/linux/parisc-linux/src/Makefile:1077: vmlinux] Error 2
make[1]: Leaving directory '/home/svens/linux/parisc-linux/build'
make: *** [Makefile:179: sub-make] Error 2

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/drivers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index 3b330e58a4f0..a6c9f49c6612 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -810,7 +810,7 @@ EXPORT_SYMBOL(device_to_hwpath);
 static void walk_native_bus(unsigned long io_io_low, unsigned long io_io_high,
                             struct device *parent);
 
-static void walk_lower_bus(struct parisc_device *dev)
+static void __init walk_lower_bus(struct parisc_device *dev)
 {
 	unsigned long io_io_low, io_io_high;
 
-- 
2.20.1

