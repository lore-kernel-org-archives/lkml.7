Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D463C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6773320882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179654;
	bh=5PRxwvJOPGRmn8UkRJJoesonvbFonXLvvtfiGZcZyPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3f84Z2oHUEobAR3e6L1rZLcBJpJdUs678hnFSQIngg3PI8J0MTSQ603eai3HDpmZ
	 7Enyq7ts+FtH/jdDxvphcwRUT9JnY6PDo765uxS8OTKLDonVVV863mtiq+gitgrVZa
	 WChvyoA3KSwTyiLsJhmwVDmkeYnk9xUw+reZjyU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436856AbfIVTON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394736AbfIVS5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:57:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646262184D;
        Sun, 22 Sep 2019 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178622;
        bh=5PRxwvJOPGRmn8UkRJJoesonvbFonXLvvtfiGZcZyPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKDazYqqeckfL3Ok9wKyFcs0fD0pEi3g8Pu/Les2sliRDHgkrwdB2/MA3owW8BvxP
         r8ykX7BXLuEiSc33hEu5ILtYE2ZNJzvWaH6vl01L1bi7g68tgtKJ270TWxI1Okd8CT
         Iijt4pRgvM4Ob8aqV856c4Ean1NM5EE/UgptICCk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Young <sean@mess.org>,
        syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 120/128] media: technisat-usb2: break out of loop at end of buffer
Date:   Sun, 22 Sep 2019 14:54:10 -0400
Message-Id: <20190922185418.2158-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

[ Upstream commit 0c4df39e504bf925ab666132ac3c98d6cbbe380b ]

Ensure we do not access the buffer beyond the end if no 0xff byte
is encountered.

Reported-by: syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/technisat-usb2.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/technisat-usb2.c b/drivers/media/usb/dvb-usb/technisat-usb2.c
index 18d0f8f5283fa..8d8e9f56a8be5 100644
--- a/drivers/media/usb/dvb-usb/technisat-usb2.c
+++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
@@ -607,10 +607,9 @@ static int technisat_usb2_frontend_attach(struct dvb_usb_adapter *a)
 static int technisat_usb2_get_ir(struct dvb_usb_device *d)
 {
 	struct technisat_usb2_state *state = d->priv;
-	u8 *buf = state->buf;
-	u8 *b;
-	int ret;
 	struct ir_raw_event ev;
+	u8 *buf = state->buf;
+	int i, ret;
 
 	buf[0] = GET_IR_DATA_VENDOR_REQUEST;
 	buf[1] = 0x08;
@@ -646,26 +645,25 @@ static int technisat_usb2_get_ir(struct dvb_usb_device *d)
 		return 0; /* no key pressed */
 
 	/* decoding */
-	b = buf+1;
 
 #if 0
 	deb_rc("RC: %d ", ret);
-	debug_dump(b, ret, deb_rc);
+	debug_dump(buf + 1, ret, deb_rc);
 #endif
 
 	ev.pulse = 0;
-	while (1) {
-		ev.pulse = !ev.pulse;
-		ev.duration = (*b * FIRMWARE_CLOCK_DIVISOR * FIRMWARE_CLOCK_TICK) / 1000;
-		ir_raw_event_store(d->rc_dev, &ev);
-
-		b++;
-		if (*b == 0xff) {
+	for (i = 1; i < ARRAY_SIZE(state->buf); i++) {
+		if (buf[i] == 0xff) {
 			ev.pulse = 0;
 			ev.duration = 888888*2;
 			ir_raw_event_store(d->rc_dev, &ev);
 			break;
 		}
+
+		ev.pulse = !ev.pulse;
+		ev.duration = (buf[i] * FIRMWARE_CLOCK_DIVISOR *
+			       FIRMWARE_CLOCK_TICK) / 1000;
+		ir_raw_event_store(d->rc_dev, &ev);
 	}
 
 	ir_raw_event_handle(d->rc_dev);
-- 
2.20.1

