Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB01C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D32B2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfLBNes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:34:48 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:45897 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727364AbfLBNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:34:47 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xB2DYIfw015794;
        Mon, 2 Dec 2019 15:34:18 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id B283F6026B; Mon,  2 Dec 2019 15:34:18 +0200 (IST)
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
Subject: [PATCH v2 1/5] char: tpm: Make implementation of read16 read32 write32 optional
Date:   Mon,  2 Dec 2019 15:33:28 +0200
Message-Id: <20191202133332.178110-2-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191202133332.178110-1-amirmizi6@gmail.com>
References: <20191202133332.178110-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Only tpm_tis has a faster way to access multiple bytes at once, every other
driver will just fall back to read_bytes/write_bytes. Therefore, move this
common code out of tpm_tis_spi into tpm_tis_core, so that it is
automatically used when low-level drivers do not implement the specialized
methods.

This commit is based on previous work by Alexander Steffen.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.h | 38 +++++++++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm_tis_spi.c  | 41 -----------------------------------------
 2 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 7337819..d06c65b 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -122,13 +122,35 @@ static inline int tpm_tis_read8(struct tpm_tis_data *data, u32 addr, u8 *result)
 static inline int tpm_tis_read16(struct tpm_tis_data *data, u32 addr,
 				 u16 *result)
 {
-	return data->phy_ops->read16(data, addr, result);
+	__le16 result_le;
+	int rc;
+
+	if (data->phy_ops->read16)
+		return data->phy_ops->read16(data, addr, result);
+
+	rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
+				       (u8 *)&result_le);
+	if (!rc)
+		*result = le16_to_cpu(result_le);
+
+	return rc;
 }
 
 static inline int tpm_tis_read32(struct tpm_tis_data *data, u32 addr,
 				 u32 *result)
 {
-	return data->phy_ops->read32(data, addr, result);
+	__le32 result_le;
+	int rc;
+
+	if (data->phy_ops->read32)
+		return data->phy_ops->read32(data, addr, result);
+
+	rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
+				       (u8 *)&result_le);
+	if (!rc)
+		*result = le32_to_cpu(result_le);
+
+	return rc;
 }
 
 static inline int tpm_tis_write_bytes(struct tpm_tis_data *data, u32 addr,
@@ -145,7 +167,17 @@ static inline int tpm_tis_write8(struct tpm_tis_data *data, u32 addr, u8 value)
 static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
 				  u32 value)
 {
-	return data->phy_ops->write32(data, addr, value);
+	__le32 value_le;
+	int rc;
+
+	if (data->phy_ops->write32)
+		return data->phy_ops->write32(data, addr, value);
+
+	value_le = cpu_to_le32(value);
+	rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
+					(u8 *)&value_le);
+
+	return rc;
 }
 
 static inline bool is_bsw(void)
diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e6..da82924 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -146,50 +146,9 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
 	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
 }
 
-static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
-{
-	__le16 result_le;
-	int rc;
-
-	rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
-				       (u8 *)&result_le);
-	if (!rc)
-		*result = le16_to_cpu(result_le);
-
-	return rc;
-}
-
-static int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
-{
-	__le32 result_le;
-	int rc;
-
-	rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
-				       (u8 *)&result_le);
-	if (!rc)
-		*result = le32_to_cpu(result_le);
-
-	return rc;
-}
-
-static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
-{
-	__le32 value_le;
-	int rc;
-
-	value_le = cpu_to_le32(value);
-	rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
-					(u8 *)&value_le);
-
-	return rc;
-}
-
 static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 	.read_bytes = tpm_tis_spi_read_bytes,
 	.write_bytes = tpm_tis_spi_write_bytes,
-	.read16 = tpm_tis_spi_read16,
-	.read32 = tpm_tis_spi_read32,
-	.write32 = tpm_tis_spi_write32,
 };
 
 static int tpm_tis_spi_probe(struct spi_device *dev)
-- 
2.7.4

