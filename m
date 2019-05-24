Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B50C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC1820851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6BVL6c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfEXGAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:00:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46132 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEXGAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:00:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id o11so4233150pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hAzC15VtGYfFmuEPXoJrQruEFJeSFaf2/TbSODbm3dQ=;
        b=n6BVL6c5ohCZ171zptj4gzdJgP7LSURoPtfb5w5kTIIwAGrGgpeMfJDOq7Y2Zek1Is
         LqYCNovu9ARHejtRQoqP9UlBer3YD500KOMOaIu2iPOEJaSlr1ilpwbtWsWWq7GizYsD
         HuXxWRLGQNuS/BgxvlBdS2uv9TX8qID2px+T22dqS0NmuEMcho0fQiy67SJLRclqSsKD
         CYnVqPJK+wty90EBJ0OLM+ywxT2aJsYQ2YhXGcXkEJ+IKBpt1ga4IwlakdKBBr8/9+1H
         KX1uhdEal5YaELsg78kbgzHLjQGTNZ8YmRi0rdVFpIu5yhEE8OqZu/PXVNiAaqJQ0mmP
         YHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAzC15VtGYfFmuEPXoJrQruEFJeSFaf2/TbSODbm3dQ=;
        b=A6u4Eo4erWAhiQi+x0S5pYNKeF6fwRB3Rlb1LhdJuw4JB6S128MGySLSel1afdxQrH
         r9rHteCGCmHyIz/L8+vJPbfCVB8CzlxoIngiIiT6HerXz6dU15PBwvlakXDWhgEE0ZSd
         KyRwzvIfnz5oOQfyXxJCHR/5CqsVD5cBYxXzTD05BRSWX/QtLOSWTLwqbEg44If6/l1T
         mt5kKY7FhfmMvTht8hrnj3MT/s7mdzmcIWlSwYbYey+n+yL90BlIAbrEjC+QhxNNsxDS
         yvNxagYjRS7bJb0KyUMESckb7gFpC5gPT8d3j6scUH28Yu2LM9n3jYOTN0MppAah2c4b
         WcpA==
X-Gm-Message-State: APjAAAXYb519wj/9k7pg+s1jP0RPVLzwGfEUbGXQIG5nmR7zk4HVLc4i
        eX0URdG06/DELJkBLxBbsoU=
X-Google-Smtp-Source: APXvYqzW+yjgetDg9TlBzArx/WPeD7mReWHkCB8ZhoLCukdNArsjI2s8Tc5xSAFnKWZO/IgstJDDFg==
X-Received: by 2002:a17:90a:bc42:: with SMTP id t2mr6798697pjv.107.1558677647323;
        Thu, 23 May 2019 23:00:47 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id 5sm1267426pfh.109.2019.05.23.23.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 23:00:46 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH 2/2] staging: gdm724x: Remove variable
Date:   Fri, 24 May 2019 11:30:26 +0530
Message-Id: <20190524060026.3763-2-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190524060026.3763-1-nishkadg.linux@gmail.com>
References: <20190524060026.3763-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return variable is used only twice (in two different branches), and
both times it is assigned the same constant value. These can therefore
be merged into the same assignment, placed at the point that both
these branches (and no other) go to. The return variable itself can be
removed.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/gdm724x/gdm_usb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index d023f83f9097..8145ae2afba7 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -295,7 +295,6 @@ static void release_usb(struct lte_udev *udev)
 
 static int init_usb(struct lte_udev *udev)
 {
-	int ret = 0;
 	int i;
 	struct tx_cxt *tx = &udev->tx;
 	struct rx_cxt *rx = &udev->rx;
@@ -326,7 +325,6 @@ static int init_usb(struct lte_udev *udev)
 	for (i = 0; i < MAX_NUM_SDU_BUF; i++) {
 		t_sdu = alloc_tx_sdu_struct();
 		if (!t_sdu) {
-			ret = -ENOMEM;
 			goto fail;
 		}
 
@@ -337,7 +335,6 @@ static int init_usb(struct lte_udev *udev)
 	for (i = 0; i < MAX_RX_SUBMIT_COUNT * 2; i++) {
 		r = alloc_rx_struct();
 		if (!r) {
-			ret = -ENOMEM;
 			goto fail;
 		}
 
@@ -349,7 +346,7 @@ static int init_usb(struct lte_udev *udev)
 	return 0;
 fail:
 	release_usb(udev);
-	return ret;
+	return -ENOMEM;
 }
 
 static int set_mac_address(u8 *data, void *arg)
-- 
2.19.1

