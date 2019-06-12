Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2423C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE55C207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnY9HJZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfFLIMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:12:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45340 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFLIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:12:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so14233425lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqLAHFWcFPPRWg/WUmIKVQXRfjbKzLHes3un8tM9Gvg=;
        b=lnY9HJZrjTwciRfoCs5TPzHQUN3/dv0/a1bpYBrC0AyoXShuh7z3OrZBVo0zgF3gy1
         Iji6Ax443BfTKtEJmUGKeZTnEaIwNzKAqrsREHkfj4RUlcQKzUtCc18aQTEFNPG6kjqd
         VGb6lGJxhcG9L3DmAY5wxIer41gE6toj5ejL9A0MqcsvXqM0QnMHNT6LMFuPOw0OiBta
         AkfxwD8kc2eCYayFZNbVhI167Zw+EfBadx6FoS/HzpA7u89R/8jrKu4h1tiDAMutM3nU
         u2hiUIMeGix/jOS0J33NjTKsofD3y+NoLWoTRTZWO/riuUtRLRT4m7WNBmKHavfRMD3Q
         FZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqLAHFWcFPPRWg/WUmIKVQXRfjbKzLHes3un8tM9Gvg=;
        b=c+wiCx+HMVY05Z1qE0hmV6lSSMmvrtus27k5QWHxga7NCE4Sugx72bYjCk1COYYe49
         Z6S4ERnm/5R1HFGsGD5AyoamHCqgtob2Bl7Xtl6PJte3Vq+MmkwZvhweVqMBpgz870Sn
         0Zrvm9mX8mxXtqS6LgRiPopkLxxdvRVtkiAeeNYvd4WCckJ0Sjy6QDeXtXoDsaFyk75/
         E1ccJaewkcdM3il+LRAgqIJCqtFP/xtt261CiUze9AMxejJzEB3ytIf3tQ+9jWbh+MjK
         LGIjBzX/IYV46owFd3cxZcX3j5xOdeqa0FfdMqPBmPiBfZ4dMbM7RIsbhFWL65qbkcXU
         SvBw==
X-Gm-Message-State: APjAAAXzYxF0velNs07vdSzyl5ARbQ1hy5KeRDkqVNEll/W0wmd4qRmI
        oGanPSnUFLq6vK71o+uvb4coCyP9EX//mw==
X-Google-Smtp-Source: APXvYqw6n37YCwsDqJZ05mtmwalNZbga+6tVZYCYCmO4E5fJxQJfJDwCFO88IOLpXwHUa74BXiqVmA==
X-Received: by 2002:a2e:1201:: with SMTP id t1mr17393546lje.153.1560327128514;
        Wed, 12 Jun 2019 01:12:08 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id t21sm3027366ljg.60.2019.06.12.01.12.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:12:07 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] drivers: mfd: 88pm800: fix warning same module names
Date:   Wed, 12 Jun 2019 10:12:03 +0200
Message-Id: <20190612081203.1477-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_MFD_88PM800 and CONFIG_REGULATOR_88PM800
enabled as loadable modules, we see the following warning:

warning: same module names found:
  drivers/regulator/88pm800.ko
  drivers/mfd/88pm800.ko

Rework so the names matches the config fragment.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/mfd/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 52b1a90ff515..5e870eef6a20 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -5,8 +5,11 @@
 
 88pm860x-objs			:= 88pm860x-core.o 88pm860x-i2c.o
 obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
-obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
-obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
+obj-$(CONFIG_MFD_88PM800)	+= mfd-88pm800.o mfd-88pm80x.o
+mfd-88pm800-objs		:= 88pm800.o
+obj-$(CONFIG_MFD_88PM805)	+= mfd-88pm805.o mfd-88pm80x.o
+mfd-88pm805-objs		:= 88pm805.o
+mfd-88pm80x-objs		:= 88pm80x.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
-- 
2.20.1

