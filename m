Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E20C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5259820842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDzDlCwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfHLKYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:24:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33766 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfHLKYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:24:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so10538649wme.0;
        Mon, 12 Aug 2019 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leQKXV9eObw1B0I49mhXBKbma5hQQg2ooGymI/Kposc=;
        b=CDzDlCwDugVO3v/5b5DZa4euPVcNJc9+CiNigfarnqreK8qsfVKswk1WRdXu1S4HZo
         jsWt1kG55brszkJUE3DAjbEB9dGdIMcSb/yglzZ7yDUxfVnKyQzKAeD8772Mp31MbX+3
         AqPLPA9wZjXXF4ncBlH8juJHHiBAh5jEpMFkjjX78kLepq9MvjCHfNsD9F9+/cmKNoOh
         gGBC458Z472HAf0lm/Ntntbrm1PoxEc+/rDPh07GQ6DMu543fDhn/9lVRQT2aPf57seW
         Tfb1FqEr1+q0S0PTC5Z/JrfjrHVyTOcN6Nt4R3/wrtS2frzs+ru4m7bumZZYfmD2StWL
         FWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leQKXV9eObw1B0I49mhXBKbma5hQQg2ooGymI/Kposc=;
        b=U5VkJmzxNl2ZI2w/lZVtxQGnZi3mmqVxrV90I0d3QneEjoW66a7PhLJOMpUOCCwI52
         k8YYuCoCFn8RGOINdgv1reNAHNsevquaZFmvhKyl8x32Qo7runcFBhhkWEmWNoxcq+7W
         E2yX69qnHECgSYdcUYNQDvXWK5BYluy/RKeQ6fjQEGHOJDxf84o0dtirszBJUqaG0rR4
         1rntJWi8xwi0nC8xWFcSEh4XtFfVw6osN0oA0AixZBI7/LmMT+JNQoRTdxNsJQuXQzr2
         AMDq4Rp1X3PX3alnHd66wk1+NaGflf3FqVCaO6fI6HOMrndlPgT714r5SqwQLAJt+90T
         hYaA==
X-Gm-Message-State: APjAAAVAprOw6oAsDCwzGABOgysQVBWcmoeXCCxXMfNyaR1/5/9TdK7U
        794Hv+u481d3QxN39EGK9iI=
X-Google-Smtp-Source: APXvYqz1jijw0uZP64vCh3InF/IsyZo5uqWc27iWdS7bwVEMvduY/stvempGP3w4sWKCNdvWlmT2XA==
X-Received: by 2002:a05:600c:28c:: with SMTP id 12mr8198240wmk.157.1565605447378;
        Mon, 12 Aug 2019 03:24:07 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f197sm14517240wme.22.2019.08.12.03.24.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:24:06 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: Enable DDC regulator for Beelink GS1
Date:   Mon, 12 Aug 2019 12:23:55 +0200
Message-Id: <20190812102355.22586-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 has a DDC I2C bus voltage shifter. This is actually missing
and video is limited to 1024x768 due to missing EDID information.

Add the DDC regulator in the device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 680dc29cb089..67d7f269c5da 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -25,6 +25,7 @@
 	connector {
 		compatible = "hdmi-connector";
 		type = "a";
+		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 
 		port {
 			hdmi_con_in: endpoint {
-- 
2.20.1

