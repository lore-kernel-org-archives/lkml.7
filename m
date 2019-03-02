Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A5C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E503320830
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g03kH760"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCBKle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:41:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44233 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCBKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 05:41:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so422585edw.11;
        Sat, 02 Mar 2019 02:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/AKQKa3JjPkRsfvuDYHtTdoCUqlSTKdXae4Ug3iovSc=;
        b=g03kH760NmqUF6tYQ+CeAKnvRoUNoeC8R8Z3hudcm4GgmQ02yzNbQL0+z3C3r+u6p4
         5YFF/sJMBNeIj7IUbsMavmvNHu6jJmlskBHamwM85Bapzp3Tkl29wd7zWvnnOMM+9unZ
         VUpgKd7rWzYBkz2h94QQongz2vwBgjXU9ujvAHOCsiEf1+fIpmUMreAUG/gUBQ395Htt
         TaIulFo8gUomzJ4OAezQo1GNwrkAcgF7mFtDPugwz4wQGql3truHYMdrTNGmualVXN1z
         egf+9zkZOc/xrOlUW8OGlJyXdNLaC3ewsWhTkPu+kTtkDO5jmAvnIbUtHj4hsU0KEGOq
         2bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/AKQKa3JjPkRsfvuDYHtTdoCUqlSTKdXae4Ug3iovSc=;
        b=nZ9x6PtUQRKyv0Ow2EESnpR0FD1NGpzwUyWIcCQJKm8arxgCJMq074guboyvlvwj3d
         TZ8z79QY92dKMWo0LNNq+YG+kLFZUFkkCHYmP961Wzn4PBcPqghmkBNRI2CARU5XqE0a
         4YPOMZgkN9ehv97nQVxHnsW/CbYeoJSw03bPeafsvnUYdNI/BBekE80/GngE4JkoRqOl
         VJjZtDNZNB5VZ1kHJYpFgcUQkzwo5O9BuK61rSCHFzbI7VLIfCkfSf/jXDUAgHuP52gX
         l9N5ga4+ZUf8+3s6rT/jYZLmz5AfnWtxBIEhlSzbz+jGZxzn/kg5Nz7kFj4SbPlfa2Po
         0OBQ==
X-Gm-Message-State: APjAAAWGJeBOFXn2Rll/o5xRwumCVz1SNhuq8CYqn1yGwQbBt5n1ZlB5
        CpoAYiFYv9GRRQE1wb9DO8s=
X-Google-Smtp-Source: APXvYqzC/4M2RmVXvrozcW9AqV6YLAZ5Sm2sZ81eoRFMQbw4oAsklppmlCLjM2sYhGOzgXToo4FH+g==
X-Received: by 2002:a17:906:3db1:: with SMTP id y17mr6198804ejh.90.1551523291300;
        Sat, 02 Mar 2019 02:41:31 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm247711edz.58.2019.03.02.02.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 02:41:30 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes
Date:   Sat,  2 Mar 2019 11:41:15 +0100
Message-Id: <20190302104116.1535-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190302104116.1535-1-jbx6244@gmail.com>
References: <20190302104116.1535-1-jbx6244@gmail.com>
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

