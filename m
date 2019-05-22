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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B07C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE4021841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPJlhy/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfEVHM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:12:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34097 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbfEVHM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:12:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so847455pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQs+0i84pw32rGcM7hvqjpNGJYFx6bkuatJbHxi/we8=;
        b=VPJlhy/0g2QHWzJMwTZkoWaXU2Oo0s2BJqURItqmTQajs1JguAA3zJqC0CLdiu5M5c
         FH8IOY+1EPVIchTYgPVi8IWBOdGBdlzVlDASKawdUEgCOO1MxDc0OqmiwAoVzAEyNLyA
         QNRvJJ/sXQTGE/PFZ/jovq6FnY2dL7KK+ewnyNUbBTMipbpxk3NiBNuADjMQHDLMh4o1
         hm05nHE9BwdKSGZo76nz4dGFIX0FJAqac+GDz31r6NZC8oyPyM1TRdSJPd2Z7gYh0BDK
         rg1iCNq3qr1qSOaGfYsyRZFjUFKg16x5pTbZSiioO9KbTfbFLLxcGcczg8RmVz/E3krO
         ndsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQs+0i84pw32rGcM7hvqjpNGJYFx6bkuatJbHxi/we8=;
        b=rYoyIdN4O6aB6B9T2L/TzQSK/7tggUjZUEzhk/51hknahYzGDLkWpuTWX/usvH9Zsg
         5/jM1kO+QdtFENwXYCweJQFa60ZRFy1jo95Y/EHCCbVLy6GSukJIEtoZx6t1nb0E3iZP
         k3db27dbAElHlJdw48rSxFG9LattfhebNI5rKIm4TlTdvTFrNYnEGxOgXqbJraP5xJkO
         esHvpdMT3VEWdBDEeG/RjG1Eame5WVg45KbEX+3BBQqOq98W1BDwdpL1OacSV+AekNXA
         jcr1JDDruEyREeq0ylaDOBcm08vurqw+ifu2quGkqNfUllVAachA3ooQKfTke5q9AaRi
         Qgrw==
X-Gm-Message-State: APjAAAV0qYQagYiHeTG/H2wUHS7TwD0bvyQQxngcPTYy7sT1Gh/CFhWo
        mA3PEgSFJjW+wqf/xU2uHtA=
X-Google-Smtp-Source: APXvYqwz8IRj6dtEjxFKUrWwRwuFhKRAdwN1MtUxoiTpJk373zi+9HhAe7iQqG8NOKeSWZK7AdM/1A==
X-Received: by 2002:aa7:9159:: with SMTP id 25mr62981247pfi.64.1558509175505;
        Wed, 22 May 2019 00:12:55 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id n127sm22750178pga.57.2019.05.22.00.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 00:12:54 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
Date:   Wed, 22 May 2019 00:12:27 -0700
Message-Id: <20190522071227.31488-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522071227.31488-1-andrew.smirnov@gmail.com>
References: <20190522071227.31488-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cabling used to connect devices to USBH1 on RDU2 does not meet USB
spec cable quality and cable length requirements to operate at High
Speed, so limit the port to Full Speed only.

Reported-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 5484e4b87975..3b37fe68d373 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -772,6 +772,7 @@
 &usbh1 {
 	vbus-supply = <&reg_5p0v_main>;
 	disable-over-current;
+	maximum-speed = "full-speed";
 	status = "okay";
 };
 
-- 
2.21.0

