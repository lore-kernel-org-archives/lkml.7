Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51819C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307A020833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLBNCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:02:49 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:45797 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727467AbfLBNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:02:40 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xB2D1qsQ015200;
        Mon, 2 Dec 2019 15:01:52 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 96DF960275; Mon,  2 Dec 2019 15:01:52 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com, Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v1 3/5] char: tpm: rewrite "tpm_tis_req_canceled()"
Date:   Mon,  2 Dec 2019 15:01:30 +0200
Message-Id: <20191202130132.175382-4-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191202130132.175382-1-amirmizi6@gmail.com>
References: <20191202130132.175382-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

using this function while read/write data resulted in aborted operation.
after investigating according to TCG TPM Profile (PTP) Specifications,
i found cancel should happen only if TPM_STS.commandReady bit is lit
and couldn't find a case when the current condition is valid.
also only cmdReady bit need to be compared instead of the full lower status register byte.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index ce7f8a1..9016f06 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -627,17 +627,7 @@ static int probe_itpm(struct tpm_chip *chip)
 
 static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 {
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-
-	switch (priv->manufacturer_id) {
-	case TPM_VID_WINBOND:
-		return ((status == TPM_STS_VALID) ||
-			(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
-	case TPM_VID_STM:
-		return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
-	default:
-		return (status == TPM_STS_COMMAND_READY);
-	}
+	return ((status & TPM_STS_COMMAND_READY) == TPM_STS_COMMAND_READY);
 }
 
 static irqreturn_t tis_int_handler(int dummy, void *dev_id)
-- 
2.7.4

