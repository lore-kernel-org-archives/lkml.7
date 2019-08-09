Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E61EC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461DF214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407174AbfHITEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:04:54 -0400
Received: from sauhun.de ([88.99.104.3]:40900 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfHITEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:04:53 -0400
Received: from localhost (p54B333D4.dip0.t-ipconnect.de [84.179.51.212])
        by pokefinder.org (Postfix) with ESMTPSA id 1201B2C3014;
        Fri,  9 Aug 2019 21:04:52 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: adv7842: convert to i2c_new_dummy_device
Date:   Fri,  9 Aug 2019 21:04:06 +0200
Message-Id: <20190809190407.12616-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the to-be-removed i2c_new_dummy() to
i2c_new_dummy_device(). So, we now get an ERRPTR which we use in error
handling by printing the error code. To keep the rest of the driver
logic as is, internally a NULL ptr is still kept.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/media/i2c/adv7842.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index 11ab2df02dc7..ffc3d174c4a1 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -3400,9 +3400,12 @@ static struct i2c_client *adv7842_dummy_client(struct v4l2_subdev *sd, const cha
 		return NULL;
 	}
 
-	cp = i2c_new_dummy(client->adapter, io_read(sd, io_reg) >> 1);
-	if (!cp)
-		v4l2_err(sd, "register %s on i2c addr 0x%x failed\n", desc, addr);
+	cp = i2c_new_dummy_device(client->adapter, io_read(sd, io_reg) >> 1);
+	if (IS_ERR(cp)) {
+		v4l2_err(sd, "register %s on i2c addr 0x%x failed with %ld\n",
+			 desc, addr, PTR_ERR(cp));
+		cp = NULL;
+	}
 
 	return cp;
 }
-- 
2.20.1

