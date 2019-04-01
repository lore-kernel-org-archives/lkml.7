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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC84C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B7920870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiEZj1Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfDAEO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40773 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbfDAEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so3867286pfc.7;
        Sun, 31 Mar 2019 21:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R26VX8UuWlYFBbR7v6jtFFgzRdzDgdAJiF2H+jj3iUM=;
        b=DiEZj1Cdyj1zlQO8uLM/SdpaYpu5sJa/t30VIr5978aDI5AVvu5AV0W64BsSMt9LeY
         gp9jHTmkHpKzwJNWGm5f382tevHCG1fZZ5HdY0zeTyq/1UCj4Ftn9NLljsBFyVY7e6MM
         DbGnBvSwfEqg+zgT5QVw+r6k6efNNZOX2esWE+RXtyF6M8tyk9caokfl1QhLNu5NvAYK
         xoK5YKjV3sNWDJuW3hrcZeICh3fnipPlp5tKSyh3Tq46FxLuAa23XuNEpXeLL/yOS29M
         WL6ROpNBVPfcosOW5RZkkyKoUQpEa9yCGK4npkCPCOxygw4ftmIZpH8ydK3pMqMHp2B6
         KEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R26VX8UuWlYFBbR7v6jtFFgzRdzDgdAJiF2H+jj3iUM=;
        b=pc/FH0eHqNCKXJTs0aC4qnPDsqv29y1CbLQeYnyDSXbiU7ncEV/a98Gg73JyiJgABC
         DrzldM2hZEWT5YjpNyQkGgyC+uuMDqTVPcnleCJDhBELeVt8zoXMKsVBM7bPtcL7+l/4
         KKV9QsnoZjDeC7xBJU0lmde0p+GqVw0kSgfPTGGkGXpjANJTw6YNEIwXvMUT14Xty8ot
         Ns/h/31F6IpYdShJYKMmypA83GSSG8HL48gJgrN7ZAhA7Vu1UxMFEI6fJkhkz+KYxFBq
         96KGtzPRt+4JTUiP8pNdm59XlOKJ065z+B8RcSdnnFuSL7wKJ+KsFT/x7CcVvX2CkVgS
         tfIA==
X-Gm-Message-State: APjAAAVvH/lT1BTintD3tdIbR8oSeXIw85CbXmNYDkIVEayn8//+K9+C
        Yxx0Xs6qb2dkbiGxc1cGsyN4+tj0
X-Google-Smtp-Source: APXvYqzJdlTo73UVrrc8IKlq+XqIcqYJhC88dUbJVQvLyagAHg9lOTFjz0pJ438ahmEAXAU25BdoPQ==
X-Received: by 2002:a62:a513:: with SMTP id v19mr3852274pfm.212.1554092092674;
        Sun, 31 Mar 2019 21:14:52 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:51 -0700 (PDT)
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
Subject: [PATCH v3 13/13] thermal: qoriq: Add hwmon support
Date:   Sun, 31 Mar 2019 21:14:18 -0700
Message-Id: <20190401041418.5999-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose thermal readings as a HWMON device, so that it could be
accessed using lm-sensors.

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
 drivers/thermal/qoriq_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 9d227654f879..7fb9321a0d8c 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define SITES_MAX	16
 
@@ -103,7 +104,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 		case -ENODEV:
 			continue;
 		case 0:
-			break;
+			ret = devm_thermal_add_hwmon_sysfs(tzd);
+			if (!ret)
+				break;
+			/* fallthrough */
 		default:
 			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
 			return ret;
-- 
2.20.1

