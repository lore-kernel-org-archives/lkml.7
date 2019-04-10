Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E88AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37FB20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eca/U/9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfDJKAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:00:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38766 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfDJKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:00:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so1169790pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ph5n1rlVsXxhxRiS/eI4XEwpF9EnmqX19+7umPLLq3A=;
        b=Eca/U/9ifQTJMQKVrkwahhalvis7PTHo59S3bOsu1UgxXCTllFaTSi5fV1sameTzby
         5OpdWQTmvio6ZU62DWkDjJa/zw2aQbGh9pnub0e5vO1SBVXwHHeP8Ws6OePnW5745jUK
         S89Pp/7Nu5kzLB3NAv/WTGHJGgWq+Ug3daCIq7Zjs5LTGplFp1m1Uh/kB7ZDBxySJ7uA
         RSL6ahZPDfoebuBClV7Gu9jwIU7/j/yyGbtPuF55XENLhcrXKpjK1JCuN6Lh9cdC4zWq
         na68QGjXeQIbwXEhog0SHKtcOcDBnTBUuwOxQrsa9OvokfRRG+1A/rGzooTllArFlDJu
         brPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ph5n1rlVsXxhxRiS/eI4XEwpF9EnmqX19+7umPLLq3A=;
        b=gV2du68FPQ2JgiQiCZTIZ0pF2vctacbEMaGV/suBdqqASb7FVWD80G4KProHMLotJA
         gzAqcdwJybQQwpogs2tZYLzIVt//bv0RYVMxrC2+ZepCnDc2ES7BB+TY7TjMVPVEJdhS
         X+wbBveuu017n9GXtZgZf7LXxB98mWWoVaQIE1F9wpzv3mT40V4vPuPfiN75Hk7pMymK
         n//QEfUliv25zPVGEaEfYOo9H4zR9O7cvJsi3ToTK5RVr5CcDOlTXma7NrUISyVSvx+J
         01y0OVeZ7BjOkM1ksT2wT/iHVHIAkFG8g5MZf72JnQxumx+TQ+ft4vHtWmBYbv2lp0w/
         V3Vw==
X-Gm-Message-State: APjAAAUGxd3L9I2BozzmHZGX3pfGgCnwpGoD2hTiPIWqPesaHWUfXVRC
        F7TPMLCwmoDgng1MiIybC0M=
X-Google-Smtp-Source: APXvYqzn6nWJzIL44N6T7uqE/o8C6rdGR+otJmKnfDx9UrcpFFtl6ve3h07Mfvs2BTn6t5tBATqyKg==
X-Received: by 2002:a63:7d0a:: with SMTP id y10mr34810051pgc.292.1554890445841;
        Wed, 10 Apr 2019 03:00:45 -0700 (PDT)
Received: from localhost.localdomain (mx.daiict.ac.in. [220.225.53.35])
        by smtp.googlemail.com with ESMTPSA id x5sm20604001pfi.91.2019.04.10.03.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:00:45 -0700 (PDT)
From:   Himadri Pandya <himadri18.07@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH] staging: fbtft: fix alignment should match open parenthesis
Date:   Wed, 10 Apr 2019 15:30:22 +0530
Message-Id: <20190410100022.11091-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning "Alignment should match open parenthesis".

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..60cda57bcb33 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	udelay(250);
-- 
2.17.1

