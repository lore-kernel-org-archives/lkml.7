Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A8C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F7326FC6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfEaWiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 18:38:10 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:50622 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfEaWiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:38:09 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1hWq9x-000715-Tn; Sat, 01 Jun 2019 00:38:01 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] media: cxusb-analog: Use ARRAY_SIZE for cxusub_medion_pin_config
Date:   Sat,  1 Jun 2019 00:37:56 +0200
Message-Id: <20190531223756.1305617-1-mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE for computing element count of cxusub_medion_pin_config
array as suggested by the kbuild test robot.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/media/usb/dvb-usb/cxusb-analog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/cxusb-analog.c b/drivers/media/usb/dvb-usb/cxusb-analog.c
index 9b42ca71c177..51d3cba32b60 100644
--- a/drivers/media/usb/dvb-usb/cxusb-analog.c
+++ b/drivers/media/usb/dvb-usb/cxusb-analog.c
@@ -1622,8 +1622,7 @@ int cxusb_medion_analog_init(struct dvb_usb_device *dvbdev)
 	/* TODO: setup audio samples insertion */
 
 	ret = v4l2_subdev_call(cxdev->cx25840, core, s_io_pin_config,
-			       sizeof(cxusub_medion_pin_config) /
-			       sizeof(cxusub_medion_pin_config[0]),
+			       ARRAY_SIZE(cxusub_medion_pin_config),
 			       cxusub_medion_pin_config);
 	if (ret != 0)
 		dev_warn(&dvbdev->udev->dev,
