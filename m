Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B69C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C422E21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPOJjaoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbfGST34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:29:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46625 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfGST34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:29:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so35418222edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wppe19Sbg/LaJHpxWMdO2Cb51TOC5T5tbB13DPqYbts=;
        b=mPOJjaoZ8B7DFK7HNdHEH/Bw5fbLR+1KxuWp2BA2vv0HUD0YEGHXoJQZY54jVODQw/
         YhRra+7xWLba9fuM14ry76BA+ljUlOoSb8yMuT3Zapv1d0u93v78SjdnwI9r3d3a07tV
         H0LkhC2VK1+ucQxDxv6V4FCWtg1vCeBif9OM9er0VolH4LBtVGtnTa6qTSpawVCmKDJp
         5W6pYxqYICLJOnHyxeBVwwYZxRACZO4Vv9g0vodIIMB0GU80X33yAoQLW2fit2LfmC7f
         Y7o1ITm1lmWFOOt3TO4rhQXPRp5kJWNBewVwnUxPLY2DVVFL3LmUybZUqSdYCAnPhBYJ
         7tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wppe19Sbg/LaJHpxWMdO2Cb51TOC5T5tbB13DPqYbts=;
        b=E7icubAz3y8NQ69n/fl3rpWaenHsZisd3HlaGTzRPZz7bNJwjZm+au0zoYCQ9N2wBM
         DqM3aBcvQG9vos8qMU+zgfNPWvl8EtrAFPlTdNcMHgCgy4F0iPrDYIbEvuaxXlMG04yh
         +AOP+n+ia+VQhpf5gnrmnC/vRNpY8IWAls1TvjRQl+xtNh6LESTmey7NsvXp+r+XD2rr
         nB3VrndaGYxGNn33eeHaS4XZr6vuEnv2BZxrXpzC7eDnluO9XS9hWYpeONeQaao5IRIy
         m+fKDpWGtEyepxi6cmuwNZ/VjCnCvzx2umtbIQlDaQ1Xc4Nq9f2OqKPpNRhbuIidwOkM
         Di3A==
X-Gm-Message-State: APjAAAUacDJxjQuaA2BIdEk7+Uh1TNYGHDsG/wilkQbkr+sscOkLTWu7
        mS44Kmp9oz570mbsRfCbNTs=
X-Google-Smtp-Source: APXvYqzYGfoa+2Rs+xxkevrhYuAWHQ7Z7bZb+FBxde/d70WtXAkvJgTnGcsuMrHKhgpC4pYgls3CMg==
X-Received: by 2002:a50:84e2:: with SMTP id 89mr48449082edq.218.1563564594936;
        Fri, 19 Jul 2019 12:29:54 -0700 (PDT)
Received: from archon.lan (adsl-89-217-88-77.adslplus.ch. [89.217.88.77])
        by smtp.gmail.com with ESMTPSA id d4sm8738624edb.4.2019.07.19.12.29.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 12:29:54 -0700 (PDT)
From:   Xavier Ruppen <xruppen@gmail.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, narmstrong@baylibre.com,
        martin.blumenstingl@googlemail.com,
        Xavier Ruppen <xruppen@gmail.com>
Subject: [PATCH] arm64: dts: meson: odroid-n2: keep SD card regulator always on
Date:   Fri, 19 Jul 2019 21:29:54 +0200
Message-Id: <20190719192954.26481-1-xruppen@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When powering off the Odroid N2, the tflash_vdd regulator is
automatically turned off by the kernel. This is a problem
when issuing the "reboot" command while using an SD card.
The boot ROM does not power this regulator back on, blocking
the reboot process at the boot ROM stage, preventing the
SD card from being detected.

Adding the "regulator-always-on" property fixes the problem.

Signed-off-by: Xavier Ruppen <xruppen@gmail.com>
---

Here is what the boot ROM output looks like without this patch:

    [root@alarm ~]# reboot 
    [...]
    [   24.275860] shutdown[1]: All loop devices detached.
    [   24.278864] shutdown[1]: Detaching DM devices.
    [   24.287105] kvm: exiting hardware virtualization
    [   24.318776] reboot: Restarting system
    bl31 reboot reason: 0xd
    bl31 reboot reason: 0x0
    system cmd  1.
    G12B:BL:6e7c85:7898ac;FEAT:E0F83180:2000;POC:F;RCY:0;
    EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;EMMC:800;
    NAND:81;SD?:0;SD:400;USB:8;LOOP:2;EMMC:800;NAND:81;
    SD?:0;SD:400;USB:8;LOOP:3; [...]

Other people can be seen having this problem on the odroid
forum [1].

The cause of the problem was found by Martin Blumenstingl
on #linux-amlogic. We may want to add his Suggested-by tag
if he agrees.

[1] https://forum.odroid.com/viewtopic.php?f=176&t=33993

 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 81780ffcc7f0..4e916e1f71f7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -53,6 +53,7 @@
 
 		gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		regulator-always-on;
 	};
 
 	tf_io: gpio-regulator-tf_io {
-- 
2.21.0

