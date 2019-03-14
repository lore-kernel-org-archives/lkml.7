Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C19C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F789217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="i92G3cKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCNHag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:30:36 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58152 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:30:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 3AB87CDC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3prnkRFiqy-c for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:30:35 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 06545A2C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:30:35 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id q141so3924773itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Mzdr9yLs5nJE6hBnuYkAGMUAiDKHyEEnR54GqF1pxrw=;
        b=i92G3cKphNuNq0tNBCv/7zjoVRSlX97srz6lq6MshYKBx2X4mOKXoPdsXGd0Juwvi/
         GiqmKR8cdOXUaYdgzm4a7aHqYY/0TdUhm4vhIdvzTvFJwM7Bm3XIZSxW55JkeY6Vdl+8
         plgXywgvOrTb5PQ7DKtXg6yxxZiU9DgWDYPl/UCvTXRDVkm1AJ7dx+mHhLOuUOOsahSG
         1fRN1isFn31J9yLKP6zPc56e0+I6gER98bJ9NHUrx544iTojmO+8paIFF6WaFSh8rBB7
         MdOZjSuwGIDqPzLxXe6Hps17Vu0k2X/K/fkeirOjt1yAj7t5XAYtTBgesJU8creSZ3x6
         f4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mzdr9yLs5nJE6hBnuYkAGMUAiDKHyEEnR54GqF1pxrw=;
        b=Nq08uL1ekTtqlQ37qOsQM1dZ8oi0F7v7GbRlzlWN1H4cYxLNSRttLMibDO41i5eYtn
         vs0aV+q5Nyyh74oDMXF8iWZLgzD751FXWkLinMBZ4cqdDrzimT/u5v7pO51lBkVUeRhu
         Lx7Ob/IplTtSD63dQ9wayf7xYeqDH6i7n74Bcac/8A7NSWM3JlB4+PZ+QCyoDp6EWzgR
         Uo40E/CWUhTnNn7c2WDErp4qvBESukwdoBE6hws2kPoVUWcA56GYQxOalCSVfIyKhUcO
         MPNotb9KFx0qNdpzv9syJ1M/O2p2x4qRhcEZc5DUIMsCx2cvK18pVuFQDIjoam7UlYaY
         DW0Q==
X-Gm-Message-State: APjAAAWn91xe7hdDQrF6gZ6W0yLypHcc1F8NjML1CxxjdAOO2J6YnYN6
        /Zak4816+mORHV3IWqPmtQTiTspBPh9Gi5yBVxN/Hl54EvzTOmQo1eA7dFIC4qZFrnuOV30SE5v
        TXFyBbwGkwTulzvnCM4i+bTAoF1J3
X-Received: by 2002:a24:4202:: with SMTP id i2mr1163070itb.85.1552548634628;
        Thu, 14 Mar 2019 00:30:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy7DO2C54XadysxQeTsnDN7MdTtxbOmv8tvN+nTC1s5OmGx+9DNywZpdKtxiwqrX/K7/IcH7Q==
X-Received: by 2002:a24:4202:: with SMTP id i2mr1163060itb.85.1552548634436;
        Thu, 14 Mar 2019 00:30:34 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id n20sm5885439iom.5.2019.03.14.00.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:30:33 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-nvidia@lists.surfsouth.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: hgafb: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 02:30:27 -0500
Message-Id: <20190314073027.22337-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ioremap fails, hga_vram should not be dereferenced. The fix
check the failure to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/video/fbdev/hgafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 463028543173..59e1cae57948 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -285,6 +285,8 @@ static int hga_card_detect(void)
 	hga_vram_len  = 0x08000;
 
 	hga_vram = ioremap(0xb0000, hga_vram_len);
+	if (!hga_vram)
+		goto error;
 
 	if (request_region(0x3b0, 12, "hgafb"))
 		release_io_ports = 1;
-- 
2.17.1

