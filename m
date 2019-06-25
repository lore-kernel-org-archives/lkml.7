Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78812C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51754204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N1Z3E600"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfFYQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:49:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54486 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFYQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:49:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so3549119wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFyZxw/PmmATYVOt4ZawM+qBj1/OEyzSJ/6Kyab2jWE=;
        b=N1Z3E600oJOwtEVH3C1Eo5uAwAxEnzzAlWIlPjtyUPZP6XvGIql/osbEXGEgp1Nx4k
         5sx/CxtAV7ql0CA8vLWy1cCSBLB0GDejFOFTdwI6VHwsJ+ebvt/OChHqNr2vng16MV8+
         P1XT7VOaDKQGk8PWEYAm9PcxBv7ZLAYS8LOTLPNkARiMaS6BYl5+32TquD7KccbgzNoh
         6Xv/7LN91jpzEiUMDcjdRlBZk/4p2NS4520oZDiZUshAYBXorKE3nHq2KrFM18Blv4fK
         jWdW2JO/QmrB81rMoagEqGrcJy1a9lJM/6JTAfsj2CG9JaaQ0lvl1uym9UNBF9zWzJn6
         nIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFyZxw/PmmATYVOt4ZawM+qBj1/OEyzSJ/6Kyab2jWE=;
        b=m1xIS++oRYoMZFMXfJGJmk8eXYTtPoqPJTS5YQDQGZJAebudhj+skCuMY0GCv+cBQ+
         RKwYscWqopmxT3+YTbUfnmagUOVLhQNT4hFGJTqx0DEhM2nIHFvssBLvGZncw7X7Un+Y
         3DZSq0KFmyyUj28Di3AEJGZOkb4uQlQQV3cAD1Fe5MVELp2k6Npctdw/muICI/J16A5F
         L/LSRCcdz/xaE7kf8D6cK7NYbd0+Pso4CTAbaIKSHHvIwdcrp47VXkQE4RslQc8SHapo
         rSAYDcpopG0H2LLsPvJTBEIwtnoJnJ10stx0PMjYUfvIGKOeDze9Ua1q4ihSRo0C6WhK
         Kz1w==
X-Gm-Message-State: APjAAAWk2supZq9Doq/LcVYhHqdG+VYWTMclEpQxIAWwqKfmBiV/LiXz
        tDKDWG6xdIyMuX53XwNTdOCpBQ==
X-Google-Smtp-Source: APXvYqysaCd7pSOBC7N6A5J56tC0N0gGA43Mb7o4V/1MzqrHjgghtqMRBQ2q8szPaZ6cVG0tv4Dq8A==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr21157208wmk.46.1561481362319;
        Tue, 25 Jun 2019 09:49:22 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h14sm3078652wro.30.2019.06.25.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:49:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] ARM: davinci: da830-evm: add missing regulator constraints for OHCI
Date:   Tue, 25 Jun 2019 18:49:14 +0200
Message-Id: <20190625164915.30242-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need to enable status changes for the fixed power supply for the USB
controller.

Fixes: 274e4c336192 ("ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index aba10a2bc6b9..a273ab25c668 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -61,6 +61,9 @@ static struct regulator_consumer_supply da830_evm_usb_supplies[] = {
 static struct regulator_init_data da830_evm_usb_vbus_data = {
 	.consumer_supplies	= da830_evm_usb_supplies,
 	.num_consumer_supplies	= ARRAY_SIZE(da830_evm_usb_supplies),
+	.constraints    = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
 };
 
 static struct fixed_voltage_config da830_evm_usb_vbus = {
-- 
2.21.0

