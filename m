Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F29C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F6B2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxlnmuVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfD3PZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:25:21 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39631 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3PZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:25:20 -0400
Received: by mail-it1-f194.google.com with SMTP id t200so5359657itf.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z+Mc5Y4zw8XCR+3OGWFbZ49ZP/F2TsXfQJigzcuwPwQ=;
        b=CxlnmuVGVBN5poS+AC9ccE/Nu08XGBnSuxYQKh1qdeqvZQesKfm7APK8ok2rbErO80
         jFU6bXM0BuFeKPLa/Z8BDTnW2LgAgMCtSlW7xXlcXiB/+GDlZDh/MkwGxD1sLe1v8bP4
         Uq4eycUuQ5CHFtV/8EnX75f+/hVqewMDmr0+wQ9w30QdqQgsMRtaBGj5Fa4HW3igjtII
         M2Nh4JKIJPLrvQ93FZi9ZVVV+zn3ZjovQ63S5COfGnN+7hEwddYwTF3CF2aPEHvF1UIq
         ub0XeI5WYeIx1u+8y7yJAYKJKm+zUU4u5D4me79sydk6EFfZBELi2fgtFWg1cC7I4mb7
         3k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z+Mc5Y4zw8XCR+3OGWFbZ49ZP/F2TsXfQJigzcuwPwQ=;
        b=XvdUX4JzRqkfThZ7/YM6X0svVerfKmVOG3ETPD71MsHvmgho+uDIdu8lzpIZDI7pG0
         W1IfqidRsBvhSzJdWaatoYKkoRYsrFe2q7YjcXBaeq8F0Vizsccdo7bDeSW8kASYqMio
         FU/NcmZG2PR/5LMhu4Y3BzinWVl4W44/z9ZXFN7mhmNXYtOULgjIiAw3hHmevI6cvpay
         6Wp4dtOZquudaalVPCsG87S55EWhMbxEkgqf31TK5GWrbNEWsypTsfSFZHN4IEKCeLwp
         4TXFNnwVLl2OhiCAv4M4pAa8oHOjjqnKGGiDJKq6OvR0s1b+ArMIp144OkUv4STL2M5p
         iBYg==
X-Gm-Message-State: APjAAAWiWf92pREBN/3CPclOda8M2Em5ymHPdh+7r+79A5NKt5QBAaP4
        gxXqDQ0Zf40EeUvpexUux6g=
X-Google-Smtp-Source: APXvYqwz/1VMEw1qBLpqOkKZtX42WQFRgwxVfUL4yBKKPWmhKURjB1kMh6SaZYV3RuJ1nPiFrUDRfw==
X-Received: by 2002:a24:6e12:: with SMTP id w18mr3815363itc.40.1556637919841;
        Tue, 30 Apr 2019 08:25:19 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id f129sm1607294itf.4.2019.04.30.08.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:25:19 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] staging: fieldbus: anybus-s: keep device bus id in bus endianness
Date:   Tue, 30 Apr 2019 11:25:14 -0400
Message-Id: <20190430152515.29829-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Normal" bus structures such as USB or PCI keep device bus ids
in bus endinanness, and driver bus ids in host endianness.
Endianness conversion happens each time bus_match() is called.

Modify anybus-s to conform to this pattern. As a pleasant side-
effect, sparse warnings will now disappear.

This was suggested by Al Viro.

Link: https://lkml.org/lkml/2019/4/30/834
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/staging/fieldbus/anybuss/anybuss-client.h | 2 +-
 drivers/staging/fieldbus/anybuss/host.c           | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/anybuss-client.h b/drivers/staging/fieldbus/anybuss/anybuss-client.h
index 2e48fb8f0209..dce60f86c16f 100644
--- a/drivers/staging/fieldbus/anybuss/anybuss-client.h
+++ b/drivers/staging/fieldbus/anybuss/anybuss-client.h
@@ -17,7 +17,7 @@ struct anybuss_host;
 struct anybuss_client {
 	struct device dev;
 	struct anybuss_host *host;
-	u16 fieldbus_type;
+	__be16 fieldbus_type;
 	/*
 	 * these can be optionally set by the client to receive event
 	 * notifications from the host.
diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index a64fe03b61fa..33a241dbec52 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1173,7 +1173,7 @@ static int anybus_bus_match(struct device *dev,
 	struct anybuss_client *adev =
 		to_anybuss_client(dev);
 
-	return adrv->fieldbus_type == adev->fieldbus_type;
+	return adrv->fieldbus_type == be16_to_cpu(adev->fieldbus_type);
 }
 
 static int anybus_bus_probe(struct device *dev)
@@ -1264,7 +1264,7 @@ anybuss_host_common_probe(struct device *dev,
 {
 	int ret, i;
 	u8 val[4];
-	u16 fieldbus_type;
+	__be16 fieldbus_type;
 	struct anybuss_host *cd;
 
 	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
@@ -1347,8 +1347,7 @@ anybuss_host_common_probe(struct device *dev,
 	add_device_randomness(&val, 4);
 	regmap_bulk_read(cd->regmap, REG_FIELDBUS_TYPE, &fieldbus_type,
 			 sizeof(fieldbus_type));
-	fieldbus_type = be16_to_cpu(fieldbus_type);
-	dev_info(dev, "Fieldbus type: %04X", fieldbus_type);
+	dev_info(dev, "Fieldbus type: %04X", be16_to_cpu(fieldbus_type));
 	regmap_bulk_read(cd->regmap, REG_MODULE_SW_V, val, 2);
 	dev_info(dev, "Module SW version: %02X%02X",
 		 val[0], val[1]);
-- 
2.17.1

