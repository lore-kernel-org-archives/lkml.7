Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75988C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E83204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvV6KozN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfC1MTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:19:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40309 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1MTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:19:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so11271815pfc.7;
        Thu, 28 Mar 2019 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccKjxaYI4BX4AIG+J6k9XiYkdy20yjoZxzYLD96dIhI=;
        b=ZvV6KozNlSGD/m9jUR92c7w1UpZKkhH9tOFv51+eoDA3gM1Q9GRf3GVRmkic/sE36h
         3isUtfUVaNN3W0p8+5vjypGAOJsP71+k54+nndzT+BZQuGO5UGoUJJXFFscpvdRaRRt8
         6aJfKO2MWfMWwuUnsBbMtWXZ0L8Ufco0ffxXdob7zxSarskjcLiRgbRbquU7Rb31F8t7
         UdXzVmomrWPMqrT80rhkCIgkg1QBu3YhRJJoWQbJ6fq32f6P7fLwS3YCxFus6gQE+0ZD
         OrohZrXTdLnARg8EW4WMKMB20gYUx3Xg+65NxTr2/e11Xk3jUHoyzk8rP9/gehpIwXuZ
         dbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccKjxaYI4BX4AIG+J6k9XiYkdy20yjoZxzYLD96dIhI=;
        b=ochwcM/plpJdBMtEDvvCdi4iAqPxlxNjNelA88eeFNQ3QrFqi3yIa7RWPmohEprnsV
         9zdAl9QiGq3IQWGlbUTLFhKyXn+grE9kr5MmarqLXgcQ3PJvDrAQ6+20fnzspLoyTJJJ
         nfDLIPv613uFla6BoKgF5XQUitg3tNWujI+Vie+YZBTpaQ478IxhLy23jUEfcxetiWY3
         G6FLwNMCmZV+zVvkROVGsMVHDYICzS8xj7cvJWCMzF3DqUxRQH4cmMYXdp8wFci0L/Kq
         /Gu0F2mZMXCWp2q8O4yxWFbr9EVXNVh7WFeN4sEaOyTc0d+s+IZbbtmwnHFY46y+e7Ei
         AKeA==
X-Gm-Message-State: APjAAAUnJuAG0J4watsHLGOsh5MelViMey9kKOp78dMdjkdjpBMlShWl
        YE67PcKIn7TEqF21DtPZjg/Axv4K
X-Google-Smtp-Source: APXvYqwfF/6F1eysAJQt4Vlo3EZSl4PUS2cKiWKhjwNSaf8Y3Y0FyVWWIf3dvPRarAlzY1TW6lhNZQ==
X-Received: by 2002:a63:145b:: with SMTP id 27mr39056385pgu.74.1553775569596;
        Thu, 28 Mar 2019 05:19:29 -0700 (PDT)
Received: from vultr.guest ([45.32.62.99])
        by smtp.gmail.com with ESMTPSA id h10sm5125480pfj.79.2019.03.28.05.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 05:19:28 -0700 (PDT)
From:   raymond pang <raymondpangxd@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libata: fix using DMA buffers on stack
Date:   Thu, 28 Mar 2019 12:19:25 +0000
Message-Id: <20190328121925.15488-1-raymondpangxd@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
a stack virtual address. Stack DMA buffers must be avoided.

Signed-off-by: raymond pang <raymondpangxd@gmail.com>
---
 drivers/ata/libata-zpodd.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index b3ed8f995..173e6f2dd 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -52,38 +52,52 @@ static int eject_tray(struct ata_device *dev)
 /* Per the spec, only slot type and drawer type ODD can be supported */
 static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 {
-	char buf[16];
+	char *buf;
 	unsigned int ret;
-	struct rm_feature_desc *desc = (void *)(buf + 8);
+	struct rm_feature_desc *desc;
 	struct ata_taskfile tf;
 	static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
 			2,      /* only 1 feature descriptor requested */
 			0, 3,   /* 3, removable medium feature */
 			0, 0, 0,/* reserved */
-			0, sizeof(buf),
+			0, 16,
 			0, 0, 0,
 	};

+	buf = kzalloc(16, GFP_KERNEL);
+	if (!buf)
+		return ODD_MECH_TYPE_UNSUPPORTED;
+	desc = (void *)(buf + 8);
+
 	ata_tf_init(dev, &tf);
 	tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 	tf.protocol = ATAPI_PROT_PIO;
-	tf.lbam = sizeof(buf);
+	tf.lbam = 16;

 	ret = ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
-				buf, sizeof(buf), 0);
-	if (ret)
+				buf, 16, 0);
+	if (ret) {
+		kfree(buf);
 		return ODD_MECH_TYPE_UNSUPPORTED;
+	}

-	if (be16_to_cpu(desc->feature_code) != 3)
+	if (be16_to_cpu(desc->feature_code) != 3) {
+		kfree(buf);
 		return ODD_MECH_TYPE_UNSUPPORTED;
+	}

-	if (desc->mech_type == 0 && desc->load == 0 && desc->eject == 1)
+	if (desc->mech_type == 0 && desc->load == 0 && desc->eject == 1) {
+		kfree(buf);
 		return ODD_MECH_TYPE_SLOT;
-	else if (desc->mech_type == 1 && desc->load == 0 && desc->eject == 1)
+	} else if (desc->mech_type == 1 && desc->load == 0 &&
+		   desc->eject == 1) {
+		kfree(buf);
 		return ODD_MECH_TYPE_DRAWER;
-	else
+	} else {
+		kfree(buf);
 		return ODD_MECH_TYPE_UNSUPPORTED;
+	}
 }

 /* Test if ODD is zero power ready by sense code */
--
2.19.1

