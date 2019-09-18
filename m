Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5431EC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FCA21924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOpifsaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbfIRQ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:29:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41828 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIRQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:29:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so187046plr.8;
        Wed, 18 Sep 2019 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LgH/ZwMWdwKceO+DTTPhpRDYUttfSih6SgTkxTt1Xfk=;
        b=VOpifsafjSIcwqi0QMLWPEJ6f4zF3EZWMzfCkWRWqN4bgvtxKEnjdz7z31KEPm7fms
         4QASqUhFy5awtmgAEcmFP0kk81ZMQpuZrzUrqvC4lBMA1HSKAOD0Mo2QIWfzwZzHLuhg
         Tv3WWTwwdz893rldnbVbhN7EBlfRwrsVxPeqo6o29WjIoWLP75r05ZVWjx0HV6N92BF/
         vlHEC86LAjm5LYvREUWZOvSEcqjcZL9CnpFHUyOG4LILzgVs7+EvviL+Qgfh+f9uwPiW
         K7LJsE8GCckE7juYnEuT8/CLz/dMElygVRz9/InPR4VtWLGsnL5mP4Czl7HmO0DirP18
         gihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LgH/ZwMWdwKceO+DTTPhpRDYUttfSih6SgTkxTt1Xfk=;
        b=CvaHq4yr+NyXk6dhrhDsNzJLgazZChGx6Vhf5s6/Bx8Y8ZXp4mftmsCgxf5N3S38Cn
         8lVcHJFFb0MDm5CmEY5YyaD01JVOmRdgKyRgZhA5Qp2IRVUiUJTiYVwzMxMKBlBLcCPQ
         CW4P2PSvyMG3mnDTDDMLHruWqnUeC/jOacwGy5lIp5SK2QR6XgVJyc6R5w6VQvG/JR1S
         LwGrTMuL8/HAP6n/ck74K2FXqCc9UiFgLcQ5UDK7t2la+32U6HoU4Z227dClJDc4X+Fn
         weSRXrrWYYGBylqflQyuX56wHcgThJyhEl+7zH513OT2kEVKRCujOxksdv5PH7cIo6vB
         4M6Q==
X-Gm-Message-State: APjAAAVsfr2XRrduo22G1pi4q/X++mFWDe7A1yM5RPxsCCaVJZPtFzAO
        weSlOycAbbNm5xUTLwey3GM=
X-Google-Smtp-Source: APXvYqx1UIM3/8Nji+DD2WgS6NY8R9IirFIx14s8+laAK8nwbFGsr/WLx/R6LHpe2fpnBILoCLPvtA==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr2973155plo.265.1568824171177;
        Wed, 18 Sep 2019 09:29:31 -0700 (PDT)
Received: from localhost.localdomain ([106.51.104.129])
        by smtp.gmail.com with ESMTPSA id s73sm2744560pjb.15.2019.09.18.09.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 09:29:30 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v2] HID: hidraw: replace printk() with corresponding pr_xx() variant
Date:   Wed, 18 Sep 2019 21:59:11 +0530
Message-Id: <1568824151-12668-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190912203119.GC636@penguin>
References: <20190912203119.GC636@penguin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit replaces direct invocations of printk with
their appropriate pr_info/warn() variant.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v2:
- Removed manually adding prefix "hidraw:".

 drivers/hid/hidraw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 006bd6f..2d082f3 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -197,14 +197,14 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	}
 
 	if (count > HID_MAX_BUFFER_SIZE) {
-		printk(KERN_WARNING "hidraw: pid %d passed too large report\n",
+		pr_warn("pid %d passed too large report\n",
 				task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (count < 2) {
-		printk(KERN_WARNING "hidraw: pid %d passed too short report\n",
+		pr_warn("pid %d passed too short report\n",
 				task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
@@ -597,7 +597,7 @@ int __init hidraw_init(void)
 	if (result < 0)
 		goto error_class;
 
-	printk(KERN_INFO "hidraw: raw HID events driver (C) Jiri Kosina\n");
+	pr_info("raw HID events driver (C) Jiri Kosina\n");
 out:
 	return result;
 
-- 
2.7.4

