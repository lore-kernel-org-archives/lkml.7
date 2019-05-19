Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD05C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91908204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHaRhKQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfESRaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:30:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35018 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESRaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:30:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so230080plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jB4evmSjIyyzoY4IpPjL+YtUlTvS8iRZCCRZv1vzwBA=;
        b=NHaRhKQKbAyHAoQJTKs5LTP9FCcTMNMRbS9r7lMAp79aP3YgJKHu1S/JavCWiBabRN
         drpE5t9qk86jlpnTfBn4v04jFDBbrKY3Wr2KrpEfto0PQc/bPx8CF8ByGZGO6EgIm/6F
         qIdbFiw8BQps8IRo2ybliCf0xchvhoJ9M+n8XzK/4bfhGg2m2I5EcBt6z4aS9gjq8Qoo
         HtGGGX/wfUpKazlvC1B7dMgpXSijW/rpcz50E4I1XcVme81KysRlCGbl9OwEGGxjIpKR
         ramWJa6T0jQlRKuhsGhmGojfHc2Hgbu1ql3GdSVxEs7HZkp3MJ7TubBJfQIkzfz1C+wV
         a45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jB4evmSjIyyzoY4IpPjL+YtUlTvS8iRZCCRZv1vzwBA=;
        b=A7o+NznxfSiS2JkuQe4NCjnbP58nN0TmZOuqvpJAaFxYrCOTgDYul2At4Gp+3uiwc1
         7EkjVBH7W80zDUPp5Xrf7noo1WRx9dQtl0Ybyyw3ebx5VokJ94zKExCbu6g+3rTYXkDu
         uf0JZEZt7CYPAuueG4SYTLb8HRG/VrsBO0NsIT55zSlXQoflsUgi7QrWsO0Gb7gIKfYm
         qEXPya06QAtESLMK/NdCOsgv6p+4jYKa97M5ytPG7Fz1PLFJrqRmhxI4TuXVVZEi419d
         A7F9wQaAZOkvW0xCcJ2UUARikrUWKd8h39V+a+LsZAwCXaWrD2ew5l4gT+AiRmsLi1yI
         7g+w==
X-Gm-Message-State: APjAAAW90ZXaZoFXE7iwanP70598MThLCnZkF99c9+K5dJG9uxeZkqRv
        nET9jLsZXNr1kp+k0WUIH4D47adb
X-Google-Smtp-Source: APXvYqyUDgN/KpPP9tG8iY+ZZCSCSYwDzbyPs4GZorShASILLZSZbMIxUE38gbPfuf6hcVv39j2S5g==
X-Received: by 2002:a17:902:bc8a:: with SMTP id bb10mr13365675plb.310.1558278437888;
        Sun, 19 May 2019 08:07:17 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:5085:bb4a:e3a8:fc9d])
        by smtp.gmail.com with ESMTPSA id g17sm2441105pfb.56.2019.05.19.08.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 08:07:17 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v4 1/7] devcoredump: use memory_read_from_buffer
Date:   Mon, 20 May 2019 00:06:52 +0900
Message-Id: <1558278418-5702-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
References: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
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
* v4
- Add Reviewed-by tag

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

