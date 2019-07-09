Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D62C73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EF120665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duj5SZfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfGJEAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:00:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46577 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfGJEAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 00:00:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so946279qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 21:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVijEPpZkHSMCYZyf6qY35aBcvTy8wAdN6VIFPPyhnE=;
        b=duj5SZfXX2LbjWs+NHlLrYz8EWUV1bLTt+b2ja1JbDclSXPZ91vbCP3OFJr2xzopeO
         VHk5gOE9EMsqUnZrd8+Un/0tmFGNXhH4OBAtlhO5lS7n2gWnGYzrbm6J5h2EHBFBpTsF
         R+64rokrSEcxjZbibVxeKl/l7ydC9hl4Ok3MDkUbO7tU4NadF+2tC09Eck7YWsidl4Sv
         lLdOidpmJl31Hr5nhk5ncSaOEXoV28596JN4KsjaZWGLbgboHEuAGHhmei6HKxM6PTZg
         xYBDRWUO1Bqdb28qH9qRo4Bdds+iqJmeFTwHM3T6bCrcak20oxnr3GCD7efEeT8V67Ww
         gUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVijEPpZkHSMCYZyf6qY35aBcvTy8wAdN6VIFPPyhnE=;
        b=C2n0hWDm82aUgU9M3H3A7E0onzIm2QOausLPAPdlzC4LEuSbBJbuPTbprc5BUi8KgP
         qLVX6EHBfGPtvDotwY0JSTxqzhOEi61SUsgKk5aC1IksVg5vmhEWBSEZwkeaQnqI8poV
         vx1PuSG4y7b4E/G8EKUS6vjiAMcZTJtA+/tgbgsYAuPg4SsHynSz/DO+H4aR2MxPC/DR
         WDOPm3ocwKoKOzR/dPlTV5Wk9Jtc3glXihZZQkiuMDcdFgYiKk9H93g0dY68EaLD4qIX
         jUYe+bwJGWvci7EOnQ5g8aAmx0GwqGz/nY3I1IokiQjHjuJ9l2wvpKtVpRgt2g2lsX2w
         GQ7g==
X-Gm-Message-State: APjAAAWtBkJA5mrARFXcej99c5KKKgdh/ZqwO4Jgs0VKqNVR2rcKbTER
        uYi6fBjXDpJTkrLJ41+zpw==
X-Google-Smtp-Source: APXvYqw+Jk3f5TgssbnTBSWfsuzbx1fFah2szeE3SL0x7E8E7G7nnjgZq0CN5iGOwN1wDJLkpFJVPw==
X-Received: by 2002:ac8:244f:: with SMTP id d15mr21112167qtd.32.1562731202768;
        Tue, 09 Jul 2019 21:00:02 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id f5sm369088qth.35.2019.07.09.21.00.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 21:00:02 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] gnss: core: added logging statement when kfifo_alloc fails
Date:   Tue,  9 Jul 2019 19:59:56 -0400
Message-Id: <20190709235957.2481-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <61c2ba4e229a6971e90627433bedae2dd28ea6a1.camel@perches.com>
References: <61c2ba4e229a6971e90627433bedae2dd28ea6a1.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing logging statement when kfifo_alloc fails, to improve
debugging.

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
Changes in v2:
- fixed braces
---
 drivers/gnss/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index e6f94501cb28..1b7387ee643b 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -255,8 +255,10 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
 	init_waitqueue_head(&gdev->read_queue);
 
 	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
-	if (ret)
+	if (ret) {
+		pr_err("kfifo_alloc failed\n");
 		goto err_put_device;
+	}
 
 	gdev->write_buf = kzalloc(GNSS_WRITE_BUF_SIZE, GFP_KERNEL);
 	if (!gdev->write_buf)
-- 
2.22.0

