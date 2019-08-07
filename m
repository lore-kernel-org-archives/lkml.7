Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EA7C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD8F21E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a0q0id7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbfHGNcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:32:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbfHGNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6JQhsPjZAx86P4wsmFB/eJa6y9P196Y+LSco+nWRdLc=; b=a0q0id7T6il4S+ArYqZeY/PZYP
        axfr9LcDdjG/QF00+s34B3BMdJ83kPzw4qZ0K4Y9p2Nof2iRI55mt70/5GXs6zw0Ppu+qM1tZ7bpq
        CvbIfrqfhtiiEOlDDGxW727VceRRVMJYGnhSmgLrcqvlStd0wikru/9fh/Gk4gRCKUFVPrvFSGy9I
        Q7xQUcNOjTqLcqyO/gPU/qF0Vlw1lBSjLotf9IqdITkCvbKaNxJeuhQPvAii1CMYutZSWP9wSEbOO
        PukMWcjzpsx6lUYEUCRCE0XYFTZSogU0WciZqKksCCT0S+okdjoH3hQD4G5DuzPLgqOo/5+tH2iIk
        yeLByV1w==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvM2x-0008Dj-L7; Wed, 07 Aug 2019 13:32:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/29] ia64: move the ROOT_DEV setup to common code
Date:   Wed,  7 Aug 2019 16:30:44 +0300
Message-Id: <20190807133049.20893-25-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807133049.20893-1-hch@lst.de>
References: <20190807133049.20893-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure how useful a platform default ROOT_DEV is these days,
but it pretty sure isn't machvec dependent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/dig/setup.c    | 9 ---------
 arch/ia64/kernel/setup.c | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/dig/setup.c b/arch/ia64/dig/setup.c
index cc14fdce6db6..0b1866d2462a 100644
--- a/arch/ia64/dig/setup.c
+++ b/arch/ia64/dig/setup.c
@@ -13,13 +13,11 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
-#include <linux/kdev_t.h>
 #include <linux/string.h>
 #include <linux/screen_info.h>
 #include <linux/console.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
-#include <linux/root_dev.h>
 
 #include <asm/io.h>
 #include <asm/machvec.h>
@@ -30,13 +28,6 @@ dig_setup (char **cmdline_p)
 {
 	unsigned int orig_x, orig_y, num_cols, num_rows, font_height;
 
-	/*
-	 * Default to /dev/sda2.  This assumes that the EFI partition
-	 * is physical disk 1 partition 1 and the Linux root disk is
-	 * physical disk 1 partition 2.
-	 */
-	ROOT_DEV = Root_SDA2;		/* default to second partition on first drive */
-
 #ifdef CONFIG_SMP
 	init_smp_config();
 #endif
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 8d47836d932c..560f9833c665 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -30,6 +30,7 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/kdev_t.h>
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/reboot.h>
@@ -41,6 +42,7 @@
 #include <linux/threads.h>
 #include <linux/screen_info.h>
 #include <linux/dmi.h>
+#include <linux/root_dev.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/efi.h>
@@ -599,6 +601,13 @@ setup_arch (char **cmdline_p)
 	if (!nomca)
 		ia64_mca_init();
 
+	/*
+	 * Default to /dev/sda2.  This assumes that the EFI partition
+	 * is physical disk 1 partition 1 and the Linux root disk is
+	 * physical disk 1 partition 2.
+	 */
+	ROOT_DEV = Root_SDA2;		/* default to second partition on first drive */
+
 	platform_setup(cmdline_p);
 	paging_init();
 
-- 
2.20.1

