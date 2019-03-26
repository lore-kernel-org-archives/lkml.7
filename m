Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B938C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171532075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH61ii00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfCZDHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:07:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37497 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfCZDHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:07:31 -0400
Received: by mail-io1-f65.google.com with SMTP id x7so9519765ioh.4;
        Mon, 25 Mar 2019 20:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Ln8nr51UnCYBD1sUbHkZrbV+AANUTrvA9tQIRa75DZE=;
        b=iH61ii00pIswTwG37IEiFm4v3PrMb+QDUnaw9WAaXeEfU30I4tlKtfm9Hnwr+3MBWw
         wM7qggTPHE7vGZo8v9Rf5o7Ii9YBpWFky2UghTcv2n9E7aSKRJ/7M1Sv029sq9jUD12W
         ChRMPAS6juq9AkIGGtP+z4OQIdtiloNG2IfgQ8DDz3Zly3m0m2epPKmAqgK2Phs/DC+J
         P5oGl6zktCcarrIDBY75hun3x525ATMdBJB9/i3myDjJidkhn7WWZbjotqdWCKWVlWB+
         epUuNIRyC3TB0JgZRE9UbijZ1VVjkZWwAH0v1JaW8hQCq7i1N0ut/7zCEapjT1pqxMHW
         J6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ln8nr51UnCYBD1sUbHkZrbV+AANUTrvA9tQIRa75DZE=;
        b=FdnnHZL2e1JwE/lPab90h6kT+AbGKeHQJHOZzF9emRSGQt0j2vHMUfCyU5r89Wko6X
         RsVYl7JnEFmHTqFdaZhbmzRWb0lu3f7qxz0nmWlN2G/oB+bPm6mhEENK9cdrSiuRcnGl
         jdHTHlrgfGXTHiEV5o+Gl4FfFH8o39G3v911fAC85BY+VHP3Db6GIgn5ykJeWtBQogS8
         HCEC+YlLDOx6Gjf4TIx39z3HcTr7M++/6fCeEtu0UC2Xks+WCODzMJFm/0vwhBxVfE8x
         bWxxvk+5mmBs7RwZCBviBBI5Gg0ujrYiLqEQbB5Z/Bdv+o1OFzfSp8t8sZbJhfBdUaF8
         9yIw==
X-Gm-Message-State: APjAAAUx9TFj/JwgXMAzpxx7MpWw41tm3E4Ws6Kur9cgE/5e9fxdO+nl
        nU4aOpimAxrBo9NQ3Z49B0ALVfi+qlwzgLu7BZRhSKHz
X-Google-Smtp-Source: APXvYqzZGyj093eVVLtjBy4X6Qg57Sx2Am7I0nkuoD3806XOtVVrFjyqo3nrx216szVYQoOmXXVsxw4DRdplLboLBMs=
X-Received: by 2002:a6b:c807:: with SMTP id y7mr19210618iof.287.1553569650636;
 Mon, 25 Mar 2019 20:07:30 -0700 (PDT)
MIME-Version: 1.0
From:   raymond pang <raymondpangxd@gmail.com>
Date:   Tue, 26 Mar 2019 03:07:14 +0000
Message-ID: <CAHG4imOAn7rcQWj--XMV2maBLgp4DynKGxwcbSzrcxk0a8n=8Q@mail.gmail.com>
Subject: [PATCH] libata: fix using DMA buffers on stack
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
a stack virtual address. Stack DMA buffers must be avoided.

Signed-off-by: raymond pang <raymondpangxd@gmail.com>
---
 drivers/ata/libata-zpodd.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index b3ed8f9..5ca0ce5 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -52,38 +52,54 @@ static int eject_tray(struct ata_device *dev)
 /* Per the spec, only slot type and drawer type ODD can be supported */
 static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 {
-    char buf[16];
+    char *buf;
     unsigned int ret;
-    struct rm_feature_desc *desc = (void *)(buf + 8);
+    struct rm_feature_desc *desc;
     struct ata_taskfile tf;
     static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
             2,      /* only 1 feature descriptor requested */
             0, 3,   /* 3, removable medium feature */
             0, 0, 0,/* reserved */
-            0, sizeof(buf),
+            0, 16,
             0, 0, 0,
     };

+    buf = kzalloc(16, GFP_KERNEL);
+    if (!buf) {
+        ata_dev_err(dev, "zpodd mech type buffer allocation failed\n");
+        return ODD_MECH_TYPE_UNSUPPORTED;
+    }
+    desc = (void *)(buf + 8);
+
     ata_tf_init(dev, &tf);
     tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
     tf.command = ATA_CMD_PACKET;
     tf.protocol = ATAPI_PROT_PIO;
-    tf.lbam = sizeof(buf);
+    tf.lbam = 16;

     ret = ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
-                buf, sizeof(buf), 0);
-    if (ret)
+                buf, 16, 0);
+    if (ret) {
+        kzfree(buf);
         return ODD_MECH_TYPE_UNSUPPORTED;
+    }

-    if (be16_to_cpu(desc->feature_code) != 3)
+    if (be16_to_cpu(desc->feature_code) != 3) {
+        kzfree(buf);
         return ODD_MECH_TYPE_UNSUPPORTED;
+    }

-    if (desc->mech_type == 0 && desc->load == 0 && desc->eject == 1)
+    if (desc->mech_type == 0 && desc->load == 0 && desc->eject == 1) {
+        kzfree(buf);
         return ODD_MECH_TYPE_SLOT;
-    else if (desc->mech_type == 1 && desc->load == 0 && desc->eject == 1)
+    } else if (desc->mech_type == 1 && desc->load == 0 &&
+           desc->eject == 1) {
+        kzfree(buf);
         return ODD_MECH_TYPE_DRAWER;
-    else
+    } else {
+        kzfree(buf);
         return ODD_MECH_TYPE_UNSUPPORTED;
+    }
 }

 /* Test if ODD is zero power ready by sense code */
--
1.9.1
