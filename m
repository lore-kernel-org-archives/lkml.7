Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4E7C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3113214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q10EU45N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfIYJz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:55:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37732 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfIYJz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:55:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so3088115pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWhbUGv2lQeZO4jYvuR/nIX8VcsQRP/3s99PPL6K370=;
        b=q10EU45NTJwIJeYfgsOBdN94NNFG3fwiOLyu8Ix7i+TuDo3WIftED76Ja2vnuOZ5rh
         qgmTU6GXJaHLYtMrF1wV0dwXj61rzxSLCXubwBC3wO2v+J84vvhJoyfkrzkgkLMBDx0P
         gaNMRxZrXdRvGNO8WCQ2H84Jtw78GxePE1UxWdthzJtNwMbuPhan0oFMKBAbcRLIdqIf
         wrUOFwSm10824LM2VQZACB2CD0ZR3+oy5SoJtq4pHz/2sAg04gbbi7BWmkpa+GVSafvJ
         dAuGXkJHykPpnzfplGIaOccK6F41LMCUwyy1T+tSybzxhFYFPWUk4xVrzityIH3k36ZE
         hRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DWhbUGv2lQeZO4jYvuR/nIX8VcsQRP/3s99PPL6K370=;
        b=YCW1mtJv/QcKk0tvghBp7KVoI4YM9mujNzeJYGfXI5wKyW73MMM1S4oUmFOPgKDGKv
         SzHBxUXJnOECzPI2ctfzltE2m16Li5MVe4hkU8qpjPrEcLeE2P+SfJ92eIlhZgCAPFn9
         4mrDmXXo7wNgvY4hrUhKt6ackLuAmXuDIGvSUWB6cKSCm8niN2pT0KBfL7iReAI2CcRw
         0vAx6R+wcvDncLGU6v2BPm1IgN/A9MQAuj8qxSooacxKHDmq69hMJiivLSGB0SupraJA
         1Plfc51ReF7Paga8/iVFGHUIv7pO1ClXnVgyfQ5iIQiHaem9iDl/FUbdavXerInxnct3
         q6OA==
X-Gm-Message-State: APjAAAVXau0WJhi1Wu+1o5j8tcWlixcc1Rzq3SWm1zAr/oBwBAugEx+n
        PhL6uRcX9dMW5M4h0mDdSXysmg==
X-Google-Smtp-Source: APXvYqwcBxlk43VFAND4HNTUQaO0wlCxMabpoBPf+ntRfhtxngHebErv30Xy5iJzGbAaRXMnyDdICg==
X-Received: by 2002:a62:f249:: with SMTP id y9mr8759936pfl.147.1569405325359;
        Wed, 25 Sep 2019 02:55:25 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i7sm2430831pjs.1.2019.09.25.02.55.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 02:55:24 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, sre@kernel.org
Cc:     david@lechnology.com, linux-pm@vger.kernel.org, arnd@arndb.de,
        baolin.wang@linaro.org, orsonzhai@gmail.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.19.y 3/3] power: supply: sysfs: ratelimit property read error message
Date:   Wed, 25 Sep 2019 17:55:03 +0800
Message-Id: <117b7b2d9bed2a288676f5614d8dd8d09746ab93.1569404757.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569404757.git.baolin.wang@linaro.org>
References: <cover.1569404757.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

[Upstream commit 87a2b65fc855e6be50f791c2ebbb492541896827]

This adds rate limiting to the message that is printed when reading a
power supply property via sysfs returns an error. This will prevent
userspace applications from unintentionally dDOSing the system by
continuously reading a property that returns an error.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/power_supply_sysfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5a2757a..5358a80 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -131,7 +131,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 				dev_dbg(dev, "driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
-				dev_err(dev, "driver failed to report `%s' property: %zd\n",
+				dev_err_ratelimited(dev,
+					"driver failed to report `%s' property: %zd\n",
 					attr->attr.name, ret);
 			return ret;
 		}
-- 
1.7.9.5

