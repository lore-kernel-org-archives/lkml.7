Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F9EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2C52196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plLBWJp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfKMJ1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:27:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46665 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKMJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:27:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id o65so1317545lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98bbtxrlztsaSeBuCTpYhW6G78UV8jrpbvcn8tDSvYA=;
        b=plLBWJp5AQE02m++GEPUI0YTKIjDTL5RtW1BLYg8HBlGB8epyTQPSL35OrV2QCJHHz
         dlh8C9hIfz33ZhJWJLYHrWoZiPRvepsZ3cv2lPLq5wjba22yE8DV1VnHFromxUlRPeZH
         UEsL4I2pC9Sq96gxTC6aqd10X/oLlypGSlBnhPabamclUTEQJ62S8IcGryqc2F2yT66n
         XE3GnKeur9IvVOz3uhy2V0iaTlQvFmH9dtuu7wD3DonSbgVgYNY2WAFAkE5VPIQxZjGD
         6yG3z6iDpGRY87NUzmCHIuwQt4l2dSKLgTgRek5hpzhOVqrlq0Ltx2/WOzTZzMMGGFIf
         6m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98bbtxrlztsaSeBuCTpYhW6G78UV8jrpbvcn8tDSvYA=;
        b=TRQkIQzacYYPdr7ZsS7ComXh/DxcUZ2jkRL1hhpELigJHLLfPs4FrHFLOyYQK+twps
         nZLNnU+AozEu5uCRuUgieyA2wr0Ehbeya8BoguBpRcgmzM67bwn++xbaMKiD7AAjnglo
         dYzsC/GdqlyLbUtO+b1k4T3rnsaX5gJLFs9YoJNAIhDVn4oYAQUuBlm1RBysO4JxtP+p
         wVy3zOrxvnpCcXhoiI0mCK1Jxwfjq+Z+U0SiZFpz66F93Yn6WJa8LZMmE0Fu+uDKGjru
         T/zr5q1EEJuhlSOi+Wu7w0TmIYUgrkC/uYEtQ5mE6+aijpCuNCdn4Q8zSfYREzMBajZT
         HbHg==
X-Gm-Message-State: APjAAAVltv5RtiWUDoP9QfUTuDm/KOvW4FPxrlwFQe3SeRiSbReGz+Ag
        VO3OFmd74fkrMg1fy4xWR2IDBw==
X-Google-Smtp-Source: APXvYqyJ5e7C/nCUl9Pi3lVJ8liQye4thGdWtnl2nLezYo7RVgIQsVKtF7flNXJjyitnyanCP2bepA==
X-Received: by 2002:a05:6512:50f:: with SMTP id o15mr1953084lfb.168.1573637229877;
        Wed, 13 Nov 2019 01:27:09 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id x18sm595872ljc.39.2019.11.13.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 01:27:09 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] arm64: Kconfig: add a choice for endianness
Date:   Wed, 13 Nov 2019 10:26:52 +0100
Message-Id: <20191113092652.28201-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
people want. Another concern that has come up is that ACPI isn't built
for an allmodconfig kernel today since that also depends on !CPU_BIG_ENDIAN.

Rework so that we introduce a 'choice' and default the choice to
CPU_LITTLE_ENDIAN. That means that when we build an allmodconfig kernel
it will default to CPU_LITTLE_ENDIAN that most people tends to want.

Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/Kconfig | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 64764ca92fca..c599b6b288be 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -877,10 +877,26 @@ config ARM64_PA_BITS
 	default 48 if ARM64_PA_BITS_48
 	default 52 if ARM64_PA_BITS_52
 
+choice
+	prompt "Endianness"
+	default CPU_LITTLE_ENDIAN
+	help
+	  Select the endianness of data accesses performed by the CPU. Userspace
+	  applications will need to be compiled and linked for the endianness
+	  that is selected here.
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
-         Say Y if you plan on running a kernel in big-endian mode.
+	  Say Y if you plan on running a kernel with a big-endian userspace.
+
+config CPU_LITTLE_ENDIAN
+	bool "Build little-endian kernel"
+	help
+	  Say Y if you plan on running a kernel with a little-endian userspace.
+	  This is usually the case for distributions targetting arm64.
+
+endchoice
 
 config SCHED_MC
 	bool "Multi-core scheduler support"
-- 
2.20.1

