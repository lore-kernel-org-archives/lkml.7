Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D50C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6006020868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbOLv6mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfDPQWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:22:24 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33837 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:22:23 -0400
Received: by mail-yw1-f73.google.com with SMTP id x66so15964247ywx.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7F9exMRREX45C8pUViq8Do93XD3VpokDWa83r/8/32I=;
        b=TbOLv6mZmd63hxyjHCSHuv7ywkKnUziSn/tgy31HFnxtNpgFssBiAUH4RRts4ihb4+
         Vzz2AvNg5t1JMiMSbILV4MXLEgZ+sdI9HBCi5OA3bniDstq5Ab1hRXFQ63jMgSg83xW/
         1iuCBy2lssUPD17tMCI9GETlCM2C4TqoTV9C+5tah7RaYs+GjW4FZTtmJfOztBfxTZOg
         KQTNkxP4o9UUEjeNr3RCG+/feemcOMshhAnqxsedvcj/o1T8fx9IF4h3H0TILywdVog3
         xSmJD1uiBizVOxLnjSyJsAqs5quxI8MiQalrAymJepq7BksJ3HjwUn0FBzGWWyc7ZwlX
         vD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7F9exMRREX45C8pUViq8Do93XD3VpokDWa83r/8/32I=;
        b=iCeOE8GtuQ4veL0HwGj4wDbxygpK9ikTlS+Y2Co5kyCXnhZ+rvJ6JtnHgPxUlkXv69
         QR5Hx6nzsyXoPE0RvbqVQ58TddWEqWZGFN06YGlZE65MKrF8G2nKqjRbBiiIK7/k20s0
         NmRtjm+XSz6DqAZXP0zAVUm5czX8k1+4g2VWChd7pLOAsYMJ7njt4h31KvHR4UQ7jlMG
         MM86ZLyfypPSDMVlAFSwlSvqW5pB6SzbfssHLFDjixko4Y/e2MXRbgyhgaGrF70b81MX
         dMcOeGEYm6kxC0gcR1bsjl6GreTJtNh2wj4je7qI6L9C2iBKuAEKUQzFE0bFsginAK/y
         s6bw==
X-Gm-Message-State: APjAAAXXzedImx13W6HRnxw97oOYmg32sNM7gejmREuJrakdlWLZy2BE
        WhoBpxqLhhZkA8UuSyFwKu4Q2C+vSzIw
X-Google-Smtp-Source: APXvYqy2qI3SZ2tJw6VpF4UtNMa11VvLM38g252ji92E3Ij0RxjO9Axjq1LQmhFPoxzNHq3TcAh4bOaB1Y2k
X-Received: by 2002:a25:cf97:: with SMTP id f145mr989704ybg.46.1555431743090;
 Tue, 16 Apr 2019 09:22:23 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:21:49 -0700
In-Reply-To: <20190416162150.150154-1-venture@google.com>
Message-Id: <20190416162150.150154-2-venture@google.com>
Mime-Version: 1.0
References: <20190416162150.150154-1-venture@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 1/3] ARM: dts: aspeed: zaius: add Infineon and Intersil regulators
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au
Cc:     Maxim Sloyko <maxims@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Robert Lippert <rlippert@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Sloyko <maxims@google.com>

Add the nodes for the ir38064 and isl68137 devices on the Zaius board.

Signed-off-by: Maxim Sloyko <maxims@google.com>
Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 65 ++++++++++++++++++++--
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 2c5aa90a546d7..63e892f16d050 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -296,6 +296,32 @@
 				reg = <0x54>;
 			};
 		};
+
+	};
+
+	vrm@64 {
+		compatible = "isil,isl68137";
+		reg = <0x64>;
+	};
+
+	vrm@40 {
+		compatible = "isil,isl68137";
+		reg = <0x40>;
+	};
+
+	vrm@60 {
+		compatible = "isil,isl68137";
+		reg = <0x60>;
+	};
+
+	vrm@43 {
+		compatible = "infineon,ir38064";
+		reg = <0x43>;
+	};
+
+	vrm@41 {
+		compatible = "isil,isl68137";
+		reg = <0x41>;
 	};
 
 	/* Master selector PCA9541A @70h (other master: CPU0)
@@ -311,18 +337,47 @@
 	/* CPU0 VR ISL68137 0.7V, 0.96V PMBUS @64h */
 	/* CPU0 VR ISL68137 1.2V CH03 PMBUS @40h */
 	/* CPU0 VR ISL68137 0.8V PMBUS @60h */
-	/* CPU0 VR 1.0V IR38064 I2C @11h, PMBUS @41h */
+	/* CPU0 VR 1.0V IR38064 I2C @11h, PMBUS @43h */
 	/* CPU0 VR ISL68137 1.2V CH47 PMBUS @41h */
+	/* Master selector PCA9541A @70h (other master: CPU0)
+	 *   LM5066I PMBUS @10h
+	 */
+	/* 12V SMPS Q54SH12050NNDH @61h */
 };
 
 &i2c8 {
 	status = "okay";
 
-	/* CPU1 VR ISL68137 0.7V, 0.96V PMBUS @65h */
-	/* CPU1 VR ISL68137 1.2V CH03 PMBUS @44h */
-	/* CPU1 VR ISL68137 0.8V PMBUS @61h */
+	vrm@64 {
+		compatible = "isil,isl68137";
+		reg = <0x64>;
+	};
+
+	vrm@40 {
+		compatible = "isil,isl68137";
+		reg = <0x40>;
+	};
+
+	vrm@41 {
+		compatible = "isil,isl68137";
+		reg = <0x41>;
+	};
+
+	vrm@42 {
+		compatible = "infineon,ir38064";
+		reg = <0x42>;
+	};
+
+	vrm@60 {
+		compatible = "isil,isl68137";
+		reg = <0x60>;
+	};
+
+	/* CPU1 VR ISL68137 0.7V, 0.96V PMBUS @64h */
+	/* CPU1 VR ISL68137 1.2V CH03 PMBUS @40h */
+	/* CPU1 VR ISL68137 1.2V CH47 PMBUS @41h */
 	/* CPU1 VR 1.0V IR38064 I2C @12h, PMBUS @42h */
-	/* CPU0 VR ISL68137 1.2V CH47 PMBUS @45h */
+	/* CPU1 VR ISL68137 0.8V PMBUS @60h */
 };
 
 
-- 
2.21.0.392.gf8f6787159e-goog

