Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5EC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF28220659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpO9lcJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfGPJtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:49:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35753 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:49:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so8863759pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOxxYg1gkl1a/ysoqs6BZ37K9CF/kS15FrSEdYGMrcE=;
        b=EpO9lcJJCleKXGgnbBcmT0vu4HaYAgr9cMkeEXTp7CyyD4yV+yFnl1mxqPgDrOOQFv
         uX4IGgyhvlC0Ycx0OgWkLzAlykS9IJaLFR2yukDVSE+KIOS23muUiLalQLQa03Wse+/Y
         FIaNNN0uwHO6LUKp+rICHDSjzUm8mrleslaGLlOHrsYK0tU9PucY0BVtOnLOBG1WYHJT
         Y41fadi2cSZHeYEnTHQY9LiafFF2DeAdHLwZ6m+FmkVnzFZMM3swsG+hfik7+0CzsULk
         CfxvI0eWRu5hr0QvUkVSUcvOiO4XnmJcvSFY/IXMPQ2Dp5U1QyJgJ6fT0ADilqS/soWL
         b0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOxxYg1gkl1a/ysoqs6BZ37K9CF/kS15FrSEdYGMrcE=;
        b=YI/L7tzJOHHZGY5lgG5xgG7fN91Ewz9g4CUPlSLQy8PTHnADxjIzVDfEXAOLtuOq7E
         MrXtUHT0te1Pa4DBoStj9cPoxlNxpFcoHdrcWCmO6e3DPH6QN8TRX7+rJ8vPwYjBJ16M
         zm3ci3Kwzjx2YhrTlW50wGWEEmGgwbSXWOsRtHchSgnED5hCWDM+INMEfqRsaa3+q9Zy
         937uCjHq9bRKyw1X7dmXD++NSwc6Tl7SVmzmI1r/8ts+tzP5k6v6hFNyPAH7jCc2KjcW
         RLFML4+LkYz+Y7Qz0p6kDpfmc9mr+gmgNTPh/vjBg2VMmDbYmK2lz28TA6liXsVr1EfW
         p+RA==
X-Gm-Message-State: APjAAAVZQm2P8yG7DdOhAE13n11ujJdqi1QOfPdCxjKM+Xzcf7Ksv2Wg
        htF3c0Aba+qYmEKMT5QMFT+HpQ==
X-Google-Smtp-Source: APXvYqw5SKHgwSs1ZhYtTM+f2bW5/Eb88H6yQX28Ko/X85JMot8sov7jCBSAQXBcHVwxNzo9et7lnA==
X-Received: by 2002:a65:4189:: with SMTP id a9mr7021968pgq.399.1563270563855;
        Tue, 16 Jul 2019 02:49:23 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c69sm22793150pje.6.2019.07.16.02.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:49:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javi Merino <javi.merino@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, devel@acpica.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/10] cpufreq: Migrate users of policy notifiers to QoS requests
Date:   Tue, 16 Jul 2019 15:18:56 +0530
Message-Id: <cover.1563269894.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Now that cpufreq core supports taking QoS requests for min/max cpu
frequencies, lets migrate rest of the users to using them instead of the
policy notifiers.

The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
the policy notifiers aren't completely removed.

Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)

This has already gone through build bot for a few days now.

--
viresh

Viresh Kumar (10):
  cpufreq: Add policy create/remove notifiers
  video: sa1100fb: Remove cpufreq policy notifier
  video: pxafb: Remove cpufreq policy notifier
  arch_topology: Use CPUFREQ_CREATE_POLICY instead of CPUFREQ_NOTIFY
  thermal: cpu_cooling: Switch to QoS requests instead of cpufreq
    notifier
  powerpc: macintosh: Switch to QoS requests instead of cpufreq notifier
  cpufreq: powerpc_cbe: Switch to QoS requests instead of cpufreq
    notifier
  ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier
  cpufreq: Remove CPUFREQ_ADJUST and CPUFREQ_NOTIFY policy notifier
    events
  Documentation: cpufreq: Update policy notifier documentation

 Documentation/cpu-freq/core.txt            |  16 +--
 drivers/acpi/processor_driver.c            |  44 ++++++++-
 drivers/acpi/processor_perflib.c           | 106 +++++++++-----------
 drivers/acpi/processor_thermal.c           |  81 ++++++++-------
 drivers/base/arch_topology.c               |   2 +-
 drivers/cpufreq/cpufreq.c                  |  51 ++++------
 drivers/cpufreq/ppc_cbe_cpufreq.c          |  19 +++-
 drivers/cpufreq/ppc_cbe_cpufreq.h          |   8 ++
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c      |  96 +++++++++++-------
 drivers/macintosh/windfarm_cpufreq_clamp.c |  77 ++++++++++-----
 drivers/thermal/cpu_cooling.c              | 110 +++++----------------
 drivers/video/fbdev/pxafb.c                |  21 ----
 drivers/video/fbdev/pxafb.h                |   1 -
 drivers/video/fbdev/sa1100fb.c             |  27 -----
 drivers/video/fbdev/sa1100fb.h             |   1 -
 include/acpi/processor.h                   |  22 +++--
 include/linux/cpufreq.h                    |   4 +-
 17 files changed, 327 insertions(+), 359 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

