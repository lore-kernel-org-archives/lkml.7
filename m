Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B8EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6535C206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzXZu0u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbfHATOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:14:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37968 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388408AbfHATOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:14:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so25906007pgu.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RGSi6Vfvu4xt0lLiUw2AuELaVvHeG9XlGKbiRKRhs5s=;
        b=CzXZu0u6zSFO45D6jZX0nRg0HDilucTrINpsfUkqhuwfKSdUyaiS8FoUrotxfcFC1D
         CZcSsbgMpzwFLos8rns9y+RV5ZCPq5heIDIbutaCOQTUImxu/hU4uGZdlM9m17LCn4Y1
         atjG3HAy6kdHQ0vfg4AlaPUnKlxIDyg2rCSoBmABrruO18JlNC5ntmSZCkLV4qMj+zXZ
         YbPcKslxsBTQOCLWZi6dNy7dNWONL36W+p1gp8eSxgVL/Jh+ccXCtp9jI5WSXMGgxsPg
         F37sSBs4esooLnu4zuX9CP7JQf/NiCC8UfzcZaThO/3LKGJpsmdAPu4NvvtlxALaCPUr
         kdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RGSi6Vfvu4xt0lLiUw2AuELaVvHeG9XlGKbiRKRhs5s=;
        b=Pezp6C5Zx89TDlyAVd0VOmP0yY1C9l1M8kfcU8ArgG2O9szJDqhdcwjORRJstHUC+A
         C/MukQSq4w2eiUPukSlCxsJWB3icjE3pJ8bdjgc8XILI5k6vdbZ/i3pUU0mqYdu9djWI
         D1SrA2jPy4rhDG7AOTAjh9pbc4zU9DWXIfez2FEH1hTfDSQtbprt0xVSEbP6ZAtfijwV
         iVvNoDMhIi6Aa+7Lq0hWmrpu+zbqgnLln+iYFUYNmvV3Nto/dibXc9armE5RlY1XxFfz
         R8LFJagOrrNyh+ban3u6Q+08otdwPAdauVg1FeyQgm9CK1NQZFPc7Cb3Rg3Y9rZnD4RL
         yz2w==
X-Gm-Message-State: APjAAAUJfDbYMwFl4iUXZu8kutl1RAUY6XCA3BXa4PJ/c80GYhcrJorr
        Gigq97zYk11hJMTwZFtoPCU=
X-Google-Smtp-Source: APXvYqzK958XAnyAAlJUQgc40czLAt5NvUHZo5mDFkLq1+OxnV7vajasz+Bhp8jPmXLYYMRbUQQS/g==
X-Received: by 2002:a17:90a:26ef:: with SMTP id m102mr354581pje.50.1564686857848;
        Thu, 01 Aug 2019 12:14:17 -0700 (PDT)
Received: from localhost.localdomain ([223.191.5.161])
        by smtp.gmail.com with ESMTPSA id bo20sm4625811pjb.23.2019.08.01.12.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:14:17 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/3] parport: Add missing newline at end of file
Date:   Thu,  1 Aug 2019 20:14:06 +0100
Message-Id: <20190801191408.10977-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/Makefile b/drivers/parport/Makefile
index 6fa41f8173b6..022c566c0f32 100644
--- a/drivers/parport/Makefile
+++ b/drivers/parport/Makefile
@@ -19,4 +19,4 @@ obj-$(CONFIG_PARPORT_ATARI)	+= parport_atari.o
 obj-$(CONFIG_PARPORT_SUNBPP)	+= parport_sunbpp.o
 obj-$(CONFIG_PARPORT_GSC)	+= parport_gsc.o
 obj-$(CONFIG_PARPORT_AX88796)	+= parport_ax88796.o
-obj-$(CONFIG_PARPORT_IP32)	+= parport_ip32.o
\ No newline at end of file
+obj-$(CONFIG_PARPORT_IP32)	+= parport_ip32.o
-- 
2.11.0

