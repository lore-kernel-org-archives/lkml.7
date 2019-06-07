Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3643C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9472D212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osOOwQ7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfFGXL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:11:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33741 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbfFGXLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:11:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so3667791wru.0;
        Fri, 07 Jun 2019 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnmvhZZD8Mx24yTeSpnfmQh3x3T3CVtR6CE0dBfbLB8=;
        b=osOOwQ7kOJIxH7q1sP4SW46/2REatRj3dNel59nhnfmBYPb1CshTkAlqHnkQ/SlTha
         3/jxPR3F1XDxNMResp+TI2Cw2Uz9+2hVrJjhM5I3ccY21BMxWVIH09kfNmOHIOJmG8Z1
         ezIRLYjPhHsvkgm2+Of8ouKxGgY0ijFLk5uV3QewuxYLFJJRVimG9hcU6fJIqKCvxK73
         /4p0wbCf9XBZvz/9a5z4GINxx1s4mJvWQCUYpjwJc1OwuioSjrz/BSzJo/JnakMaC0ij
         TuIooNATlmyuU023PqcumCx+ct6OltX06coqN7ikDiPLyFqqldSMWz/UP080zco7VUxd
         bu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnmvhZZD8Mx24yTeSpnfmQh3x3T3CVtR6CE0dBfbLB8=;
        b=KZcrSMw/IarvKTTBggDLRJtztOcTQmRYNapmi1RacLSl4Dx6vRe+8fPSkpJ59W7MRq
         WTlhbp7KOjhTIlmrC3FVqeY3WuT9uUaSrmd1dEjBT6O4lYBkLG+ROZKIaKfQ8IyOwcBQ
         zRzOrw2rKyKyw/ReCUHM0mY4PZY0ZVglpCA+fWO7lg0WLP/loHJD1ckRvXtfu82NDq66
         g5KT8ZbkUI2jEDKdH+Vtwu1+lvOHjQ8gqMTVO8MGH3Q22tkWMThr2G45ztV1G154e+TQ
         6bHanx+jSLuFQH4914DHjZjbEGlCrZ2HtZtWt3Q6Td5jLi6uKrVlM/irJV4e61KTD1Dv
         NaVA==
X-Gm-Message-State: APjAAAVvN2+LNla3U9VGFNk6PSjd7asRaxuhPEkF/739/HnOJ2R2vsSW
        9i8FRbkGFI8Ug0VkSBqijzE=
X-Google-Smtp-Source: APXvYqxzvMi2E7q37ryIRkiVEGGK3LUQy/2+KYp1m6auhNzADjBso1u1JR0r+SFNXqWeSF4b4WrWYQ==
X-Received: by 2002:adf:fe4e:: with SMTP id m14mr12060521wrs.21.1559949075256;
        Fri, 07 Jun 2019 16:11:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id h84sm4108559wmf.43.2019.06.07.16.11.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 16:11:14 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Sean Young <sean@mess.org>
Subject: [PATCH v5 06/13] ARM: dts: sunxi: Prefer A31 bindings for IR
Date:   Sat,  8 Jun 2019 01:10:53 +0200
Message-Id: <20190607231100.5894-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607231100.5894-1-peron.clem@gmail.com>
References: <20190607231100.5894-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since A31, memory mapping of the IR driver has changed.

Prefer the A31 bindings instead of A13.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Sean Young <sean@mess.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 84977d4eb97a..f0f5ba349c1b 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -822,7 +822,7 @@
 		};
 
 		ir: ir@1f02000 {
-			compatible = "allwinner,sun5i-a13-ir";
+			compatible = "allwinner,sun6i-a31-ir";
 			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
-- 
2.20.1

