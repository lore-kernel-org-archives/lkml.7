Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7578C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756E520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uc2qJvTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfCFWls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:41:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40390 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:41:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so11803041eds.7;
        Wed, 06 Mar 2019 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/AKQKa3JjPkRsfvuDYHtTdoCUqlSTKdXae4Ug3iovSc=;
        b=uc2qJvTXNfYNfVo+izKWZi1r71Xx5f1Z6II+zvl1shUocQYalyCXYXUf9g0YgKHMe5
         5dVqk1K/tigdPbJw/AJfhz6vDn4k2+S/1dacmQR7hxPzhjczhwPI5ss91dpJ2wVfKmBz
         9lLEleKSyFlSTMnqWtviiPBSXt9HaqDICW3MkdCgFycR980Fx00Jp31xZaszRFpiOHRs
         CNuqm+/Z0PPPkNpnt8ZEdGeEnc1bS2Icn2EDYXIfZ+DIraLttymMHF7x/phA9NTupDeo
         jkSbAKOBeYcaptpHjRSgZZMVcpt6pTF2MNL/RT2Eq0R1OY4jiWrnbFzMz2RSbbfnlGFj
         K0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/AKQKa3JjPkRsfvuDYHtTdoCUqlSTKdXae4Ug3iovSc=;
        b=G+jIwYOCyJa2qh+ECiVtARdkPl0NC7H2b3i7cx5nmq+p3nhpxdPflM8tOpCaQXuZ/T
         kKxMjcrOnP88ZPIVSUrmP6LfLNoP1jz+cRcXbcjpXJX0EdbfeYl0THuJDvcbzsJTNiPi
         r6uWbjvmwOwedW4UNjCwaOpBtEx3ey5i7+aDmyMwaBmV2BXPn6L7p12Muu9I7ViHi45a
         aXvMHWlzIiN2Rk6sJjQ6oxCiU8IOe/30fLXfWLCNtW9jFpRcVNZaQFmJ92fLVaF8L2j6
         mE2GAMP8RUW0HqDbegepl6pQRrNfT1DE+I1QSbdJhkAKZuZC388o1VAhPjoCGrfiK5qj
         4OJA==
X-Gm-Message-State: APjAAAUC91jSGXmclRkctGLC2RWWSaaxk16MHeifckWp5Fd7EpHKZt0m
        tF7kQcsZgxaS5yWlnOWb928=
X-Google-Smtp-Source: APXvYqwe0yJolfaGCs4vX2bSe5YH36iYq11pNU6sQJrlYpPffVav4Rn/Sc2TIZzoKoyy8HdOjmO2KA==
X-Received: by 2002:a17:906:6ad6:: with SMTP id q22mr5538557ejs.197.1551912087489;
        Wed, 06 Mar 2019 14:41:27 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm801356edz.58.2019.03.06.14.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:41:27 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes
Date:   Wed,  6 Mar 2019 23:41:12 +0100
Message-Id: <20190306224113.24853-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190306224113.24853-1-jbx6244@gmail.com>
References: <20190306224113.24853-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the vop0 and hdmi nodes
for a MK808 with rk3066 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 9d2216d71..8bc259d3e 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -30,6 +30,17 @@
 		};
 	};
 
+	hdmi_con {
+		compatible = "hdmi-connector";
+		type = "c";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	vcc_io: vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
@@ -91,6 +102,20 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_in_vop1 {
+	status = "disabled";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -150,6 +175,10 @@
 	status = "okay";
 };
 
+&vop0 {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.11.0

