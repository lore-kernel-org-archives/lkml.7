Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601F0208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeAMWzlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfF1Cu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:50:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38175 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1Cu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:50:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so2198006pfn.5;
        Thu, 27 Jun 2019 19:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2vqCu+MS+Img9r2z6/QFX/3aEGn5jsBEl1RMM1fPhso=;
        b=qeAMWzlrKSDx6Q/RRzQ4353QIEhM0VyBhhUnC1wyQkMGls5gBSuviEwbJazRlOBTMP
         jwC4bCg5bzKqWjBFjptrl6tQ9iA3S2OVKq9bsy9faiLXvEq8GzGjxXeZjB9Ny80MKKDN
         W8vOwnepdtxDJJ2rBZr8LsrUAqitVJRvvLFH9r8C1PLGYYelNJnQlEkTq1EdzQZMbr4H
         p4o1N2hPPhSX0v/QDs3dLY4oowijenSWg3AK/mE8AwoJ4runi7BvLowlsBYFcfSF2FmW
         tuSQok5Nuj+3gkv9ipd0BPVc0vG53orNw/I2GbCrOb//PPOBDRFNhQ0bP+kidjA6+esn
         cZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2vqCu+MS+Img9r2z6/QFX/3aEGn5jsBEl1RMM1fPhso=;
        b=d/0TeO8SThTeX2ugxUwyKeTlqa+vwxULsDzbRXDDyLVfDsQEQhlBqkf8GQzj+didMs
         KhOaih8vp4pCxUVVwuoINgBIgtjyku2ADhtVW33Wuor8/ULfgZ+XRtdmZ8ncPoi+5wRr
         W+qC8dH45tZWZzqeT1Amq+LYOLp7aNvwf4EbEFGQZ2qGqtrxpthh2y/Q31bdogIIC4lE
         O+QxxBAjRlOAU2yBbOWYPAB/XbBLuALZh85jpnWkcSgUejl/eUhMgIcKrPHKXarVP3pX
         8pC2h8+XeJ7eZf+TpKJOnODM0WXFEr6intywl+qdfi1ERjqdgyLx0mXXpqveNTX54e9+
         AKUA==
X-Gm-Message-State: APjAAAV0PrA0o1xA2Tf8fG5wZ0+04PnrxlozuFJ1Di0zXdGfKGbMBqvv
        ntF/08jq8kTp5TZRLBDB5Wc=
X-Google-Smtp-Source: APXvYqxOMn3XXjIavfVVVOqWwhv7qSskxdyUtP1LwXecHil9rj6KtvpibgLg5zqF2qKy3hz2y5R0Rw==
X-Received: by 2002:a17:90a:2768:: with SMTP id o95mr10104027pje.37.1561690227303;
        Thu, 27 Jun 2019 19:50:27 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id b37sm551587pjc.15.2019.06.27.19.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:50:26 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/27] video: fbdev: remove unneeded memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 10:50:17 +0800
Message-Id: <20190628025019.16026-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index e5b56f2199df..47bc7c59bbd8 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -612,7 +612,6 @@ static int mmpfb_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto failed_destroy_mutex;
 	}
-	memset(fbi->fb_start, 0, fbi->fb_size);
 	dev_info(fbi->dev, "fb %dk allocated\n", fbi->fb_size/1024);
 
 	/* fb power on */
-- 
2.11.0

