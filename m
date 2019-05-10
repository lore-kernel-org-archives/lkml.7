Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742E0C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1FF217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfEJNKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:10:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42980 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfEJNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:10:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hP5IO-0005L9-As; Fri, 10 May 2019 13:10:40 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: logitech-dj: make const array template static
Date:   Fri, 10 May 2019 14:10:39 +0100
Message-Id: <20190510131039.4675-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array template  on the stack but instead make it
static. Makes the object code smaller by 10 bytes. Also reformat
the declaration.

Before:
   text	   data	    bss	    dec	    hex	filename
  29376	   9360	    128	  38864	   97d0	drivers/hid/hid-logitech-dj.o

After:
   text	   data	    bss	    dec	    hex	filename
  29270	   9456	    128	  38854	   97c6	drivers/hid/hid-logitech-dj.o

(gcc version 8.3.0, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-logitech-dj.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index b1e894618eed..72d0ab05401f 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1111,12 +1111,14 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
 
 static int logi_dj_recv_query_hidpp_devices(struct dj_receiver_dev *djrcv_dev)
 {
-	const u8 template[] = {REPORT_ID_HIDPP_SHORT,
-			       HIDPP_RECEIVER_INDEX,
-			       HIDPP_SET_REGISTER,
-			       HIDPP_REG_CONNECTION_STATE,
-			       HIDPP_FAKE_DEVICE_ARRIVAL,
-			       0x00, 0x00};
+	static const u8 template[] = {
+		REPORT_ID_HIDPP_SHORT,
+		HIDPP_RECEIVER_INDEX,
+		HIDPP_SET_REGISTER,
+		HIDPP_REG_CONNECTION_STATE,
+		HIDPP_FAKE_DEVICE_ARRIVAL,
+		0x00, 0x00
+	};
 	u8 *hidpp_report;
 	int retval;
 
-- 
2.20.1

