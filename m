Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60751C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F306214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179627;
	bh=g7ImD3Q5yFxdqIyESBY5o6a+si5j7yoFRXlz7SFGtl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z13ghbIO9HWQTjRFOEJMtNRkErmBEG7r5pBp0hbLwo3uLzCs2uu6GvNX2kgbIvC3X
	 Vcp4X8275TxA4grzamRht51kyCkqGm63BIU09FwBA9Rd1utx04euiYg9Rx1p6FdJ6I
	 rfOd9ZJR+u2t9b2dVfD9p/2ersawdSChnhb2oNuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436805AbfIVTNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394839AbfIVS53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:57:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E37F206C2;
        Sun, 22 Sep 2019 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178649;
        bh=g7ImD3Q5yFxdqIyESBY5o6a+si5j7yoFRXlz7SFGtl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEYeTyF1YMCtVgywKFSJ1gRBJ/GZmxGUY29eC6BEs/gJFLViYmZp/Uk6qTMkfLKHr
         hUUXqeLpgV7jIEUBtOowURdJEQEWuM4w/O7y4KAn1wUf3QA9zmShsWoVkgnfSzcdGJ
         /cMmNTJr2fd+XJdas0y08NCcawunGJ5lBYcUMydg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Stoughton <nstoughton@logitech.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/89] leds: leds-lp5562 allow firmware files up to the maximum length
Date:   Sun, 22 Sep 2019 14:55:53 -0400
Message-Id: <20190922185717.3412-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Stoughton <nstoughton@logitech.com>

[ Upstream commit ed2abfebb041473092b41527903f93390d38afa7 ]

Firmware files are in ASCII, using 2 hex characters per byte. The
maximum length of a firmware string is therefore

16 (commands) * 2 (bytes per command) * 2 (characters per byte) = 64

Fixes: ff45262a85db ("leds: add new LP5562 LED driver")
Signed-off-by: Nick Stoughton <nstoughton@logitech.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp5562.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp5562.c b/drivers/leds/leds-lp5562.c
index 05ffa34fb6ad0..9d9b673c873c6 100644
--- a/drivers/leds/leds-lp5562.c
+++ b/drivers/leds/leds-lp5562.c
@@ -263,7 +263,11 @@ static void lp5562_firmware_loaded(struct lp55xx_chip *chip)
 {
 	const struct firmware *fw = chip->fw;
 
-	if (fw->size > LP5562_PROGRAM_LENGTH) {
+	/*
+	 * the firmware is encoded in ascii hex character, with 2 chars
+	 * per byte
+	 */
+	if (fw->size > (LP5562_PROGRAM_LENGTH * 2)) {
 		dev_err(&chip->cl->dev, "firmware data size overflow: %zu\n",
 			fw->size);
 		return;
-- 
2.20.1

