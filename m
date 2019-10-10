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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6A4C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4245A208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC/XV+18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfJJN6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:58:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37314 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJJN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:58:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so3972740pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lYhH0LhqbaaCqPvzQECTErqO/n6x+8fxYPTtkfuF5nc=;
        b=BC/XV+18pfXBfiKPMugpZLBYfkXW6VdNQ5qg6f4xeK3k3Pkoi6UYM7UNl5zmS1Zhaf
         9UdOf/5lKg5VzuBn+2C3LSlgQiQz7OIxyV0xpvFiIDNZCDve9eNp5m91zCK0krGIFSw1
         x33b/ClbyCOK8kbQ0f4suVrNLIwD0T9IdjGGqLxiJ1+ISE1fLw2tfr3Tnd6zn6k1ylXN
         5GH8YcMcIT0s/XPJpR+ARfDynztK5wVJSm4e/WR57vmm4NgpQ0hAE8CeuI0BcQ9fO9M8
         mZ0ofIOB4+hpppkniBAzkVPzj5Bl4hPntSu6i9OjT6e/GOomRBctmf0GzzgpxQG1Hzsc
         BRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lYhH0LhqbaaCqPvzQECTErqO/n6x+8fxYPTtkfuF5nc=;
        b=CB+lMreLFZaTBUqhgyseediHnyuZjZ7SUV0dpXmGW6ROIRoyASpha8bibddq3vhdz8
         ggYSjT96feA/0RHDh0FYpNHyxpm8umKH0ouMLmlGUwSJgL+bEBozwj7Rp+WdtWYFotpn
         UncUBKSBbpjgOl6qbTlU71nzvdCH/04EyKaoM/1ovWgoqCARafkp+Nek4nxe3riU5iDk
         rg50U1CcGC07HcF+LsSLqCTnVtpWR/vwTPLA+fmtmPIW8Njhq6KjKZkVNnENb0SoJjUh
         1H+eK91S6nOskOaMD3vCq0szJ0UlExtgvaCPicrk+oj95RqyXpj/ihAksKNjTXvwKPcs
         k/Cw==
X-Gm-Message-State: APjAAAV2WqMBDpo7cueWfl9vYaBdnIKZuVY89EeT2+5/tXLC7GL8Xiso
        uOAsR0nJcA469beQhZ96/q8=
X-Google-Smtp-Source: APXvYqyR8QeCaeGE//rK0N9nzobokZvJPylfXCJvsurrYX8lFWpSqUDVdPzmgNZe+IVX99thk2ifOw==
X-Received: by 2002:a17:90a:2ec5:: with SMTP id h5mr11689675pjs.87.1570715909114;
        Thu, 10 Oct 2019 06:58:29 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id b14sm6040303pfi.95.2019.10.10.06.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 06:58:28 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3] mtd: maps: l440gx: Avoid printing address to dmesg
Date:   Thu, 10 Oct 2019 21:58:09 +0800
Message-Id: <20191010135809.11932-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid printing the address of l440gx_map.virt every time l440gx init.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  -- use pr_debug instead of printk(KERN_DEBUG)

 drivers/mtd/maps/l440gx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/l440gx.c b/drivers/mtd/maps/l440gx.c
index 876f12f40018..0eeadfeb620d 100644
--- a/drivers/mtd/maps/l440gx.c
+++ b/drivers/mtd/maps/l440gx.c
@@ -86,7 +86,7 @@ static int __init init_l440gx(void)
 		return -ENOMEM;
 	}
 	simple_map_init(&l440gx_map);
-	printk(KERN_NOTICE "window_addr = 0x%08lx\n", (unsigned long)l440gx_map.virt);
+	pr_debug("window_addr = %p\n", l440gx_map.virt);
 
 	/* Setup the pm iobase resource
 	 * This code should move into some kind of generic bridge
-- 
2.11.0

