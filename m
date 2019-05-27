Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54087C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EAD2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLQDLiMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfE0MjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:39:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40606 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfE0MjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:39:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so9051225pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I2x1nMpbWtGUoX8qQNpGkZM5zNWW5FxIMZjq6CiV9J4=;
        b=WLQDLiMqYc4wAcrPNLABAX/cxJD52IHUFRYVJi+CG16FhfkAA+VFvMkSyTBG6lMQy4
         Kw9sLHps7B0HVbGxdJC3JEBMoYqb9zFa+WEBGLFidKiiaS/xDzR/8iOd8uak7lwGpyrs
         1+PbynatWpzqiXPpFQvPgi8a9AMVR3z1YNh9ql3ixgNhRmurZUJQ31mzOXn+vGJl27CK
         VOQLeVi3gzZU64nDhqQj5KuNgDaZpR2+i+ymV0FNcgHmk94FrX9EXRGdp4WXZkBU4Rq1
         2KMUaOLly7NAQM+mjFNSrZ5ZLbEPUGMXlQ0mG5fK1NbJMTyT0Wn8IMy/a6ZNduqKqfec
         v/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I2x1nMpbWtGUoX8qQNpGkZM5zNWW5FxIMZjq6CiV9J4=;
        b=Ua1Zry5ANlHiJ6ieVGB+Nu3e+3FUT29LyeTGjdu9hnjsRfI7NT3B5/WKgDkX8aqvj7
         9GWS4JonnZcO/gS1g3tIUkKXJ38o/wLYE7/1ugQ+LM8TSDB+vMVmpyoOR35jb400zlOO
         9kMbpFgZbxGrQwmklMCN4V3hO5bz+JCkNdg9ieOOnSP1GV9gDjiGyITZAze9RYqqE8Bq
         S94RoAIGhTcBVY+mqurYNl74ge0B1nx3TZpEp63kRYBH/Ffr7J51K/ydt7L1eH0s0Etu
         bCw2ji9MWcZXHtMsla+x6QLGplw9229bQDjLIrFFrqOzyEm5b8iPIZhH0BqNGZzcrouP
         JThg==
X-Gm-Message-State: APjAAAXtPMcnR6cVcP+O06DzkuFuZJxbUKWFIPP93kiW3QPJT8K/qpgy
        dO1q5EYkyFe1pjsHRQPK4mI=
X-Google-Smtp-Source: APXvYqxOo/BUzEoH5j4zas1J2WtUb1Nyo/to08FQXZtZS3Rl1Ofd1Yy2ZwzoHu+1n+2ku4m/dMgRIg==
X-Received: by 2002:a63:4f23:: with SMTP id d35mr32716873pgb.212.1558960761187;
        Mon, 27 May 2019 05:39:21 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id z9sm12664048pfj.58.2019.05.27.05.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:39:20 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH v2] mtd: remove unused value for mtdoops
Date:   Mon, 27 May 2019 20:39:09 +0800
Message-Id: <20190527123909.20427-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTD oops 'hdr' header is never used, drop its initialization

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
Changes in v2:
 -fix comment for patch
---
 drivers/mtd/mtdoops.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index e078fc41aa61..6ae4b70ebdbb 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -191,14 +191,8 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 {
 	struct mtd_info *mtd = cxt->mtd;
 	size_t retlen;
-	u32 *hdr;
 	int ret;
 
-	/* Add mtdoops header to the buffer */
-	hdr = cxt->oops_buf;
-	hdr[0] = cxt->nextcount;
-	hdr[1] = MTDOOPS_KERNMSG_MAGIC;
-
 	if (panic) {
 		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
 				      record_size, &retlen, cxt->oops_buf);
-- 
2.18.0

