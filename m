Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9874C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734F12070D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxFlMS6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfEONnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:43:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35719 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfEONnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:43:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so19170pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dm1dO39Z0bTf0y37QqAuJ55GyE745O7vo6s1u0Y7l7g=;
        b=kxFlMS6opM1hV2xM9mMVuBVV9ISBvrj1POuyhRqAyVgtQt1j+D0hwEdYNpgw/HScRG
         htnD7F/a56LfcXStyD8RkxnJbocLUGq4Tqz4AhqnDtxUqSLghjbhNL6mmX7QRsyMjAhm
         gZ6lScu+ey711jijwmY3Pn6m+5N/CYQq9onXbGR2GvNmGTa6C+msI11lOD0n3jflJpuU
         ogfzUH6m2bcu2AvCdY3gBoRgZf6vbWOcmeObQlYaeaI8uOdaqTGLWOOGnHipE8s+fDS9
         HQrnP++z5xbUVbia4lE8yiCunL5WqrUKww1ZfoQwu1IM4pX0w5VB/VPz8jzpSfkuF+u2
         tpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dm1dO39Z0bTf0y37QqAuJ55GyE745O7vo6s1u0Y7l7g=;
        b=YbOnsSD+wpCPYeOdqmAE16BHuf1T6l24VVZlGPdW2qqMsOmNHmYFKJ4ntaHd/KwFz+
         CL41reZo+xgaYy/zPOQDtB1+sxIA02u+vC8OWtkCfUlgBGVNoMYaIR0tqkzzmY1RTdlQ
         AiKPL+Sb49nbLq2mBs3mZxAJexSXGiCNiKfNJihXQHP3Bqqb8/4Tbfal3hUsaG+eHVkB
         AvAKmNLWiz279HkbcEWi/ZmXFHMQn8oHiKAPCbc+DHo8cRfiUJV+61EfJJmBbQAIjvqR
         BM/0RZF2lTqQA/MEXmF8epd6rk2t9oJAjupEuSG9glDY1PwrlEkTTmbDYt0OO3jG5aB+
         onkg==
X-Gm-Message-State: APjAAAUTvvDpb7LpNoASJSB6hwQrJRnB0pVjPyb0WpkIh+OcsoINnSHG
        UsYfMld8rdd43CMCVbbSPes=
X-Google-Smtp-Source: APXvYqwp27RmOtYyGlxe9msuqDyi/cFO1P0cbcQ7xZMgFhtGjej69lixQg+NV+dICOz1kpr17fdnyA==
X-Received: by 2002:a63:d345:: with SMTP id u5mr41861119pgi.83.1557927795958;
        Wed, 15 May 2019 06:43:15 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n184sm4144488pfn.21.2019.05.15.06.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 06:43:15 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH 2/2] bsr: "foo * bar" should be "foo *bar"
Date:   Wed, 15 May 2019 19:13:10 +0530
Message-Id: <20190515134310.27269-1-parna.naveenkumar@gmail.com>
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
index 2b00748b83d2..35d456716969 100644
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

