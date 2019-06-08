Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7220C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01A1208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfFHK55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:57:57 -0400
Received: from sauhun.de ([88.99.104.3]:51934 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbfFHK46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:56:58 -0400
Received: from localhost (p5486CBCC.dip0.t-ipconnect.de [84.134.203.204])
        by pokefinder.org (Postfix) with ESMTPSA id 5A7563E4795;
        Sat,  8 Jun 2019 12:56:57 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/34] staging: media: soc_camera: imx074: simplify getting the adapter of a client
Date:   Sat,  8 Jun 2019 12:56:10 +0200
Message-Id: <20190608105619.593-32-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/staging/media/soc_camera/imx074.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/soc_camera/imx074.c b/drivers/staging/media/soc_camera/imx074.c
index d907aa62f898..14240b74cdd0 100644
--- a/drivers/staging/media/soc_camera/imx074.c
+++ b/drivers/staging/media/soc_camera/imx074.c
@@ -409,7 +409,7 @@ static int imx074_probe(struct i2c_client *client,
 			const struct i2c_device_id *did)
 {
 	struct imx074 *priv;
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct soc_camera_subdev_desc *ssdd = soc_camera_i2c_to_desc(client);
 	int ret;
 
-- 
2.19.1

