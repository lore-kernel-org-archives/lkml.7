Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1B7C06514
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DD9218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWeNBkc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfGDHga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:36:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40179 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGDHga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:36:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so2639291pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HRLgsM/YRXffCDN0dNN2kJ7G9GZLkToihDfCd/KbHc=;
        b=RWeNBkc7jbRxcq/jToCqRSX7TpZu/Sxt4xherbLXDgW7CFwokq3TBp0AnHLDq5b0i2
         Rmqc4Z3aGr2wzmWWz8QCP5BGsJCZrqK8rx7Ao7kwo7Xrl0QV8GJg7ZtGTg1mBeQJFMic
         zYMgW3VLPPJVEl+MR1GE+OT93rVUmooSQRAED8wlQbDA/5Y5bfNjunKj1v4x6yQn5/DT
         x6mZEpW8a+YocNvyv+sSC1bWuSgeDxf+sg+2mi9jPxmGaJykE7dib2BubR7Wjpy6yy7y
         oHOmjpIRjYiWU0qkchxdvV2eg8YLReorwwZP6ipu8yrPFcRLmmEhnI6Cdu+8Nb4sXBjn
         YXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HRLgsM/YRXffCDN0dNN2kJ7G9GZLkToihDfCd/KbHc=;
        b=KtFMyZwJDYv10DFTkzsnfWC8Wir1QLkC/vfgEwSCxeW16Sc5KosQC0jxEgObnvq3jE
         V0UsVmm/PUByoajS9wO7yx5QDO4bZzI+kHiTdvAY5jSEZfjoXBymB6nhenANw8FBQadC
         QhYUStR1jthpe0nqGMLac6Bs7cUpQw0NPRATKIU96+AexIkq/8vZRim/u0+EmzFDvQmV
         RfO8gflw6txnrMaS1zn2Ns28DkvCv4FFYG9kYIk0tA54B3ol5cX7kdvG34ovZPaxseRK
         lvOsn3VQHgW95lpUMCxBTZJGhIaSkXNa35jl3IyBnvgs6wn4EboQWQN1sn4949QalITC
         uFHw==
X-Gm-Message-State: APjAAAVEbKUAyEJ1575eWlwUS6UAZi72+49INKUihRrf3AdSnpM3DqNk
        P7CeUC5IK2qWDCDL37TxGEP4Nw==
X-Google-Smtp-Source: APXvYqwYs6LSq7cyeou9/jnEoPLlcAis7RlPoTqhfVKxyGj6txSB5Q4CxW4Oe9vGrN4moSXypWmGuQ==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr1335671plt.102.1562225789355;
        Thu, 04 Jul 2019 00:36:29 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id y8sm5670277pfn.52.2019.07.04.00.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 00:36:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Len Brown <lenb@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V6 0/7] cpufreq: Use QoS layer to manage freq-constraints
Date:   Thu,  4 Jul 2019 13:06:16 +0530
Message-Id: <cover.1562210705.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry about another version after another round of embarrassment over
compilation issues. The same patches have gone through pm/linux-next and
linux-next/master earlier, not sure why the current issues never came up
before. Anyway, they were stupid coding mistakes :(

I have pushed these patches again for the build bot to test, which
should finish before these get merged in PM tree now.

This patchset attempts to manage CPU frequency constraints using the PM
QoS framework. It only does the basic stuff right now and moves the
userspace constraints to use the QoS infrastructure.

Todo:
- Migrate all users to the QoS framework and get rid of cpufreq specific
  notifiers.
- Make PM QoS learn about the relation of CPUs in a policy, so a single
  list of constraints is managed for all of them instead of per-cpu
  constraints.

V5->V6:
- Fixed compilation issues with !CONFIG_PM case on riscv architecture.

V4->V5:
- A new patch added, 6/7.

V3->V4:
- Few commit logs updated as suggested during reviews.
- Separate commit (2/6) to create resume-latency specific routines
- Reused earlier work ("update") for notifiers as well.
- Kept Reviewed-by tags as is as the patches normally got better only.
  Please take them back if you find any issues.

V2->V3:
- Add a comment in cpufreq.c as suggested by Qais.
- Rebased on latest pm/linux-next.

V1->V2:
- The previous version introduced a completely new framework, this one
  moves to PM QoS instead.
- Lots of changes because of this.

--
viresh

Viresh Kumar (7):
  PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
  PM / QOS: Rename __dev_pm_qos_read_value() and
    dev_pm_qos_raw_read_value()
  PM / QOS: Pass request type to dev_pm_qos_read_value()
  PM / QoS: Add support for MIN/MAX frequency constraints
  cpufreq: Register notifiers with the PM QoS framework
  cpufreq: intel_pstate: Reuse refresh_frequency_limits()
  cpufreq: Add QoS requests for userspace constraints

 Documentation/power/pm_qos_interface.txt |  12 +-
 drivers/base/power/domain.c              |   8 +-
 drivers/base/power/domain_governor.c     |   4 +-
 drivers/base/power/qos.c                 | 135 +++++++++++++--
 drivers/base/power/runtime.c             |   2 +-
 drivers/cpufreq/cpufreq.c                | 201 ++++++++++++++++-------
 drivers/cpufreq/intel_pstate.c           |   7 +-
 drivers/cpuidle/governor.c               |   2 +-
 include/linux/cpufreq.h                  |  12 +-
 include/linux/pm_qos.h                   |  48 ++++--
 10 files changed, 320 insertions(+), 111 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

