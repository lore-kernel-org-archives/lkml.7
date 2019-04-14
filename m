Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96FC282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 04:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43F2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 04:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfDNE5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 00:57:02 -0400
Received: from www.osadl.org ([62.245.132.105]:46580 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfDNE4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 00:56:54 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3E4tDwi021036;
        Sun, 14 Apr 2019 06:55:14 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/3 RFC] ARM: mvebu: at least warn on kzalloc failure
Date:   Sun, 14 Apr 2019 06:49:49 +0200
Message-Id: <1555217391-3552-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although it is very unlikely that the allocation during init would
fail any such failure should point to the original cause rather
than waiting for a null-pointer dereference to splat.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with experimental coccinelle script

While this will not really help much - but kzalloc failures should not
go unhandled. 

Patch was compile-tested: mvebu_v7_defconfig (implies MACH_MVEBU_ANY=y)
(with some unrelated sparse warnings about missing syscalls)

Patch is against 5.1-rc4 (localversion-next is 20190412)

 arch/arm/mach-mvebu/board-v7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 0b10acd..37f8cb6 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -128,6 +128,7 @@ static void __init i2c_quirk(void)
 		struct property *new_compat;
 
 		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+		WARN_ON(!new_compat);
 
 		new_compat->name = kstrdup("compatible", GFP_KERNEL);
 		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
-- 
2.1.4

