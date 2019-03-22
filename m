Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6416BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B42190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfCVKvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:51:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:24392 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfCVKvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:51:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 03:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="157368552"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.199])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2019 03:51:43 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, pauldzim@gmail.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: turn on TPM on suspend for TPM 1.x
Date:   Fri, 22 Mar 2019 12:51:20 +0200
Message-Id: <20190322105120.8441-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpm_chip_start/stop() should be also called for TPM 1.x devices on
suspend. Add that functionality back. Do not lock the chip because
it is unnecessary as there are no multiple threads using it when
doing the suspend.

Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
Reported-by: Paul Zimmerman <pauldzim@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 83ece5639f86..ae1030c9b086 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -402,15 +402,13 @@ int tpm_pm_suspend(struct device *dev)
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		return 0;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		mutex_lock(&chip->tpm_mutex);
-		if (!tpm_chip_start(chip)) {
+	if (!tpm_chip_start(chip)) {
+		if (chip->flags & TPM_CHIP_FLAG_TPM2)
 			tpm2_shutdown(chip, TPM2_SU_STATE);
-			tpm_chip_stop(chip);
-		}
-		mutex_unlock(&chip->tpm_mutex);
-	} else {
-		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+		else
+			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+
+		tpm_chip_stop(chip);
 	}
 
 	return rc;
-- 
2.19.1

