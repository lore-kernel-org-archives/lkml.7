Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4F9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB00821783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118922;
	bh=g7ImD3Q5yFxdqIyESBY5o6a+si5j7yoFRXlz7SFGtl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FQGeVVoBkqz7W2D+Z/25MA1T4md4rrVAgUSIclj4aCXrHg4Dr9ePD6muxF32yOdaO
	 sGPA9GVEWgmNqB9bU1GRD9qf6cIdJfy3qU4yTNbZYX22OAWGHJK5cTNOh/UG81Lw8B
	 reYyJcIDPf+Jk15TUscXuK6XIcvfuKi+yD889yro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfJCQIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731955AbfJCQIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:08:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5A021848;
        Thu,  3 Oct 2019 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118914;
        bh=g7ImD3Q5yFxdqIyESBY5o6a+si5j7yoFRXlz7SFGtl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcpqZMH4WWkVQWHCxnP/6QZCEQCnMbkB2DnnE9U3UpknrhDMsjzLTC1Vi57Ng0t1H
         PnwBCmna64JbH2RcIzpgIYiCmATf/VamxtuDxEHYy5ukUCsqkCVjVj7VmOSJSc0Ov1
         DwhGd2aQ8u93mZ70wu4G627RzZxtG20lSzK3qHeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Stoughton <nstoughton@logitech.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 057/185] leds: leds-lp5562 allow firmware files up to the maximum length
Date:   Thu,  3 Oct 2019 17:52:15 +0200
Message-Id: <20191003154450.192983537@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



