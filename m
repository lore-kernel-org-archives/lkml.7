Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56613C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2402A206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfD0P1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:27:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33134 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727366AbfD0PPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:22 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2t-0000zQ-BD; Sat, 27 Apr 2019 16:15:19 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004e5-TJ; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mauro Carvalho Chehab" <m.chehab@samsung.com>,
        "Shuah Khan" <shuah.kh@samsung.com>,
        "Antti Palosaari" <crope@iki.fi>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.101285957@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 185/202] [media] media: em28xx-dvb - fix
 em28xx_dvb_resume() to not unregister i2c and dvb
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuah.kh@samsung.com>

commit 6eb5e3399e8f45aa191ad21c0556bece8ea559f2 upstream.

em28xx_dvb_resume() unregisters i2c tuner, i2c demod, and dvb.
This erroneous cleanup results in i2c tuner, i2c demod, and dvb
devices unregistered and removed during resume. This error is a
result of merge conflict between two patches that went into 3.15.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
Reviewed-by: Antti Palosaari <crope@iki.fi>
Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/em28xx/em28xx-dvb.c | 17 -----------------
 1 file changed, 17 deletions(-)

--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -1712,7 +1712,6 @@ static int em28xx_dvb_resume(struct em28
 	em28xx_info("Resuming DVB extension\n");
 	if (dev->dvb) {
 		struct em28xx_dvb *dvb = dev->dvb;
-		struct i2c_client *client = dvb->i2c_client_tuner;
 
 		if (dvb->fe[0]) {
 			ret = dvb_frontend_resume(dvb->fe[0]);
@@ -1723,22 +1722,6 @@ static int em28xx_dvb_resume(struct em28
 			ret = dvb_frontend_resume(dvb->fe[1]);
 			em28xx_info("fe1 resume %d\n", ret);
 		}
-		/* remove I2C tuner */
-		if (client) {
-			module_put(client->dev.driver->owner);
-			i2c_unregister_device(client);
-		}
-
-		/* remove I2C demod */
-		client = dvb->i2c_client_demod;
-		if (client) {
-			module_put(client->dev.driver->owner);
-			i2c_unregister_device(client);
-		}
-
-		em28xx_unregister_dvb(dvb);
-		kfree(dvb);
-		dev->dvb = NULL;
 	}
 
 	return 0;

