Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2494C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A7820652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="CNMRtLPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLJThj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:37:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37956 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLJThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:37:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so14703316lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 11:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iVJKBlhEYT6S4kQZRu/hdIVpnnDPFI8gf9sf12wfx90=;
        b=CNMRtLPlIp77f0IVCJYc6IX1Y09b5Wqnv9CF96KD6ytBL4eDUSJ80kH1zFvGs0aGpB
         SkmFjdxaicjcndoWwMrAm3tQ5Vw4g1iE/Pe7QQ5xWiwGDSGnJRJHjD4QHxyhTfGIdhj3
         4ueE3qEswRNpoLloqIKeAKd6Sw4d8+IC3pPHu+5zgVcw9k8z0biTS6cvB6pjcSYuoqyG
         6RmjKc+jctS4BGy769thvk+IfJabmbWSzKC8OK5lnqhP6prbF2PTR8w1m3rWL6Rp05Fm
         2TUqqdigReR2A4kQ3NbA/klRYOF+v62hjosjyK32VddWLcz5+VcfGE1z2OQji383Hm6S
         rzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iVJKBlhEYT6S4kQZRu/hdIVpnnDPFI8gf9sf12wfx90=;
        b=fBVZJKqRlNusA3eT5PhdDI4APT26/PwMRd2G53WrS9oFN9yl/YHj1kENxDCWm+KZzi
         cCereeKmVOGEodE4Rc/3ZFHXjGOqnTgyM9BdrEjSnpSaQD0Vvx4WONhrgsrAv4B4PLCJ
         L6iCYYnTiw9Y9HRuOBraFZ1UE7OaePu9J5XQEa+3cyOTv6WLkVGmTAkCnbXdaNG9/zLS
         cpSYLA/JTnpWXwolC5WKwTu3PhstHnqp4wNzNqtQy/r+ezRNACBr/u9Ypb4SUZlO5SRx
         j94vsBDTNCXy6LHEzb2O34fRfGS6uMA28e1EDzVoSDwziecAYb6bKBEog+RFpJzry657
         nosA==
X-Gm-Message-State: APjAAAVvP16ePQOIttLqsWGBgavfkU65vQ4LlPeNSwlrMMWHuoklJ56A
        0BxOFZvVmaMnlA/7jHkOHgc6xw==
X-Google-Smtp-Source: APXvYqwYZYNq7GNw2QOsd8P7bDup+PoLnIVJpWUvM2k28qn2ZLKHEDQXTHn7SBLoQSvanHoE22KBmw==
X-Received: by 2002:ac2:5dc7:: with SMTP id x7mr20113199lfq.24.1576006656477;
        Tue, 10 Dec 2019 11:37:36 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:88a:ffe6:e26c:e506:75a0:c93a])
        by smtp.gmail.com with ESMTPSA id y29sm2311376ljd.88.2019.12.10.11.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 11:37:35 -0800 (PST)
Subject: [PATCH RFC 1/2] dt-bindings: memory: document Renesas RPC-IF bindings
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bd2c82fa-b0f0-9274-8c69-d13f7cddefc5@cogentembedded.com>
Date:   Tue, 10 Dec 2019 22:37:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
HyperFlash connected to the SoC to be accessed via the external address
space read mode or the manual mode.

Document the device tree bindings for the Renesas RPC-IF found in the R-Car
gen3 SoCs.

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt |   52 ++++++++++
 1 file changed, 52 insertions(+)

Index: linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt
===================================================================
--- /dev/null
+++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt
@@ -0,0 +1,52 @@
+Renesas Reduced Pin Count Interface (RPC-IF)
+--------------------------------------------
+
+Renesas RPC-IF allows a SPI flash or HyperFlash connected to the SoC to
+be accessed via the external address space read mode or the manual mode.
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+		"renesas,rcar-gen3-rpc-if" as a fallback.
+		supported SoC-specific values are:
+		"renesas,r8a77980-rpc-if" (R-Car V3H),
+		"renesas,r8a77995-rpc-if" (R-Car D3).
+- reg: should list 3 register areas:
+	1st for the RPC-IF registers,
+	2nd for the direct mapping read mode,
+	3rd for the write buffer area.
+- reg-names: should contain "regs", "dirmap", and "wbuf".
+- clocks: should contain the clock phandle/specifier pair for the module clock.
+- power-domains: should contain the power domain phandle/specifier pair.
+- resets: should contain the reset controller phandle/specifier pair.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+The flash chip itself should be represented by a subnode of the RPC-IF node.
+The flash interface is selected based on the "compatible" property of this
+subnode:
+- if it contains "jedec,spi-nor", then SPI is used;
+- if it contains "cfi-flash", then HyperFlash is used.
+
+Example:
+
+	rpc: spi@ee200000 {
+		compatible = "renesas,r8a77995-rpc-if",
+			     "renesas,rcar-gen3-rpc-if";
+		reg = <0 0xee200000 0 0x200>,
+		      <0 0x08000000 0 0x4000000>,
+		      <0 0xee208000 0 0x100>;
+		reg-names = "regs", "dirmap", "wbuf";
+		clocks = <&cpg CPG_MOD 917>;
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <1>;
+		};
+	};
