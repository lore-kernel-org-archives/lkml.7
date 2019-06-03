Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26105C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE6127979
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfFCPvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:52 -0400
Received: from foss.arm.com ([217.140.101.70]:53866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfFCPvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732721A25;
        Mon,  3 Jun 2019 08:51:48 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CEF83F246;
        Mon,  3 Jun 2019 08:51:46 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [RFC PATCH 32/57] drivers: s390-crypto: Use class_device_find_by_name() helper
Date:   Mon,  3 Jun 2019 16:49:58 +0100
Message-Id: <1559577023-558-33-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new class_find_device_by_name() helper.

Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/s390/crypto/zcrypt_api.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 1058b4b..16cad8e 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -133,12 +133,6 @@ struct zcdn_device {
 static int zcdn_create(const char *name);
 static int zcdn_destroy(const char *name);
 
-/* helper function, matches the name for find_zcdndev_by_name() */
-static int __match_zcdn_name(struct device *dev, const void *data)
-{
-	return strcmp(dev_name(dev), (const char *)data) == 0;
-}
-
 /* helper function, matches the devt value for find_zcdndev_by_devt() */
 static int __match_zcdn_devt(struct device *dev, const void *data)
 {
@@ -152,10 +146,8 @@ static int __match_zcdn_devt(struct device *dev, const void *data)
  */
 static inline struct zcdn_device *find_zcdndev_by_name(const char *name)
 {
-	struct device *dev =
-		class_find_device(zcrypt_class, NULL,
-				  (void *) name,
-				  __match_zcdn_name);
+	struct device *dev = class_find_device_by_name(zcrypt_class,
+							NULL, (void *) name);
 
 	return dev ? to_zcdn_dev(dev) : NULL;
 }
-- 
2.7.4

