Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6972C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F9D206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tgMGgJOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfKQPmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 10:42:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43089 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfKQPmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 10:42:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so16497059wra.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 07:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuPdkD+bA6TdlVYEYwcSYUb/qJnSTJSjAX8JE2sMeo4=;
        b=tgMGgJOtQE+mEiiOcUVXvNbmQaY6jSK6K+gLWNv3g0aJh2uGuY6KNVo3xh54y4B6Ao
         hHPR5ChkhhIw8st2wRQP4I8oxkpzMLXqoY9uNJt0TR3na1qZEzvOty1dhk370e7XU7dM
         4Kxxr/enmLxhFYRIQJZJTfkh/bmtcX98IgrNyvdK8wwaK6uYK23P4gYZ1QzaxpndFhIa
         whz+ND4w33yD6XDjt9k3gf5GCLNt7OLnZCR/cZ/uOq8hORpEXvHNRGreVZXKGCVK8A7/
         7NdRN0zR8Uss36z5XuFl6PV+ifg/ZNhweaxuFuLhapj5OoRBgIM2sGDrk9mhZ9sn1aU4
         46yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuPdkD+bA6TdlVYEYwcSYUb/qJnSTJSjAX8JE2sMeo4=;
        b=TBSVkkxfTeI0OEg60lM8FxBazA9NrD76mypjwGVwUlG1VYTsGWrijy2IuAhw2n3/Dw
         weDxQ3f0BH7kzCmRJlsBjDZ5gTkKT0zPdXoiVGmFbRRzMdvqANdeJCXfvqzzKrOZwaIY
         Q7Kbz4EX7QzNsRT2aSs8+eLIO0CxNRsNyDs6P2tMtoKFlPd6Ayl6oPjwBJ5XSDOYIWPB
         cT9zGiwba+5oHpZg1dK+cvQk7gm1YCQFeQjpvrPY4RDZplu0+zsOEYnSMDwpzIgOkUjz
         Gz1DRb88C/SL67cWZEugtVtRKX58lfMb8ev+BbioO8HX/2hy4//cSapMY8D483DFQ8tP
         BB8w==
X-Gm-Message-State: APjAAAXT0AvAW2sXjcQGe+FQMqihskKAwZ/p41uTn7bIZ83CGuFsOqXL
        U/Ps+zoZjTU3xdWHOQxqJF0=
X-Google-Smtp-Source: APXvYqyDuA85QWhD1P8GZoP2+7bU7wdR6s1KBQH7peM7qT6waPkCdSQCaBE77pCEEu5nueoTdgN+QQ==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr16626325wrw.357.1574005321095;
        Sun, 17 Nov 2019 07:42:01 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 13sm13008097wmk.1.2019.11.17.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 07:42:00 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] ARM: dts: meson8: fix the size of the PMU registers
Date:   Sun, 17 Nov 2019 16:41:54 +0100
Message-Id: <20191117154154.170960-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU registers are at least 0x18 bytes wide. Meson8b already uses a
size of 0x18. The structure of the PMU registers on Meson8 and Meson8b
is similar but not identical.

Meson8 and Meson8b have the following registers in common (starting at
AOBUS + 0xe0):
  #define AO_RTI_PWR_A9_CNTL0 0xe0 (0x38 << 2)
  #define AO_RTI_PWR_A9_CNTL1 0xe4 (0x39 << 2)
  #define AO_RTI_GEN_PWR_SLEEP0 0xe8 (0x3a << 2)
  #define AO_RTI_GEN_PWR_ISO0 0x4c (0x3b << 2)

Meson8b additionally has these three registers:
  #define AO_RTI_GEN_PWR_ACK0 0xf0 (0x3c << 2)
  #define AO_RTI_PWR_A9_MEM_PD0 0xf4 (0x3d << 2)
  #define AO_RTI_PWR_A9_MEM_PD1 0xf8 (0x3e << 2)

Thus we can assume that the register size of the PMU IP blocks is
identical on both SoCs (and Meson8 just contains some reserved registers
in that area) because the CEC registers start right after the PMU
(AO_RTI_*) registers at AOBUS + 0x100 (0x40 << 2).

The upcoming power domain driver will need to read and write the
AO_RTI_GEN_PWR_SLEEP0 and AO_RTI_GEN_PWR_ISO0 registers, so the updated
size is needed for that driver to work.

Fixes: 4a5a27116b447d ("ARM: dts: meson8: add support for booting the secondary CPU cores")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 5a7e3e5caebe..3c534cd50ee3 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -253,7 +253,7 @@
 &aobus {
 	pmu: pmu@e0 {
 		compatible = "amlogic,meson8-pmu", "syscon";
-		reg = <0xe0 0x8>;
+		reg = <0xe0 0x18>;
 	};
 
 	pinctrl_aobus: pinctrl@84 {
-- 
2.24.0

