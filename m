Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4ABC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9F021D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436606AbfIYOQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:16:10 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50709 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407340AbfIYOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:16:10 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iD85Q-0000DJ-BG; Wed, 25 Sep 2019 15:16:08 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iD85Q-00065e-0D; Wed, 25 Sep 2019 15:16:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/4] arm: fix missing declartion of module_frob_arch_sections
Date:   Wed, 25 Sep 2019 15:16:02 +0100
Message-Id: <20190925141604.23364-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925141604.23364-1-ben.dooks@codethink.co.uk>
References: <20190925141604.23364-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module_frob_arch_sections function is missing the header declaration
which is in <linux/moduleloader.h> so include that to fix the following
sparse warning:

arch/arm/kernel/module-plts.c:188:5: warning: symbol 'module_frob_arch_sections' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/module-plts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index b647741c0ab0..6e626abaefc5 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sort.h>
+#include <linux/moduleloader.h>
 
 #include <asm/cache.h>
 #include <asm/opcodes.h>
-- 
2.23.0

