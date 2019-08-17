Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657BDC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 05:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468592173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 05:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfHQF1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 01:27:55 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43619 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHQF1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 01:27:55 -0400
Received: by mail-yb1-f193.google.com with SMTP id o82so2654763ybg.10;
        Fri, 16 Aug 2019 22:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S1Fgry2hFdb7wuznV5MLxh7FRA3bpAQhtlorPVSGQOM=;
        b=f6IMOeET7vf844z0Cf1lIcGSM/TITrsLYo/y2zwv9qC/q9RSGwv4g8Pf3O07tWqjzX
         MYQ+XRMv75FIY6JOPQdQCb4LflTPutfwE2YB+AGy5alJD4HRl0trhGX6IoQYAwDzhTWj
         jhOeuDPmFea65cm2H/oo0J8om2X/0G/pbEvpAiuGTfhTzFAdSwmtUC8XwtxRAMklqghU
         lIlWl6T9ARZH9RU2fyw6UMUDtR83zwm8m8oQrHXzqd+uZ7hvjnd7Z3vGfbRRxOdcd7UF
         sVlPJ8WnLs5zFQcZC282t4h0pWJCBb25UBqbviC0ZN21tGwlnB380TzacS3EaaH3jRbj
         IR3A==
X-Gm-Message-State: APjAAAWVjbqAlmmQ+Kfsvk9TVh1GKykYyZc57Er+R20Yyyta14yldHmP
        miGgUAMRISuZzTXmTvyV8OE=
X-Google-Smtp-Source: APXvYqz815DslbgSCFSm1vQUGQtzUr6BrmVvtkg5xguYKne5Cd1R2Pjf4kH6j3XurFFKN3RY58fuqA==
X-Received: by 2002:a25:e050:: with SMTP id x77mr9864861ybg.408.1566019674521;
        Fri, 16 Aug 2019 22:27:54 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id m124sm1721930ywb.13.2019.08.16.22.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Aug 2019 22:27:53 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: cpia2_usb: fix memory leaks
Date:   Sat, 17 Aug 2019 00:27:46 -0500
Message-Id: <1566019668-4152-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In submit_urbs(), 'cam->sbuf[i].data' is allocated through kmalloc_array().
However, it is not deallocated if the following allocation for urbs fails.
To fix this issue, free 'cam->sbuf[i].data' if usb_alloc_urb() fails.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/media/usb/cpia2/cpia2_usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/cpia2/cpia2_usb.c b/drivers/media/usb/cpia2/cpia2_usb.c
index 17468f7..3ab80a7 100644
--- a/drivers/media/usb/cpia2/cpia2_usb.c
+++ b/drivers/media/usb/cpia2/cpia2_usb.c
@@ -676,6 +676,10 @@ static int submit_urbs(struct camera_data *cam)
 		if (!urb) {
 			for (j = 0; j < i; j++)
 				usb_free_urb(cam->sbuf[j].urb);
+			for (j = 0; j < NUM_SBUF; j++) {
+				kfree(cam->sbuf[j].data);
+				cam->sbuf[j].data = NULL;
+			}
 			return -ENOMEM;
 		}
 
-- 
2.7.4

