Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD04C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B117204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962669;
	bh=RZHhLtnbYR92Tt2A5Oo+4YI0+QJ9PPVF76ew02vkmuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZU+KWlP6G95FOGTyjs8ks2bWyWv8oKlCrqrfi7EipiZNiF43TkbpQpuHQN/oahyr+
	 I74u+nMD1AlttHLzrq0rGZ9r2GpSbGP+jKfOzUdN19EEgSjT0rtdlYyEFD8D+i9GIz
	 jjyw+etyvFfNyDywMEp6Ld+IsP4peZrWfERp9+fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfDVTvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731214AbfDVTuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:50:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4B920643;
        Mon, 22 Apr 2019 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962651;
        bh=RZHhLtnbYR92Tt2A5Oo+4YI0+QJ9PPVF76ew02vkmuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkOIYJCYQrldUma3wHwduNSv8Inx3EJIv+yNGrTc3cEqvJNQ4LrhDRxraOOEtdKKO
         e3B88+R78bhdHVWhX+wR3rZHWB77FkYZzrRp9t6FvFEjV8JfOMg1fr+aEW2PcvZ+cE
         ypzjuSAV7TopjJcawu/XK9Y1tiU91ecWEbKLIG7U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     raymond pang <raymondpangxd@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 14/15] libata: fix using DMA buffers on stack
Date:   Mon, 22 Apr 2019 15:50:21 -0400
Message-Id: <20190422195022.13760-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422195022.13760-1-sashal@kernel.org>
References: <20190422195022.13760-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: raymond pang <raymondpangxd@gmail.com>

[ Upstream commit dd08a8d9a66de4b54575c294a92630299f7e0fe7 ]

When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
a stack virtual address. Stack DMA buffers must be avoided.

Signed-off-by: raymond pang <raymondpangxd@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/ata/libata-zpodd.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 0ad96c647541..7017a81d53cf 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -51,38 +51,52 @@ static int eject_tray(struct ata_device *dev)
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

