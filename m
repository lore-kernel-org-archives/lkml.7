Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E6C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAF121479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJ7HVrCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfEVHVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:21:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38697 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfEVHVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:21:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so859222pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjT5+TUdogD5IbDyotKdyR3j6dKa+aLy3uq/scgE75Q=;
        b=sJ7HVrCKpqUVy4tE5MK5M7kmRgJyS3uV4/2c4WG3VbWVVwdET1TrqFO14fp+jBDnKu
         lkZpiQp0cxoqaS1ZtxFITz4LC0sFTFx3uRspGF/89LWN6MCz6TEvUUcEkoO0n8VW6uQs
         ILeJs84C1vp3kDlp/wBj974ewbUOjIZUfYSGZ62D3DZcWzqBDHH8jQXq6Sx1DVNPNIAZ
         r+XYJTL2qSXcCHhdlz/72jqrhnQLqNpHUEOtKO0Q4reWBRo03Tp+pyg3p+irZnkZhonL
         J4PLxoYR5Psod0NX56u1/qqICInHVs9wkZeQZprJv8R8dmXjigr1/dSV/DuRK7wIRM1e
         5BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjT5+TUdogD5IbDyotKdyR3j6dKa+aLy3uq/scgE75Q=;
        b=nK3gDmwcxbz/0QOxINbczbv28OjwqvPqRuNZ5V7b4j5rnlnvCeYyAAImCw+yvmNBoo
         hmI4cVRKfSyaJNuZagHRa6k/dW9Nk3kryJS5D3qH9trLWJ8LNC0zGncvaHPYWfidGkG9
         k7waD3/I43hYnDfzDkKrXI43UkfmBxjknTWoizpOClwz0GvLP12CM0Oq4wLkykA8AhGd
         KFhAlSNEAROv4yHJB7nodg5gkfi4AgT+LudQPUXOyjwXV6O0iNBrW7Px+IbPv0afC5VO
         +MIb0qKBzSRYINR7gNi2Eb4lEllJtEavMy3j19EyP3VWhSqCW+TWZbl8TjMYG6fvcq4Z
         Rijw==
X-Gm-Message-State: APjAAAU3Jso8VEdRoowHQaslto5+Yuz1EH1UdcO12wZxsdEv9iCsAOjq
        wh8ppNrq+Z/el3D4NCAHaJ0=
X-Google-Smtp-Source: APXvYqwpQYU0P0CAK6rkHMIR4e2vM1N9mIn2qJDItVQ3VqzMdCxPS2KcXGK2Smf7CiVy9/eGetZjUA==
X-Received: by 2002:aa7:8493:: with SMTP id u19mr93929323pfn.233.1558509672245;
        Wed, 22 May 2019 00:21:12 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t5sm25307204pgn.80.2019.05.22.00.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 00:21:11 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: vf610-zii-dev: Fix incorrect UART2 pin assignment
Date:   Wed, 22 May 2019 00:20:51 -0700
Message-Id: <20190522072052.2829-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART2 is connected to PTD22/23, not PTD0/1. Fix corresponding pinmux
node.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-dev.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 0507e6dcbb21..1f2e65ae2bd6 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -385,8 +385,8 @@
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			VF610_PAD_PTD0__UART2_TX	0x21a2
-			VF610_PAD_PTD1__UART2_RX	0x21a1
+			VF610_PAD_PTD23__UART2_TX	0x21a2
+			VF610_PAD_PTD22__UART2_RX	0x21a1
 		>;
 	};
 
-- 
2.21.0

