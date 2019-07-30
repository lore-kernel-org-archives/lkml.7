Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430D0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACEE208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFKbdyVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbfG3Qc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:32:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33987 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732892AbfG3Qcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:32:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so66515759wrm.1;
        Tue, 30 Jul 2019 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=roPQylPXOP5pvvI0RbGtrGn/jUs09WcVvXOpVr0avoQ=;
        b=XFKbdyVVC6UyPajVeTCmcLIneaXJq7GXcA7JHauoV+q1ZWVJ+sYDXaSXBUJep6QH2W
         gmecNpC67gWuyQRbLa9m2syGcYs3e59bgRKoKZeUOWXsxBkmSBdNIoYUQIqh+NzHTAgJ
         nmOJNSi+zdz/l7IFIcDq9jqztV7pyiUOJ9YCO4OjLsYARgZOb1twEX4NOralRnw07oLE
         Lh4NFKL5uvvEDi9rFuIrVLBbTrjEcW+p4fAJu/EvZpVeUAhPQ2x28sPK5AcldKmyQaUl
         QUkKE4Eno9Tr11CPWGVONAgWd+61bbwaBqsq/ltT2crvABkx/FsWNBcpAXV0YdyUZmV2
         mhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=roPQylPXOP5pvvI0RbGtrGn/jUs09WcVvXOpVr0avoQ=;
        b=quaUEuOp37QIgsMFA1X9NyHadAX9hOSHL/UgTcfY6VbMJF0UFiqxESe0UaDvcDpEkC
         wmDo+1DTwRNT394N6S5IiMBHG+gK7QcfT4gF+eJqtstTAzFEif7K4qIfuIQRjjVhONyf
         r/tAnMRXiH7+in6qah5SiGF604Xoc2v2R3nr+uKTaPV99te3Q7/4Y+79IPhNEgsAInW8
         JOprSLlZJmyL7aAYVeqMaTd5MY3VLMNz/cWWq20a9xcCqwuT2n5X4oh4ZOUVI+gJEbmm
         siRd25BRNDQuae74hodWHjdvF4VCEIFJHTo5+OPq8clpMoF2Q42YhK+ybURO4y2fNhWH
         z6Og==
X-Gm-Message-State: APjAAAUuOHVsQLRD8jZ3+9IXVyMBJe4LQydwTQOhq+jW859zyf0xwBBa
        1KJw+gaolkqClrYT02MB6sA=
X-Google-Smtp-Source: APXvYqxt9WbgMsjDb93KWckpdOBv27JhjHyK/F2R5hxH0ydzndgBHcRfAjTN5pqDmteqBRF1cYnzyg==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr13552589wrj.272.1564504359436;
        Tue, 30 Jul 2019 09:32:39 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/20] PM / devfreq: tegra30: Include appropriate header
Date:   Tue, 30 Jul 2019 19:22:32 +0300
Message-Id: <20190730162236.6063-17-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not very correct to include mod_devicetable.h for the OF device
drivers and of_device.h should be included instead.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 81efc3ddb486..8280f96f4cb9 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
-- 
2.22.0

