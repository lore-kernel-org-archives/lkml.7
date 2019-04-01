Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAAF20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oW+VF3ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDAEOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41845 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDAEOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so4052474pgs.8;
        Sun, 31 Mar 2019 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXP9Z75LmCTBJbOt5LufP20Vd3mjxeDkQuMNJQNjHi8=;
        b=oW+VF3tyX0KNkgdcGKxOkKGq2I4fvH3kdD4wL63Ao3zm/mErK3ZBf9OJf8iNATZYKH
         GpjEiZtWrLZGrUjSbkMToZlFXmdMdtCYswO9fPt0jyvq2W9ji1eIRyh2iqvN7BmH+uUA
         g4tprj3CTQVcUeOKRf3nsBFt0SkdTuC9c1a7XyYecsXJGGTPXFbC/GTQL3IcpAq5P5jl
         zdhBboPSFwDevx0o/b9AFY9YWrmzsAroy9rG1X62Fvrr2m49kT377bs3pSyFK2A3r0YE
         UFYJmZq2yZrf12E7w5S7wGIPks0lNAYcAdBXwNiqETL2sv2z/MRir+2/+8hbeA4vMP8W
         zYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXP9Z75LmCTBJbOt5LufP20Vd3mjxeDkQuMNJQNjHi8=;
        b=PZdG4IDhO4Tfvz8MNoAsyFGumattWy7Tm/pOWrveKDZyxcHK8aI/6VtAN3gzJSr548
         nM6/EuFI0up5zcYd8dIyQB1jkYkpeLLlus3JtXIGzOsTrrZs0JEx5XLgnm5FDDvkLiWn
         S5AqGZFTQhbtIEHF/xT28dnaxYqzotumxOaLF0KW5tWO2YAmO4idwvtZAO1BFVlE6h65
         wRZY6HA7mkKLUhwRXwWWh4x72N63vTLuH1zkt73s+8fUMuUnXCk1/SDMeSCZACG7L0yQ
         iRZdWyLjw7dLKKzmz+nC829qcVtoAmfiHhST0jN5huVtlyksFdi8M1ocwwm7Rsmv28nU
         tIUQ==
X-Gm-Message-State: APjAAAUUk/on1eoypAUrNSzaCA+Qa6X81HvZ7vqkDg621k3rSYLq9Cb0
        Vcf3pAAzpto7xI1jteIxPPmKBINW
X-Google-Smtp-Source: APXvYqwtcjXqcZJskUpgFcqm1yWFOgKaNAu7jQpWicXJQKp1GLzLq8nsPMRxWhd7jJuOkt82XeMvRA==
X-Received: by 2002:a63:614c:: with SMTP id v73mr59440595pgb.395.1554092075067;
        Sun, 31 Mar 2019 21:14:35 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:33 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/13] thermal: qoriq: Remove unnecessary DT node is NULL check
Date:   Sun, 31 Mar 2019 21:14:06 -0700
Message-Id: <20190401041418.5999-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is meant to be used with Device Tree and there's no
use-case where device's DT node is going to be NULL. Remove code
protecting against that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3b5f5b3fb1bc..7b364933bfb1 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -193,11 +193,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 
-	if (!np) {
-		dev_err(&pdev->dev, "Device OF-Node is NULL");
-		return -ENODEV;
-	}
-
 	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
-- 
2.20.1

