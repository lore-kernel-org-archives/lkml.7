Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA58C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6E92070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SE8Mnega"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfEMLgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:36:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45062 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfEMLgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:36:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id a5so6340706pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Fb/veKnGyDp8hXkKfJ4Q0+zLXcHapXdg1OxZTaiVz/4=;
        b=SE8MnegajciPpkWVJ3bjrJg/+Dip1PMvBNurM0aKdalPz4oR4x4yYveDcMWz8OEQHq
         J9MVQp4vBX6ff4/QzKfzPyfzyMAo5w7NyUyANFlqFRagc9LcpbYhIhQMqNAeNUoEkgth
         1/unQ/fyAS6T9UVRGsap2IMHkitsE8v2nOJZDVZoxCL9AHO3zsLSjP0Psl1KdwBIFmmy
         giDet+agKy9nJYSCh2IqIsJjXghT3dHQuFTZFT3ntgHsFtLiXkYV3CGPpONSIQTVzHlz
         183YAg3JYWkfOgTLmUIKL+wybYXpvMAX+gX2Pwc2/0jgzcARbdIlunXJ6T1zxzgBgn9E
         0F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fb/veKnGyDp8hXkKfJ4Q0+zLXcHapXdg1OxZTaiVz/4=;
        b=HvF2sUIHRLJYpgqlVE8g64ivSnjPj1IzV4KK+MBRwsTB4jf2Z7cYQ4WzezBCFCZiRG
         4weKdPxt8G9U27Vju4R6V/VU+ppTWJUStszAHxnnyM2LCUg2JRBhgDMzd0sqQnf7A+2q
         hk+uGN7ks/LE94kNar7tbc7GdZcnwHtJzKVRMllxxjSyvKXnetudeZzY4hXlGgRpcZ1t
         AawcXutA+2is6mibdcTAhyu7vxsnKbe6lpXKOJzOTXQfdGRG4fk4iW4MEW5m61b0aOtW
         +mqB38YkHxmPLI9Q+hKdRAnKEj+60cdzRVO9mWWe1ztgr7QsowrL/y9PEIjdwjwi3yR9
         9H6Q==
X-Gm-Message-State: APjAAAVp2LQnut4htYLh3Xryc9BZetXa480VgSp7r55JBay41rCVf0Gx
        eyj6aAv1YNCYuKYXaOS2DZ/BAQ==
X-Google-Smtp-Source: APXvYqwKjZpV/pDCZYH2704t0tvyeXKmd34Pjq0/pYTVJ+prbL7PjV6J3fy9y1fjyhqTQ/BriZeUcg==
X-Received: by 2002:a17:902:446:: with SMTP id 64mr29268102ple.322.1557747402600;
        Mon, 13 May 2019 04:36:42 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d15sm44657128pfm.186.2019.05.13.04.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 04:36:41 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        thierry.reding@gmail.com
Cc:     palmer@sifive.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        paul.walmsley@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v12 0/2] PWM support for HiFive Unleashed
Date:   Mon, 13 May 2019 17:06:18 +0530
Message-Id: <1557747380-12257-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

This patchset is based on Linux v5.1 and tested on HiFive Unleashed board
with additional board related patches needed for testing can be found at
dev/yashs/pwm branch of:
https://github.com/yashshah7/riscv-linux.git

v12
- Rebased onto Mainline v5.1

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

