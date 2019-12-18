Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE2BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17192176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uITl8L2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfLROGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:06:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38140 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfLROGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so1276941pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 06:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uV9emrToibtOtd5PwV/QEFcEzg9NL+MgjlxJNDfEwL8=;
        b=uITl8L2DI2aQzJ+jPqTvx8o8bwqNQZzz9yIa4VZjCTy+rXuhJrdcGB1QhFsFeE4FHo
         baT1rLDOQFTP8OkqTuMQt5Dnt+YP8Ec6aMKejz98kCxMvnF3131NU0iinnzWy0DkxhaE
         fGa+cv4Pur7BJUWH1N+e4BJOtoPCEQ1yjl1qkzdKzf0MrvpLYDDBLftlbUKdAL9/Kxwk
         l+8XYK9FGO4htM4pYNRIrA04KYP57bmN2hsc8sLM0jRPU08lOyBYZSG+MWUcyIfHPk+D
         H4vmxLeBaO2Hxcsl98RVzGTz3/HaJeVdTE6/rEPHKTzK1owIWlRTetcxaJK8EWfw3RLp
         sK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uV9emrToibtOtd5PwV/QEFcEzg9NL+MgjlxJNDfEwL8=;
        b=LDsNHkaryvTGN6BjDSQ5RglHCSS73sBdWR2dKGNlBPWxS7X66/0O9stuP++boY/Vwa
         qcq9J1LucrMsyaipuwuzM7DOInVhTOiaHtSvOsBqa5Gb5DeRPy3TjmkmvlIPovKxSHBb
         2BkBSV9To3XvdG44WydI28Vk+X26MdPF9ph2HHS7OYjDldhDH1zPTEeqOPO/E6od9okD
         v6mZ+ur0WHO4gO9SnbRWxC/aBVLLJN2JfSN5r6UW4knz4xTp86mOIUk+CxhN7r+ddZjN
         phB/5gVf5+u0tAU9eh86K3lElYD258WRtAAiew0CoWp7Q5qiB52oA+r6vSd2718nJbmS
         1GhQ==
X-Gm-Message-State: APjAAAXkPZyVZ2/e4s3DGfzzjNnRCAQuRgekht99YuChjTcgToJKYTe6
        fC6fKtt3QrAlVFXCJ5Y4Afk=
X-Google-Smtp-Source: APXvYqxT3fV1Ulz6tWQI94WjXrxyeWnJup5zp9HZWBIwe5+NxmlgbPxwEI2ELaAbchfM5lx2V5LeRw==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr3188567pgh.331.1576677964039;
        Wed, 18 Dec 2019 06:06:04 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id o184sm3390758pgo.62.2019.12.18.06.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:06:03 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mtd: maps: pcmciamtd: fix possible sleep-in-atomic-context bugs in pcmciamtd_set_vpp()
Date:   Wed, 18 Dec 2019 22:05:52 +0800
Message-Id: <20191218140552.12249-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

drivers/pcmcia/pcmcia_resource.c, 312:
	mutex_lock in pcmcia_fixup_vpp
drivers/mtd/maps/pcmciamtd.c, 309: 
	pcmcia_fixup_vpp in pcmciamtd_set_vpp
drivers/mtd/maps/pcmciamtd.c, 306: 
	_raw_spin_lock_irqsave in pcmciamtd_set_vpp

drivers/pcmcia/pcmcia_resource.c, 312:
	mutex_lock in pcmcia_fixup_vpp
drivers/mtd/maps/pcmciamtd.c, 312: 
	pcmcia_fixup_vpp in pcmciamtd_set_vpp
drivers/mtd/maps/pcmciamtd.c, 306: 
	_raw_spin_lock_irqsave in pcmciamtd_set_vp

mutex_lock() may sleep at runtime.

To fix these bugs, pcmcia_fixup_vpp() is called without holding the
spinlock.

These bugs are found by a static analysis tool STCheck written by
myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mtd/maps/pcmciamtd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/pcmciamtd.c b/drivers/mtd/maps/pcmciamtd.c
index 70bb403f69f7..d2cd1708aa49 100644
--- a/drivers/mtd/maps/pcmciamtd.c
+++ b/drivers/mtd/maps/pcmciamtd.c
@@ -301,17 +301,23 @@ static void pcmciamtd_set_vpp(struct map_info *map, int on)
 	struct pcmciamtd_dev *dev = (struct pcmciamtd_dev *)map->map_priv_1;
 	struct pcmcia_device *link = dev->p_dev;
 	unsigned long flags;
+	int fixup_flag = 0;
 
 	pr_debug("dev = %p on = %d vpp = %d\n\n", dev, on, dev->vpp);
 	spin_lock_irqsave(&pcmcia_vpp_lock, flags);
 	if (on) {
 		if (++pcmcia_vpp_refcnt == 1)   /* first nested 'on' */
-			pcmcia_fixup_vpp(link, dev->vpp);
+			fixup_flag = 1;
 	} else {
 		if (--pcmcia_vpp_refcnt == 0)   /* last nested 'off' */
-			pcmcia_fixup_vpp(link, 0);
+			fixup_flag = 2;
 	}
 	spin_unlock_irqrestore(&pcmcia_vpp_lock, flags);
+
+	if (fixup_flag == 1)
+		pcmcia_fixup_vpp(link, dev->vpp);
+	else if (fixup_flag == 2)
+		pcmcia_fixup_vpp(link, 0);
 }
 
 
-- 
2.17.1

