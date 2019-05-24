Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEE5C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE29220815
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcU0PA0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbfEXPf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:35:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40720 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389203AbfEXPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:35:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id q62so9040051ljq.7;
        Fri, 24 May 2019 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7Liv7qd8+5BtHD0U0PqHlvEgsBKMReX1LuzLFCMHK8=;
        b=jcU0PA0hUnXW9X1FBpgsbvZrt3YIH/dGhht9rrB9VJN9krvINOfGpAaPxzGqJCaSD+
         +BF07DjsNNPv46E28PMY+wul6aCLtG7uteRyM0dINjhbsKWJvUF3B28uJLXQn7o2FwMa
         OeEjA351SWervSm0262UEjgyf7H0WaE5EIoRwsjzG91uyzhcQ2W44lqm7/R1Q07C97CK
         pP7DHrvXL9ZxrEsPyl9Vv5dmceB1fyAxIbkHM42Mzvj8HJeA91Q6kXF/jLE1Hka6YkT9
         jK+x4eoxMWZ/mL2Cq/upnWGm2AQezaR7AezYaSWRUzIXsp8iSOhj5UfFt/Y39lkMYTXA
         Aglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7Liv7qd8+5BtHD0U0PqHlvEgsBKMReX1LuzLFCMHK8=;
        b=dymcQBrP81edz/iSIaEIYt/sAqyKbAeeWHK1dkJi6Gla9bsIXs4jlR6919jmDrG94G
         t4Kf+BPztMDpGWtTHzOtatKVXq+rQFhiuW6uIn5mtldvM+rPjBBOJfjBde/+rQBn6b7+
         yl5/pGFy4dEIgkOBrOIW/RS3Sr8gsPMkJMnWhdkfc83cTkbbPYgioZmoGmTuwFejBi1x
         lYCmUsND3ldWxrdffG9oAWpxj1gqTduzvKxh1nHs+24yntCUlqRhHWCXdNkeHmWElQPX
         R8ozxKw7VTQ8fqjjiLjXmdXQoc75ocioCOPWuvNsNZVvRoQYXpdvkKtdgMlWiQxg29XC
         qCNg==
X-Gm-Message-State: APjAAAXrxwgy6sdvgVP7aCPI9ahGGud3vTeYonAPTU0oiNCVUzAWKcuN
        nXQAeYPwEmkbT0eFRCNAdy0=
X-Google-Smtp-Source: APXvYqwgb8gNmxN7E76vJBMODOQHHtEXafw3rWkHIKuclkkrxOj6H7Px5y+W9/juHUfdEYimsHU+hw==
X-Received: by 2002:a2e:7808:: with SMTP id t8mr13805852ljc.78.1558712125783;
        Fri, 24 May 2019 08:35:25 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id y14sm572316ljh.60.2019.05.24.08.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:35:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v3 0/8] NVIDIA Tegra clocksource driver improvements
Date:   Fri, 24 May 2019 18:32:45 +0300
Message-Id: <20190524153253.28564-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series primarily unifies the driver code across all Tegra SoC
generations. In a result the clocksources are allocated per-CPU on
older Tegra's and have a higher rating than the arch-timer, the newer
Tegra210 is getting support for microsecond clocksource and the driver's
code is getting much cleaner. Note that arch-timer usage is discouraged on
all Tegra's due to the time jitter caused by the CPU frequency scaling.

The series was extensively tested on Tegra20 and Tegra30.

Changelog:

v3: Fixed compilation on ARM64. Turned out that it doesn't have the
    delay-timer, thanks to Nicolas Chauvet for the report.

    Added new "Support COMPILE_TEST universally" patch for better
    compile-test coverage.

v2: Rebased on recent linux-next. Now all of #ifdef's are removed from the
    code due to the recent patch that generalized persistent clocksource.

    Couple other minor cosmetic changes.

Dmitry Osipenko (8):
  clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
  clocksource/drivers/tegra: Unify timer code
  clocksource/drivers/tegra: Reset hardware state on init
  clocksource/drivers/tegra: Replace readl/writel with relaxed versions
  clocksource/drivers/tegra: Release all IRQ's on request_irq() error
  clocksource/drivers/tegra: Minor code clean up
  clocksource/drivers/tegra: Use SPDX identifier
  clocksource/drivers/tegra: Support COMPILE_TEST universally

 drivers/clocksource/Kconfig         |   4 +-
 drivers/clocksource/timer-tegra20.c | 276 +++++++++++++---------------
 2 files changed, 127 insertions(+), 153 deletions(-)

-- 
2.21.0

