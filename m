Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE39C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DEC2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="GU7oj8eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgAINwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:52:36 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46717 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbgAINwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:52:33 -0500
Received: by mail-wr1-f51.google.com with SMTP id z7so7400353wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmlrA1h72ZzGJRA3vJ6HAmtvtsW5XxQ4C49Z2OG3RDc=;
        b=GU7oj8eqyaI6CJKArBOATouELO2rRt20bUumWtNWy9mud+/QF1s4DeUcjXnZFA1GWw
         55CZQ8cbAkM+WRLO55+Xx+hq3y7NsOyBYto9I4NmHT+TyrNLhKzoQAF+sQEgvZCThYXt
         RgBnnds/Wck+5/aetKf89fQAT2FFm1xBDAdl2sVHdiHX2Fm4OcwOYC3c32CWR8BNANYe
         XiRuc5yjnwJAguELKlD71QtyTz0X9DEruvDWJ08GR788bRG+DeALd+UMjYmU8A2aBCa7
         OBklAmwxHCdAoed0r3QTadzlar9Nm0p8Uv4hhrI7+gURSx43FwFK5MKusvK8rptmL27x
         lIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SmlrA1h72ZzGJRA3vJ6HAmtvtsW5XxQ4C49Z2OG3RDc=;
        b=WykjftqFrhLP143ZtRFYDWEJrtk8+bkdw7XmWxqN1yMVB1AmgaN4E7OkQ7lBUUJ230
         vsVyLWgiq2eSyfzVKcaYAeBx2jFVQ6gn0zc4FQlkgqUvSxO6uaNe3919AU8aAdcRssWU
         PGOFq4qpy0gQTCh06WOYL9LAQGnZUY4zstdE++0CO/ucyM1CnlaP/xmzoNZ5Rq58VjBy
         tpeFbdczgSCCpPpbwGedQmcJOWDflw0JtqSpwVAe8L2xj3WQj9Lv5JrxqiRzjud0Tu2H
         kbRNmpqxYIlWz7X01kVfKswBzVPySY7qLxLmCiLrGrWfs/+SJNNdYF2FmBGBQ+bHtfA9
         ZwpQ==
X-Gm-Message-State: APjAAAV+NeMVD6sWnIkE4Yy9QscxuqbGSQ9H1IkrbY/J1BNf3wTuorJ0
        1GXKz1drgO9W76UAZVJWwvqw+g==
X-Google-Smtp-Source: APXvYqxry93M9d9N42zDox2abItlRc/ZRwvNbiZxMLdDc5EbQUonmPZpd1ymh1LA7g5ytlgPUoCg+Q==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr10791323wrv.250.1578577951886;
        Thu, 09 Jan 2020 05:52:31 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g7sm8183285wrq.21.2020.01.09.05.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:52:31 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] arm64: zynqmp: Setup clock-output-names for si570 chips
Date:   Thu,  9 Jan 2020 14:52:19 +0100
Message-Id: <b1939b85c07be210f09a4fe60e91e580320def82.1578577931.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577931.git.michal.simek@xilinx.com>
References: <cover.1578577931.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are more instances of si570 clock-output-names property
should be used for differentiation of clock output.
The patch is adding this optional properties for all zynqmp boards with
si570 chip.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index c96e8416fa7e..845671447f60 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -389,6 +389,7 @@ si570_1: clock-generator@5d { /* USER SI570 - u42 */
 				temperature-stability = <50>;
 				factory-fout = <300000000>;
 				clock-frequency = <300000000>;
+				clock-output-names = "si570_user";
 			};
 		};
 		i2c@3 {
@@ -402,6 +403,7 @@ si570_2: clock-generator@5d { /* USER MGT SI570 - u56 */
 				temperature-stability = <50>; /* copy from zc702 */
 				factory-fout = <156250000>;
 				clock-frequency = <148500000>;
+				clock-output-names = "si570_mgt";
 			};
 		};
 		i2c@4 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index ae62fe4287c2..822de6f04725 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -388,6 +388,7 @@ si570_1: clock-generator@5d { /* USER SI570 - u42 */
 				temperature-stability = <50>;
 				factory-fout = <300000000>;
 				clock-frequency = <300000000>;
+				clock-output-names = "si570_user";
 			};
 		};
 		i2c@3 {
@@ -401,6 +402,7 @@ si570_2: clock-generator@5d { /* USER MGT SI570 - u56 */
 				temperature-stability = <50>; /* copy from zc702 */
 				factory-fout = <156250000>;
 				clock-frequency = <148500000>;
+				clock-output-names = "si570_mgt";
 			};
 		};
 		i2c@4 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index b3c29947d6b3..022c732005ee 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -304,6 +304,7 @@ si570_1: clock-generator@5d { /* USER SI570 - u47 */
 				temperature-stability = <50>;
 				factory-fout = <300000000>;
 				clock-frequency = <300000000>;
+				clock-output-names = "si570_user";
 			};
 		};
 		i2c@3 {
@@ -317,6 +318,7 @@ si570_2: clock-generator@5d { /* USER MGT SI570 - u49 */
 				temperature-stability = <50>;
 				factory-fout = <156250000>;
 				clock-frequency = <148500000>;
+				clock-output-names = "si570_mgt";
 			};
 		};
 		i2c@4 {
-- 
2.24.0

