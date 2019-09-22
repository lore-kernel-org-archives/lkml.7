Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE63C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8169B20882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569177877;
	bh=34W1jjTazjZpi9L33eWvheVRmOMYkavJ5q66RdOX93w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qAnk/7ILTzpHAYyJ6o2hlsR+5EZCfeYsPa8tAqj8bp1mBoIqPK2Hsf9QK8uvACREm
	 WFN3PdELHko0BAtMD+/gt+5Lx2qZd2W6Cgdf+h8DTiwuZU5G3HQK5iOkgPAvfrZ90N
	 Y/VJyv0+4zEu9yqEulHG16c6Myb1y5KB9BRx+i38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbfIVSoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388694AbfIVSoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:44:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC42206C2;
        Sun, 22 Sep 2019 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177846;
        bh=34W1jjTazjZpi9L33eWvheVRmOMYkavJ5q66RdOX93w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0tfweO0naisZ0J2afvXndHXOO1xR0aJHN9pc82FuRnu1Yej5I90Z2MA1P7Xk8JSa
         g244puSr4LjDiHx+Y3eO2ia6UKftTg0kL7XB8D8H449LVLnvZbBhQAe0C580LRj8/p
         6MET/efrdbSZklRuP5MLtSj+ChoYlmXe7guU5uUY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Stoughton <nstoughton@logitech.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 013/203] leds: leds-lp5562 allow firmware files up to the maximum length
Date:   Sun, 22 Sep 2019 14:40:39 -0400
Message-Id: <20190922184350.30563-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
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
index 37632fc637414..edb57c42e8b1d 100644
--- a/drivers/leds/leds-lp5562.c
+++ b/drivers/leds/leds-lp5562.c
@@ -260,7 +260,11 @@ static void lp5562_firmware_loaded(struct lp55xx_chip *chip)
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

