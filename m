Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02934C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C507F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SAbwpz8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCRLrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:47:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44549 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfCRLrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:47:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id a3so11067866pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3IvVN6bHe9Zm36t3Y+tbmGkwIFb1zRc7DMqJgbAOWIQ=;
        b=SAbwpz8rOcLIu5bx6r3dCXj/pOctJyfExLq1swAZVP0Gg/afhCsdwFBEC68cHHfws3
         4gIlpQR+y7D0Cj+Z19yZyBeeu5UOdVi+MpCGr8jqYVea4uGUvHtU6Ya/vhodAhrUUD1g
         yt3spZlW/oYCRxNbSeMrxWbbFSOfpj/SeT/mBhepvVERzQY3cRoj5asKQzHZ2/o+YqGD
         RGMNNWmNZxFxcL4GWUMCyw5BVC28A94swCZsKo1Q14k5Mgu7XPN5rbYl9wk+1MuZHh22
         UfVIjtUi7HiNvdqFHr+AC6ae/nwHrsfmODM51aEkAdN/nvmqaqakLh8Fmnv+dNSLX8Z0
         2/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3IvVN6bHe9Zm36t3Y+tbmGkwIFb1zRc7DMqJgbAOWIQ=;
        b=EeMnAV2yY7C8kMRD1M13ZBgu8l6gzEtpZEOXX6a2nRUUVrlb/aloRvkJ5fuNNlPNZj
         /byyz5OxUNbZQ8zzB6laZ2NBYY9dI+ggQ93MOqFPY0GgQHbcNFVBqR+6y+SiGzw2D3eh
         MGhrcJnuPW8xSyltj/jzvajR0G8LhRn/BOkXmsjW/oGm+t3YASpFBSDlEqZ07LoHynj3
         2nWpOE+k6iWHV2+cU+ddKh6u1hjVjDT+6qhg8UbvI4YWjXCL1/LdqOnxWvBvAX2OmpOZ
         DoA6tWOmUoPOnQsYHYsYZM8CBNnczMSojxuEVDk1CY08weeuTlTXOWQ7Bhfa1ooQOIo4
         zIhA==
X-Gm-Message-State: APjAAAVYANdIcJg52oOvr7N1kIJzPagRsxyTt5nk0+j/RRhjzJoOCZG9
        +TprGeMZOR//LhfpZNeKZFpF6A==
X-Google-Smtp-Source: APXvYqwQoKz34wHhI/asX2cwSEGbZL6lTCuSL0ONgq7n8XuOeOQKjEhc92X46BFGGs+3RtTdr/cCpg==
X-Received: by 2002:a63:7843:: with SMTP id t64mr17366051pgc.178.1552909657742;
        Mon, 18 Mar 2019 04:47:37 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p5sm14403911pfn.154.2019.03.18.04.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 04:47:36 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v10 0/2] PWM support for HiFive Unleashed
Date:   Mon, 18 Mar 2019 17:17:12 +0530
Message-Id: <1552909634-18757-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

v10
- Use DIV_ROUND_CLOSEST_ULL instead of div_u64_round
- Change 'num' defination to u64 bit (in pwm_sifive_apply).
- Remove the usage of pwm_get_state()

v9
- Use appropriate bitfield macros
- Add approx_period in pwm_sifive_ddata struct and related changes
- Correct the eqn for calculation of frac (in pwm_sifive_apply)
- Other minor fixes

v8
- Typo corrections
- Remove active_user and related code
- Do not clear PWM_SIFIVE_PWMCFG_EN_ALWAYS
- Other minor fixes

v7
- Modify description of compatible property in DT documentation
- Use mutex locks at appropriate places
- Fix all bad line breaks
- Allow enabling/disabling PWM only when the user is the only active user
- Remove Deglitch logic
- Other minor fixes

v6
- Remove the global property 'sifive,period-ns'
- Implement free and request callbacks to maintain user counts.
- Add user_count member to struct pwm_sifive_ddata
- Allow period change only if user_count is one
- Add pwm_sifive_enable function to enable/disable PWM
- Change calculation logic of frac (in pwm_sifive_apply)
- Remove state correction
- Remove pwm_sifive_xlate function
- Clock to be enabled only when PWM is enabled
- Other minor fixes

v5
- Correct the order of compatible string properties
- PWM state correction to be done always
- Other minor fixes based upon feedback on v4

v4
- Rename macros with appropriate names
- Remove unused macros
- Rename struct sifive_pwm_device to struct pwm_sifive_ddata
- Rename function prefix as per driver name
- Other minor fixes based upon feedback on v3

v3
- Add a link to the reference manaul
- Use appropriate apis for division operation
- Add check for polarity
- Enable clk before calling clk_get_rate
- Other minor fixes based upon feedback on v2

V2 changed from V1:
- Remove inclusion of dt-bindings/pwm/pwm.h
- Remove artificial alignments
- Replace ioread32/iowrite32 with readl/writel
- Remove camelcase
- Change dev_info to dev_dbg for unnecessary log
- Correct typo in driver name
- Remove use of of_match_ptr macro
- Update the DT compatible strings and Add reference to a common
  versioning document

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 ++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 334 +++++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

