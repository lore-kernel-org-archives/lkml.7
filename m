Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E7F20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SZrZbABi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfCYKNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:13:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32784 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbfCYKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:13:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so6084785pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GMLtY2GdyWG9nrbKnq835v1bpH/NP2f++yUPdpGeCec=;
        b=SZrZbABiXkdtvhDsRc1WxVg0Hd7jjeXCe/sJEIOcOX6wXZCPDi9gUc2qNy+uTOEazN
         dMGRDVVisIevy3x0SlKbSJeuLfCOrnR7nZLjWBPCOiw/AzCgWLivzJarTdCySUJGz2NI
         Lp3LSNTv+XodtFDCY7KOxLi5JxA7US3/Th08Icr3ScR012zJ37f1yXP6xKL5tXebCa3X
         HPHcDJscpl/yIZKBKds+mAxvVNFKq6oc0medOPY8QSzTzIw7A+/JSxdhM/4DyMIt4TgE
         xfSB/4FhVhvCGSJzwhcy8JwJO17M5OuboYEYUjufsBpYmkrxWxO+CldEyZAgHxu2ZagP
         5FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GMLtY2GdyWG9nrbKnq835v1bpH/NP2f++yUPdpGeCec=;
        b=JsVjLmcOcv6h/grFugGNBJFprdsMKZdh7XfZ2kX2akOqg3l2xdtsRJ8uLYTjxhwRmk
         Ipde1f0L5rqDrD7ZUtbwmuWzX7Ct3yF1zUER25LN6asiF/q+leKvbAVfTpNyHJxm6xmI
         +y7l0Cn+fst13H7Kt1qoA1TJ+/PFjaaDc2KNFJS2CmmlJXxF6uhJw8+qEZ/U/1BMt/As
         8RkeD7v/iTCnWK/W/z4tHlCIlViLJIRQrses3BCAFYlknZb1cJ1/Z3RmZc1HtjQHiPsy
         1SEmZRUSIAwFP+iwBHfDqTMRTY6YXu5Ev4jRWJn/1WsI1+B46dBs746I8hbniuwJ1Rmf
         Hokw==
X-Gm-Message-State: APjAAAXXqPktTHV5mbZKMMd6KxWoJDP66fD7LnafRO5HZ6+wrv4SAJPo
        98/zQ4iwHhAdmRXvtJ0cq8/KPynv7os=
X-Google-Smtp-Source: APXvYqzXmUosXuZwyVc1SD/1egp/DQDVX1Y0hJ70xgxB7mbHyy8wqSpOK/TmEuszhmSX5N3OTrPTOA==
X-Received: by 2002:a17:902:be04:: with SMTP id r4mr10918931pls.218.1553508797866;
        Mon, 25 Mar 2019 03:13:17 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id v82sm30151298pfa.170.2019.03.25.03.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:13:17 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v11 0/2] PWM support for HiFive Unleashed
Date:   Mon, 25 Mar 2019 15:42:57 +0530
Message-Id: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

This patchset is based on Linux 5.0-rc1 and tested on HiFive Unleashed board
with additional board related patches needed for testing can be found at
dev/yashs/pwm_5.0-rc1 branch of:
https://github.com/yashshah7/riscv-linux.git
 
v11
- Change naming convention for pwm_device and pwm_sifive_ddata pointers
- Assign of_pwm_xlate_with_flag() to of_xlate func ptr since this driver
  use three pwm-cells (Issue reported by Andreas Schwab <schwab@suse.de>
- Other minor fixes

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
 drivers/pwm/pwm-sifive.c                           | 338 +++++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

