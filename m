Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22240C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EF42173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ZMZRHE1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfHYMbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:31:21 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:54431 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfHYMbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:31:21 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46GZFz2DnWz55;
        Sun, 25 Aug 2019 14:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566736183; bh=vZsP+gC6xjkhdwkU8RmUdpu99NTy+OKDeJJ+3qq5kYI=;
        h=Date:From:Subject:To:Cc:From;
        b=ZMZRHE1TUw+O6DnjyEJH55gwzmnFGtQock72ZLgmnL0kUwHZR+00TCEkDbTJ8IIXK
         2RJO/iFKs0OsqsFTu1Oae6j2OEAmN2TKpzP5QMEPivRTT3R/x8qajRx+s2OE81r5Jl
         N8gvx2iu3vHZRwUtmVL3UYeMjHXqRBKAtiiHOgJOyzmzugXIDVw5/9OjpXeYaPZdnb
         Lrc7xuC1a4zlr4BiAnBQVFcTre+fV7KmPeXwArRrgVi03P+wvrPxsw4ieK6Ohf9tFB
         pJ0atbODbU0EXW7LwnLvxG6IuTPWJYkYISzHsrbf908bku/iRj09ugVb1AdcruXo73
         M1ToJmT36+SZg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sun, 25 Aug 2019 14:31:18 +0200
Message-Id: <af358d4136fda9d0d7eec95a54e9f880b704159b.1566736219.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] ata_piix: remove open-coded dmi_match(DMI_OEM_STRING)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since de40614de99 ("firmware: dmi_scan: Add DMI_OEM_STRING support to
dmi_matches") dmi_check_system() can match OEM_STRINGs itself.
Use the feature.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/ata/ata_piix.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index e4da725381d3..3ca7720e7d8f 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -840,6 +840,12 @@ static int piix_broken_suspend(void)
 				DMI_MATCH(DMI_PRODUCT_NAME, "Tecra M3"),
 			},
 		},
+		{
+			.ident = "TECRA M3",
+			.matches = {
+				DMI_MATCH(DMI_OEM_STRING, "Tecra M3,"),
+			},
+		},
 		{
 			.ident = "TECRA M4",
 			.matches = {
@@ -955,18 +961,10 @@ static int piix_broken_suspend(void)
 
 		{ }	/* terminate list */
 	};
-	static const char *oemstrs[] = {
-		"Tecra M3,",
-	};
-	int i;
 
 	if (dmi_check_system(sysids))
 		return 1;
 
-	for (i = 0; i < ARRAY_SIZE(oemstrs); i++)
-		if (dmi_find_device(DMI_DEV_TYPE_OEM_STRING, oemstrs[i], NULL))
-			return 1;
-
 	/* TECRA M4 sometimes forgets its identify and reports bogus
 	 * DMI information.  As the bogus information is a bit
 	 * generic, match as many entries as possible.  This manual
-- 
2.20.1

