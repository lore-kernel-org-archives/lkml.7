Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE2AC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A4420828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flameeyes-com.20150623.gappssmtp.com header.i=@flameeyes-com.20150623.gappssmtp.com header.b="K61PK3Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbfHZPRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:17:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46413 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbfHZPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:16:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so15701311wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AqmKploJwNEA01q6HdblwWXOczYQSlAf7l7rD8CnGgs=;
        b=K61PK3ZuuK3rb3OIZAmP9wCbHJ4A9LrRIPVSrifW9lR2b+SiwRWBUoXYugkskq71l5
         wDSATfSbzqeh/CsXUOyXNPS/5LaJL7iQfuGS6VKdqI1+zTyZnBcFk+gKOky5yHXf2fOU
         /2okuYxWX96p7GEMwLBZHbrtIyO3/XWpOq6UNFqlsBE1WsXxD6D3YH96+9PVEegfi+Hz
         P4gXuGPJYcQngTrqMiK+Ogwlj9HJo5Hx4IfxdDdPYbLVy0nXEMVuPX6arO2pDifxfDXC
         kxil6IyTCeBAKTBfTGsk9Z6g1sN6J+DDkXjWYc8qdhw9S03UIzvIcEAkX24RV6QsgYTg
         gY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AqmKploJwNEA01q6HdblwWXOczYQSlAf7l7rD8CnGgs=;
        b=RW8YDjqX126ZmY77iYeb6P0Vqsprd3gbAwgrH9wljO0PO+ikKPQarN14/r6vSaSKRR
         n8QkdugnhqAVfHajiMzRoNiahgdDzqp8iuFnynSSJuOtWqbRlKk7u7LCgplES7FoJ3Rg
         hl+d0HgW2yXmwY9KbT50gNOKVY45E19fbDDWFS61pJdVP2H8eLTrhF/h3gSGeChZB55R
         fzfGqBkiBJDKCmRmth75V97AqgnjmFib9zYQe2oTkxQljGC1g6lmAkRbL3TvqHj5EAnE
         sRNvINxqgjt1A66AY3qjCqUHDzVueTfv0+kJiVVeOFF/BXXNFJvzoqfqSOIEAeE7HYRs
         bg9w==
X-Gm-Message-State: APjAAAWkD5YATsKj+1MUQxgdAbzbYKyAF+KXpTP7WG4Gr5NWsWbr8ILq
        jVpJ6wMtEDe9lNckKDKPFx3qKOdHpqQbxA==
X-Google-Smtp-Source: APXvYqxtTp/CXAzrCTQq5SIJ/vEK0POKnjvbnL1xOrPOcMMlRhKPSbdXqLlMafmkl6WzKattDuXelA==
X-Received: by 2002:a5d:5183:: with SMTP id k3mr23740324wrv.270.1566832611441;
        Mon, 26 Aug 2019 08:16:51 -0700 (PDT)
Received: from localhost ([2a01:4b00:80c6:1000:5b16:35e9:1ce5:7fc9])
        by smtp.gmail.com with ESMTPSA id e11sm33608151wrc.4.2019.08.26.08.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:16:50 -0700 (PDT)
From:   =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
Subject: [PATCH 3/4] cdrom: remove REVISION/VERSION constants that are awfully out of date.
Date:   Mon, 26 Aug 2019 16:16:39 +0100
Message-Id: <20190826151640.5036-4-flameeyes@flameeyes.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826151640.5036-1-flameeyes@flameeyes.com>
References: <20190826151640.5036-1-flameeyes@flameeyes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver changed significantly since 2003, there's no point in it pretending to still be that.

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
---
 drivers/cdrom/cdrom.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index ec1267d0a5c0..732aa7115ebd 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -244,9 +244,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#define REVISION "Revision: 3.20"
-#define VERSION "Id: cdrom.c 3.20 2003/12/17"
-
 #include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -559,7 +556,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
 	if (!banner_printed) {
-		pr_info("Uniform CD-ROM driver " REVISION "\n");
+		pr_info("Uniform CD-ROM driver\n");
 		banner_printed = 1;
 		cdrom_sysctl_register();
 	}
@@ -3374,7 +3371,7 @@ static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
 
 	mutex_lock(&cdrom_mutex);
 
-	pos = sprintf(info, "CD-ROM information, " VERSION "\n");
+	pos = sprintf(info, "CD-ROM information\n");
 	
 	if (cdrom_print_info("\ndrive name:\t", 0, info, &pos, CTL_NAME))
 		goto done;
-- 
2.22.0

