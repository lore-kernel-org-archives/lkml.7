Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6566C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F28A2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fdO3JfgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfCTLxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:53:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45229 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfCTLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:53:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id v21so1749820pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/bJv9DuAM2pvfcOoOnP+vj4tP5tECf/i0mClvD8AEJk=;
        b=fdO3JfgZrTNp9uy82okXfuvE0KpIXfP4SmG75FdqKVuGqMOSW+kLv6pHOO7E0ruj+2
         wrp6L2tk/eDGfOKdB9yXIWgNYfq7kpeAmxgbSMpwMRIvE1C4loD6gDMM3KQRhr2VBcI+
         ZDUJwFYAB5dy+rwuxbZEwBs8IPCTBqYXSLbZCyEFvqSrZtdEkhEPP4H7EebYvropxPhO
         uxxO0DxCtD0GvRwMpUXhfSnDxkvAOLyVxa7uFt5p2EviWeot17c75DKdq5Uthm+MOcr0
         Maps2bSGmACCl/cneOPyMBAvhzg6GxzJroZ/l75/1fnMxHdg6nmRL19MK0GSuvjr+oNy
         mwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/bJv9DuAM2pvfcOoOnP+vj4tP5tECf/i0mClvD8AEJk=;
        b=mr+fRt5dKGeFE8WzYUk+Hrjzvm7sF5A0rCl2s5BlY7XHEFkniHgwQfBaVngJxQnkfR
         YMSK2NL3ILQVBvxQV/IxVYN5u1LoSIkCEgC6CtawmZwCISnoSayNP0D9DaT2JYjPje1d
         6712CytmRJXNiSUgM/wr3rc9GsV9M7wYLfmNqeN04lFFI+RmFubaeFPN9Fk4BlVLXu79
         sZ5z/EMeoxTf7KP2pNQKL/WfN+1LGX6ED5FYz1/Nt6IJvClbWglnoWBT6AoI2XigzYx9
         papcj3TixmJeX8QFmkBAezW9oIAGB95UAfE1HsKCEKeZMUcb+5kEgUIwaS4wOmgTOSUg
         cmBg==
X-Gm-Message-State: APjAAAU21Psh5TQ9A/S8WyjGzLLsRUvIoSaMrOXm2Y0TZ7ZfT5nWEugp
        xjK0O0TnQzXi9sJsxEboE5VfMg==
X-Google-Smtp-Source: APXvYqxhNTKxGiSZcyTfaxPZffk1AyonVYUpmBTQNMKUdsKk3SjMnpPOAlRt7jZaQUZX/GU26WDQrQ==
X-Received: by 2002:a63:1f61:: with SMTP id q33mr7029298pgm.325.1553082814378;
        Wed, 20 Mar 2019 04:53:34 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id u10sm1999435pgr.2.2019.03.20.04.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 04:53:33 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/2] EDAC Support for SiFive SoCs
Date:   Wed, 20 Mar 2019 17:22:06 +0530
Message-Id: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds an EDAC driver and DT documentation
for FU540-C000 chip.

Initially L2 Cache controller is added as a subcomponent to this driver.

This patchset is based on Linux 5.0-rc8 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be
found at dev/yashs/L2_cache_controller branch of:
https://github.com/yashshah7/riscv-linux.git

Yash Shah (2):
  edac: sifive: Add DT documentation for SiFive EDAC driver and
    subcomponent
  edac: sifive: Add EDAC driver for SiFive FU540-C000 chip

 .../devicetree/bindings/edac/sifive-edac.txt       |  40 +++
 arch/riscv/Kconfig                                 |   1 +
 drivers/edac/Kconfig                               |  13 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/sifive_edac.c                         | 297 +++++++++++++++++++++
 5 files changed, 352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/sifive-edac.txt
 create mode 100644 drivers/edac/sifive_edac.c

-- 
1.9.1

