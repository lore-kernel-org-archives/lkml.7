Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ACDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043AE218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfCPW1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:27:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39735 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfCPW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:27:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5Hla-0006mE-RA; Sat, 16 Mar 2019 22:26:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove unused code
Date:   Sat, 16 Mar 2019 22:26:57 +0000
Message-Id: <20190316222657.7940-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two final hunks of code that are only built
if SDIO_DYNAMIC_ALLOC_MEM is defined however this is never
defined and if it was the code would lead to dereferencing
an uninitialized pointer oldmem.  It appears that a previous
commit 1babeb0c3e59 ("Staging: rtl8723bs: Remove dead code")
removed some of the dead code but not all of it. Clean this
up by removing the final hunks.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 3fee34484577..92191e9789bb 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -428,9 +428,6 @@ static u32 sdio_read_port(
 	PSDIO_DATA psdio;
 	struct hal_com_data *hal;
 	u32 oldcnt;
-#ifdef SDIO_DYNAMIC_ALLOC_MEM
-	u8 *oldmem;
-#endif
 	s32 err;
 
 
@@ -447,13 +444,6 @@ static u32 sdio_read_port(
 
 	err = _sd_read(intfhdl, addr, cnt, mem);
 
-#ifdef SDIO_DYNAMIC_ALLOC_MEM
-	if ((oldcnt != cnt) && (oldmem)) {
-		memcpy(oldmem, mem, oldcnt);
-		kfree(mem);
-	}
-#endif
-
 	if (err)
 		return _FAIL;
 	return _SUCCESS;
-- 
2.20.1

