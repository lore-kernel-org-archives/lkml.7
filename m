Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2A6C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D483420872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5T74E7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbfIYKDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:03:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44589 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfIYKDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:03:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id g3so2908631pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2+Lw+Pa01X7BomivX93hO8QHJLkQUok4YlT1BdSE8Q=;
        b=E5T74E7aiLNp58UWXnpZyalzu/mEv9i0J0gVytsV9dTDjmkgfai15/LekVtp2q1QcL
         gaUVymGSBo5rrEU8HwK0LQX+zl+RCTe3huCu6qasixs/qsPmjPe0FjMPf+1/ysEXI4gr
         QY0M7E5Xm3nU70nK+lwHwWAw3Cz7idV3KUWPfpiqvoXtfPDSilQp97dXeagEI3L2wun7
         CHBsMtM3phTNDbBI0YHMjhb6eSItTo2M8qOB910EXVdoDmfkiqKoeggt1ynccRLa9e4o
         VRAYo4oTP1CPOM3JmlA6MHB5owQWFCmvxN45t3Ys8AAd9TFxvLW5ATyKJk3K9NvvFbhH
         DBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D2+Lw+Pa01X7BomivX93hO8QHJLkQUok4YlT1BdSE8Q=;
        b=gSqWkQz+K2/730hcLoJl/+VTZCyjDoW27KLHOmOnYzCIEsKdvkjxOYl0q8ly21HS5S
         Up9fz4YPTdAOIxGCYyUuC5F42k6dR5QO6taVznkjXMuncB6yVugtzLH2/d6R3Fj4xd3w
         xj9vM0+Plstf+XFrDj96thPuot8LhTvUN+gpWvABc2NFm4lHvPR8hVM2PAAj3J8CPRV+
         YTuSBoqu2SFxlqjKlYMo6JCrZThrEdOCpR0728IJit7Q/3otjfyMhRSCFvCE9uNvCJ5p
         Wn53fM6VASosIna+eAa6Cpu+aEevuWLvn+c/ab2XYy8sgt0FmdOS9DCd/kwuSfBROj3v
         e4PA==
X-Gm-Message-State: APjAAAUezXMXUyPAiPdrAXJ59/Rq5Mv1Op+lbt7qLqHSwTjJLq2sMpc1
        Tg1W9krGnvEqcs28+g2eqvnW3w==
X-Google-Smtp-Source: APXvYqyK1/XMgIGTBB477BhqN6s74xUQ051y3HOsz4kjV9sUQYEjuuOo+dD5rVKeMURqOO2+apKG7Q==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr5285165pjs.69.1569405831188;
        Wed, 25 Sep 2019 03:03:51 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm4753752pfi.113.2019.09.25.03.03.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 03:03:50 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, sre@kernel.org
Cc:     david@lechnology.com, linux-pm@vger.kernel.org, arnd@arndb.de,
        baolin.wang@linaro.org, orsonzhai@gmail.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y v3 3/3] power: supply: sysfs: ratelimit property read error message
Date:   Wed, 25 Sep 2019 18:03:35 +0800
Message-Id: <c136c30f8b113ba9b0359f57d2a109766c1d7a70.1569405445.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569405445.git.baolin.wang@linaro.org>
References: <cover.1569405445.git.baolin.wang@linaro.org>
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
index eb5dc74..2ccaf4f 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -91,7 +91,8 @@ static ssize_t power_supply_show_property(struct device *dev,
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

