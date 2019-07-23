Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B1C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1C321849
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl7jWz+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbfGWUl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:41:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53353 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfGWUl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:41:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so39782930wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9GBmEn58r7ljhhnrz1/YqVdStFn2BirruPVruUa2Frs=;
        b=Tl7jWz+uINjV1kbzVFy8+fZTdlMFj5EFxUMB8FbB69gRK5iK/cknTR/uJ3eXOsmYy1
         9z99F8ebWmHLG74iPq3WSPk7cdSoBn192LjyDQNGf0KMS51vh0OZf2XOQ2gqnmNqERmb
         GsQuO/BKW/OOEToS6+iiqhjFq4nGRQ6dld+9xYIIqJZ2WVWIRTenWW1+8in5dGu8PzAa
         baUoQUi1LoNs0aq++waQ9e69+Ps6zbxe5pazguTk7J1f3N7ao948hmfFTNSIk6dOo46j
         6WA4frMEhGKV3o2iTQI3xxkBT7fFvWopO6F6h+VVQrVHx0xFIDCe7L17Q0H7V+mvaJtc
         WJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9GBmEn58r7ljhhnrz1/YqVdStFn2BirruPVruUa2Frs=;
        b=AiVgWGkBpsgUoclMyl788UCA8KAv6PEu8ddrIV2HeJGs4J8g/LpIz4TqXEXWiOLsyv
         QAJaTCJFubydolkB8HjMJCDA40c8LlJCWp9DnPBll0EzBMcCZHkkMpR9Tdy8rawQ9EUI
         IjPAY3gr98nC5CEdA6wybjGMyR41vBSP3B+ELKDVUEepgpHr6oabu1rP7sp/7jhOcwDB
         /7WcV2/yO6V9f3rP+IHBFc3uPhPdJYqXjMgDJabbqvVRNAMPIoiXm5HYw8/cAH8gp2O3
         wqrWUKiJujRamKO5pb7mJ3d+qOZYQXSdRzOp7kzAn/f0tbo9nlYBtu5+2qBz5LL4CsHb
         C6jw==
X-Gm-Message-State: APjAAAXkEXmNdjGYbDnI1Xi0XdXMFfHmIf2ae0nHFR2BX7eGohIWA+3c
        HTPi0yBW15/npxotwVyWBixNZrtejbw=
X-Google-Smtp-Source: APXvYqxHC+6axFZRC3vn/kkiYdfngyPclOl1oFId12mrvcXlUX41o2j+hvrNmYnmN+Jfztkfjfxo4A==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr64443708wmk.147.1563914484847;
        Tue, 23 Jul 2019 13:41:24 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h16sm43934487wrv.88.2019.07.23.13.41.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:41:24 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ben Segal <bpsegal20@gmail.com>
Subject: [PATCH 1/2] habanalabs: fix F/W download in BE architecture
Date:   Tue, 23 Jul 2019 23:41:19 +0300
Message-Id: <20190723204120.26578-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Segal <bpsegal20@gmail.com>

writeX macros might perform byte-swapping in BE architectures. As our F/W
is in LE format, we need to make sure no byte-swapping will occur.

There is a standard kernel function (called memcpy_toio) for copying data
to I/O area which is used in a lot of drivers to download F/W to PCIe
adapters. That function also makes sure the data is copied "as-is",
without byte-swapping.

This patch use that function to copy the F/W to the GOYA ASIC instead of
writeX macros.

Signed-off-by: Ben Segal <bpsegal20@gmail.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/firmware_if.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index cc8168bacb24..61112eda4dd2 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -24,7 +24,7 @@ int hl_fw_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
 {
 	const struct firmware *fw;
 	const u64 *fw_data;
-	size_t fw_size, i;
+	size_t fw_size;
 	int rc;
 
 	rc = request_firmware(&fw, fw_name, hdev->dev);
@@ -45,22 +45,7 @@ int hl_fw_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
 
 	fw_data = (const u64 *) fw->data;
 
-	if ((fw->size % 8) != 0)
-		fw_size -= 8;
-
-	for (i = 0 ; i < fw_size ; i += 8, fw_data++, dst += 8) {
-		if (!(i & (0x80000 - 1))) {
-			dev_dbg(hdev->dev,
-				"copied so far %zu out of %zu for %s firmware",
-				i, fw_size, fw_name);
-			usleep_range(20, 100);
-		}
-
-		writeq(*fw_data, dst);
-	}
-
-	if ((fw->size % 8) != 0)
-		writel(*(const u32 *) fw_data, dst);
+	memcpy_toio(dst, fw_data, fw_size);
 
 out:
 	release_firmware(fw);
-- 
2.17.1

