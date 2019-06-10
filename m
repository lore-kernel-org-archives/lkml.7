Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C4C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDB22082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcgbprTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbfFJKvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:51:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33477 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbfFJKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:51:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so4351006pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nrRXRZLGYNCevB7P9G3OypvWpceLIiQ3ZsEEykg2uo=;
        b=kcgbprTvW7V6ti9e2eqMCTo+r0IkcXNP3aoI3bJr+vpxKG+hZGfrsF0QSplUGzrwhp
         1hYixkVbW/8RDdREbEjyH9YJhd4IaqEOTSw7d6xsjNLU1vmIbUdhVafW6PHj7jJEuy6G
         D9zC/DPQBUzyhzTb7Lt+YgG7+YJXTozze7YjSvSQ3r/gy31bFfbXIJrbgnulgLqLIEn2
         Vy7H4zYXdhAgTdqSn174uwtPI64/2dEj9dydKFIIvo17BE0sGuxjyag/dj7mX+b2L4ZC
         PZs6ufhW5SkDVK4ygXKSkxzmIc8efcnz0IsMSGDPXVEcX7R3NNesnOBojR1dShR0bn29
         bVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nrRXRZLGYNCevB7P9G3OypvWpceLIiQ3ZsEEykg2uo=;
        b=SmPmgdBogd/22+XesYQ8AmteG+gzM93F1rAtdm6dFXV1i8hOiSVcfdLU2CGiJYVwHB
         +QB7NQL2cMXYUV1/9vcJURRyaSFzIJYtSYrQWByxV8a0KvJRk+yoiFibFlhyqNGF5LX8
         kBIzpAKQYQFBTdWVKTkIrzbNCFwb2A6WSRGpbmrzHwF1bP1tsTB8KGWjmqRqgCeh8zuW
         oe4zEHl31RmnYHKa77uJjyIM/LeZQLKbUvp6vVs1fOyCAuG+2aa9mfZ2CpHQrmFmnEi5
         mh3SyPLdOZaIwiUqSGptsOS6kT1C2FlmS1iIcD6vFz8b5EEiwgjbnRxxlyFZlz/f6q8u
         +fLA==
X-Gm-Message-State: APjAAAWqKK8e9oQIiSApkl2v39Qpp3DLkUwCmLkPnOTy6443WMKgVdSu
        YpAMIVuDHszvLeoG39UErh2Ovw==
X-Google-Smtp-Source: APXvYqyGlVDir430MCaqbMXQr7mk1OEzFBHQegeaPhz5iaPiwEcmW4FtmltmprADvphfod21ZvUIbg==
X-Received: by 2002:a17:90a:a785:: with SMTP id f5mr20588788pjq.4.1560163911094;
        Mon, 10 Jun 2019 03:51:51 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id y22sm5484067pfm.70.2019.06.10.03.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:51:50 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/5] cpufreq: Use QoS layer to manage freq-constraints
Date:   Mon, 10 Jun 2019 16:21:31 +0530
Message-Id: <cover.1560163748.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset attempts to manage CPU frequency constraints using the PM
QoS framework. It only does the basic stuff right now and moves the
userspace constraints to use the QoS infrastructure.

Todo:
- Migrate all users to the QoS framework and get rid of cpufreq specific
  notifiers.
- Make PM QoS learn about the relation of CPUs in a policy, so a single
  list of constraints is managed for all of them instead of per-cpu
  constraints.

V2->V3:
- Add a comment in cpufreq.c as suggested by Qais.
- Rebased on latest pm/linux-next.

V1->V2:
- The previous version introduced a completely new framework, this one
  moves to PM QoS instead.
- Lots of changes because of this.

--
viresh

Viresh Kumar (5):
  PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
  PM / QOS: Pass request type to dev_pm_qos_read_value()
  PM / QoS: Add support for MIN/MAX frequency constraints
  cpufreq: Register notifiers with the PM QoS framework
  cpufreq: Add QoS requests for userspace constraints

 Documentation/power/pm_qos_interface.txt |  12 +-
 drivers/base/power/domain.c              |   8 +-
 drivers/base/power/domain_governor.c     |   4 +-
 drivers/base/power/qos.c                 | 115 +++++++++++--
 drivers/base/power/runtime.c             |   2 +-
 drivers/cpufreq/cpufreq.c                | 203 ++++++++++++++++-------
 drivers/cpuidle/governor.c               |   2 +-
 include/linux/cpufreq.h                  |  12 +-
 include/linux/pm_qos.h                   |  71 ++++++--
 9 files changed, 325 insertions(+), 104 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

