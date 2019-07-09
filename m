Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA7C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E01620665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsZDzZNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfGIRai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:30:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45358 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIRai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:30:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so5731711plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhzoA+M5jkeiQIXxQEVV1I7zF+KNlygH1cHtqS9R958=;
        b=UsZDzZNNmKThZtw7IQ1wVtAuaHRpvyW0mf1kffMld8UOomxGl6C0XPYoq3JCIto5QE
         6uLRcWhLRZd+OlwMWXUyOpafyGS4Tqgh+A4t4YnpzYjXRgA9hP4HIzem2zvU2Rd3Ml3K
         PinJzk7tgcuWNE0u6AUcRBwbNX8M/bz1WxmsnJgH+FHmrkG5Smkg1/yThS2Nam9X2H9Z
         98LyU/7ylwridkju+KOXuxLtupS/bTYIhA+T4S40k4jGJh10MliVhSMn0qNoizGdqvPF
         pigcSl04xUqW14PY+mvgES/e3n7zcFcnSMcp/ywlVpM+FCZgak+DgsLLGBqV2OmRYBt8
         +qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhzoA+M5jkeiQIXxQEVV1I7zF+KNlygH1cHtqS9R958=;
        b=Ca/Oo3cwfGBzAea0v6Adi3sLBfJGCZhuHqfyc+BZ8+XSXElog/ZBrXKaSNEjKAPtW9
         0/lnIriiFPE+U/Ros09sKd4qZ8v2MDA/l6DXRRwX6yxpPVcmMIiZbsrOoWQzjLRxSYMt
         NQSHzrys0Uc3jKIi4NXt3aGK2bxXo6LfU71LU4/4PBbvCtUtoCOJ01m0QSXLWCXp8T5q
         BMz/QJ9GcD805Oe0MBqqROrBb3vTxAyzs4k1iRwI99VcGXm8yYJfA5WClW9k8kR+ItT4
         Ps26NDqK5+oNpdWB7+AQgf7wRrQlwykT+31hDPuVr8PH3Gp0Z1/6SIiGmX5W1/ao8RDs
         PWnA==
X-Gm-Message-State: APjAAAWJL8cVOrZR3bQgIfJlZ8dR/Vo04hBzjXWX9rdjAEueWzTjzacX
        zln4i3Z31SYmVjPD/6mIOW0=
X-Google-Smtp-Source: APXvYqzbf+gQ7/eQiFrimDNG4lBjRy/jFi3wBohQEbyJjfMa5yqtjt0twsCJv+xYqDZ+TLpPMSZEXw==
X-Received: by 2002:a17:902:925:: with SMTP id 34mr33107906plm.334.1562693437875;
        Tue, 09 Jul 2019 10:30:37 -0700 (PDT)
Received: from localhost.localdomain ([110.227.64.207])
        by smtp.gmail.com with ESMTPSA id h6sm21048579pfn.79.2019.07.09.10.30.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 10:30:37 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     ssantosh@kernel.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] memory: ti-aemif: Add of_node_put() before goto
Date:   Tue,  9 Jul 2019 23:00:26 +0530
Message-Id: <20190709173026.13829-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a goto from the middle of the loop, there is
no put, thus causing a memory leak. Hence add an of_node_put before the
goto.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/memory/ti-aemif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index db526dbf71ee..9fc80aa89f64 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -378,8 +378,10 @@ static int aemif_probe(struct platform_device *pdev)
 		 */
 		for_each_available_child_of_node(np, child_np) {
 			ret = of_aemif_parse_abus_config(pdev, child_np);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(child_np);
 				goto error;
+			}
 		}
 	} else if (pdata && pdata->num_abus_data > 0) {
 		for (i = 0; i < pdata->num_abus_data; i++, aemif->num_cs++) {
-- 
2.19.1

