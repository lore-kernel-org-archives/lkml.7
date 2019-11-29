Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80632086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575022812;
	bh=Us2LR83sqTpDDxH+Vob/8vFqXsuJSQfz1IXYJRDcCJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AFORp+Xv+wBQyP4Z37D39/DOGHvEZa8W68fmIrB+wQawpYMnV/RsrPl2mYRnMdfZ0
	 SD8d/9pgHlqyif70/vEwY6OYUyCk11KER3l2Cf3QJt/YNDdceuZHNhO8tAIkImJBMZ
	 bky4llqzL35xfn2D1co5snWa0xo+2iSrwizMXNs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfK2KUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:20:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37017 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfK2KT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:19:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so22223212lfp.4;
        Fri, 29 Nov 2019 02:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl1LB5EX7oIVC0mGuDqRbEVhDWig1nq2VNrs1gvJuaw=;
        b=Vp4HYuwYQHp46lVvTS5GCZ1qqSWfIhgJbhDrfZjhW/6jArG4t4+kPTd7E952raO/Xc
         1GZdzL3P9ppH5db5zxNVhzK7sNxXA70vmsQ3YXNn9DydV0th4KziQvKrSfGFlp0Mr3p6
         RVEhhj6WYEmb6qyKbSszRtxQfmDz4+QTH97LRV3CS3+wwPhgUFDgWyVBbsANA3MpCmKs
         qvTDFKhBNt2DhkpteOoJ25xGsiS+3pFDbw0rKFbzTaXNlxMqzuLu5qPyflnxRx5e0Tdl
         v7YUHU1b8QFLTTAr30mj6xgsSX13plmP+STfzta2Bad4FVrhYDR0M1iC9IjsbyEkfqsL
         l5SQ==
X-Gm-Message-State: APjAAAUsw0HayCMNaDA4iqxwz4uT4D9lE26XXhznQrPKdlEqLmEt+/2L
        gshWVuRf5LZaJaaTm7tAIFlZCuh3
X-Google-Smtp-Source: APXvYqwxcevyF+Crh369dU5ipDZwFgUk1/YR1kPM4h38HLel3dEEONpTEAS1i786gMXyLtZ3H5rqHA==
X-Received: by 2002:ac2:5626:: with SMTP id b6mr5692138lff.74.1575022795839;
        Fri, 29 Nov 2019 02:19:55 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id o9sm3416079ljg.56.2019.11.29.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 02:19:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iadNU-0002Yg-Cw; Fri, 29 Nov 2019 11:19:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>, Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 2/4] staging: gigaset: fix illegal free on probe errors
Date:   Fri, 29 Nov 2019 11:17:51 +0100
Message-Id: <20191129101753.9721-3-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191129101753.9721-1-johan@kernel.org>
References: <20191129101753.9721-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver failed to initialise its receive-buffer pointer, something
which could lead to an illegal free on late probe errors.

Fix this by making sure to clear all driver data at allocation.

Fixes: 2032e2c2309d ("usb_gigaset: code cleanup")
Cc: stable <stable@vger.kernel.org>     # 2.6.33
Cc: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/isdn/gigaset/usb-gigaset.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/isdn/gigaset/usb-gigaset.c b/drivers/staging/isdn/gigaset/usb-gigaset.c
index 5e393e7dde45..a84722d83bc6 100644
--- a/drivers/staging/isdn/gigaset/usb-gigaset.c
+++ b/drivers/staging/isdn/gigaset/usb-gigaset.c
@@ -571,8 +571,7 @@ static int gigaset_initcshw(struct cardstate *cs)
 {
 	struct usb_cardstate *ucs;
 
-	cs->hw.usb = ucs =
-		kmalloc(sizeof(struct usb_cardstate), GFP_KERNEL);
+	cs->hw.usb = ucs = kzalloc(sizeof(struct usb_cardstate), GFP_KERNEL);
 	if (!ucs) {
 		pr_err("out of memory\n");
 		return -ENOMEM;
@@ -584,9 +583,6 @@ static int gigaset_initcshw(struct cardstate *cs)
 	ucs->bchars[3] = 0;
 	ucs->bchars[4] = 0x11;
 	ucs->bchars[5] = 0x13;
-	ucs->bulk_out_buffer = NULL;
-	ucs->bulk_out_urb = NULL;
-	ucs->read_urb = NULL;
 	tasklet_init(&cs->write_tasklet,
 		     gigaset_modem_fill, (unsigned long) cs);
 
-- 
2.24.0

