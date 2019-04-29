Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D37C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145BF214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfD2ITo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:19:44 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:42586 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfD2ITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:19:44 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 68Ki2000F3XaVaC068KiL0; Mon, 29 Apr 2019 10:19:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL1Vm-0000l4-2n; Mon, 29 Apr 2019 10:19:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL1Vm-0001yb-0Q; Mon, 29 Apr 2019 10:19:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Angelo Dureghello <angelo@sysam.it>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire peripherals
Date:   Mon, 29 Apr 2019 10:19:37 +0200
Message-Id: <20190429081937.7544-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic definitions of mmio_{read,write}{16,32}be() in lib/iomap.c
assume that the {read,write}[wl]() I/O accessors always use little
endian accesses, and swap the result.

However, the Coldfire versions of the {read,write}[wl]() I/O accessors are
special, in that they use native big endian instead of little endian for
accesses to the on-SoC peripheral block, thus violating the assumption.

Fix this by providing our own variants, using the raw accessors,
reinstating the old behavior.  This is fine on m68k, as no special
barriers are needed, and also avoids swapping data twice.

Reported-by: Angelo Dureghello <angelo@sysam.it>
Fixes: aecc787c06f4300f ("iomap: Use non-raw io functions for io{read|write}XXbe")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This can be reverted later, after this oddity of the Coldfire I/O
support has been fixed, and drivers have been updated.
---
 arch/m68k/include/asm/io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
index aabe6420ead2a599..d47e7384681ab1cd 100644
--- a/arch/m68k/include/asm/io.h
+++ b/arch/m68k/include/asm/io.h
@@ -8,6 +8,12 @@
 #include <asm/io_mm.h>
 #endif
 
+#define mmio_read16be(addr)		__raw_readw(addr)
+#define mmio_read32be(addr)		__raw_readl(addr)
+
+#define mmio_write16be(val, port)	__raw_writew((val), (port))
+#define mmio_write32be(val, port)	__raw_writel((val), (port))
+
 #include <asm-generic/io.h>
 
 #endif /* _M68K_IO_H */
-- 
2.17.1

