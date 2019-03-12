Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3798214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RGmsMOGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfCLJVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:21:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32866 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:21:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so1395815pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VaBKOjGbr/7EzlR3EouVAvjCAnoJlqVZbWJCrJEq/Eo=;
        b=RGmsMOGpXtu3KKjBuVygx/qN6Mtnq9zCgob5otktVlullDhIV2+7zAEIl9Q5uGKuJE
         oTdJYicKuuERk1xlfkXReL8z4+8jTw+Hva/8KIYAZSimIKpwWHBAmBKoGzDKjxc7uCix
         hdXvf5JV7r6C+Eo8WiqTnyosd5pqRnfFTZh5IuW6cFXl+jeUrUq0hI1maI6FprdR5bqM
         FGWuo11QvY9jRrIAZ4zAeAoSSGuw9Y/ynrMnRbxe6jy7jk8CuwlJIO6KT49VYI31MBWx
         e0/XcWpWKO1T0Oe1TogoBiK385Jwno0VE1j98PYZlGP6C0TDHgNHuVkoxrbO3TDQ/hyf
         Mdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VaBKOjGbr/7EzlR3EouVAvjCAnoJlqVZbWJCrJEq/Eo=;
        b=U0LyHt2DW8iaLkkAXTejGwtnLuB6LNlykrrXOGZxIQMby6+ZTCVac/dKL1S4HfVbh3
         jBNUHgSBZM7jeNkiUVTLM8QoKerQM27MMezrGQfyMo6ZG46VlvTtPYvI4IMxkjp6BERj
         CiUdmrcDMo6+MQqotPwbwzZ0cwVMJ2ynhRquZEopzs7q7z9IAKjL7bmvvy/GNLXHoYu1
         l11FtLI+b7NSZFMQq/MCtvWnWPvW6gdCT2M77mcgShfS+UtuRKItyCPzuvkgjvNUl67N
         tL8V/PXMToP3RYn96HJfB1LjrXq7aIyi+Yslj9wZGuvtrDqREUGn6UU4zHhXk1ur7AS4
         Akmg==
X-Gm-Message-State: APjAAAU4RAoP9B+fgiKDo2c1Z/Du+2Sh5RWByY5uG5j2CU9aeg8l+osN
        Z3YuXicckYOHPhCrnV9GEL7TyXbZIwM=
X-Google-Smtp-Source: APXvYqyxFZxnbwXujiMx5dkiJk+ConaqG0mWp78cSpLgPSnzDZwLq3jNbjTAjP3Rt6XZbqE1rhTadA==
X-Received: by 2002:a63:cd03:: with SMTP id i3mr25521894pgg.172.1552382478779;
        Tue, 12 Mar 2019 02:21:18 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d86sm17569638pfm.18.2019.03.12.02.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 02:21:18 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/2] L2 Cache EDAC Support for HiFive Unleashed
Date:   Tue, 12 Mar 2019 14:50:59 +0530
Message-Id: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a L2 Cache EDAC driver and DT documentation
for HiFive Unleashed board.

Yash Shah (2):
  edac: sifive: Add DT documentation for SiFive L2 cache Controller
  sifive: edac: Add EDAC driver for Sifive l2 Cache Controller

 .../devicetree/bindings/edac/sifive-edac-l2.txt    |  31 +++
 arch/riscv/Kconfig                                 |   1 +
 drivers/edac/Kconfig                               |   7 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/sifive_edac-l2.c                      | 292 +++++++++++++++++++++
 5 files changed, 332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
 create mode 100644 drivers/edac/sifive_edac-l2.c

-- 
1.9.1

