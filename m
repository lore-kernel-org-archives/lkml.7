Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3507FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F1A214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Oxn2sPg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfCLILq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:11:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45397 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfCLILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:11:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id 125so1205644pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uR1gAPnmRxr5NSTo6n1j0Gxqlzn9eYUSnVyB9MH1y1A=;
        b=Oxn2sPg8/a4tvXYzBi6bMt2QtXR9ucK6nQNzoF/tNlGKlwsNvKQ2pH8G3eOCbFWF9p
         /wpGovgX5Kl0WkA5hV9zYprYcj9mJmFcBJn0G7naZZn2uy9QanP0jCVbD4523UqOkodj
         bpsmJuEDftRDsYwoSsfY1xndBoIBt+BOo+wiczbkiTTh8DkNT/UwKqZLI59te0apDi75
         cl5vKNvGHJjharHggTFMxnQg0jb2YbL6Ix5KZq4YOfiPrH0QSPRGoaRCTdmbxNQthmNu
         S8eTH3mXJ6USs6hlUH4+dihHaNrIkdmVwlRJRJnkrB8CtCRxjxICqXbfwMQVB0t2Vbcg
         es6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uR1gAPnmRxr5NSTo6n1j0Gxqlzn9eYUSnVyB9MH1y1A=;
        b=lL2P6qCsCcP4GLlqtu8s7znkvgEMTMr8evR//foSC80mHxtx8SM+ocSFJh8QaSgxOH
         ciAL9ezVpN5kozEB0RQZNt+ClEIjIWn8bpxdsqr+ZCCVF71/G/lLlZJjrw4sDkfQ0tzJ
         Lf9VtKZYQh8IGVpPe/sN7x7rd1xCQn4z0JFVkMxmEuW/mOzD3jocRf/QrN4//XOnAuCc
         mOfWuPYvrGVAAvEEt2PHkIoWa6zrO4lul1LIQ1zIpkls2oWTHaP1PeimCddA+wfKj2uC
         sjcur/qape+GuOIXkHC4Nj9KhJiuRWVPnxHo6wz+zPAr0x8Dx3Dcx6tKsNykj/mAgYd0
         VvxQ==
X-Gm-Message-State: APjAAAW1MOex+fEtNA+ixj47kNs7seG7TJuYVwrPhysZ4kaNcPiHFTyP
        ZDx0145y6XUgKFmwn/fvLj+ZtA==
X-Google-Smtp-Source: APXvYqy6rLqxE+SeKcyPKJOjSbAmd6+2lAup/y7OEH/09TNmGLAN2LtbEe7ciIOGpGB4At9CtDZLBg==
X-Received: by 2002:a62:560f:: with SMTP id k15mr36896540pfb.231.1552378304495;
        Tue, 12 Mar 2019 01:11:44 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id o5sm3687795pgc.16.2019.03.12.01.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 01:11:43 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v9 0/2] PWM support for HiFive Unleashed
Date:   Tue, 12 Mar 2019 13:41:27 +0530
Message-Id: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

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

