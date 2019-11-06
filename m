Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50946C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC9B217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfKFJum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:50:42 -0500
Received: from sauhun.de ([88.99.104.3]:50202 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731677AbfKFJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:50:40 -0500
Received: from localhost (p54B33505.dip0.t-ipconnect.de [84.179.53.5])
        by pokefinder.org (Postfix) with ESMTPSA id A35402C0554;
        Wed,  6 Nov 2019 10:50:38 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/12] media: pci: bt8xx: convert to i2c_new_scanned_device
Date:   Wed,  6 Nov 2019 10:50:27 +0100
Message-Id: <20191106095033.25182-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. RFC, please comment and/or ack, but don't apply yet.

 drivers/media/pci/bt8xx/bttv-input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bttv-input.c b/drivers/media/pci/bt8xx/bttv-input.c
index 492bc85c2700..41226f1d0e5b 100644
--- a/drivers/media/pci/bt8xx/bttv-input.c
+++ b/drivers/media/pci/bt8xx/bttv-input.c
@@ -386,7 +386,7 @@ void init_bttv_i2c_ir(struct bttv *btv)
 
 	if (btv->init_data.name) {
 		info.platform_data = &btv->init_data;
-		i2c_dev = i2c_new_device(&btv->c.i2c_adap, &info);
+		i2c_dev = i2c_new_client_device(&btv->c.i2c_adap, &info);
 	} else {
 		/*
 		 * The external IR receiver is at i2c address 0x34 (0x35 for
@@ -396,9 +396,9 @@ void init_bttv_i2c_ir(struct bttv *btv)
 		 * internal.
 		 * That's why we probe 0x1a (~0x34) first. CB
 		 */
-		i2c_dev = i2c_new_probed_device(&btv->c.i2c_adap, &info, addr_list, NULL);
+		i2c_dev = i2c_new_scanned_device(&btv->c.i2c_adap, &info, addr_list, NULL);
 	}
-	if (NULL == i2c_dev)
+	if (IS_ERR(i2c_dev))
 		return;
 
 #if defined(CONFIG_MODULES) && defined(MODULE)
-- 
2.20.1

