Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7320FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B0D20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klDhtl4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfEQRuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:50:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45322 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbfEQRuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:50:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so7972274wrq.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GnGykp5Yn5rW4hdUevVwgljZDVqoV+UL5T4XcxLWCIc=;
        b=klDhtl4CJf1psnh/c2+l/6BzjS93ozGSoz7AP3U++ORtk1Z2vad4jZWJtqwD4+qNZ/
         MsayuMNy/3ZLDla/F23G2/N5ti2xW6ULKKuSueztxLYoAbk9HXqE1Y3r4bEMVRCGOC58
         OJsAjy1c0OHSuhPqRTG//+ufjeTHTfzkU+TZ4LCkDGDgCm7mGmd8ZlLHJWxZGSnXoRAU
         z9ickbU7VUOFt+U7MkEjNg+lIVs0TwYkSxNdnPMSSYBJYhWebevWheSgUoLHSWvweiVg
         UcWCQ04r1zOLopAx5sCG0H2X8IJs2M7ND4Sbr4sKxF2aqDvVmSIDcxwUgxvr273p0HRc
         IY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GnGykp5Yn5rW4hdUevVwgljZDVqoV+UL5T4XcxLWCIc=;
        b=a9TXp3C8me5jj7yjY5VUaZfjXGgQeyVpf8WO6wB9gUKAdAdjApPSo4+spH2eoC+ZpZ
         Y6tJJMIESpu6VQfkra/rkXbosUcdqEfwRZL7mkgyw0upYgW2ayYKpQetsDck3QerZ6uG
         FXWygNltyGUnDxExsjipM5Vo3t+Y7Cx6Zow1RIgFuF/OM+3XGFH404jpaOU3nOyXe0p0
         QbdyXJvrON1UeWRmbIVb4tAGEyLMo+oGfHpoZ/0F9jQWFWDWbHgsZ+Rgvx3Vv8x4n74H
         bfoC+xOMZGCRYYPHH3OsVVULo7pdDDVABWekkJ7R4QxKwLLCDZlNyPIbrLo7bwthe9Tf
         xYLg==
X-Gm-Message-State: APjAAAVIlwaRNzUSnLnH2+rB3thAWlSikjRqWrdpjiNjjiTRXECfvE35
        TC6vvmUVGMw1azsrVywUFy8=
X-Google-Smtp-Source: APXvYqyQVKmFd6NMtANlYq+ucinAnbLCuWhETsvswPd+OxYzYWt3A6qN9YAQNbcjFpbgwXyp07+QuA==
X-Received: by 2002:adf:e288:: with SMTP id v8mr6634699wri.7.1558115415197;
        Fri, 17 May 2019 10:50:15 -0700 (PDT)
Received: from luna.home (2.154.17.217.dyn.user.ono.com. [2.154.17.217])
        by smtp.gmail.com with ESMTPSA id b2sm9286379wrt.20.2019.05.17.10.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 May 2019 10:50:14 -0700 (PDT)
From:   Oscar Gomez Fuente <oscargomezf@gmail.com>
To:     oscargomezf@gmail.com
Cc:     gregkh@linuxfoundation.org, thesven73@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fieldbus: solve warning incorrect type dev_core.c
Date:   Fri, 17 May 2019 19:49:56 +0200
Message-Id: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes solve a warning realated to an incorrect type inilizer in the function
fieldbus_poll.

Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
---
 drivers/staging/fieldbus/dev_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 60b851406..f6f5b92 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -211,16 +211,16 @@ static ssize_t fieldbus_write(struct file *filp, const char __user *buf,
 	return fbdev->write_area(fbdev, buf, size, offset);
 }
 
-static unsigned int fieldbus_poll(struct file *filp, poll_table *wait)
+static __poll_t fieldbus_poll(struct file *filp, poll_table *wait)
 {
 	struct fb_open_file *of = filp->private_data;
 	struct fieldbus_dev *fbdev = of->fbdev;
-	unsigned int mask = POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;
+	__poll_t mask = EPOLLIN | EPOLLRDNORM | EPOLLOUT | EPOLLWRNORM;
 
 	poll_wait(filp, &fbdev->dc_wq, wait);
 	/* data changed ? */
 	if (fbdev->dc_event != of->dc_event)
-		mask |= POLLPRI | POLLERR;
+		mask |= EPOLLPRI | EPOLLERR;
 	return mask;
 }
 
-- 
2.7.4

