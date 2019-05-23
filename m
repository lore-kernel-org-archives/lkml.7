Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7503C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BF920881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="J7/qws0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfEWLqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:46:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45697 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbfEWLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:46:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so2649763pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7jtC9YLwA0closzFKH5J5lT2qmKzUMNqjaIDumr77w=;
        b=J7/qws0Qxp3NVZLnHy2qXlZRe+iDyhBpqBA9UAirr+0rrSH2reViAepFM/UquHryeC
         kAfTHH/I2AeboDE6avThPcLAVsl+d70CrgbKZv4GCmnyhp/O9i/jUh4XNUledWpIYKa9
         cLJR1D40KnLdmwRxxicn8hbF+jHu5jHp85TZS050DNv4WRRgUT3Qac1/3NA+d++p9U46
         MtK7xisAUL0tNQld94DBPXeHZOma/juwPjqawte5LaeeUJMiarRZhg31h2LdPf8SxCgx
         XHOVHNtiTM+J4TP/KWakDpvTm7KuBLCG7royYQ0lMAsmSol24XTrpoWMOTcQ4JPwC/Gd
         5zJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L7jtC9YLwA0closzFKH5J5lT2qmKzUMNqjaIDumr77w=;
        b=Q9+yPfG9cYwvpS7aClnc+xaPu+bCIucP1eoFzRdOmKsKORPUkR6gHbeVfV75L50oC8
         RY13hVtXRl/o0Glo5CYUzqQsfQEYMNX0u256GuOnSaXrDEC8+IhOUunoXSLw+trY+6gf
         Zukyq76mek9Y2WJ4U3kA5F8GUMk198Ke6Wktf7pyuPXp1LpZumQVIE/DhlxH6lDBWZ51
         FmOvvAV1nVAUOu2qKRLQYGG/0pb/HbU4T81ZtqXpxi/1D8xPLhRRw9ffcl7Q8obKpQaF
         e87GYjimkazEbEwiR3KumPSCLYn6Q3TPZiLTm0/EEQVTVeiaZG5RWK7nxzSCbntGz+sC
         XPBg==
X-Gm-Message-State: APjAAAU3jRudfc1paZECsdMvMH8Z9aLSx2NpYuWFTzGcCM8gFD64xDbq
        FuobJSPSG7W8BrCHaeHszD5Kbw==
X-Google-Smtp-Source: APXvYqzYfysVuLot60OmXdN5I7JacwSrGu0ekg3Gy2uMSozgIxzrs6RFjWap2hpiFOPQOvuCvlVNqg==
X-Received: by 2002:a17:902:1121:: with SMTP id d30mr2953751pla.153.1558611989302;
        Thu, 23 May 2019 04:46:29 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id l43sm565045pjb.7.2019.05.23.04.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 04:46:28 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, ynezz@true.cz, paul.walmsley@sifive.com,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/2] net/macb: bindings doc: add sifive fu540-c000 binding
Date:   Thu, 23 May 2019 17:15:51 +0530
Message-Id: <1558611952-13295-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558611952-13295-1-git-send-email-yash.shah@sifive.com>
References: <1558611952-13295-1-git-send-email-yash.shah@sifive.com>
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
index 9c5e944..91a2a66 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Should be "cdns,[<chip>-]{macb|gem}"
   Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
   Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.
+  Use "cdns,fu540-macb" for SiFive FU540-C000 SoC.
   Use "cdns,sam9x60-macb" for Microchip sam9x60 SoC.
   Use "cdns,np4-macb" for NP4 SoC devices.
   Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
@@ -17,6 +18,8 @@ Required properties:
   Use "cdns,zynqmp-gem" for Zynq Ultrascale+ MPSoC.
   Or the generic form: "cdns,emac".
 - reg: Address and length of the register set for the device
+	For "cdns,fu540-macb", second range is required to specify the
+	address and length of the registers for GEMGXL Management block.
 - interrupts: Should contain macb interrupt
 - phy-mode: See ethernet.txt file in the same directory.
 - clock-names: Tuple listing input clock names.
-- 
1.9.1

