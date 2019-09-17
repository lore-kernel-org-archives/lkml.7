Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F4DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955F220665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIiPJdSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfIQXLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:11:06 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:44833 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfIQXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:11:06 -0400
Received: by mail-ua1-f74.google.com with SMTP id q60so1402341uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 16:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jlMHw/lJbiY9oSEnSweuao0JSeVWEh3JbwJsg89mwrI=;
        b=iIiPJdShJg+votTKhSxCj9XflkorFeVJZ+qv6HIz9JR671diyAgR0G2zhtr4I3sUqQ
         LldERcVxSLVY1RRqQdUglxcBeKcTrQkHGQ/df7i4KlxZA8+7KuG4SkCa/wjPkkG45ijA
         sCcJfzi+5yH/l+m7r3PJiL0UnjyEhd8caZkEL9EYpURgF5+sc3llcI0RO4CaKgvoIjDT
         X/jNJtBK9yLf0v7koQEO3TBhUdQ9jgSeVUOzkgkFvKzHyDN/NN4xzXiQvZjhOL1x5q/Y
         hdhk4Fb1lvFT5o1eWbby35wBe37vSpj3Z3ZNf/4ZAH6VAmMXV3en+UAquPQkv2oG/3wp
         1aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jlMHw/lJbiY9oSEnSweuao0JSeVWEh3JbwJsg89mwrI=;
        b=XsKMhLmwuVRR2kNrHhndgIqWs3nM8kXNyFBsuvng0k5eaN2+514lub8172dcU5FSOm
         m80OxWL3SG937OeHtkG1anK8qnn6cgrqvPLerNMJOg+//dpbBZiA7g7O51CwYnXGlrp9
         5Pj/iJDn/UohYEe5fZxV7HUJiEdXJZs3DTvyEE6rI8TkK3+iDsypXPxhsl+LW9mVpHUj
         +HdKIlAk94Y9uk1w+aarhfAfS5iqXP7Vn0IJ6wbHaZPQ82R9K83NbM6wAxLYIGyFub2O
         52JQcbg7LROA8YD4IVVAAT9Okov4rRO3YDEf4Qzklm6A5fpB9ZDvm1ZEKxH37XQGztZP
         Oqcg==
X-Gm-Message-State: APjAAAU0rwJ7d8c6Y51bBgdmaVLqCofU4lUQYN5ftxT3C6o+Z1SDeyJ6
        X/C/Gilpca7Xnzmtct+uzPMbk0TxmnNjtkpJTmbLpUgm0u8o3iCY4rPWP00rWdaBisrncOxo/Il
        DkzS9EgVO/PsM5IiAQ2zRXdkPvoSHkdrTlYHzkZkFffidVGfUNph66/YGU7XesdiXFbo3pr2qyZ
        s=
X-Google-Smtp-Source: APXvYqyxZnxMszRPn1jPzpK7n38YEEYv3W39ooLbNyjfXgLLARZtHr2YTGfUPKZqz5mdHxu+3w0TGzlkMwzX+w==
X-Received: by 2002:ab0:4203:: with SMTP id i3mr823027uai.53.1568761863903;
 Tue, 17 Sep 2019 16:11:03 -0700 (PDT)
Date:   Wed, 18 Sep 2019 00:10:31 +0100
Message-Id: <20190917231031.81341-1-maennich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH] usb-storage: SCSI glue: use pr_fmt and pr_err
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow common practice and retire printk(KERN_ERR ...) in favor of
pr_fmt and pr_err.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: usb-storage@lists.one-eyed-alien.net
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 drivers/usb/storage/scsiglue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 6737fab94959..0b6fa225b352 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -28,6 +28,8 @@
  * status of a command.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/blkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
@@ -379,8 +381,7 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
 
 	/* check for state-transition errors */
 	if (us->srb != NULL) {
-		printk(KERN_ERR "usb-storage: Error in %s: us->srb = %p\n",
-			__func__, us->srb);
+		pr_err("Error in %s: us->srb = %p\n", __func__, us->srb);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
-- 
2.23.0.237.gc6a4ce50a0-goog

