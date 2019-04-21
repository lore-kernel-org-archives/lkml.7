Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D89C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457082087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99oDpIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfDULr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 07:47:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33819 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDULr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 07:47:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so4457668pfd.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=whtq2ZN7fCyP3XM0xkWgV0oR9AWeLM9uhe5XWglxZds=;
        b=l99oDpIN+j3bfZei78ZpK8kLM38FV/yJIG4udNe9PZR4In+ELT0c4L13MkDzn+1I++
         a96Th+XpFMPHSq5iRFWMSHVJBaqfExpWukt91dMBIB4OhbRI1N41ssXDiZlLaDEqlwoH
         OCz4Dt6il51G20ejNYjdrUUey8u2UOjUAWbxQLncFV6LaGbI5tCD6ki+5dfhW4gn34FB
         wbGO/9itAedYlQjlNzQcntgkDSh6OA0JrJd9/K/C4OZy7UYWl+kIEvU8epaG//mLby19
         piXgsJ4foQSrXPo+MS7EjND6SRQ4/YAchnNPfbKt/VL1NqT7PutM4I4Gla24SLQGy9an
         1pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=whtq2ZN7fCyP3XM0xkWgV0oR9AWeLM9uhe5XWglxZds=;
        b=jDI0ryDFIYwbyRJPbSXWQ3PppSFZ1S7R78vxnt6WqQF+tdHHeC00ICMlcWxHtKhoKf
         RsE4J6KefqTwqhe85zXDX8R85C9kRSL2rJEX1q862No7tKBrahuVplWLhSRPi26dwCoC
         P966t4ynq6TblHzlZQ+sDqoQ6X0H37eoaeb0T2067Ih4F8iWqgv5VrW8AsdnBqawIGx2
         tZsa8tZZMpSkbvmyrILXWq5i1q8K/v5J4pGWZnn+dz3sML4Zu3V/NF57Id0jQauzEhl4
         tigaMamn6kM2TuYUdkwFLynrEX+UKS4u8eXK6VefvEmWPgXUdaJ/DP/hFvcPdCvmv7s3
         qVNQ==
X-Gm-Message-State: APjAAAVG1gTCQRgcphkqe+dkXHBQmk5Z6otxZIE6VmNmgoIWIAzOpx0d
        a+pMPhahY6pQixzKb0T5FFE=
X-Google-Smtp-Source: APXvYqwFDusseZzmDcmJx0jMcjkP9rM5gBocudOovR6cxkQIyTUvxfCkEqTU8o3RqUvBkMBM09lPRw==
X-Received: by 2002:a63:84c7:: with SMTP id k190mr13623510pgd.255.1555847278864;
        Sun, 21 Apr 2019 04:47:58 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id d15sm13230275pfo.34.2019.04.21.04.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 04:47:58 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/06] misc: genwqe: Fix misuse of %x
Date:   Sun, 21 Apr 2019 19:47:48 +0800
Message-Id: <20190421114749.20385-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer should be printed with %p or %px rather than
cast to long long type and printed with %016llx.
Change %x to %p to print the pointer.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/misc/genwqe/card_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/genwqe/card_debugfs.c b/drivers/misc/genwqe/card_debugfs.c
index 7c713e0..6f7e39f 100644
--- a/drivers/misc/genwqe/card_debugfs.c
+++ b/drivers/misc/genwqe/card_debugfs.c
@@ -227,7 +227,7 @@ static int ddcb_info_show(struct seq_file *s, void *unused)
 	seq_puts(s, "DDCB QUEUE:\n");
 	seq_printf(s, "  ddcb_max:            %d\n"
 		   "  ddcb_daddr:          %016llx - %016llx\n"
-		   "  ddcb_vaddr:          %016llx\n"
+		   "  ddcb_vaddr:          %p\n"
 		   "  ddcbs_in_flight:     %u\n"
 		   "  ddcbs_max_in_flight: %u\n"
 		   "  ddcbs_completed:     %u\n"
@@ -237,7 +237,7 @@ static int ddcb_info_show(struct seq_file *s, void *unused)
 		   queue->ddcb_max, (long long)queue->ddcb_daddr,
 		   (long long)queue->ddcb_daddr +
 		   (queue->ddcb_max * DDCB_LENGTH),
-		   (long long)queue->ddcb_vaddr, queue->ddcbs_in_flight,
+		   queue->ddcb_vaddr, queue->ddcbs_in_flight,
 		   queue->ddcbs_max_in_flight, queue->ddcbs_completed,
 		   queue->return_on_busy, queue->wait_on_busy,
 		   cd->irqs_processed);
-- 
2.11.0

