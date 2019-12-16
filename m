Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94BA2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfLPMaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:30:15 -0500
Received: from sauhun.de ([88.99.104.3]:39774 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbfLPM3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:29:51 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id 8F1CC2C2D9E;
        Mon, 16 Dec 2019 13:29:49 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sean Young <sean@mess.org>,
        Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] media: pci: ivtv: convert to i2c_new_scanned_device
Date:   Mon, 16 Dec 2019 13:29:45 +0100
Message-Id: <20191216122946.3495-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
References: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable. Change
the legacy function to simply return void because the retval was never
used anywhere.

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/media/pci/ivtv/ivtv-i2c.c | 6 +++---
 drivers/media/pci/ivtv/ivtv-i2c.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-i2c.c b/drivers/media/pci/ivtv/ivtv-i2c.c
index 0772d757a389..982045c4eea8 100644
--- a/drivers/media/pci/ivtv/ivtv-i2c.c
+++ b/drivers/media/pci/ivtv/ivtv-i2c.c
@@ -208,12 +208,12 @@ static int ivtv_i2c_new_ir(struct ivtv *itv, u32 hw, const char *type, u8 addr)
 	info.platform_data = init_data;
 	strscpy(info.type, type, I2C_NAME_SIZE);
 
-	return i2c_new_probed_device(adap, &info, addr_list, NULL) == NULL ?
+	return IS_ERR(i2c_new_scanned_device(adap, &info, addr_list, NULL)) ?
 	       -1 : 0;
 }
 
 /* Instantiate the IR receiver device using probing -- undesirable */
-struct i2c_client *ivtv_i2c_new_ir_legacy(struct ivtv *itv)
+void ivtv_i2c_new_ir_legacy(struct ivtv *itv)
 {
 	struct i2c_board_info info;
 	/*
@@ -235,7 +235,7 @@ struct i2c_client *ivtv_i2c_new_ir_legacy(struct ivtv *itv)
 
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	strscpy(info.type, "ir_video", I2C_NAME_SIZE);
-	return i2c_new_probed_device(&itv->i2c_adap, &info, addr_list, NULL);
+	i2c_new_scanned_device(&itv->i2c_adap, &info, addr_list, NULL);
 }
 
 int ivtv_i2c_register(struct ivtv *itv, unsigned idx)
diff --git a/drivers/media/pci/ivtv/ivtv-i2c.h b/drivers/media/pci/ivtv/ivtv-i2c.h
index 462f73449a6e..2d9cdaa682c5 100644
--- a/drivers/media/pci/ivtv/ivtv-i2c.h
+++ b/drivers/media/pci/ivtv/ivtv-i2c.h
@@ -9,7 +9,7 @@
 #ifndef IVTV_I2C_H
 #define IVTV_I2C_H
 
-struct i2c_client *ivtv_i2c_new_ir_legacy(struct ivtv *itv);
+void ivtv_i2c_new_ir_legacy(struct ivtv *itv);
 int ivtv_i2c_register(struct ivtv *itv, unsigned idx);
 struct v4l2_subdev *ivtv_find_hw(struct ivtv *itv, u32 hw);
 
-- 
2.20.1

