Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F36206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsFYDaWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfHXA1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:27:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37480 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfHXA1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:27:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so7207789pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP1f8HZAKr0tzKIISPkmMNb7FYisHg4ALq7z2Nj4r3U=;
        b=bsFYDaWn5ODG2D4KejL85Am/pCDbwuA16m/seUKTZdnhwDzhgFoICV4vTYihcI5XHV
         4B/93/ZTjr3xZYLg7f9nmnHO2TfZFR11NG/bhJ9nt1RbGqVFwp6TfjfzsCMKLnxYV9VB
         Ymahtvefc3UO6y7EmHjW0meIOHtwYp36U3RVErGLG6l7+bsaK0pgATneQgICMX5H233X
         48ECLzKEphuzi6kh8qoKaN1dj42npRrZMBx1XJgYGEKFE0HkXJ8Zso8/AM5Nuos1Nove
         9dNd7XHJWBwolzzLr49ymBEBax52Jh0s03tQYpzhgcRhjZ1/CSkzh1BmrgZqZaNjMD57
         12og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP1f8HZAKr0tzKIISPkmMNb7FYisHg4ALq7z2Nj4r3U=;
        b=Pwd1s4Tlez0/gwQQ00ECJF73opz8RTCpmF1bIj7Zkah5qkvZiPj5T4/Wy+Bp5oohDC
         1U1fJuaODirOeOM72ICHtaD2cxW0AK5osU9YdMlKbJQcmm3ZkGC4U97UGyivh2xUJ9er
         byPd+GZtE27QdBAhMcnUy7WI6HV36H1s/TeV/h5XrxwSQqT7Oeh9Cc1GhZoHt5wXuG2A
         Oa3G/El8OdwS1IuoemKFWI4aS0thQPA/VgxBQLTnLl5jgWBXCB12otTiR8GwCYmbNKVt
         vVpF8teuCq7g74DqnMxvaavvdUjgrIHHZpEhBMbv5/fWzvHNOX+F8qAa5aZ9xeMoyxfN
         Q9zg==
X-Gm-Message-State: APjAAAWe1deIoSyFOCn4+G2mb4IsuOxi/ZKBlP+DrBLzBxFy/iHQv3By
        uK6GB0aXQks5tm8MIVPCtcU=
X-Google-Smtp-Source: APXvYqwv66UnDIdIf+qUtP0SrN5iezU05RBtgXdSLuMxGX4NzBEJM3XILGRnczj34lPR6qqYumEFqw==
X-Received: by 2002:a65:6458:: with SMTP id s24mr6185430pgv.158.1566606442055;
        Fri, 23 Aug 2019 17:27:22 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id j15sm3681399pfr.146.2019.08.23.17.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 17:27:21 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-scu4-aib: Configure IRQ line for GPIO expander
Date:   Fri, 23 Aug 2019 17:27:03 -0700
Message-Id: <20190824002703.13902-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure IRQ line for SX1503 GPIO expander. We already have
appropriate pinmux entry and all that is missing is "interrupt-parent"
and "interrupts" properties. Add them.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index e6c3621079e0..45a978defbdc 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -570,6 +570,8 @@
 		#gpio-cells = <2>;
 		reg = <0x20>;
 		gpio-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
 	};
 
 	lm75@4e {
-- 
2.21.0

