Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9FAC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637472084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557917958;
	bh=/aWhPZJ6uNNDo2118noQh/BUYWHFCadlSsiybRkSSSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aAaMEmH8dO+vsU/GE5QWNYRNjT9xAZmFmt5emqICasMiaUTESyIXjsFs9pQ5+qhXQ
	 KhDEYpRKt9nz48QrMzsQR2zjA1xRl9IajYiKP5ZMiQtwLpP8g9sHrT4uu5ZtxH/IyK
	 cB/l1SuGn0Qq2M6udcmlmjuqcN//cV4DBinvmDPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfEOK7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfEOK7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:59:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AE4321881;
        Wed, 15 May 2019 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557917954;
        bh=/aWhPZJ6uNNDo2118noQh/BUYWHFCadlSsiybRkSSSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhZiPUFun8clagBeewfbIMFXHr4id2494LPDUYdSYJcKRSVfE1TaeI84WKXTshmS+
         VtgPoqytaxHE0ZJ3DzJ1nY68RczPHFMiP9dlNEGUEgvYNtTZ3Jj6PPg0FDkGtsRP4p
         BkEDcfc3HpDUcO3aA0NuWDUieHjPBRBvPp+37o8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 38/86] rtc: sh: Fix invalid alarm warning for non-enabled alarm
Date:   Wed, 15 May 2019 12:55:15 +0200
Message-Id: <20190515090650.236950353@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.1



