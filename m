Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1CFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5872C206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML3d8Imo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbfDQRLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:11:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45976 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:11:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so14954642lfl.12;
        Wed, 17 Apr 2019 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tk0XOSSw05MiG22+00Z1NQTboAbIxMtqzCmVHHPusrU=;
        b=ML3d8Imo+KilAVrmrDE497knG1vQgIiODil+nja5KbID2giuq6s2ZkZxNxtwTVgOot
         dbXc3S7KLorQ3OcBJyn163j63HfTfCXpr5xA/x9sESM3VpEafbJI1+V4aKi09LKZfYyB
         kSMtRv0iq8H5h7zfal6SKReIqwpWa2tZq0/J1xWrl1a/c/hwMb2rZwpuU2+VzH7Gb2Nk
         L09ZMBXIuQMMB1vyHLyUa+M4kCOTeNPs/ntoVmU/FvSDas6Q1hZuyuaBCf3l6Cka8LSh
         k2BJY8hcN9iHFfwkRzjPwQ3jOAwYUhoikTDnjwhhz6bUWW2R8r5Mox8QfHVvRgfX9n4E
         +BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tk0XOSSw05MiG22+00Z1NQTboAbIxMtqzCmVHHPusrU=;
        b=SGZeHnmAkujvEnzXAPl5mwF/v8PmbaUPZ6EmijNINEYVLWIaAt0Ym0o7e+iibC7oEb
         WRCcb1hYOI9q61lb0cYL3I5N13tJ/tCpBdDoCThPZjpiAywFbxAUCkyv7H54KrZuKnYl
         yCSlCEo4Nf2hiCbSiVI/ErilE9QNH/A4YtaktyVbmmOPVhIr2+L+q4p6tGTw5iW/v3s3
         CSljnG0/driaFkgMpu2Mxy4EqXwm3R+95emBqkdq/9VKXhFdkSI7mCnU/4G7u2YTzP/z
         7eVRpzVXFF4S51xeFx7D5jj9mt2QZ01P8gn0H99WzQlpvZw9f70P8Oenf8DYao75gN2Q
         p1nA==
X-Gm-Message-State: APjAAAWCm9uoYeELFVyTGVE/F1mBN3fRpIpVRHfwH5QoRnDJ1MYpqOha
        w4xdQgN3oqwQ7qGbO2mzL9rT892Yrbs=
X-Google-Smtp-Source: APXvYqztGUp1kpU2LY6LEQirVXzdWub/ZcKoEhEXJzxkW6bfrJ5Zm5SvVBwbs7k3x3sJEppGzXWwPA==
X-Received: by 2002:ac2:598c:: with SMTP id w12mr13396798lfn.52.1555521057922;
        Wed, 17 Apr 2019 10:10:57 -0700 (PDT)
Received: from otyshchenko.kyiv.epam.com (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id 77sm6710842ljs.58.2019.04.17.10.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 10:10:57 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     julien.grall@arm.com, horms@verge.net.au, magnus.damm@gmail.com,
        linux@armlinux.org.uk,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH] ARM: mach-shmobile: Don't configure ARCH timer if PSCI is enabled
Date:   Wed, 17 Apr 2019 20:10:40 +0300
Message-Id: <1555521040-16706-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

If CONFIG_PSCI is enabled then most likely we are running on
PSCI-enabled U-Boot which, we assume, has already taken care of
configuring ARCH timer stuff before switching to non-secure mode.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

---
A bit of context here...

We are highly interested in Renesas "Stout" board support (r8a7790)
in Xen hypervisor. The reason is to have fully supported HW for
performing "OSSTEST" (Xen automatic test system) on ARM32.

To reach that target we need a "generic way" for the secondary CPU cores
bring up and switching them to non-secure hyp mode.
So, the PSCI as a generic well-known way to bring up CPUs, was chosen
for that purpose. 

You can find corresponding patches for U-Boot here:
http://u-boot.10912.n7.nabble.com/PATCH-0-3-PSCI-support-for-r8a7790-SoC-Lager-Stout-boards-td357352.html

You can find corresponding patches for Xen hypervisor here:
https://www.mail-archive.com/xen-devel@lists.xenproject.org/msg43332.html

To sumarize:
Together with enabling CONFIG_PSCI in shmobile_defconfig, current patch
is a minimal required change needed to run mainline Linux on top of
PSCI-enabled U-Boot.
There is no need to modify device tree. U-Boot will take care of inserting
proper "enable-method" strings in CPU nodes.

---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index eea60b2..bac4490 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -32,7 +32,7 @@ static const struct of_device_id cpg_matches[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static unsigned int __init get_extal_freq(void)
+static unsigned int __init __maybe_unused get_extal_freq(void)
 {
 	const struct of_device_id *match;
 	struct device_node *cpg, *extal;
@@ -60,6 +60,12 @@ static unsigned int __init get_extal_freq(void)
 
 void __init rcar_gen2_timer_init(void)
 {
+/*
+ * If CONFIG_PSCI is enabled then most likely we are running on PSCI-enabled
+ * U-Boot which, we assume, has already taken care of configuring ARCH timer
+ * stuff before switching to non-secure mode.
+ */
+#if !defined(CONFIG_ARM_PSCI)
 	void __iomem *base;
 	u32 freq;
 
@@ -101,6 +107,7 @@ void __init rcar_gen2_timer_init(void)
 	}
 
 	iounmap(base);
+#endif /* #if !defined(CONFIG_ARM_PSCI) */
 
 	of_clk_init(NULL);
 	timer_probe();
-- 
2.7.4

