Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB54C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD1B2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJwErV9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfG0QAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:00:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45203 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbfG0QAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:00:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so25907516pfq.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jmQ3Jf4dt05shssK0l4juyl32cLtaO8jXqW7R4sHh4Q=;
        b=vJwErV9pIYPPaD/iztuYBxCZrj5px3NhLKlqkxV1QO8yLXOWS1VtA2KqObldl/4Gge
         yZ+BteFg0Lu79oAq0Q0F1P2IGbc8X4jaMhNsUOEf8e3uG0oYbIugD35HsBGHaWqJbJO8
         dI7y79mui/yY+f1sfLir/78uaOPFIlOhTRetigE9Thk0sK7d21DmD2J2+qqWE0u2k7aN
         PNnN/HngkB/HZN6OK08OvdjBJ0TO/2CtxXSHj0Lt1VTPHLP+2Z4EHsSzZTC7+txto0bI
         m5TkWMotGtDQmRvZlEH/DeqEGPDJLmSj0C46p96yd2IogGaL9OOO+e1nJWmL6dWjUH/e
         rNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jmQ3Jf4dt05shssK0l4juyl32cLtaO8jXqW7R4sHh4Q=;
        b=Z8Bo4oIuiIi9WjWA077pZjVew93Zzzirza9wwvowxShaArQJLArZ4f1Ndl05lNfGJ8
         hjpCZCyetwV3gTaW5X3L4Zq0Frask/haFPdsWOHwFAnlSt5NGH2UGmGevCAK/CHghxIm
         xURz2kXB3TtVslFyCmwEP2UBk8BuxQPiD4MUIANI8DMHzmnSHyefmKdCrYbDhi+SUUHR
         FqGwuEl3Ft+4wWZ+6f3xGIlLIyDUfMOB9SW8bM7Joi5g7hpHgTFSx61wHKGkbRFE+3jq
         2mPKCNkfiwG5US1EqJG0ar64B1/mgsblJKxEycFl+iDdyY60BWvy7bb1VpXsV4p51Sp8
         hOdQ==
X-Gm-Message-State: APjAAAUfTrsCzkTHcpNUGCSYoXh2h2FBtcRqHGxEDiRGRe+o9tp9wYIb
        QWWa6JcAPnI64hPOaPlnlBg=
X-Google-Smtp-Source: APXvYqx9d2GVWaAsKFE9/FRkAXg3FOY4cRWaYdYysWFMTfV+oSF06Er71ZUvZBx4dtvC0Z+VIhJ8RA==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr70639414pgv.315.1564243202727;
        Sat, 27 Jul 2019 09:00:02 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:d1fb:8d6c:15fe:b4a])
        by smtp.gmail.com with ESMTPSA id c98sm54964994pje.1.2019.07.27.08.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Jul 2019 09:00:02 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 1/2] devcoredump: use memory_read_from_buffer
Date:   Sun, 28 Jul 2019 00:59:05 +0900
Message-Id: <1564243146-5681-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
References: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memory_read_from_buffer() to simplify devcd_readv().

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/base/devcoredump.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f1a3353..3c960a6 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -164,16 +164,7 @@ static struct class devcd_class = {
 static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
 			   void *data, size_t datalen)
 {
-	if (offset > datalen)
-		return -EINVAL;
-
-	if (offset + count > datalen)
-		count = datalen - offset;
-
-	if (count)
-		memcpy(buffer, ((u8 *)data) + offset, count);
-
-	return count;
+	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
 }
 
 static void devcd_freev(void *data)
-- 
2.7.4

