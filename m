Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0482ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72662080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 14:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfJFOwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 10:52:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55460 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFOwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 10:52:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iH7tg-0003dx-3q; Sun, 06 Oct 2019 14:52:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: abituguru: make array probe_order static, makes object smaller
Date:   Sun,  6 Oct 2019 15:52:31 +0100
Message-Id: <20191006145231.24022-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array probe_order on the stack but instead make it
static. Makes the object code smaller by 94 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  41473	  13448	    320	  55241	   d7c9	drivers/hwmon/abituguru.o

After:
   text	   data	    bss	    dec	    hex	filename
  41315	  13512	    320	  55147	   d76b	drivers/hwmon/abituguru.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/abituguru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index a5cf6b2a6e49..681f0623868f 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -1264,7 +1264,7 @@ static int abituguru_probe(struct platform_device *pdev)
 	 * El weirdo probe order, to keep the sysfs order identical to the
 	 * BIOS and window-appliction listing order.
 	 */
-	const u8 probe_order[ABIT_UGURU_MAX_BANK1_SENSORS] = {
+	static const u8 probe_order[ABIT_UGURU_MAX_BANK1_SENSORS] = {
 		0x00, 0x01, 0x03, 0x04, 0x0A, 0x08, 0x0E, 0x02,
 		0x09, 0x06, 0x05, 0x0B, 0x0F, 0x0D, 0x07, 0x0C };
 
-- 
2.20.1

