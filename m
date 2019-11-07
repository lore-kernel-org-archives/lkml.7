Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9AC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8448B214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tFeI+bI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbfKGJqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:46:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33615 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:46:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id w30so2288026wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYdHQ/UO27K++cZW9zQuGji5xNvlsvTd2fpe7ujHCIY=;
        b=tFeI+bI82f7A9CpRrm9gCaaLcV7L2rzG0cOBj47LsplQyzscDWZ3uSLmVVhWH5Ll/l
         RJcMzMHrmLR+NhhG5jy+j6QjSH5iqcUjFJr+m34ITo3AtN4W/0mMXab9iywV2TSwnVJm
         4fi8CMpuw3leDD1mdEP8zY6PvqvgXP9UAYbQ1VKb+5KwJtbHQe+ShVBdOHZtjg2EU984
         YoTOK6R2M/Jfjqzg1PULRDczEaDkzOe/PyLGA3BXMTShRJybE++WeCLiXu0jHXYyfiF9
         Dnt9h7jgQzXBV6HK1JsB6bcryzs8ANOWZJCdw73JfF2yrIR5ulTaBfuWTTq1MidZQcjR
         RQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYdHQ/UO27K++cZW9zQuGji5xNvlsvTd2fpe7ujHCIY=;
        b=U01qoL4ptKjsniDzhVgw2N0+ONSw5CYkebjHORGxWghZ5yGU/c+HSOPJaRKg31cFvd
         O7dLIlCi3vdoL+JkooXVvFJ9I4O1vA0YbIHq4bL/tCU9Nw8scLsoTxMEAZccrs0Y4NSX
         j7TVqBuEnMa0+KnRFa/yKN6e48uYc2xxGKISEiFNCVvMeWGq3jzBan+Usq/fJddFh7bG
         SD7cMKkUhcsNKM+91vkGy5yMtUjeyD4FXKtNPPL3G1C7TFc9FfJjPBBaP0tNWAXhF2XT
         mLsWO8WzBjYnpFmh6gG94Pso68i+JYHak39oCTDX0DNcLYqHKwT9/hbmmXnssh0eILnB
         5/EA==
X-Gm-Message-State: APjAAAV6hU8WqOBwSnDvc9G02IBj+2YDmBaRLe++G1KpivuhFuQFa3u/
        0+Hsd6r22g8/svEjutPJ8zPHqw==
X-Google-Smtp-Source: APXvYqx6uFZ7ophY/dHYBLgpfGDu/hW16RYAXW1k4gUoFsC70OQxNUBqA9m6WSaXBdxp1jtieD8bSg==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr1912912wrq.118.1573119972703;
        Thu, 07 Nov 2019 01:46:12 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id j14sm1917896wrj.35.2019.11.07.01.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:46:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] bluetooth: btmtksdio: add MODULE_DEVICE_TABLE()
Date:   Thu,  7 Nov 2019 10:46:10 +0100
Message-Id: <20191107094610.22132-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This adds the missing MODULE_DEVICE_TABLE() for SDIO IDs. While certain
platforms using this driver indeed have HW issues causing problems if
the module is loaded too early - this should be handled from user-space
by blacklisting it or delaying the loading.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/bluetooth/btmtksdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 813338288453..519788c442ca 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -57,6 +57,7 @@ static const struct sdio_device_id btmtksdio_table[] = {
 	 .driver_data = (kernel_ulong_t)&mt7668_data },
 	{ }	/* Terminating entry */
 };
+MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 
 #define MTK_REG_CHLPCR		0x4	/* W1S */
 #define C_INT_EN_SET		BIT(0)
-- 
2.23.0

