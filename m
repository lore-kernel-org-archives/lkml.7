Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07707C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C852087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LsF8PBSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfCAKxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:53:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42457 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCAKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:53:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so11258483pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 02:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3fRrDsmK1ByhQ9oou21D3uLddzCzDQbGOSeHbzpJLTI=;
        b=LsF8PBSaxbY+fPYf0z4vnlbsuWkfE2mmWCOSOVevDJlJ7aFhtU5E7yHlG1Yf/o3fCU
         6itZ2jdL3AX7YwJ+5t9Yv8uD2dXYaW7AXJywIyiF3ZkpsaXaLyLjY+jrXoDlfGU8WqbT
         joalnXSOvvdUie6GDgmLK0kRASMTFHf1Un+WUgoaG7is7R10Ppjo45N8OpUJ0rOTBXi/
         Ke87bTRstjOZ+Ory7vk4XjplpUT5+fXAeQBGthqkMbbEy5ZYWuuK+ZI9MiAPLAmTOkT+
         Ez0xT0L6Gb+dcTAzZqB6ZmoXHD1RqyzII3f5kQVuV8UqbE69ZyK8QObuEnJoxwRiK+08
         44gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3fRrDsmK1ByhQ9oou21D3uLddzCzDQbGOSeHbzpJLTI=;
        b=ePyVNg74jGGRbjsgPNWC/1rXybDDYYmuUJ5zcB2nGo1w322Tn3hMuqi9XoMRHIcvk2
         SHW3TcV9pToKhh+DIfUOl5bMkBPlREuxJzdTlyWZm0cBRCl9jfqeLkB0bo1bWnDqkcQ2
         fYrj99DXFQmET7B9F4u9AtqkormhGwYWLunNRx1EoRa5II+v32sBX1T3vl36FSrbPs8J
         xumy0RQvHNVAsm2bkT8nCxVjDXwnKgwOm2EyH38KcpBT7xFnSaI+EAvAosD/T8sAFusm
         KAqqdnXQ9a8kTMstjWUxT7F/bY0+2Dvr8L95f9aAWkbhApx7dPedU4oKSTnYX7bO84A3
         Mtvg==
X-Gm-Message-State: APjAAAVMGDozbDHfd5gu/j+38xFkZ85AXeTzNxCs7YHK7XNM6IJfPhr1
        nLGZGHZ+MS/6nsjbPs/8esOFQQ==
X-Google-Smtp-Source: APXvYqxmRvaIlL2QRp0LXXjmWsHxks8Okf2Ow661yCdYgpG5PgIopLk8QDFeOFRzLvRs30EGbs5QXg==
X-Received: by 2002:a62:4287:: with SMTP id h7mr5023925pfd.110.1551437620632;
        Fri, 01 Mar 2019 02:53:40 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id k74sm49239164pfb.172.2019.03.01.02.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Mar 2019 02:53:39 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v8 0/2] PWM support for HiFive Unleashed
Date:   Fri,  1 Mar 2019 16:23:17 +0530
Message-Id: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

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
 drivers/pwm/pwm-sifive.c                           | 345 +++++++++++++++++++++
 4 files changed, 390 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

