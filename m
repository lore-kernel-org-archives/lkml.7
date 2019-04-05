Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89553C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5369F2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+3kTvoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfDEILb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:11:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:11:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so2658699pgs.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEA6p5JevwHNXaBrdUMxSWF58a6asPN8krCKpHrLb0c=;
        b=r+3kTvoYzn0O1if9OqvGksQTGdf8qEqBr8lXNxyqOnNmn3f+3zq8APRfdAi4uO5GQy
         TbIOvA9ZZB+eOT5KQaLK+Y1j27fTPApHiQP7brYNgoJ2tSb36ZnN54EawjRxOAXm8WE5
         fuH1Fhfiyz4KmxDa1Jyix+juNMJP5DqVv5Iwe6QlFyU8GTVX/e1CbsG0ZSooQzZXZOzs
         YurlxeNLDdsCm6G+0RUhMQDNyB7e1GHA8Ceo/NOj+cE2dFHuqbQdtkD2OBl1vDlSDVWt
         JUOmTH7xPHRk9PID0UdS1xBu0sIYvaJ0G9reQTbi3H+vIj/pwC8gll/Ht7cKEhopDL7h
         16Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=sEA6p5JevwHNXaBrdUMxSWF58a6asPN8krCKpHrLb0c=;
        b=ixQR4e7ej8wsfjjDyHCztFFBboTmWs0/EbU7NWs5QblvnYWulPr6fWfUOGuKhzn1Cw
         CnNd87M9t8WHzHMdqVVOStmOO9BbqS8dXWbG2jcvKxETV22VJ9H6Bj8mzSUDlUoqYngj
         0TEU1F7kKMTBWu86MgU3UFhIztG2BA66YvzYV6/v/rWwbVFHgQo6y1YRxoTv3p8gqD/R
         xatbrZO/Hu0nVbDE2GxeJiGdEzC2MZjDA6iewKdfDP6+yh4o8QPYtzWlROtI6uhzCsS0
         6dLIANVai5RhlMbYqUFyFHJvFr91tR3NFEXm7SIaSiiDT3JWDmXudP+aXpBe8LYWoLsQ
         qadw==
X-Gm-Message-State: APjAAAV88S5vjTxtQEVAI9BTkeNRE9pmg0r5ciQGAcxNtHYWBy1E8hIx
        JPzO0Et0cIN3ot6kKt29R6c=
X-Google-Smtp-Source: APXvYqzv1g6cLhtiDeerYEh7TUahcMOk+J7i6/lfgwKZ8QWWcg2vnnwhBjs+6GFgAF982jt6tHQQDQ==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr10535790pgs.173.1554451889641;
        Fri, 05 Apr 2019 01:11:29 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id u5sm17188985pfm.121.2019.04.05.01.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 01:11:28 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation); Fri, 05 Apr 2019 18:41:18 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] drm: aspeed: Clean up Kconfig options
Date:   Fri,  5 Apr 2019 18:41:17 +1030
Message-Id: <20190405081117.27339-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GFX IP is inside of the ASPEED BMC SoC so there is little use
enabling it on a kernel that does not support ASPEED.

When building with COMPILE_TEST the architecture many not have CMA
support, so to avoid breaking the build we only select these options if
the architecture supports the contiguous allocator.

I suspect the DRM_PANEL came from a cut/paste error.

Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
This fixes the powerpc next-20190405 build. Sorry Stephen!

v2: Clean up as well as fix the build
v1: https://lore.kernel.org/lkml/20190405052830.27899-1-joel@jms.id.au/

 drivers/gpu/drm/aspeed/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
index 42b74d18a41b..cccab520e02f 100644
--- a/drivers/gpu/drm/aspeed/Kconfig
+++ b/drivers/gpu/drm/aspeed/Kconfig
@@ -1,11 +1,11 @@
 config DRM_ASPEED_GFX
 	tristate "ASPEED BMC Display Controller"
 	depends on DRM && OF
+	depends on (COMPILE_TEST || ARCH_ASPEED)
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
-	select DRM_PANEL
-	select DMA_CMA
-	select CMA
+	select DMA_CMA if HAVE_DMA_CONTIGUOUS
+	select CMA if HAVE_DMA_CONTIGUOUS
 	select MFD_SYSCON
 	help
 	  Chose this option if you have an ASPEED AST2500 SOC Display
-- 
2.20.1

