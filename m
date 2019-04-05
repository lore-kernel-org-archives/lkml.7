Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7894FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466BF218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1ZsIldM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfDEMVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:21:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55658 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDEMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:21:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so6424729wmf.5;
        Fri, 05 Apr 2019 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oy9YhvfUPRMYIBS/a2j0RiN4RT+0mQKFaTFf9z0FhJU=;
        b=C1ZsIldMMXm51Mw9MCSUocnqPHdkUzBhMi45J/ec7FjUR2QoTte+nSpih5V9GAQ9Xf
         8iB5nogZF5qFPwCG3nHCzMdc3189kAlQLCXUIktBMMPV/BMrWbXsKfYB8L3qFcPMuJAA
         Z5LbS92K8nYRoGN2b6YZTgslLcFODLO5X2+SkpWSNe4JSVMR2jQUrnx2XfIwUU1vKb8U
         60ZHesPAQLSHw2UQvjXZtCVQFyCkZlzzRocqXWAAOHKANNPAPGbT2ok+HAMCDAWF/fkq
         13kgPfCjh0rVfR+QbJcwrI8Ctg6uAaRlOTXY9NkJZ7iBxOR/9zRNPUcjnvJv1XS4farQ
         0YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oy9YhvfUPRMYIBS/a2j0RiN4RT+0mQKFaTFf9z0FhJU=;
        b=FyF84WzsHhXV95VVSzMFdh9G7LgJbxCG7mNhLrIZZb7/fujS5xpOrRmKZd65X+fQQW
         7qaEGX/nTIklZntB3Z/pVMBZm5A1+4YAnhqmTrd5UbWwdORirOYS27I3rATHYPyC0xW/
         2cV1+nZqtBsEr/xJdPqlYlAqg0kUB+7E/XOWYBWdfSf+8MBC0LPkKTYJwMDNmvrWsDXN
         PxnzagtR/RuQ7qAgztBONlF+dmJQ50cHSaalK4ZOb4VppWzcckHwCphB8IrYvHOxZdE8
         PzRnGUs2fESfC27ucNgaducRPzzD9iKdTrz0A594TsVKs2FjPqjtFEhLZxyBb5iXXUkj
         2vnA==
X-Gm-Message-State: APjAAAWcIZUtG3SJlcKGQPOa/FsZq7AXh3YDt7HDH/sXjIU4Q1aBosHI
        1Tl/Lr3yqXjwhNXSWPwBBDk=
X-Google-Smtp-Source: APXvYqzLeDz3H8pUFYlu5UUH7++wtSuKxj44ZtW7yhkWEFU3vE9q5oVlACHD8ewUY3kV4j5IXsfCLQ==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr1888219wmg.26.1554466891838;
        Fri, 05 Apr 2019 05:21:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id d14sm34454123wro.79.2019.04.05.05.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 05:21:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/5] arm64: dts: allwinner: h6: pine64: Add PIO regulators
Date:   Fri,  5 Apr 2019 14:24:43 +0200
Message-Id: <20190405122446.2101-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405122446.2101-1-peron.clem@gmail.com>
References: <20190405122446.2101-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PIO regulators for Pine64 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index bdb8470fc8dc..8b0b7675a53c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -131,6 +131,12 @@
 	status = "okay";
 };
 
+&pio {
+	vcc-pc-supply = <&reg_bldo2>;
+	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_bldo2>;
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -251,6 +257,11 @@
 	};
 };
 
+&r_pio {
+	vcc-pl-supply = <&reg_aldo1>;
+	vcc-pm-supply = <&reg_bldo2>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

