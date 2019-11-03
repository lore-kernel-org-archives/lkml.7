Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E936CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C8F2067D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 15:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN89MVqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfKCPkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 10:40:10 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42524 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfKCPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 10:40:09 -0500
Received: by mail-yb1-f195.google.com with SMTP id 4so6727010ybq.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x4j/IlwUnW0oXPf0xwxr4LoLQSGvtIg5s+az3FiNtkk=;
        b=JN89MVqm93zYD9LofbK1mpWPJSkcvJZhCAFdIoMo1g0lKy+MWTXz7uUKlQgjMG+kB7
         HfTYu6hm2ODG1nw/wUCI3KqWVNhqflhEmlipICvTbMKM3MkX9/b5+Yt68qGHRw4DJgo9
         PBMqp5mgAl5C54D4Jyg7mvSpVW85NgMNKZngxTcfu+BwzX1MTn4jJrX8g0IUFv/cMXzZ
         LaxZ/QLE52C22WXO/2Bgm0I8OzUklElVmeN85r3HKyQGXRqN/oeshFu2hnfNRAnUYsBp
         PtR7f+9K1wtWV4xSjjmdrhfVUqOsQlDFTXnnO0u6lqF5TAoCXe0/YyiLTgPCTCs9deXy
         twcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x4j/IlwUnW0oXPf0xwxr4LoLQSGvtIg5s+az3FiNtkk=;
        b=nKOhzvVKx1Q3RnJzXAQIxDa0r100jf5fSx0r2nIrxIwvYqJvO48CIxTN8sDa5Mc2TK
         7l1tLskl1NdTeW4wBrOYQWGRG3uPvKNGS1xMpqTNkqY43ypE7nE9sQhRUdGfkn6Zz+mi
         d+PgDhP9JaQj9PYzsXTr7p7LkUpR2x20U4p7cBXOs5Ee3Qc3h6bQiDJnxo1HOf4bAY/i
         WFYsONt7as+qsKxcRNcVxgK61nBRruTq61g14TYxRr7kuAYBDHQIuJZKty6NDZj5VddI
         /DSXZ3mqiKFv6rFJRAZLXp0f1QxGd6if1vlgPfeGnWd0LJG97AlMmB5L69oYjeiQpEYC
         ShIA==
X-Gm-Message-State: APjAAAX+VWyvk2/rHeTp5dG1lnqtalE/SAoFdVuq8j6gChste1FlsBwr
        4JQZkNv7P7Uod2X3K7bij0M=
X-Google-Smtp-Source: APXvYqxbZxQYVugnGwmYAPCnUUXS9jZ+q1NxK1xEmrIBsy4Hp57ulLZLpZ6OslMRU75zEHAjWFI5Ng==
X-Received: by 2002:a25:3ce:: with SMTP id 197mr18238973ybd.255.1572795608598;
        Sun, 03 Nov 2019 07:40:08 -0800 (PST)
Received: from rkanasun-VirtualBox.ad.cirrus.com ([141.131.2.3])
        by smtp.gmail.com with ESMTPSA id l76sm12569294ywl.24.2019.11.03.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 07:40:08 -0800 (PST)
From:   Rama Kumar <ramakumar.kanasundara@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, nishadkamdar@gmail.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Rama Kumar <ramakumar.kanasundara@gmail.com>
Subject: [PATCH] FBTFT: Changed delay function.
Date:   Sun,  3 Nov 2019 09:40:03 -0600
Message-Id: <20191103154003.2739-1-ramakumar.kanasundara@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Changed udelay() to usleep_range() based on the document in the path, "Documentation/timers/timers-howto.rst". It was suggested to use usleep_range() function for sleeping duration between 10us - 20 ms. original code used udelay() for sleeping 20 us.
 
---
drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index eeeeec97ad27..471a145e3c00 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
 	gpiod_set_value(par->gpio.reset, 0);
-	udelay(20);
+	usleep_range(20,20);
 	gpiod_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
-- 
Signed-off-by: Rama Kumar <ramakumar.kanasundara@gmail.com>

Thanks,
Rama Kumar

2.17.1

