Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D8CA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE962086A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE+WGJ65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfJ3BFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:05:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54083 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJ3BFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:05:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id n7so291247wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwKPYWxS6N7QQs8KHn31UhBaWlHrSb9chBUeYy6x7Uk=;
        b=IE+WGJ65rTS6ju3EWrohy9bqdrBkENHzz9f5O6saojD+N7g3h9zF5bFcB4j4bYQEPY
         j1HfttuBlcxc9Btwhls/5XmfWugAvMoHo+WoB9xddRFJ5WnAG4O2Y7ypcEPEKG/sAxxL
         UDZ2J3fjvjBMKrio3QN3h8vF1Ihv/tvHjA4asmzOE3ivWKavZWVszkG4mL0Jsdo2Klwl
         wlSfV4yq0vEoOmQoAL/MDCKjMM6UeEjsZe8Ur2dEABV9gppcSKTSffGXs4tJT6T9f2QS
         ReG5Z+JPkHtq2H7Xj8iruNUwRkag1xX2v2ykPYeqDD6V3VDrAO1VY8e31hBDm5IomxW4
         mpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwKPYWxS6N7QQs8KHn31UhBaWlHrSb9chBUeYy6x7Uk=;
        b=SKCczfu4EH0CLp9+vgxVEbSqt8foMAfDDL8HU/dBsYrfP/0GWYrimxmri5AJ7Rw8SN
         yOdTTR4/7wi31YtAMOcztVa53mtCjUdyvTgw9N2tm3ZNgZa9NUfNiJIrIOMcmZ/PHMuS
         JajaLgQ+ao3qWnTS/7Glxas54nJiCD0VDRUdxwAxZHVswcVglBfTx8Hk583y0lISok5X
         w9yeiBAX9jzpOOqF+HyAqvGNNfy5DQ8rV0/LuxEOWlRQcR3ljSn2Q26sW2Dm7/emSsK8
         Nx7zLPyVMq/PMXOfHHpzHBMffGqPLOO7jfpwdcltQMvrDjf5lZ9N/oumC8asrqPK3g00
         DAkg==
X-Gm-Message-State: APjAAAWyXc8f3w4QvazvD4cBCPuXK+to9dMFr/GnxmmGSZNmOoKXs6yE
        NDG93Fwbm5O70WsgkVJywJ0=
X-Google-Smtp-Source: APXvYqwXDb27TdvZrFYc10PL5AKDWvitgT+FV88q6l91ekeTmqop9q9xnkH6Y557MAy6iGlNMAUuQg==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr6840822wma.111.1572397500249;
        Tue, 29 Oct 2019 18:05:00 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id d11sm672744wrf.80.2019.10.29.18.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 18:04:59 -0700 (PDT)
From:   Roi Martin <jroi.martin@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH 4/6] staging: exfat: replace printk(KERN_INFO ...) with pr_info()
Date:   Wed, 30 Oct 2019 02:03:26 +0100
Message-Id: <20191030010328.10203-5-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191030010328.10203-1-jroi.martin@gmail.com>
References: <20191030010328.10203-1-jroi.martin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning:

	WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ...
	then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...

Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index aa0d492fc673..401f057fe924 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -396,7 +396,7 @@ static int ffsMountVol(struct super_block *sb)
 	if (i < 53) {
 #ifdef CONFIG_EXFAT_DONT_MOUNT_VFAT
 		ret = -EINVAL;
-		printk(KERN_INFO "EXFAT: Attempted to mount VFAT filesystem\n");
+		pr_info("EXFAT: Attempted to mount VFAT filesystem\n");
 		goto out;
 #else
 		if (GET16(p_pbr->bpb + 11)) /* num_fat_sectors */
-- 
2.20.1

