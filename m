Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D598220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFU0EUIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfB1N71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:59:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34189 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbfB1N70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id l5so17232655lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fIxnpfTVRo4NqTG5VV5AlJ5Aa6I4ShK+i0R4B6GW15c=;
        b=HFU0EUIkFncF3jV5TSFJxzyIka13FnPpFxqA552ehqSZHqj3DSBUnCge5GdAGbFiS3
         gUUh+Udg8zGWQUK6lABMAAcCDP1k7bqb83dSr3IeLwM3YmpyIQZSY9AC9rFubfeRraeB
         GF4x5dSaBDmQ84sRkm6prj+r6F4IwGb+rJgpuM1RBlWLY/0bn4vOX5MNXSzhGd6wCsW/
         n4UxM1xVTZUbYC3Rx1Uk1Kk+3AyHMM/vZ5sPDTCmrDgTvCPwX3v6Gpai2+nurBdWyCyM
         vupSPX7Rbw1lELDiKH58KDGpKFcM5ZvXGYhcO+868DONwakXg4Mk0XAmz9IVwOnpRnSB
         VAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fIxnpfTVRo4NqTG5VV5AlJ5Aa6I4ShK+i0R4B6GW15c=;
        b=CV0WSNrfB9P8E2wNTH+NHaBj+k59mY3p7mc+NuTVsC8Fp2V3k3MxRKSu155HncNTBa
         24W3omdrQ3hO5qzM3vWdG8BDvgGUSWHjXVWSgsCKvAjldMDy42xYLcodNbS7t4uw7aoo
         rWf4ySn7uJLKGlXEhcH9Pa+7Z6GkBDUGo85iA4pAQcJqTCWY+n5wF+C5ftZgS1+Ad7Lz
         IfOl3eQtq7qiImlrjJSR0mQG1S4zp9voHSfCll5BhgVcUj8fnfI4DkIlOdvxw2v9QZ8G
         1UJDLdELag/t3ni414NSpfNxinqF9Ew5jDEfllFPY+XxZ2lJf4W4xlJR1IdYy+keQZwB
         V8ZA==
X-Gm-Message-State: AHQUAuY5F0n32HvGyj05z+k2s7j1mytqaQwR4TZlTgoaqoTubQLSidma
        gcNX5KCpPnkXzwBAylcQurPhKg==
X-Google-Smtp-Source: AHgI3Iba1tmoGWaqmJvAgv0DWF/bI5FNwKcCY5PoKkrjmdfh1AFwNiQtUFDdbdwzrhyunz1qAqhrlQ==
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr5043730ljk.64.1551362364517;
        Thu, 28 Feb 2019 05:59:24 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v20sm4090265ljv.83.2019.02.28.05.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:59:23 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] drivers: firmware: psci: Some cleanup and refactoring
Date:   Thu, 28 Feb 2019 14:59:12 +0100
Message-Id: <20190228135919.3747-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of these patches have been sent earlier, but part of a bigger series [1].
Instead of waiting for that series to get reviewed and accepted, I have split
it up, such that these trivial independent cleanups can go in as a first step.

The only intentional function change, should be the last patch, where we start
checking if PSCI OSI mode is supported in the PSCI FW and print a message about
it, as that is quite useful information for the user/developer.

As there is a ARM/ARM64 "tree wide" change included, it would be nice if
this could go in already for v5.1-rc1, to set the foundation for the next cycle.
I know it's *really* late for that, but maybe Rafael can help take it via his
pm-tree, if all acks are received of course?

Kind regards
Ulf Hansson

[1]
https://lkml.org/lkml/2018/11/29/1801

Ulf Hansson (7):
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  ARM/ARM64: cpuidle: Let back-end init ops take the driver as input
  drivers: firmware: psci: Simplify state node parsing
  drivers: firmware: psci: Simplify error path of psci_dt_init()
  drivers: firmware: psci: Announce support for OS initiated suspend
    mode

 MAINTAINERS                                |   2 +-
 arch/arm/include/asm/cpuidle.h             |   4 +-
 arch/arm/kernel/cpuidle.c                  |   5 +-
 arch/arm64/include/asm/cpu_ops.h           |   4 +-
 arch/arm64/include/asm/cpuidle.h           |   6 +-
 arch/arm64/kernel/cpuidle.c                |   6 +-
 drivers/cpuidle/cpuidle-arm.c              |   2 +-
 drivers/firmware/Kconfig                   |  15 +--
 drivers/firmware/Makefile                  |   3 +-
 drivers/firmware/psci/Kconfig              |  13 +++
 drivers/firmware/psci/Makefile             |   4 +
 drivers/firmware/{ => psci}/psci.c         | 114 ++++++++++++---------
 drivers/firmware/{ => psci}/psci_checker.c |   0
 drivers/soc/qcom/spm.c                     |   3 +-
 include/linux/psci.h                       |   4 +-
 include/uapi/linux/psci.h                  |   5 +
 16 files changed, 113 insertions(+), 77 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (91%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

-- 
2.17.1

