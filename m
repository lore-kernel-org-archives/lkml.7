Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AD2C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 18:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F3F21883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 18:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfIBSxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 14:53:10 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:45073 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfIBSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 14:53:10 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2019 14:53:09 EDT
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 9533E3A32A; Mon,  2 Sep 2019 20:43:27 +0200 (CEST)
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] staging: exfat: use BIT macro for defining sizes
Date:   Mon,  2 Sep 2019 20:43:19 +0200
Message-Id: <20190902184319.11971-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning:

  CHECK: Prefer using the BIT macro

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/exfat/exfat.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index bae180e10609..f71d4e8c0c8e 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -163,8 +163,8 @@
 #define HIGH_INDEX_BIT	(8)
 #define HIGH_INDEX_MASK	(0xFF00)
 #define LOW_INDEX_BIT	(16-HIGH_INDEX_BIT)
-#define UTBL_ROW_COUNT	(1<<LOW_INDEX_BIT)
-#define UTBL_COL_COUNT	(1<<HIGH_INDEX_BIT)
+#define UTBL_ROW_COUNT	BIT(LOW_INDEX_BIT)
+#define UTBL_COL_COUNT	BIT(HIGH_INDEX_BIT)
 
 static inline u16 get_col_index(u16 i)
 {
@@ -690,7 +690,7 @@ struct exfat_mount_options {
 };
 
 #define EXFAT_HASH_BITS		8
-#define EXFAT_HASH_SIZE		(1UL << EXFAT_HASH_BITS)
+#define EXFAT_HASH_SIZE		BIT(EXFAT_HASH_BITS)
 
 /*
  * EXFAT file system in-core superblock data
-- 
2.20.1

