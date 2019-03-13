Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA22C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68482171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UG03IFrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfCMIhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:37:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44175 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCMIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:37:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id u9so784523lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wXapuDJ/TxdZdSmwteecFqdWBuQB0h5GI4Aq0atblIM=;
        b=UG03IFrKLS7qPDvXkQBipZ6olkkLjZGtf4y+g0vP284yEVpeIs/wpf6sRS0z0823Xs
         sETGgK3VJV+7FMAU6xhjQNBGEZKt9d+iiMycQNBY6+5PsbGyEpz5erpt6rIAMtNMvWIe
         5R56zDmn4LfUEBoJRdEmB4THA3UvcoySX5zw4KjUHJ2rbMcgmBGxczxp/HY6KfTQiETz
         9egy4TJVt/uT2x04XyYl5gfs26iHyNJVLRsGCjzT1grANTqHgBw3wKejcu8diRfVLP3+
         OV8vxv5QiKTtks1ZrMb9eGrhKO3IvPE3AyH15KJMQFgkILQY/HDJHssAOoYlBUIutF0q
         vLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wXapuDJ/TxdZdSmwteecFqdWBuQB0h5GI4Aq0atblIM=;
        b=SUr0XMQtxW6mJfx5JJtW2W1vlxaZcZsC5WgMNHcrmlEAjEy5YqYnnnGjBILcrjaQL2
         AkNjLZ5dcwEGrvJk71zsJnAlpf1bM+S2gMTRVaTX1nox26XK9e923Qi/pBCGP6w9JAlo
         sGa0jDQSg/qWhRdHqOh8Hdl+Fa5WSDoGDzdWKqU9whxaq5yc8CwQcydMl2Qet0EI6iwD
         alnlOZidl3CviOMBTkAnrDOvBqjKV2PGJpeqRAan/8yo1KKKpZTBQZ2/Gwd60uE+1ryL
         +2aRBzAsnaU3O0DMMH8m0aRI663OETF4RaKThB/YV0i6+c5hMftWDeU4F7aY3sfdNgYh
         YjjA==
X-Gm-Message-State: APjAAAUt4+damH9Qkx0G0PnNs/ULpx1GLwc4zUmDLSCuql+RyCf10ooF
        NjXZ65YRLqaiUIHxh/9P9FqpAA==
X-Google-Smtp-Source: APXvYqwxT83yk6AKKclQYQDujXakyrFGedrnLmXS0kqchel5AWw9xTEJiEzzask6eDWiGid8xcWJRQ==
X-Received: by 2002:ac2:4355:: with SMTP id o21mr20467825lfl.85.1552466228116;
        Wed, 13 Mar 2019 01:37:08 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a23sm1707716ljd.20.2019.03.13.01.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 01:37:07 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] MAINTAINERS: Update files for PSCI
Date:   Wed, 13 Mar 2019 09:36:56 +0100
Message-Id: <20190313083659.7100-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190313083659.7100-1-ulf.hansson@linaro.org>
References: <20190313083659.7100-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files for the PSCI firmware driver were moved to a sub-directory, let's
update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a419acaa01c5..97dcec6fc877 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12257,7 +12257,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1

