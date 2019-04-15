Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D531C10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA5420833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="f2ebh7ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDOBuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 21:50:21 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.91]:16317 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfDOBuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 21:50:21 -0400
X-Greylist: delayed 1385 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2019 21:50:20 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D566131E4A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 20:27:14 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id FqOwhav3wdnCeFqOwhO6P2; Sun, 14 Apr 2019 20:27:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j38GHo+STQz5ACyf1XHDDr2+jK7GF1V7iahohtBK4yo=; b=f2ebh7haEwMegcCIxVR7xjO1n
        EB+j6us50YAAMRY/bpcC4V+/aoBVELl912zIRYy8Z28OvSh/Lk4CNyBqTGoZpqDs+656N8QcjNEnQ
        u9ARYsbfbC0d5cJtH10SmcM2sxbEBVorclnQkyaFYOt4CeVVxknh8dZnQbWLU4ZYTotf6A4WFHz8k
        B4k1UctAdereqXwVwMwu/KKfGdlLV6VyFAIXAFx+Usreog9e4IXBW+5B6XDT1mVWZo2Mmsh3tiSwW
        uBYws8Pqfqz4SHzy/p6JYaVI4fIy1sNCi2huuLNNckkJBIcwjvxs+SnbNmqUNMlwL8XTQR9qa00zv
        1oaEftFPA==;
Received: from [191.191.240.251] (port=33232 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hFqOw-000Uj7-0G; Sun, 14 Apr 2019 22:27:14 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 2/4] dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
Date:   Sun, 14 Apr 2019 22:26:33 -0300
Message-Id: <20190415012635.6369-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190415012635.6369-1-matheus@castello.eng.br>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.191.240.251
X-Source-L: No
X-Exim-ID: 1hFqOw-000Uj7-0G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.191.240.251]:33232
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 33
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For configure low level state of charge threshold alert signaled from
max17040 we add "maxim,alert-soc-level" property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 .../power/supply/max17040_battery.txt         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
new file mode 100644
index 000000000000..9b2cc67d556f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -0,0 +1,24 @@
+max17040_battery
+~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : "maxim,max17040" or "maxim,max77836-battery"
+
+Optional properties :
+- maxim,alert-soc-level :	The alert threshold that sets the state of
+ 				charge level where an interrupt is generated.
+                          	Can be configured from 1 up to 32. If skipped
+				the power up default value of 4 will be used.
+- interrupt-parent : 		The GPIO bank from the interrupt line.
+- interrupts : 			Interrupt line see Documentation/devicetree/
+				bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+	battery-charger@36 {
+		compatible = "maxim,max17040";
+		reg = <0x36>;
+		maxim,alert-soc-level = <10>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+	};
-- 
2.17.0

