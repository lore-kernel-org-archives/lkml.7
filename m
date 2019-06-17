Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BD3C31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B22C21882
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="E1qaffNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfFQEUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:20:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38940 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfFQEUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 00:20:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so5023064pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 21:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RQ7r99LglmbRJj2DFXAbmR129HoEeLSxwVPFaO0vZw4=;
        b=E1qaffNG5g19xLO4vzkHC21Vw/NF7z9+26a48uunjr0ykZXCHL1INVEF+BStNKIzmf
         MPAQJGgkKxKxGLbnOSqzwH4jhBdlJvPBNZJGMkHZFLZ6bGA5HVIw4RVESbhx5k78XAyf
         1K9TqA1WvcFlLVhLev0Qd0v5d7Rw57j/xFfGksf6VUBVYLOgerYkRgd7yYPZj8ORVRl3
         PnTwKpmkALBRMEtLQzxIvjpP06Xz8k6v2K9rPEgN33uMEilH5kQUabP/in3HOhRj7BGc
         hBRFtAS/KVcfAsNEHXi2OWg2Ps3YEqGqzrFQCRDmEIy2LDb9bE7ms4i7F8UV9x6khz1g
         2LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RQ7r99LglmbRJj2DFXAbmR129HoEeLSxwVPFaO0vZw4=;
        b=swjbf9HxRS0OYZ2YAckeKiJh4CwKLQ8pvScHmsbjsvyqeviFMJ+qJwUk6watU+n+X6
         Ljic5cPg0U/LKAZ0byJLD4Rrrt3Tc0Kye+7gH3AEX46ad7Qsvv+/kok7Zo/fbfx6LQou
         nQXwufBuCs+nFHxDG/cUMpyuP/h6N7XaxXzCqTsyXbUdgEyWwDnmriitw+h2QXe+FleS
         Td5TPHhLSEffqbAptegiun0fa/spr7n6lh13A+FLjwanHNoBrVFeuBFQh8B093IlJZcZ
         WPTZUOAOQtEHCgx9h7AtdqJsFqtY8pjrJrWYhbn9KHOUVbYVehlUYwnXu3jiEK+4zZCh
         mIlQ==
X-Gm-Message-State: APjAAAWewPdnyNLqid2EdZpVy6FqDRVtZZjkXdpeJqzhQIehUWv5jSw2
        BX9GFhS630SgjYSdHlusYFq3hw==
X-Google-Smtp-Source: APXvYqwvjjmZfDrezWanalmKfk1xhnUKnOL1Pxt4oVaR0rC4m7W+UW7/7L/oNyXvbXJxRwDupxGOdA==
X-Received: by 2002:a63:7ca:: with SMTP id 193mr46709129pgh.240.1560745201766;
        Sun, 16 Jun 2019 21:20:01 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id e184sm14485615pfa.169.2019.06.16.21.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Jun 2019 21:20:01 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     davem@davemloft.net, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com, ynezz@true.cz,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 1/2] macb: bindings doc: add sifive fu540-c000 binding
Date:   Mon, 17 Jun 2019 09:49:26 +0530
Message-Id: <1560745167-9866-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibility string documentation for SiFive FU540-C0000
interface.
On the FU540, this driver also needs to read and write registers in a
management IP block that monitors or drives boundary signals for the
GEMGXL IP block that are not directly mapped to GEMGXL registers.
Therefore, add additional range to "reg" property for SiFive GEMGXL
management IP registers.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 Documentation/devicetree/bindings/net/macb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 9c5e944..63c73fa 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -15,8 +15,11 @@ Required properties:
   Use "atmel,sama5d4-gem" for the GEM IP (10/100) available on Atmel sama5d4 SoCs.
   Use "cdns,zynq-gem" Xilinx Zynq-7xxx SoC.
   Use "cdns,zynqmp-gem" for Zynq Ultrascale+ MPSoC.
+  Use "sifive,fu540-macb" for SiFive FU540-C000 SoC.
   Or the generic form: "cdns,emac".
 - reg: Address and length of the register set for the device
+	For "sifive,fu540-macb", second range is required to specify the
+	address and length of the registers for GEMGXL Management block.
 - interrupts: Should contain macb interrupt
 - phy-mode: See ethernet.txt file in the same directory.
 - clock-names: Tuple listing input clock names.
-- 
1.9.1

