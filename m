Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8B6C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2392920726
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGWT/Jlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfLOPRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:17:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40334 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfLOPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 10:17:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so3371729plp.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qm1xoQnUfMoiwKvQO9cACBYf0LpXiiT+sd+pGOhlOzA=;
        b=LGWT/Jlj/zttjXhuo7VdSjdzVQWPFccURbeoo2UGXWNSMUTd3eoYtsVdn6amE0OdLp
         8VIWxiTvIiZdrf+VXnVWrIYWota3NGxuwsBkOAw2XcNEFZAaE/jy72FotOjp1SD1+lsT
         eME9rQvbv90OxtOBjC+sDpjQ8KJ0OX37oLbcT3nsKemlRfs0UKINb2Bo/zSgHylN+fiZ
         VEJc3cguA1ZqysVFGJRDCrAzjtTo96Oz8weAQvzIB9XnujOO2L1PpRdvdZtwbkJt6GiA
         esSxUdG3pYcyViuzPP0U4MzrUewJsFJY6Z7iMH425rI3RhL++rIYs6Yt4BNtjrZbOfPZ
         QIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qm1xoQnUfMoiwKvQO9cACBYf0LpXiiT+sd+pGOhlOzA=;
        b=gcW5hTaksnbqkAzjR/SS685h0wDlJbtRbh3UPEWINv6oAPKQdEBbf1N/zcIMiPsSEh
         RIkvnj6FaSOCUZxNEg10QWr5zLndpWLchbxZ7fLia2+sNUhilsAdlYJJLpA1KqSNgeRq
         sj09RG3UJTC1nhkFIOJkObYA9QIZln+VFNMzr5UWtksZyXGGcRp5eorE29RV60ECBUSW
         HbGAjXDMEDqm6aJwK9Cl54yQ65LN9gjQplUZMuFXwJAyc6LeMziPuTUsQU9LbDPZ1BZT
         1ArcBIHNDAFR7ljhrOL32c+LWDay/Pns7o6nlEoYMi9+9/F4PyKTndtb3KLWhddfj2Ty
         MrsQ==
X-Gm-Message-State: APjAAAVS1skAsg+MdR93QO2I7aX9wrfpYbqBWtq8MflxuiJoc6MidvGL
        7zAXdG1ZfGwWp818M+62who=
X-Google-Smtp-Source: APXvYqyn/TwuVxxqK5Zw0qflVQaASkHD9qEX+CfJYwBp9QG6233HyT5qighVxs9h3WXSLUOGRRY9NA==
X-Received: by 2002:a17:902:56e:: with SMTP id 101mr454054plf.118.1576423030776;
        Sun, 15 Dec 2019 07:17:10 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id i9sm18945708pfk.24.2019.12.15.07.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 07:17:10 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/3] clocksource: em_sti: convert to devm_platform_ioremap_resource
Date:   Sun, 15 Dec 2019 15:17:05 +0000
Message-Id: <20191215151707.31264-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.
BTW, do another small cleanup.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clocksource/em_sti.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 9039df4f90e2..ab190dffb1ed 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -279,9 +279,7 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 static int em_sti_probe(struct platform_device *pdev)
 {
 	struct em_sti_priv *p;
-	struct resource *res;
-	int irq;
-	int ret;
+	int irq, ret;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
@@ -295,8 +293,7 @@ static int em_sti_probe(struct platform_device *pdev)
 		return irq;
 
 	/* map memory, let base point to the STI instance */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(&pdev->dev, res);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-- 
2.17.1

