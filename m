Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441ADC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E2D218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGCOwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:52:42 -0400
Received: from gofer.mess.org ([88.97.38.141]:45647 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCOwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:52:42 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id E1CEB60A67; Wed,  3 Jul 2019 15:52:39 +0100 (BST)
Date:   Wed, 3 Jul 2019 15:52:39 +0100
From:   Sean Young <sean@mess.org>
To:     syzbot <syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, hans.verkuil@cisco.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] media: technisat-usb2: break out of loop at end of buffer
Message-ID: <20190703145239.ridwf2jegipnoxfz@gofer.mess.org>
References: <000000000000089d7f058683115e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000089d7f058683115e@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure we do not access the buffer beyond the end if no 0xff byte
is encountered.

Reported-by: syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/usb/dvb-usb/technisat-usb2.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/technisat-usb2.c b/drivers/media/usb/dvb-usb/technisat-usb2.c
index c659e18b358b..676d233d46d5 100644
--- a/drivers/media/usb/dvb-usb/technisat-usb2.c
+++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
@@ -608,10 +608,9 @@ static int technisat_usb2_frontend_attach(struct dvb_usb_adapter *a)
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
@@ -647,26 +646,25 @@ static int technisat_usb2_get_ir(struct dvb_usb_device *d)
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
2.21.0

