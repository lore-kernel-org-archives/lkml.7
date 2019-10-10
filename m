Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8BEC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CDB20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nopcsrkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfJJIBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:01:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32833 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733062AbfJJIBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:01:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so3162811pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yRXE4lgk6VKA0SzChNSURLfGUKIVW/iDRtWVwE8XS0I=;
        b=NopcsrkwHtz44y+FYo1Jk24rTELMBAhpD7oSUVmNudaJ+4CODqzIz+B+ZU+sH3CKMU
         aWo4quo2GWPvJ1IzP475StNoOf38jVCayq9Rzld/TiwstDbeeBKvDBgHM4F+cneoUsuq
         Jvw0AeJwOE2TjJeiojzh/sPaqtoz1zS4nNws+q8tfGwNUQFq1OFtJ5TJxGgdA+LiBA/q
         2LDL5X9h2dnvQdiIcvJY3F65jIZN8YpWoy4tS+h8SZ3FzRwkwXNpaxDNNkztjoFCAXGE
         z4UxpDNqiW5dgqf5h/YY9qqAhpVP122dI7ncioXBC9gw5rLmjoScvMNBKiY0XmvDAgnd
         7Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yRXE4lgk6VKA0SzChNSURLfGUKIVW/iDRtWVwE8XS0I=;
        b=inqPK+TH/3hptAeqYPsQSPlTsU69fqbHWBCA7Sarn4CyaZBiSSTbgHoKbdtwkQzOA8
         AfCnhaO9T5AVnAWaks4Nu4aCqmyg5Qyp1EYn0cpjQ5We/t2mGLRMpSLV/7Bi5iDLvH2E
         iYOLwHSyZgz5k/e0gTIPjjTE+B7Al//MJ7EdM0GEjj1TOm3My9D1cnEL4Njb6gndcu8j
         RMcdcgl5yxVlcC1QCZXeSz8I+PzOUIIr9QipozK7Dp2y/BEao11QFMv7+JzxLbRSNYae
         s0B3KjJn/uM3c4txXMNkPTjg1WuTzzam6NrQr1L3XAah9sM96FbFDy2mb3HcpivSk12E
         s0vw==
X-Gm-Message-State: APjAAAXuqSNeqrodc7nsbysXOy3Zg+g82B10Za0lmJbXwpPz7dv5YrGk
        L64SDYKRVnOglapaHWc0yPT7Az36
X-Google-Smtp-Source: APXvYqycvb2atxrRD8WJF8cZ15pQBiu+eEti0S/n3JRj4sNhaTbtEl33EEpHOKISfg4OovEYWoccAg==
X-Received: by 2002:a17:90a:a604:: with SMTP id c4mr9885538pjq.48.1570694512313;
        Thu, 10 Oct 2019 01:01:52 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id ep10sm10628639pjb.2.2019.10.10.01.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 01:01:51 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] mtd: maps: l440gx: Avoid print address to dmesg
Date:   Thu, 10 Oct 2019 16:01:30 +0800
Message-Id: <20191010080130.25402-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid print the address of l440gx_map.virt every time l440gx init.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/mtd/maps/l440gx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/maps/l440gx.c b/drivers/mtd/maps/l440gx.c
index 876f12f40018..e7e40bca82d1 100644
--- a/drivers/mtd/maps/l440gx.c
+++ b/drivers/mtd/maps/l440gx.c
@@ -86,7 +86,6 @@ static int __init init_l440gx(void)
 		return -ENOMEM;
 	}
 	simple_map_init(&l440gx_map);
-	printk(KERN_NOTICE "window_addr = 0x%08lx\n", (unsigned long)l440gx_map.virt);
 
 	/* Setup the pm iobase resource
 	 * This code should move into some kind of generic bridge
-- 
2.11.0

