Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF08C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AA821850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KNJ5AgUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfGSLLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:11:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36241 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfGSLLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:11:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so14326634pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LpUwCj6ex4EuWz7pYkskzS9o+TUIY6ouJ6SDTvkm7g=;
        b=KNJ5AgUP+nhPQ0XA7JUBTUfni+1LDf7ptqmqWjY4nHFvVJPbmRnXMaTt/uMUXACEhr
         /cDC9w7z4WcGkB+Wp1lxULdRT+MX3mCZD3zopQaSaPBccY9CGUqu0Qc8bPHmPOAIM+EM
         2D3ApY6uxLfR5xv3LQt/vSWubpw8VMEv7/gSg7gNLGZIZhQG4qVeDjG7atcT2M+6SuXq
         RE9wro+b9iZLBNbloz4S6nGLPJRhsGheB7E2fMFI49EqLaybFhE3IXsRSoge9BRnWbYv
         7T404jj5YKtXvD3EyjyRefxifVbXztSZvgM1z0uT3YhkpXUqyoZ8CDv7I5vY1vjTR8Fc
         NWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LpUwCj6ex4EuWz7pYkskzS9o+TUIY6ouJ6SDTvkm7g=;
        b=F+ezUcblOPLq2lJnQ9bLhOLLZBmLzb6xpAcwk0uP5PH2J5BEDM9vKefvPv7HQeETqA
         3pVRlJLtLfxle1QFTV3OGVWpM202CRfE37FL1KueJWNIOLn1x2IlHbk/ZhJOropV9qqp
         9xA5IdULU7oEAmIYN9LHciEq/geF4PUq6ZAMThm15WIzMGeMh3xTDvqOq2C8xPUwtZUW
         2nXbFY6R55pFgmadmO9BiCxYTlgv2nuuZiaq8qQfigzdkOtet77pRTv3wRHPxGDbHG5O
         /7nhqjIx0osZHY5s2LA73fcW5FoyTak9fWZHMBYQISfZFIyK57p35o/Y09866WyFIxdK
         sm6g==
X-Gm-Message-State: APjAAAWZwmoLO6Z5QduvPsWHaveO7m++5gDOvPaRJq+zeAyaBW7wegSo
        BhHkiJiG0WuouaKu0gAn2WCYKw==
X-Google-Smtp-Source: APXvYqxYl9DggRwywYgz894WYfruJqLA9GZZwTOMXKLsPkulca1u7VdoxE+L79pLVGQQ0g6uCpIRsQ==
X-Received: by 2002:a63:2b0c:: with SMTP id r12mr53596123pgr.206.1563534668955;
        Fri, 19 Jul 2019 04:11:08 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id i9sm10196872pgg.38.2019.07.19.04.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 04:11:08 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     davem@davemloft.net, robh+dt@kernel.org, paul.walmsley@sifive.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        nicolas.ferre@microchip.com, ynezz@true.cz,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 2/3] macb: Update compatibility string for SiFive FU540-C000
Date:   Fri, 19 Jul 2019 16:40:30 +0530
Message-Id: <1563534631-15897-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the compatibility string for SiFive FU540-C000 as per the new
string updated in the binding doc.
Reference: https://lkml.org/lkml/2019/7/17/200

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 15d0737..305371c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4112,7 +4112,7 @@ static int fu540_c000_init(struct platform_device *pdev)
 	{ .compatible = "cdns,emac", .data = &emac_config },
 	{ .compatible = "cdns,zynqmp-gem", .data = &zynqmp_config},
 	{ .compatible = "cdns,zynq-gem", .data = &zynq_config },
-	{ .compatible = "sifive,fu540-macb", .data = &fu540_c000_config },
+	{ .compatible = "sifive,fu540-c000-gem", .data = &fu540_c000_config },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, macb_dt_ids);
-- 
1.9.1

