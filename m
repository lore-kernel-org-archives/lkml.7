Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C91C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1356C2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYQEEpUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfDPRpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:45:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45032 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:45:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so19883164ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9dBeiwUJ6YvdJiaxoXS8M1YiROnKDAH5OnAeHsqBOT4=;
        b=vYQEEpUtcRNCnZDBGIaN6oXtbOIMCUO2j8+qrEqP+XlPmuuWXjRh2R4vy25QxWSBhe
         SXnzzoKSnlIbRMBigB1tRo8QreoydCD8WfsXh0Oupn7bFjm//fgJNPei1jLgn6aHo/lZ
         czDvQCCWuh0zYXV9Y2FJrajLI/spN8TuVzOf3vaz8/L1wtNHsh5aLPTL9iMwV6wzncoU
         AHQJ0wwVD4pO1UPT+A6huNQ/glcCVkUxsl99yup8lPqpPUgACAL370nG5Ys8j+RQg+fb
         agigc8vXt06WgTrG3Cl1iKRkmcTIeC01jEnhWt+563xe1d9HhKucnGvNF3hm3bar+4l1
         Jpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9dBeiwUJ6YvdJiaxoXS8M1YiROnKDAH5OnAeHsqBOT4=;
        b=GDi/ACQSz+6leqZKz4KgD70aEkGINWl28G0JYfBLRLcSUmxQLve7epLrFDwKEO9ekw
         oIXrXm0cYuPXXEBa5yzR9yE5VKtl7/ESyucJIiWAlKvStzm0/3rMlnWN437ONIwKcIHW
         nf5j2d9h7Xkhe6F2puOLLEVw1o8kCKDfTbRYBxfiwdWkQ7XUrVGjvbnZ4IWlUU9JQ83z
         PvCLjQm1EsnohOCjARubZAM39gvSSGClYRK92Gyl6QDoB7gpYrcfggZjv1Ys05xYEwMs
         v+Vc77X1G3yEBMEjRDDjvmhK1Hfx9w8FX2VJFlo4AY8w7F69qHsBz/Fq47da2QemlvA6
         ix7A==
X-Gm-Message-State: APjAAAXFIMn5hzJlhJI9VI2XQc7rGpVdonHgMiE4ZsOGEAC9RbTWGjiz
        Q2Ii/0S/pWckbtuVaBDKaSCYR0t7qIQ=
X-Google-Smtp-Source: APXvYqzqAo0h/ApUDp6BJc5hN+zBW8908IF9+igneCxCrj8HXHesL5zxI6EXRqTe2i8lLraWOaqsbg==
X-Received: by 2002:a2e:9597:: with SMTP id w23mr38269756ljh.111.1555436748863;
        Tue, 16 Apr 2019 10:45:48 -0700 (PDT)
Received: from localhost.localdomain (62-167-31.netrun.cytanet.com.cy. [62.228.167.31])
        by smtp.gmail.com with ESMTPSA id x6sm10733982lfe.67.2019.04.16.10.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 10:45:48 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: pcmcia: This patch fix the following checkpatch warning.
Date:   Tue, 16 Apr 2019 20:45:44 +0300
Message-Id: <1555436744-15494-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch hardcoded function name with a reference to __func__ making the
code more maintainable

WARNING: Prefer using '"%s...", __func__' to using function's name, in a
string

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/pcmcia/tcic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index 1a0e3f0987..fc653e7 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -540,7 +540,7 @@ static irqreturn_t tcic_interrupt(int irq, void *dev)
     } else
 	active = 1;
 
-    pr_debug("tcic_interrupt()\n");
+    pr_debug("%s()\n", __func__);
     
     for (i = 0; i < sockets; i++) {
 	psock = socket_table[i].psock;
@@ -583,7 +583,7 @@ static irqreturn_t tcic_interrupt(int irq, void *dev)
 
 static void tcic_timer(struct timer_list *unused)
 {
-    pr_debug("tcic_timer()\n");
+    pr_debug("%s()\n", __func__);
     tcic_timer_pending = 0;
     tcic_interrupt(0, NULL);
 } /* tcic_timer */
-- 
2.7.4

