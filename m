Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81469C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466EC2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEBMzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:55:50 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:53910 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfEBMzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:55:49 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 7Qvm200073XaVaC01Qvm19; Thu, 02 May 2019 14:55:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hMBFa-0007if-ER; Thu, 02 May 2019 14:55:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hMBFa-0001px-C2; Thu, 02 May 2019 14:55:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Matteo Croce <mcroce@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: VDSO: Don't leak kernel addresses
Date:   Thu,  2 May 2019 14:55:45 +0200
Message-Id: <20190502125545.7020-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with
%p"), an obfuscated kernel pointer is printed at every boot if
debugging is enabled:

    vdso: 1 text pages at base (____ptrval____)

Remove the print completely, as it's useless without the address.

Based on commit 0f1bf7e39822476b ("arm64/vdso: don't leak kernel
addresses").

Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/kernel/vdso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index f4dd7f9663c10a70..e8cda5e02b4ea7bd 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -205,7 +205,6 @@ static int __init vdso_init(void)
 	}
 
 	text_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
-	pr_debug("vdso: %i text pages at base %p\n", text_pages, vdso_start);
 
 	/* Allocate the VDSO text pagelist */
 	vdso_text_pagelist = kcalloc(text_pages, sizeof(struct page *),
-- 
2.17.1

