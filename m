Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7B9C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0DD21707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipD065TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfD3PZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:25:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36478 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3PZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:25:21 -0400
Received: by mail-io1-f68.google.com with SMTP id d19so12564909ioc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkkQKfx3i4UJpG5BXSLavl71hrc1Bj7hR6FUHs8SFgI=;
        b=ipD065TNKZnuHOXgj3ghAJ6MyDkCr6YyDMqE5wIhtHY9ootPO1I5QcfimfvS8XxYaW
         9mNft+LFKTn3ZMaTAwstJDC4r+r7M4E6/mc6v8MHIN+qykYuWeQuSb7EwV8xr5J7peNv
         VrlvhMlvwooW0ckqN4+PUk6oq0awVMZvaLSpxJxuxlzEz7z+NpI2p4Cf41pzKIMiUYVU
         W4VTOwW1enbPEu5BPbf7sENVw7aoSlrxuoXCyMtWd9uW2lyrIyYotXzt74lLcIw4VA7b
         4+KIkqgZQ8qmpZRDCMJTHGgvb7CiGzCm/asQ2KewYTl1dMMS2dmqUdgPX+zyF+3jDflR
         6SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zkkQKfx3i4UJpG5BXSLavl71hrc1Bj7hR6FUHs8SFgI=;
        b=mD6fRsYNUe62XOKHuBifs8tMY71/NoLB4xXjtRhp7CGtIl3KEPJzzBIF09TlUKu4/M
         MteJCniPPC8F1EXLhDAPYwhr90FtYvceasSkeKJB+RRGLS6zKJ2jhMbsa7iZAeXehgyz
         lfbkutbnronFqxFyh2sR4Iq3eo+SdOLo19iQqv8pP2KZdFYqaJiAuy+lLAWxQOMjbO2c
         10V1td65Qb8ZazBkwULmkZO1ZwJOAGuVKFpMv13OoKrch8seyfhDp5qTI88j34mN8a6N
         CrmBwSwEoZ4nKaSXT4lDVDOr0rfcEoY89t/FTh4//ZlKIhQIDiOc10qup6tiaf9xzszp
         jwWA==
X-Gm-Message-State: APjAAAUUTpxFXJ3CjVDTHI56xwxre7BfA1GpcLSf2vjMBNqMsEQdH2/p
        Qn04uVBfCXL9zfRVVJ04mjP7Su1N
X-Google-Smtp-Source: APXvYqwGCTXE3e8IraPi+Q2wOiK7YXufAACS6sDziQJPBNxRop30E7Qcjo/J9JG81QVICk/Mse5DWg==
X-Received: by 2002:a5d:9317:: with SMTP id l23mr9144179ion.261.1556637920855;
        Tue, 30 Apr 2019 08:25:20 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id f129sm1607294itf.4.2019.04.30.08.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:25:20 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] staging: fieldbus: anybus-s: rename bus id field to avoid confusion
Date:   Tue, 30 Apr 2019 11:25:15 -0400
Message-Id: <20190430152515.29829-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430152515.29829-1-TheSven73@gmail.com>
References: <20190430152515.29829-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the anybus-s bus id from fieldbus_type to anybus_id, to
avoid confusion with an identically named variable in the
fieldbus_dev framework.

Although this value is called fieldbus_type in the anybus-s docs,
it acts like a bus id, so the name change is appropriate.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/staging/fieldbus/anybuss/anybuss-client.h | 4 ++--
 drivers/staging/fieldbus/anybuss/hms-profinet.c   | 2 +-
 drivers/staging/fieldbus/anybuss/host.c           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/anybuss-client.h b/drivers/staging/fieldbus/anybuss/anybuss-client.h
index dce60f86c16f..0c4b6a1ffe10 100644
--- a/drivers/staging/fieldbus/anybuss/anybuss-client.h
+++ b/drivers/staging/fieldbus/anybuss/anybuss-client.h
@@ -17,7 +17,7 @@ struct anybuss_host;
 struct anybuss_client {
 	struct device dev;
 	struct anybuss_host *host;
-	__be16 fieldbus_type;
+	__be16 anybus_id;
 	/*
 	 * these can be optionally set by the client to receive event
 	 * notifications from the host.
@@ -30,7 +30,7 @@ struct anybuss_client_driver {
 	struct device_driver driver;
 	int (*probe)(struct anybuss_client *adev);
 	int (*remove)(struct anybuss_client *adev);
-	u16 fieldbus_type;
+	u16 anybus_id;
 };
 
 int anybuss_client_driver_register(struct anybuss_client_driver *drv);
diff --git a/drivers/staging/fieldbus/anybuss/hms-profinet.c b/drivers/staging/fieldbus/anybuss/hms-profinet.c
index c5db648aa65f..5446843e35f4 100644
--- a/drivers/staging/fieldbus/anybuss/hms-profinet.c
+++ b/drivers/staging/fieldbus/anybuss/hms-profinet.c
@@ -208,7 +208,7 @@ static struct anybuss_client_driver profinet_driver = {
 		.name   = "hms-profinet",
 		.owner	= THIS_MODULE,
 	},
-	.fieldbus_type = 0x0089,
+	.anybus_id = 0x0089,
 };
 
 static int __init profinet_init(void)
diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index 33a241dbec52..f69dc4930457 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1173,7 +1173,7 @@ static int anybus_bus_match(struct device *dev,
 	struct anybuss_client *adev =
 		to_anybuss_client(dev);
 
-	return adrv->fieldbus_type == be16_to_cpu(adev->fieldbus_type);
+	return adrv->anybus_id == be16_to_cpu(adev->anybus_id);
 }
 
 static int anybus_bus_probe(struct device *dev)
@@ -1371,7 +1371,7 @@ anybuss_host_common_probe(struct device *dev,
 		ret = -ENOMEM;
 		goto err_kthread;
 	}
-	cd->client->fieldbus_type = fieldbus_type;
+	cd->client->anybus_id = fieldbus_type;
 	cd->client->host = cd;
 	cd->client->dev.bus = &anybus_bus;
 	cd->client->dev.parent = dev;
-- 
2.17.1

