Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AA7C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D222084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg3kCUrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfFNHqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:46:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38542 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:46:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id a186so916265pfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tbbGEv4x1CahB7ZQlkzlL+YIAqtJwnEeeWd2qin2uQ=;
        b=Rg3kCUrIv9jP4E3Wtg/dMoXR2W1io0SYwkKQBvpanMUTfGuq7dxji19gaBBejmhEgK
         nuOGR87LsFRMxIgrLL7mMamVDZP+gpHd1xmCOFTRISMaDXQBxF44PnVhvLKSYymjuuoH
         P907xdbeecTJ+wVjLN2JmMT5TG3aGUI2pLDbxJrr3ElCJC5/0vgBCXyOG7KMeY+HxILT
         yrsUbMq+/ribD56GjK0bJjEC+AvcpW6pcgZtlbSnMO/yg6ELe8lVXCb1na3C6VvOKhXq
         DsN9WrwE2ix0mejv6O5hMI7Kwp+o2zQTQTthwO8YGB5ARp6FuCpU+DnQPYLK9QBSfpdh
         oSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tbbGEv4x1CahB7ZQlkzlL+YIAqtJwnEeeWd2qin2uQ=;
        b=Ecr5wVY421B5gegkCEzPPVQRZR0JIPtGYIhvELhptSfaCKiLi4TukPHW1qsGM8hw8A
         MjUpS/oQd6Ccki7e6V+78cBGmZ3oVhe0irsz/X3SDra/KA0rdOdIbxXIHKQtrP26TMlA
         6qQW0F1vxey4Da1k0ZiKnx6qOaCFemw0j1tXqbXRDWchEKsfbwm6hqVRC8ouQhGZ+EwC
         SFu0j22fhArF2dkjvCRHXLlSQmYQLulMTYlZUeZcf1dmkSFuiemP16TmGTS/d7f/eVRY
         6atd25m4TK12WrAhOT5puCXIUpUYbySdm6utjgwLbQyp+asajqupIk++fN3iYbVl9/1X
         kDuA==
X-Gm-Message-State: APjAAAV0pOrBPfSdebsEW97xSHaLvFf4Q9N6hZmnlUhYptYAc+1PxRhe
        wz4SP9v+nWxyg4U9PMWw/VE=
X-Google-Smtp-Source: APXvYqyAK0GiKVcKQOfn7IYbgFctVcr39CHQwfSj7KLFUhTi+qMZK1wvt29jGNP8jCo7yX8Glcvi2A==
X-Received: by 2002:a63:2159:: with SMTP id s25mr32504026pgm.234.1560498365578;
        Fri, 14 Jun 2019 00:46:05 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id b17sm2128349pfb.18.2019.06.14.00.46.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 00:46:04 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx7d-zii-rpu2: Fix incorrrect 'stdout-path'
Date:   Fri, 14 Jun 2019 00:43:47 -0700
Message-Id: <20190614074348.17210-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPU2 uses UART2 as a serial console and UART1 is not used at all. Fix
incorrrectly specified 'stdout-path' to reflect that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx7d-zii-rpu2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-zii-rpu2.dts b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
index 3e467a94e8a6..6b8b2fc307d8 100644
--- a/arch/arm/boot/dts/imx7d-zii-rpu2.dts
+++ b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
@@ -16,7 +16,7 @@
 	compatible = "zii,imx7d-rpu2", "fsl,imx7d";
 
 	chosen {
-		stdout-path = &uart1;
+		stdout-path = &uart2;
 	};
 
 	cs2000_ref: oscillator {
-- 
2.21.0

