Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9E5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00964218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117243;
	bh=EX9/gjsvzk3QMJHY9F0LrsMt2KPDAAEg13oZ0uElnUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=veeBlEZbEX/YZfPlmp5xYvh/FnEHJDnVPIVaWy6ltL2ZXcnagRc2rs1Dt3DyDKFRw
	 904vlNZE6ykth5GJ29WtoLAK8DEFD2fMdToMX/zRK/8usi48Osx5QPfk9fbiPu/gKf
	 wCicAaD+5MD55nAhjbCT7kxj0z9y3VWblOz5dkGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfDXOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732135AbfDXOrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538A9218FC;
        Wed, 24 Apr 2019 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117237;
        bh=EX9/gjsvzk3QMJHY9F0LrsMt2KPDAAEg13oZ0uElnUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQx6vV3RKQduhClgEohVPJ9xNIPW4itf3t46KdyQYjhuj3TBP48EsnIc497ElhuWk
         0gWZaT+C6aAkG+RoprHVRKOknqxB1SM33o/eM0gFuBB4vX0SsDaiLS2yIO5bx3ha4J
         TROGixpnqHT+316rrF6Yjj/lKjcydP3tYPKbq6S4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/35] rtc: sh: Fix invalid alarm warning for non-enabled alarm
Date:   Wed, 24 Apr 2019 10:46:37 -0400
Message-Id: <20190424144709.30215-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 15d82d22498784966df8e4696174a16b02cc1052 ]

When no alarm has been programmed on RSK-RZA1, an error message is
printed during boot:

    rtc rtc0: invalid alarm value: 2019-03-14T255:255:255

sh_rtc_read_alarm_value() returns 0xff when querying a hardware alarm
field that is not enabled.  __rtc_read_alarm() validates the received
alarm values, and fills in missing fields when needed.
While 0xff is handled fine for the year, month, and day fields, and
corrected as considered being out-of-range, this is not the case for the
hour, minute, and second fields, where -1 is expected for missing
fields.

Fix this by returning -1 instead, as this value is handled fine for all
fields.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 6c2d3989f967..9b6a927149a4 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -462,7 +462,7 @@ static int sh_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static inline int sh_rtc_read_alarm_value(struct sh_rtc *rtc, int reg_off)
 {
 	unsigned int byte;
-	int value = 0xff;	/* return 0xff for ignored values */
+	int value = -1;			/* return -1 for ignored values */
 
 	byte = readb(rtc->regbase + reg_off);
 	if (byte & AR_ENB) {
-- 
2.19.1

