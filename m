Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A6C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D919820656
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRl2tksR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfDYJEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:04:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33955 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:04:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id y16so8732186ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SKU8TqyaZdotevtfnq5N1kqyp924DnkQ1SW3hKFZumc=;
        b=WRl2tksRLvo+9Es+YS3ubYSIJu3Px06jrBvjXouQ97+kTd0fYCwU6kGQ6B9uN2DBEs
         pIr+5STewigGPrD2YQTEQw7neS26wEZSsxMDfr/Z9lVnev7mbQKGttmRrvETFWe7vw8T
         igcqU7K78oNqHJwc3PFnYx/MGQaBBudDM47MVDuikyCHmdtgV/Lg6EujrAXmV3sp4X98
         oG6/EHUlzDoEll5pStL1xFoThDf7sx+NKIrmeM5mz59qIJoVgQWaCf7MoR8geJxrpnEO
         F4HBJoX50SdRTPZO5wZej7GdpKGwuH9JivQjMY1Tx/qDTFJHWBZ3Jj4AWFFOsdQaYKWX
         m3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SKU8TqyaZdotevtfnq5N1kqyp924DnkQ1SW3hKFZumc=;
        b=ju/dEmlF/xtG4hPC879gfet9OlGnCAtHak2BBFSSWLKCQk4gPQfA5cnRFlAGQShdHS
         zD8zjSS36pFfsgC4do4om1/3TepzhPH0J7URxaW5+WKU8I4rkcqHMxxDP7ewq2uJQGcn
         +Fq/TgovcBOGC+Jg3FUaZwJynKn13mr1SH8pAnWJBiprTvkNO4mac7bYgTyBQraqhE4m
         5T682fSOYTu7cMcPNwoJKm0jfZ/A2C125NCTUohClqhCw8Az1ZD/b249/2lj6rKgC8Qe
         TeuWjXt4DkgyysRo49raWhoT+vL1CcpZs7LIa7PmowuHx+1iAkyaOw4adUTWbkwZU7DI
         8JfA==
X-Gm-Message-State: APjAAAWAMfPoMT07YAt+571+91DAuc+joZsT9oREW9mJJZweaPMPg1u6
        kM3FIyKcIWToRHAXcR0Ug7XiiA==
X-Google-Smtp-Source: APXvYqxhTPV7EXwsv+3UZV5aPgs8DT/JmHv4c3QEWbbRzS9IMl/A1vqhc/RmZpJ3K83Rm5t0KFbOnQ==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr6648786ljc.172.1556183068544;
        Thu, 25 Apr 2019 02:04:28 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v26sm4517353lja.60.2019.04.25.02.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:04:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
Date:   Thu, 25 Apr 2019 11:04:09 +0200
Message-Id: <20190425090413.10700-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently genpd was extended to cope with devices belonging to CPUs. However,
attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
because of the virtual device that genpd allocates in this path.

In this series, this limitation is addressed, together with a few other related
fixes/cleanups.

Ulf Hansson (4):
  PM / Domains: Use the base device for
    driver_deferred_probe_check_state()
  PM / Domains: Drop unused in-parameter to some genpd functions
  PM / Domains: Search for the CPU device outside the genpd lock
  PM / Domains: Allow to attach a CPU via
    genpd_dev_pm_attach_by_id|name()

 drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
 include/linux/pm_domain.h   |  1 +
 2 files changed, 36 insertions(+), 38 deletions(-)

-- 
2.17.1

