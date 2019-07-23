Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578A2C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D64122512
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8JRy8Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbfGWKjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:39:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37566 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733163AbfGWKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:39:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so18937967pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1CSfefBlUqQoXiFMYE8mieb7j8rh8vb0qkSPdSvsg0=;
        b=k8JRy8IkfT5Wo3A7zv9onvugcDCKbe7QpxzQfBpTNhim/P6+Kl3aHvDbzxMak1id9M
         FExITlw82OUhoyLH9tJXjkSHndsZycZtHkTtpMexJRjARq+BC1h95i73J2kOzKL+VJtk
         ftFUGJqicFGT9BHboVbAmybFJU4MM+yf2YdrLD6bAdmdEVNscxap3P1IMq9Qw0hHqKRC
         T79GFlRkQat9Cl2Z7bw5IYhMRhV59TAuDl150slPwuBw84b5JFYRMoQJ/h8adEpb/vcL
         djUm9hBTp4qF/thze01xw2uueWfXHa2SHFtwO0bfhJkfC43EBPgUCTxrOpnbc3Hx3sKg
         Bh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1CSfefBlUqQoXiFMYE8mieb7j8rh8vb0qkSPdSvsg0=;
        b=hwm/RskYkCsesgJe6kZtPMP8KzdD6xjpyDqoejG98ODfAcQMn3/OQls+dpKBskGVUV
         c6T02O0SN+k/fddwLVxsbR37g525GZ9h4wd6cOnNGl3MV7qP2Ps4Xuu0B1Aohdt3kshZ
         GCfrtGwcB6igb+4dOov6owXEvmpyVxI1fqpW5IKj3rIeY+XcwiIYRYWsyn6BIBprU2WQ
         JeeAhRxssC7WUtL+KF5mC9rrZaJl9V958QIJ/bsX2GuAE/S4CqeOcWQ264mY7M0tDHtV
         MllKsDDqImUXz2i2+qAXEujGfywSH/LEDZkxDJ65K9IK5sL519pNwq9xXOqHfXczNYR+
         BlMQ==
X-Gm-Message-State: APjAAAXEo1v6kRpzvf7AQ625XOqgsrGON0nWmDitVWsxGqHoABjstcH/
        fzwX1eYD4/UMb38CJYkStm8=
X-Google-Smtp-Source: APXvYqzISI2XUfruijkaoObSvTrIL3oceIQzKdDKBwGIobF1MvYLhG4r+xcj0LXKik5luZfzmWQ4Rg==
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr82053697pje.129.1563878361842;
        Tue, 23 Jul 2019 03:39:21 -0700 (PDT)
Received: from localhost.localdomain ([122.163.0.39])
        by smtp.gmail.com with ESMTPSA id w22sm45991969pfi.175.2019.07.23.03.39.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:39:21 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] irqchip: irq-mbigen: Add of_node_put() before return
Date:   Tue, 23 Jul 2019 16:09:10 +0530
Message-Id: <20190723103910.8006-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_child_of_node puts the previous node, but
in the case of a return from the middle of the loop, there is no put,
thus causing a memory leak. Add an of_node_put before the return in
three places.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/irqchip/irq-mbigen.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 3dd28382d5f5..3f09f658e8e2 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -241,12 +241,15 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 
 		parent = platform_bus_type.dev_root;
 		child = of_platform_device_create(np, NULL, parent);
-		if (!child)
+		if (!child) {
+			of_node_put(np);
 			return -ENOMEM;
+		}
 
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
 			dev_err(&pdev->dev, "No num-pins property\n");
+			of_node_put(np);
 			return -EINVAL;
 		}
 
@@ -254,8 +257,10 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 							   mbigen_write_msg,
 							   &mbigen_domain_ops,
 							   mgn_chip);
-		if (!domain)
+		if (!domain) {
+			of_node_put(np);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
-- 
2.19.1

