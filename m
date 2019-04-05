Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF6C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A92175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtFnNMW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfDET2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:28:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45350 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbfDET2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:28:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id e5so6637385otk.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A5e5OlwaDzaaHSgM89AUO2fEaN1VXl/wQkXrwISZ4zM=;
        b=XtFnNMW95hNXKMcPRYG+qvPSy52CZzj4XD+5tQ9UrAx/AXeU6HuKt+d5tjNiZ8XSfN
         UbKwIpyv/xSWGuv6XayiFqpms+FZYFQzuY+Rjx5loU5Z4AwHt/f77ZMxjOrRHq/56kpN
         0Kq7xNFYhV9wj0xVENd/F6CwaALVawAIGw2iv54QrDiNh3nNSVSwYYuEBtyLQ4hE9vGJ
         MNYMxIie7hW/kq4+6KsbLgEZDfMyqX1klA1p+TLOMq8kPAexaDcf+laTJyS2NwzdBBqn
         0T4u7fSQ06aRBeGatE+6gYq47DfT+C4eP3wO+pJlX/bwqZh73mi6tx7wYqX8q1kihn/6
         dv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A5e5OlwaDzaaHSgM89AUO2fEaN1VXl/wQkXrwISZ4zM=;
        b=VH73UZJSUbPVyoK5BD76W9i8agsWCnzQ/Xe0WCyLpEvIhUpJLxjbOQ0uLRWH4KWKu9
         qqTaKp/7QetvoxuruYZpeIDRLHEf0p0/LyUHMSELR+qVgxWFFenInhPhezsbTrsA+LLJ
         GjsA864sORmhw4yTQUkp1aLrpKAfmZX3lGBp11GJ5/EOveeSKZeO7mOPEvZCh434H4Qg
         qDDFxSWPybE7RRsh3O1nMxzU2itGH6c559FOh3Yt2v9EeTOFyfUHKvHCjt9xxB8Nkc90
         FIYeaCnLEC5D4/nT+zX8TXvUfpopvdC3D+E1yDqhT3p9Q/3eu9pyMyxwBMHW2fn+pQXh
         nJUA==
X-Gm-Message-State: APjAAAU0YLmba1KGnrYBTihvq2kgG8o5fuu2pFEY2kBPJBeWzTPG/Te8
        gS2q9jmS7a33ZlGnKVXMN6w=
X-Google-Smtp-Source: APXvYqxWEjdPICYDrv9TeTX+sheXuZc8+dJvI1Qq1hBx5eAH26krwe4WhSPFBCi53h3kJE1wydjv1w==
X-Received: by 2002:a9d:7399:: with SMTP id j25mr9966659otk.88.1554492520073;
        Fri, 05 Apr 2019 12:28:40 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:7549:4e85:9095:b601])
        by smtp.gmail.com with ESMTPSA id a34sm10391913otc.46.2019.04.05.12.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 12:28:38 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: olpc_dcon: Use WARN_ON() instead of BUG_ON()
Date:   Fri,  5 Apr 2019 14:28:36 -0500
Message-Id: <20190405192836.4866-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use WARN_ON() instead of BUG_ON(), as the WARN_ON() produces a backtrace
without crashing the kernel.

Issue found by checkpatch.pl.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 6b714f740ac3..900baab70691 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -138,7 +138,7 @@ static int dcon_bus_stabilize(struct dcon_priv *dcon, int is_powered_down)
 	}
 	if (x < 0) {
 		pr_err("unable to stabilize dcon's smbus, reasserting power and praying.\n");
-		BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
+		WARN_ON(olpc_board_at_least(olpc_board(0xc2)));
 		pm = 0;
 		olpc_ec_cmd(EC_DCON_POWER_MODE, &pm, 1, NULL, 0);
 		msleep(100);
-- 
2.17.1

