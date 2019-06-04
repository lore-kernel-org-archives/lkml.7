Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83999C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C249249A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="ReKQN1Lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfFDODt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:03:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35501 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfFDODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:03:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so665109edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C89Zm5tqX6wwdqdwxOr1J581zGxrK1/FIkPJm608gBw=;
        b=ReKQN1Ltrc6A4Z2El8pR0PXGPrStXWhkcji/2N49UFsdqNCVNCvN0X51v/dE1/VPRd
         HPhxKvSXknjmV5O5G37Zgr/+sD5IH9j3pfDGes/yd1qFzfjvkOeVJ9ueDFqRPogPOMFE
         kJ0k087RquGzueGpV1rBYb6vJ2sXkSzbpZJEhwVmSl81s4UCQC0LKLN+Kql5RCnWBOsn
         XRliNKxpM+wnPaNSqjD2PMGxo0FoKaNIJgMgeqzR0F/pRgTERUGzKSF7SKhZ08gis1dK
         olAB2pwpRVOYAw2XSWckeGQzDeMlS+P1M1RAjn+UinMUCzpJFpsiHg6Plsn6gDvyRZ4t
         dcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C89Zm5tqX6wwdqdwxOr1J581zGxrK1/FIkPJm608gBw=;
        b=VNH4IhpmAm//hKI8r5RiHssb3OE+Wr4ahLbnBKWM7g7seV/PdlbQMW1O0fGyZSZbK4
         qd14UtOVYqbKw8NM5bhxlCcODqWgduWr6Hejo8VRZzxunrJgBm6rVcjqVGfccmHX9bQ6
         zgTaI7IsfLt0HEalLWkaG2qq13+BimxZjcb3hzEOuOYLcnNks9MQsi3ZEHascJj05dx4
         6reMV6lBa2inzeip/SVTAI12w79P2BmYNkLvkxig6HHlZFE2vtO+um1bNn9Z7KqFWLFP
         h3GIV7h/iNihkFDXIBXKDK3uxK8Uh4m1WZuU7rpz+219BCJP15PEQvqs2xQfaloIYfdS
         1+CA==
X-Gm-Message-State: APjAAAUO/R+UN/0SSf5sqC5DgCm96+h3W1n9Z2voj5GWzInDiAQAXLQq
        c9832VWbVAQQ15YEydOxHJRYLg==
X-Google-Smtp-Source: APXvYqzNo6pxIWtWg6c+hl2tqLBkAFuScB+C1FTzvmh8Szoa7TT0yDrjXkqI6mOBi2SBSea2psc1yg==
X-Received: by 2002:a50:905a:: with SMTP id z26mr35907729edz.96.1559657027339;
        Tue, 04 Jun 2019 07:03:47 -0700 (PDT)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id j27sm3194485eja.91.2019.06.04.07.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:03:46 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/1] counter/ftm-quaddec: Add missing dependencies in Kconfig
Date:   Tue,  4 Jun 2019 16:03:26 +0200
Message-Id: <20190604140326.12295-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses devm_ioremap and of* functions. This fixes a
linking failure with e.g. ARCH=um.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/counter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 233ac305d878..c9e3f5c98484 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -50,6 +50,7 @@ config STM32_LPTIMER_CNT
 
 config FTM_QUADDEC
 	tristate "Flex Timer Module Quadrature decoder driver"
+	depends on HAS_IOMEM && OF
 	help
 	  Select this option to enable the Flex Timer Quadrature decoder
 	  driver.
-- 
2.19.1

