Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE297C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817C1218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117590;
	bh=j3zqp7WzoD1FVBeS5IQznFaC03BDtOC35ofbxC2Tq1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjTc5xrN6hwGUQQRtP52mBdl5aCmgMz0OQ17zhzY4vmFMSvRID2bIlQdf7zo1VH/e
	 TOrMxrxWEQ7F5Zuse8VFODgMSbkfYgkig75K6lEtc00YnrpyLA8oEcdgHy0QyJ5C32
	 VSgCyPzTSO/xqWM4lyNBZgJaJPoJGoCXVp/mE4Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfDXOxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732464AbfDXOxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:53:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0D321902;
        Wed, 24 Apr 2019 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117586;
        bh=j3zqp7WzoD1FVBeS5IQznFaC03BDtOC35ofbxC2Tq1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRGyixELCMlueBzUl7lv2YEdHG7uBUGmX9JXHGa/fiJCHSSrS3ormAptulGBjj8dA
         QA0iqbpakXW7o8NMqOUNqbfmu723BY+QGRxaiJisTZmmYeN7ZOcfW+dYt0DrO5ewU1
         GL8aeHuU7nRY1GSHpW/3tN2EPteFTPk7hP4hMCgE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 02/10] rtc: sh: Fix invalid alarm warning for non-enabled alarm
Date:   Wed, 24 Apr 2019 10:52:51 -0400
Message-Id: <20190424145259.31639-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145259.31639-1-sashal@kernel.org>
References: <20190424145259.31639-1-sashal@kernel.org>
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
index d0d2b047658b..dcd5dcae7b3c 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -455,7 +455,7 @@ static int sh_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static inline int sh_rtc_read_alarm_value(struct sh_rtc *rtc, int reg_off)
 {
 	unsigned int byte;
-	int value = 0xff;	/* return 0xff for ignored values */
+	int value = -1;			/* return -1 for ignored values */
 
 	byte = readb(rtc->regbase + reg_off);
 	if (byte & AR_ENB) {
-- 
2.19.1

