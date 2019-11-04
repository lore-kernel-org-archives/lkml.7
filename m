Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD7CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0092080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6kZP/Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfKDSNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42523 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfKDSNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id s23so8479845pgo.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I32GagO5xwpjaCvYA7jwVW7GwjuY4NbR5b26Ld8w57U=;
        b=X6kZP/GvXomxJTpONdRTjc05uKXG60V6KmAFh5sdmFw/KfM+oijNNCl2oUL5CbnjJD
         bZ7fCXsjov868pGwWXolsD5V2kCStDPw6mIa/4CVypZPHYNENWm6bZ6r9+gu5oFKbMRR
         BqnsYkoJg6S/ScRTH7LQyZ948THS5mscenYO2Bc7fthtzq+9iHb17I5dcr+4egxIkjAM
         8IvalnEp6sE3Eb9ZhupQbObuTPvb59awJR6zpiJ/gDmi/q1nxfMiJvCttciyJpccXbiB
         1+OiRYaS+i3nBuhwvhWsOU/IrxT1rBjWGbWxjGEjOvYfbU02a7Y62IYwBlAOfm336zwp
         GFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I32GagO5xwpjaCvYA7jwVW7GwjuY4NbR5b26Ld8w57U=;
        b=grWsw0YfiF8HrbrceA/Vkw01PNNW1cmduGgBQ1BcSuiUQbaRIYwRd0q82peY5T3Vmy
         BN65gvh3C5EX5F/Cb8QOcNTBp1M/nBJP7XzU2psILLqV0N/wiHmKVkQwtn3FnSYqn2Bd
         N6UQMmO8Q5fW7uq/7Swjh4of8OdnDAvBqwQWuUwjAuEpvu+zpTCANF4h8byviPwJVa7p
         XoLo8MRXqmhpQ54gaw+shdGXS9oZVaUQyRHmQCUeSQvoUPCJloCXzbgi8K0sotETMN3M
         va6yFz6f4pXbLbPODrOGqoRFU8QAz39NUuxUCh2KdnPk9uE9H21VrHMsQgRKEtOyKHGi
         aomQ==
X-Gm-Message-State: APjAAAXvTwHpahVns+t0saPVPBjqNF1qScPOjUaPTDXsc21Ta0Ve9NMB
        mhw5YGavvjlENlD+EsB70RVlCm6MpSM=
X-Google-Smtp-Source: APXvYqxi1HKTpbkTjiBtFMOwP27EP8SelMqiVXqAq1C7HqrzqeV35j9Au8LOkmEJ9k0ZpssoJK2vOA==
X-Received: by 2002:a17:90a:f496:: with SMTP id bx22mr547355pjb.101.1572891186044;
        Mon, 04 Nov 2019 10:13:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:13:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] coresight: Add explicit architecture dependency
Date:   Mon,  4 Nov 2019 11:12:49 -0700
Message-Id: <20191104181251.26732-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

Coresight hardware is only likely to appear on Arm systems and currently
the core code has Arm-specific barrier operations in it so can't be
built anywhere else so add an explicit dependency saying so.  This will
make no practical difference currently due to the way subsystems are
referenced, the subsystem is only pulled in on arm and arm64, so mainly
serves as documentation in case someone wants to increase build
coverage.

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 7a9f5fb08330..6ff30e25af55 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -4,6 +4,7 @@
 #
 menuconfig CORESIGHT
 	bool "CoreSight Tracing Support"
+	depends on ARM || ARM64
 	depends on OF || ACPI
 	select ARM_AMBA
 	select PERF_EVENTS
-- 
2.17.1

