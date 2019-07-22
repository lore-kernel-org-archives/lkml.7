Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFDFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70117217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfGVR0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:26:25 -0400
Received: from sauhun.de ([88.99.104.3]:42116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbfGVR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:10 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id CE21F4A1491;
        Mon, 22 Jul 2019 19:26:08 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] media: usb: go7007: s2250-board: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:02 +0200
Message-Id: <20190722172604.3572-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
References: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/media/usb/go7007/s2250-board.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/go7007/s2250-board.c b/drivers/media/usb/go7007/s2250-board.c
index 179d4d642dae..49e75a1a1f3f 100644
--- a/drivers/media/usb/go7007/s2250-board.c
+++ b/drivers/media/usb/go7007/s2250-board.c
@@ -505,9 +505,9 @@ static int s2250_probe(struct i2c_client *client,
 	struct go7007 *go = i2c_get_adapdata(adapter);
 	struct go7007_usb *usb = go->hpi_context;
 
-	audio = i2c_new_dummy(adapter, TLV320_ADDRESS >> 1);
-	if (audio == NULL)
-		return -ENOMEM;
+	audio = i2c_new_dummy_device(adapter, TLV320_ADDRESS >> 1);
+	if (IS_ERR(audio))
+		return PTR_ERR(audio);
 
 	state = kzalloc(sizeof(struct s2250), GFP_KERNEL);
 	if (state == NULL) {
-- 
2.20.1

