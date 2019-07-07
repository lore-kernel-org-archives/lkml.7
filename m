Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EB5C48BDC
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE985206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+6b/LTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGGNWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:22:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51356 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGGNWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:22:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so13247238wma.1;
        Sun, 07 Jul 2019 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5YdWWVMd38nilr4ywfeyrVqnEs8Y0BgotJ6Skyub8PI=;
        b=J+6b/LTAVvdqXojW7zeBtpk69OLCxogsdNUp9jnUJq6k6kSDJEQauhKM1U4ADgbeh1
         NV8NMC6LeUoEwzgNnlfscQBzUo1HXb2TG68ho8ium36/4spyY2EFpI4zx3kFzf8pxk8N
         HG8x07GvcMXyIBaFq0vOnrBo4bqlE7tibzZdaB0SksZNnDiE5MSc6hGZPmHZMIL8nqiP
         zg3m5jqb7J+gjSWL4O0rrkmna9ny81CSX/rrY+hxcwKBJ2AfOHJxvIuaFB5LlUYtwMYm
         4w2TSHt3d8IODany3rYd55tVsVXy5/A33aQfCFNDtImdvfZX7MDGa2JgUZbkteBjVxiT
         fkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5YdWWVMd38nilr4ywfeyrVqnEs8Y0BgotJ6Skyub8PI=;
        b=ne3eJYhJw9Xi3HIR0c1TJq11CWxcVnESHvQHF95TsY0BgY6lr4vVmwU4cqhHOPKo/I
         rGtKaGHFSjcekvmYi0HVAoxH/NU813eDHXsUP8PiYnCsGsN1VSY6u/L54oEAK3LYF3+l
         A5kad7b52JunL3E/wzH0Lq4AWAL+Y6R/QZIAN0vRbW+VDd0SNxrl7smaN3EaRQ+maLNX
         MVkjSzklLdWTgJLgsDSkQ/r+Z3uQ6HherfTJ4YNoCJPyvTEloaQPzo7ZQbnfVdHi3QsF
         tdefXHiXUmA/k8uxfvyTfy/B/gMr2KK4D/GEW7JxvrOHpeAlyxSRkeKE1hlFY0M6L9Fi
         2IAg==
X-Gm-Message-State: APjAAAVz7zyb3MGeq5bNAhoI/SndWWGowifutIHsnmeDAKLI/17pSdnG
        44MbmW5/rPqtpebeyhEV/Q8=
X-Google-Smtp-Source: APXvYqxx6qMvoMtymoeRIihBuitmB4LqsyyGmlMPLkdcxJv0gLiGOp4htOMFDuwWb7njVO+89J7gnA==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr12359795wme.29.1562505769414;
        Sun, 07 Jul 2019 06:22:49 -0700 (PDT)
Received: from arks.localdomain (179.red-83-58-138.dynamicip.rima-tde.net. [83.58.138.179])
        by smtp.gmail.com with ESMTPSA id w15sm2850075wrr.59.2019.07.07.06.22.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 06:22:48 -0700 (PDT)
Date:   Sun, 7 Jul 2019 15:22:46 +0200
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: interrupt-controller: Document RTD129x
Message-ID: <20190707132246.GB13340@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Realtek RTD129x interrupt controller.

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---
 .../realtek,rtd129x-intc.txt                  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
new file mode 100644
index 000000000000..3ebb7c02afe5
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
@@ -0,0 +1,24 @@
+Realtek RTD129x IRQ Interrupt Controller
+=======================================
+
+Required properties:
+
+- compatible           :  Should be one of the following:
+                          - "realtek,rtd129x-intc-misc"
+                          - "realtek,rtd129x-intc-iso"
+- reg                  :  Specifies the address of the ISR, IER and Unmask
+                          register in couples of "address length".
+- interrupts           :  Specifies the interrupt line which is mux'ed.
+- interrupt-controller :  Presence indicates the node as interrupt controller.
+- #interrupt-cells     :  Shall be 1. See common bindings in interrupt.txt.
+
+
+Example:
+
+	interrupt-controller@98007000 {
+		compatible = "realtek,rtd129x-iso-irq-mux";
+		reg = <0x98007000 0x4 0x98007040 0x4 0x98007004 0x4>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
-- 
2.21.0

