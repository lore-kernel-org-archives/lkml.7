Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3210C4360D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975362086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeBGCxRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbfIIB0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 21:26:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33237 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbfIIB0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 21:26:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id g25so9669243otl.0;
        Sun, 08 Sep 2019 18:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Ov2d6Pnm9u+Qu6MuAf8jhV3xMMR4SjQUGOpB2HvBj0=;
        b=jeBGCxRNn+pUIGhwRwVpQqdTM/IILqqr3/4As4imoqUasPXfypeW3HUH1otXbg9JYv
         52fimVWUxuIKNuYMya5fLjh0r0X0AJ5nPFSRsCiM3UYxsE8f3xv+iyJ0zhdvrxBjYSNW
         iQzYT1+lVrbyzlaWpWOwWET0fSPBpZ3ic4F9V+KlNoXmwKA94nVgdj0je7ZZiaPQ6KuQ
         WucSJpugiVN84M01w7/gTq4VyAt6SbNlFkfy3xPRGy4bRp4BPP3xRDY3V2ddEYknnngU
         HXbuBusFEpN6kMfHXwJbobmpEAAkQd4vKgZ5h2kurvofmG/jlM3dIH+mu5rlItBQtWQU
         kVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Ov2d6Pnm9u+Qu6MuAf8jhV3xMMR4SjQUGOpB2HvBj0=;
        b=FZZl9ymd8E626JGA51vNuB/Z86JiMEXAdHXV+IMK65d5sQTR/qkSI9DnRYwf4MGdhi
         eFSpxEWsQ2m9HKcN1jI+zP1ialCDP/8WxujppjelG0fWSgwfD52lg2nPl9e0iVMYGk4X
         gPsVMw+/93YDHVdlXF+oinuuqJDDY8A891GVyZ7jmkiPfOh4ufXecOID7EpNRPTg6muM
         9EehYHEUvyKNj9CzlXO+hnqw/qnD2jM/AYlqwoLFXaYt3JWqXaHl7E2yDss0hKYg3+xq
         GoXBtrXrrNuBxNO0LP3pJwyLzEEzNzIEaH/pFpxvB4vIXlse5Vrt3cqeeL+o8LYT2uEt
         9d7Q==
X-Gm-Message-State: APjAAAVdE5va8qSXgZPX/8HU7ZrSbT2SPPVrdNBvOeDhN93FX7lcocnz
        cqrsdw7ERSPzK5+pniUU3GU=
X-Google-Smtp-Source: APXvYqxREF5U+6iLM0y+RqBU1gb9iyKo78SFJJdiLHDsba6Zy60Pv8GzxsKEmTWJ0FnmUHdON9IdBA==
X-Received: by 2002:a9d:7ac8:: with SMTP id m8mr13140172otn.172.1567992376680;
        Sun, 08 Sep 2019 18:26:16 -0700 (PDT)
Received: from sreeram-MS-7B98 (cpe-173-174-83-82.austin.res.rr.com. [173.174.83.82])
        by smtp.gmail.com with ESMTPSA id d24sm4898419otf.78.2019.09.08.18.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 18:26:16 -0700 (PDT)
From:   Sreeram Veluthakkal <srrmvlt@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     nishadkamdar@gmail.com, jeremy@azazel.net,
        thomas.petazzoni@free-electrons.com,
        payal.s.kshirsagar.98@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Sreeram Veluthakkal <srrmvlt@gmail.com>
Subject: [PATCH] FBTFT: fb_agm1264k: usleep_range is preferred over udelay
Date:   Sun,  8 Sep 2019 20:26:05 -0500
Message-Id: <20190909012605.15051-1-srrmvlt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the issue:
FILE: drivers/staging/fbtft/fb_agm1264k-fl.c:88:
CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
+       udelay(20);

Signed-off-by: Sreeram Veluthakkal <srrmvlt@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index eeeeec97ad27..2dece71fd3b5 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
 	gpiod_set_value(par->gpio.reset, 0);
-	udelay(20);
+	usleep_range(20, 40);
 	gpiod_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
-- 
2.17.1

