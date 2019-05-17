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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB6C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7656320868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzwojkgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfEQEuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 00:50:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45998 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfEQEuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:50:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so2657436pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 21:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mEEht3Z5ULloHWTAWSA2Ir3JXWTUszy2jqLRnINQh2k=;
        b=Tzwojkghh+nxfGap//8LbAS7bq00YSDhF3+osEmh0FKE/duc3zkAkh6+vGRyWUmGVk
         vZa6S6B0OHJW6h01RbviHI5Y+QBBVkinFDrboXNjvxVeciTgJtfbW/op+NUHpG63IXnY
         F6uMKVqFIfuivM3zZkznm6VXdCC8ihisngsSNogZoe3H4w9CxS9wkVcJe0PYcBchq5U+
         WGbM2nkaXTgxpDpeQ+HxikLUKzCD1tQYvXLDpRKf7Rm5VpLUwbWzMTnwo9NFxpPC5Hz8
         ulcB+KwKpD3WYzGnz0w2Sssbi+VL9h6uUbOCdYgfkqDNQgmpJd+3vstAbgSNRWLBjyaL
         hNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mEEht3Z5ULloHWTAWSA2Ir3JXWTUszy2jqLRnINQh2k=;
        b=PwgXTkR7Q5ek4Th05IK1iPta/uIMx5utoXD9A/aA8KmkjCMoNVH8wqLadOzA8Y3dbq
         mVIbQ1kT4d8FUNsm8BL+zZM1Ir+hCIt/mphYRB2N2EE2KKW35kje+wNm3cV+FL1SQWaI
         gkALYDjFP0K998pkMNLh0mmJfY2eOHGzo/pbwALhFQrxVLsMkZDYMWm+PY6y8VC6/nxh
         xdhiDdlPbj9OTEuPwowY6p4NUN8MpohEgV5m7S7qHs8ILK+ED6492PSa7KnITlVV2bIV
         sccctsOh6huasnDKd1G57ngy3B2rguoGq10xOIIDR6rNw/BHG/Xoc8LnOHT/lp1Ikp95
         7V2A==
X-Gm-Message-State: APjAAAWpzqrhg4LeBNJL7EjSoEmgzRh6K3TiENsGK2RMsSzqAXVdSO1K
        PpSp3I66BZU9lTTQPHQn7z1FLz2fkgU=
X-Google-Smtp-Source: APXvYqxl2ZzkKlwDABV3tPHFgfVdvYjVJFKUTylVQ2cG1Ro726Gf4BK/zxgloSTTgfcOKYGYaMhhwA==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr59161367pfi.126.1558068621257;
        Thu, 16 May 2019 21:50:21 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id g19sm13316262pgj.75.2019.05.16.21.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 21:50:20 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH] bsr: "foo * bar" should be "foo *bar"
Date:   Fri, 17 May 2019 10:20:07 +0530
Message-Id: <20190517045007.20250-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

Fixed the checkpatch error. Used "foo *bar" instead of "foo * bar"

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/char/bsr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index a6cef548e01e..d16ba62d03a0 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -147,7 +147,7 @@ static int bsr_mmap(struct file *filp, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int bsr_open(struct inode * inode, struct file * filp)
+static int bsr_open(struct inode *inode, struct file *filp)
 {
 	struct cdev *cdev = inode->i_cdev;
 	struct bsr_dev *dev = container_of(cdev, struct bsr_dev, bsr_cdev);
-- 
2.17.1

