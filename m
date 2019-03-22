Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BF02070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258435;
	bh=G8x3nrhxVcqhNAdY7UbUCnyC+hULVW5gZvVJhBiRjqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTqRMsSIvf3alZ3QSG8GN0yHRpyJB+gbVyqTtKOQJ3LDiwNsAx3BNqds3pxOLS8ft
	 bLt97L+RILck3ITdKSsHiJYRwBed3PBOPLzeMGbRiQZ3jny6a4MMZsOkAivltTxCVa
	 QTpJWkOpwfAEAoGNtzalKrGHtQGNKPPVBFFiAick=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbfCVMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbfCVMGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:06:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067D52192D;
        Fri, 22 Mar 2019 12:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256395;
        bh=G8x3nrhxVcqhNAdY7UbUCnyC+hULVW5gZvVJhBiRjqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y02vKlL5fXNZZwq8hAWQFrSHQrwN5d8ZgV2PXtZPYq0Nt2PElpFzp41km6WtHeqT2
         rtPf6omqIWsQ9h1hF9B4+qOcPDlp7mO28loDUaXIf+xGFFh2GTHeJY7VLZ8I3pGdcm
         srSsPmMV7e+FnarV4wLyYVf2MYasmIYEucDSo0Qo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 198/280] usb: typec: tps6598x: handle block writes separately with plain-I2C adapters
Date:   Fri, 22 Mar 2019 12:15:51 +0100
Message-Id: <20190322111330.151334518@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

commit 8a863a608d47fa5d9dd15cf841817f73f804cf91 upstream.

Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
adapters, but the problem described with regmap-i2c not handling
SMBus block transfers (i.e. read and writes) correctly also exists
with writes.

As workaround, this patch adds a block write function the same way
1a2f474d328f adds a block read function.

Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately with plain-I2C adapters")
Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tps6598x.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps
 	return 0;
 }
 
+static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
+				void *val, size_t len)
+{
+	u8 data[TPS_MAX_LEN + 1];
+
+	if (!tps->i2c_protocol)
+		return regmap_raw_write(tps->regmap, reg, val, len);
+
+	data[0] = len;
+	memcpy(&data[1], val, len);
+
+	return regmap_raw_write(tps->regmap, reg, data, sizeof(data));
+}
+
 static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
 {
 	return tps6598x_block_read(tps, reg, val, sizeof(u16));
@@ -127,23 +141,23 @@ static inline int tps6598x_read64(struct
 
 static inline int tps6598x_write16(struct tps6598x *tps, u8 reg, u16 val)
 {
-	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u16));
+	return tps6598x_block_write(tps, reg, &val, sizeof(u16));
 }
 
 static inline int tps6598x_write32(struct tps6598x *tps, u8 reg, u32 val)
 {
-	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u32));
+	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
 }
 
 static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
 {
-	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u64));
+	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
 }
 
 static inline int
 tps6598x_write_4cc(struct tps6598x *tps, u8 reg, const char *val)
 {
-	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u32));
+	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
 }
 
 static int tps6598x_read_partner_identity(struct tps6598x *tps)
@@ -229,8 +243,8 @@ static int tps6598x_exec_cmd(struct tps6
 		return -EBUSY;
 
 	if (in_len) {
-		ret = regmap_raw_write(tps->regmap, TPS_REG_DATA1,
-				       in_data, in_len);
+		ret = tps6598x_block_write(tps, TPS_REG_DATA1,
+					   in_data, in_len);
 		if (ret)
 			return ret;
 	}


