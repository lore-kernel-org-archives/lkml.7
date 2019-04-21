Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD85BC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3292087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhAtqPQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfDULrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 07:47:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36150 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDULrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 07:47:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck15so4559089plb.3;
        Sun, 21 Apr 2019 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qbJIqdLlDA1nPtGsQRWXyualiN4HC+K0PDqOSxn7kiA=;
        b=JhAtqPQRYi71oTGmKaW5vqd/hPpUyR6ddF9TI0K19aApqlO5lvOoajKFFXMAdSEWPG
         +iUjzTb57eM4Q2cK+PceWOhD8viITvwsxugBX6ukYbAScSIga1u6CVBTgpQxw5Z/WKDZ
         8lEFcXzbVjnYOrwDZ8Q3naclisGSxwQrsnWLj8BQCwK00UsCCmDSuTTTX8drfbETVHFi
         4dgG0udF/17M5WX9ajs17q41NY9OfdOJPewDLqhhIkE9IS5z/zlwNAOFb4pk98AkzcUW
         J5W88oXg/bFh/syHdQHof6pxxYsD8qj/1ht2F0Mq++MhrX3V0AB91VkabZN2jHOYdvhq
         gc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qbJIqdLlDA1nPtGsQRWXyualiN4HC+K0PDqOSxn7kiA=;
        b=dXSK0cIAGatsim0Z9s0J4l7NNAYzMUBrnDk6wc9ffFavbzjnkOaSCg0PJ6L0Qxf6mM
         I06YC0+CItTBKlQ11tYbgKIiLrpwFqmNYupXJqYuYJxQIUuv8+4KwnCdkjzqyKwWvOqU
         S3XBv+W5gf6njjFhs8qVVR6Uhv2NQkU83biLeh1XCMzQCexhIh688aPZNjIcATnxcbKD
         S/YitLBdpjw6A04ZYvczaTgBHW8db+oCHH79JTRU8YezkGeE7fbYcPpE7egVNdcoRO9n
         SnQ5tI/Okt/fUX1vao6fEmerXTXl1++cCeuR5xPVt4MX+jhI4g7V2uqost5sLaYdZ5ia
         7UCQ==
X-Gm-Message-State: APjAAAVYS401OYIKHxrrxsG3JkxBbhmMhFYoqGC+UDjq3/h43jrmqUzq
        6e9rv2rBkzQtT0Z1bgy/uUg=
X-Google-Smtp-Source: APXvYqxkjvuweaQLz+SP5CCN2IKBZBNOf3eDC4rip86JwQdSy5CfbouUBvXOkJb+XvEzvh3JYAF5ug==
X-Received: by 2002:a17:902:2ba6:: with SMTP id l35mr9953943plb.56.1555847238591;
        Sun, 21 Apr 2019 04:47:18 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id g2sm16006272pfd.134.2019.04.21.04.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 04:47:17 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/06] atm: iphase: fix misuse of %x
Date:   Sun, 21 Apr 2019 19:46:54 +0800
Message-Id: <20190421114654.20265-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to long type and printed with %x.
Change %x to %p to print the pointers.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/atm/iphase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 82532c2..5278c57 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2826,8 +2826,8 @@ static int ia_ioctl(struct atm_dev *dev, unsigned int cmd, void __user *arg)
          case 0x6:
          {  
              ia_cmds.status = 0; 
-             printk("skb = 0x%lx\n", (long)skb_peek(&iadev->tx_backlog));
-             printk("rtn_q: 0x%lx\n",(long)ia_deque_rtn_q(&iadev->tx_return_q));
+             printk("skb = 0x%p\n", skb_peek(&iadev->tx_backlog));
+             printk("rtn_q: 0x%p\n",ia_deque_rtn_q(&iadev->tx_return_q));
          }
              break;
          case 0x8:
-- 
2.11.0

