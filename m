Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C481207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDbIlVA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfFLIMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:12:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46327 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFLIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:12:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so9915169ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlVjUjqpWzID0KuxViSALS3lzmjYAzsT4I+mvQyLT2o=;
        b=lDbIlVA9aF0aoJGtLsKYOOo+mpBh3j55rX512XVSvbx7lF96pkcklSUc2hMcFH6aWJ
         pTaumzaRme3TiK6VZ4uBob/qhZtxgZWehfgknEsQv09sVZX60/7DnIld6JMEsvzcw0Qd
         putu1z4HMUHMPtjl4EyS/Ry5ufLyXAprYpNNmhGAbhLw2FjNz0qHjy8qufWGxWmUulIR
         zSRysAOX1rUj5CPxbEJp68Aewsyzhe2mCnk86KMYhjgRPN50+k+s1Lo8m2+6/dcvdpDi
         nh6Flbrwc2wC81rff1C+DAZuWHylVdUFRSMUDs1q0ZuesD9k9sj+jpA5yoS5tEKB4vss
         Ep1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlVjUjqpWzID0KuxViSALS3lzmjYAzsT4I+mvQyLT2o=;
        b=EqHNOHjQOsIJX5DgQ4vveudIOlkFrsXnSZABu6AhH2J6Jg7GK2Ld1aHUskwKvDN0Zl
         GH1d3c+MZ13noO7kmCG3/EzTg2F4H2s7pfKJA8kSzJIHkBcW0c2snRBpbei2rluGOPsC
         28OPSHiYUnLpu5oZE3YGPlelGLMHLx1Hkt8nVTpFVgt6IB1Rb3AfhrS8VIxXo8mU0iHJ
         K0LBhFCOOUAx80ekfG70Z+3oGR5q6F46JRSupwGtgVLphbpwt0uT5P1d/wGDxtniKklY
         DQ5Sdf1P1BYGphOBGk+ogaK4XW4bfyv2eBaodVF6cwpHPpDAB3MTezvV+nsSDzuXuKv3
         Pb1A==
X-Gm-Message-State: APjAAAXa/O07AXo6qT5UqVijkadQKStORAawE0VW5UmDqActxHSVxzzd
        oacemYajfn5S7JS7+XESX3NVDA==
X-Google-Smtp-Source: APXvYqwHyWM9GqP0EP0UjwOE49JW96qoqR9GLtO0yy6E6HPJJuWlSJaSBkei4laH5sn6K7o3mZTnCg==
X-Received: by 2002:a2e:a311:: with SMTP id l17mr22655761lje.214.1560327122815;
        Wed, 12 Jun 2019 01:12:02 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id a21sm228813ljd.70.2019.06.12.01.12.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:12:02 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] drivers: regulator: 88pm800: fix warning same module names
Date:   Wed, 12 Jun 2019 10:11:58 +0200
Message-Id: <20190612081158.1424-1-anders.roxell@linaro.org>
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

Rework so that the file is named 88pm800-regulator.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/regulator/{88pm800.c => 88pm800-regulator.c} | 0
 drivers/regulator/Makefile                           | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/regulator/{88pm800.c => 88pm800-regulator.c} (100%)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800-regulator.c
similarity index 100%
rename from drivers/regulator/88pm800.c
rename to drivers/regulator/88pm800-regulator.c
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 76e78fa449a2..c15b0b613766 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
 obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 
 obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
-obj-$(CONFIG_REGULATOR_88PM800) += 88pm800.o
+obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
 obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
 obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
-- 
2.20.1

