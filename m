Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC93C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5342053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfLPM3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:29:53 -0500
Received: from sauhun.de ([88.99.104.3]:39770 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbfLPM3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:29:50 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id D6A972C2D79;
        Mon, 16 Dec 2019 13:29:48 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sean Young <sean@mess.org>,
        Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] media: pci: cx18: convert to i2c_new_scanned_device
Date:   Mon, 16 Dec 2019 13:29:44 +0100
Message-Id: <20191216122946.3495-5-wsa+renesas@sang-engineering.com>
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
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/media/pci/cx18/cx18-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-i2c.c b/drivers/media/pci/cx18/cx18-i2c.c
index 1ef7ccf4a722..a83435245251 100644
--- a/drivers/media/pci/cx18/cx18-i2c.c
+++ b/drivers/media/pci/cx18/cx18-i2c.c
@@ -88,7 +88,7 @@ static int cx18_i2c_new_ir(struct cx18 *cx, struct i2c_adapter *adap, u32 hw,
 		break;
 	}
 
-	return i2c_new_probed_device(adap, &info, addr_list, NULL) == NULL ?
+	return IS_ERR(i2c_new_scanned_device(adap, &info, addr_list, NULL)) ?
 	       -1 : 0;
 }
 
-- 
2.20.1

