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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE0ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E2C2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrP7wzKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbfJJJCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:02:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42046 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbfJJIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:40:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so3207387pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VOH0FG/wfv4tTtRAMaFH4XaR+zS/VbCyArBPqtL3IdA=;
        b=jrP7wzKomFVFwg1M3qS+BWJWMnb6EndUxHO0g/Ys4jaJiN8HHwR1OagZQcNJq45ykC
         oN9yLuOPcz4JGLJ+LL9XiSU3D5YKaB8zwV2OGQZ6ckUwNtPn5h8+i91R4wCjS1vEkNU3
         AlyOo/W5Id9eFaBVKI6cpovRtfW8KsELBRvJzZGOuNyyneDeZU7gXaMSsUzm17lzTAwq
         MHYVr/DKnGWnRHfEteLgoYNpOw+JcvP3HspDEfaTL0aGUEe1rj0aaJGp13moAFbSWlD0
         +hBRdZLIWMZ2LQXPK/ysZiPBceVfIh6kUEOekDyAPBjavydFhox8dOrt+urqPMimHtdU
         phuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VOH0FG/wfv4tTtRAMaFH4XaR+zS/VbCyArBPqtL3IdA=;
        b=T6ILszZnxpa0pNloxv3EKgXHci7f/ANdIf+joqxSdMIOCOg1uuGxsxoW+nO1+8YrfX
         sOO1Mcn/HYDLeo2Vckkoi1pOw9nYVTQ2vHErjzwsB12tC7Z62nwmTpJzSn5pQcbp7p6X
         JXR3Ew4oZFvXFw/J0y4iiVEsXAxC9I4sZoxRGbPW6xqYGjcFesUSC3aPsUMCLhV6ynQ+
         jLkhrUGbVEh92GUIGPFxIN91ual7oDL2nyK4Fvu4TUY7NAfvqioQNEyr9QiRsIbgGF2M
         cHBWSQblwoF4ix04VkGH9PRQyjDv5BizrK1d7Q2i50aazqZKHKfCg1NIY6/dgQSkFzbc
         /l0w==
X-Gm-Message-State: APjAAAVmSY45dbQ9btU38tXrNQr1QLPa7DfsYTNL5l5K3ZogGsvKheoN
        LUX7XoPbzIMrs/zHOusCZqo=
X-Google-Smtp-Source: APXvYqzWarJ2ujAQfqmDQjlMQl1mMnKaKFzOZ6j2Mt7ttxZUv1tC3Ny6E0t3uffmQx9lwP3WTp4xIQ==
X-Received: by 2002:a63:cd47:: with SMTP id a7mr9363852pgj.29.1570696846951;
        Thu, 10 Oct 2019 01:40:46 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id s1sm4772495pjs.31.2019.10.10.01.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 01:40:46 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2] mtd: maps: l440gx: Avoid printing address to dmesg
Date:   Thu, 10 Oct 2019 16:40:19 +0800
Message-Id: <20191010084019.5190-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid printing the address of l440gx_map.virt every time l440gx init.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/mtd/maps/l440gx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/l440gx.c b/drivers/mtd/maps/l440gx.c
index 876f12f40018..ebe37edc8e88 100644
--- a/drivers/mtd/maps/l440gx.c
+++ b/drivers/mtd/maps/l440gx.c
@@ -86,7 +86,7 @@ static int __init init_l440gx(void)
 		return -ENOMEM;
 	}
 	simple_map_init(&l440gx_map);
-	printk(KERN_NOTICE "window_addr = 0x%08lx\n", (unsigned long)l440gx_map.virt);
+	printk(KERN_DEBUG "window_addr = 0x%08lx\n", (unsigned long)l440gx_map.virt);
 
 	/* Setup the pm iobase resource
 	 * This code should move into some kind of generic bridge
-- 
2.11.0

