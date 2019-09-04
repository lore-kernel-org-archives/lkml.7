Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3336CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6322CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="tj/g9gwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfIDIRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:17:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36775 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfIDIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:17:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so20194073wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/jBzTQPRmv+yMs8YDs43WjpjETT8qVnCVE9fxuGlNdg=;
        b=tj/g9gwZd6CqG3KnjOJKSlCQgA4W51FVP0Di1h5flTJVDxc2WCBykTr2JSheute+tj
         pGi7zpS0IaQw57Ev+oFws0GOhBDFeHqzEbvA+Q6HynGNWnaISVVHQVrj+mJXS9ZSEBVu
         LUwhVWJ0y0XoN2HtIv9y80Hh2amjX33O+CUG5VxR23d1SYl/b2dsireJ6LapMY9vN1ve
         cSHIh1YBx0WB7QTRJSHr9eAxcA7YIkaUye2nFkhRBKJ3mo0OiD+G2+MWQk75VtXidJrV
         ADEwVgi2cEpSMQ+qAZWsoJvHzuocvt7wpC+uxelJcm/s9NecFDOumE9aJslvZ/3qawoB
         WT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/jBzTQPRmv+yMs8YDs43WjpjETT8qVnCVE9fxuGlNdg=;
        b=WcaDDSV5GiDGkq3QGxI2oj9OdlLZFBSiSL9qiUHTOychAJGcym01fjvHmld/UMWU+4
         z4UR8og/KEGqmdn9yCaz7DWe+F+asM/+rJE/2RN1EiA0QxfPmQalUW8k3mvURbMvDJdr
         TVr0zwiX4spEXdRwPArMOCuPOz4Q5I730OgZ0TBhAPLYAnGfYSI4biXoNnJ138qt4xbC
         hKeGdA4F39rmhnFoTiSc3QJncLelbyMnYvgSgJgjiWXrMMLh3Nac5K0V2nVcLJLUC3tk
         g8Lgl6p7FiqIOHYKuoK5EIzFZ9Dpr646y1o1xPeC2OzQmwUBVXmqlYoryobkTaaz8vzT
         SVQg==
X-Gm-Message-State: APjAAAUc/gNiREQ6TNJcMvviGDQXJMMwvFdRcDfoYlGUdJMblsIhF29N
        8yUgqhcum0vaWXFp0XD1eiZzUYdoFwRiRg==
X-Google-Smtp-Source: APXvYqzsU8GlIkziGEdTBIJWV/nZekrNZ7MA/Nbj2q2qo+wZGDruJFzl8KaYzxPtoqWK1BKpcmom8A==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr16484061wrx.117.1567585052056;
        Wed, 04 Sep 2019 01:17:32 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w1sm24302623wrm.38.2019.09.04.01.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 01:17:31 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] microblaze: Enable Xilinx AXI emac driver by default
Date:   Wed,  4 Sep 2019 10:17:27 +0200
Message-Id: <5c4fa0dabdc51b3f697491d1fc7f3669468fcb33.1567585044.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Xilinx AXI emac ethernet driver for Microblaze.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/configs/mmu_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 000da33365c4..43ede33da900 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -45,6 +45,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
 CONFIG_XILINX_EMACLITE=y
+CONFIG_XILINX_AXI_EMAC=y
 CONFIG_XILINX_LL_TEMAC=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
-- 
2.17.1

