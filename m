Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F38CC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B024218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfJIN1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:27:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731430AbfJIN1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:27:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 801F2B17E;
        Wed,  9 Oct 2019 13:27:29 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] MIPS: SGI-IP22: set PHYS_OFFSET to memory start
Date:   Wed,  9 Oct 2019 15:27:16 +0200
Message-Id: <20191009132718.25346-6-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191009132718.25346-1-tbogendoerfer@suse.de>
References: <20191009132718.25346-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IP22 started at physical 0x08000000. To avoid wasting memory for
page structs set PHYS_OFFSET.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/include/asm/mach-ip22/spaces.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ip22/spaces.h b/arch/mips/include/asm/mach-ip22/spaces.h
index 7f9fa6f66059..78d0335f5f2e 100644
--- a/arch/mips/include/asm/mach-ip22/spaces.h
+++ b/arch/mips/include/asm/mach-ip22/spaces.h
@@ -10,11 +10,10 @@
 #ifndef _ASM_MACH_IP22_SPACES_H
 #define _ASM_MACH_IP22_SPACES_H
 
+#define PHYS_OFFSET     _AC(0x08000000, UL)
 
 #ifdef CONFIG_64BIT
 
-#define PAGE_OFFSET		0xffffffff80000000UL
-
 #define CAC_BASE		0xffffffff80000000
 #define IO_BASE			0xffffffffa0000000
 #define UNCAC_BASE		0xffffffffa0000000
-- 
2.16.4

