Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18918C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FF421881
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WV5CpTWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfFQET4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:19:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45330 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfFQETz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 00:19:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id s21so4997391pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 21:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PzMic+UPAsRVZkkITfxZ+ge6idfcXfDdmr2qhDqY6n4=;
        b=WV5CpTWuXXki19nzu6N9H4WFS+1qFX4Zn9NZINa28o8wbNhwpfTRfiK1GElM4cY1Tr
         OXwKzfSGQ693mK5rBKum59OYO2Y/KE/N3/CBYGMGAj2tEkmmhL2LEVCNVp/ToqEwDUpt
         uIvKHLfQOxOAuR7Aym33NV5f0w8cK331vvlJ4Ixgw8MGbYMfFxzaBdERtR2DZ/VfG7ge
         BnpyGAvqcm9fWzqaXzH0aPqEWuOuWJNrwKmsTg/IPnitfm8/ic0u/w7uhRaak9ZVuScn
         H9pzpxSllmqXDtktC9e9QljAfuQV1BovQlbSOoJ4vnQCVmVOuOEp+6Ee3qRwTEoj1ylE
         gyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PzMic+UPAsRVZkkITfxZ+ge6idfcXfDdmr2qhDqY6n4=;
        b=mn17ZQO6X68Tdl8/6hXNUC5AzodLNFes5S+ODBRnIR9adPtEmAfuwCzAagWL9/Df/w
         1H4e62wRGrT8RtV9QqpkCc3IA+OVBoZ94PgkVgt7w+SCzSQI6QdCcTjCd+mQcJWJNWbg
         mDl86O+Wauh2MSAQE39i5yCbCjXQSyq1BZxDxVJcT+RSF3Khi8jKuYemum53XrCEa+q/
         0dOOMCBZM3vPOh6AlKDd7b9FycQ7UI7dtFn87kebBMGlVsVJxd+be6xisbcc8ouoYbTK
         bXwVx/Tul+yMKPUdQfKLLpIVlp/J3heQbzh1BpjIO4JTHGGJudKyZDt2XE1ZE7jAzy5K
         FEUg==
X-Gm-Message-State: APjAAAUd8CVpGlGUSTJ9K8P9a8XxxgQiLGk/4lr0omdigxxBJ2HA8C9X
        kZg+zHfdOJr4Jio+JnY6LKMIkQ==
X-Google-Smtp-Source: APXvYqxku2gBiJg02TLyfOFVgeYhsUcEMfbEDv7QwSe2WVsfh8XaKgPFs07+kEEOLES3+KCMvShowg==
X-Received: by 2002:a63:5c16:: with SMTP id q22mr15119353pgb.200.1560745194961;
        Sun, 16 Jun 2019 21:19:54 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id e184sm14485615pfa.169.2019.06.16.21.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Jun 2019 21:19:54 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     davem@davemloft.net, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com, ynezz@true.cz,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
Date:   Mon, 17 Jun 2019 09:49:25 +0530
Message-Id: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On FU540, the management IP block is tightly coupled with the Cadence
MACB IP block. It manages many of the boundary signals from the MACB IP
This patchset controls the tx_clk input signal to the MACB IP. It
switches between the local TX clock (125MHz) and PHY TX clocks. This
is necessary to toggle between 1Gb and 100/10Mb speeds.

Future patches may add support for monitoring or controlling other IP
boundary signals.

This patchset is mostly based on work done by
Wesley Terpstra <wesley@sifive.com>

This patchset is based on Linux v5.2-rc1 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be
found at dev/yashs/ethernet branch of:
https://github.com/yashshah7/riscv-linux.git

Change History:
V2:
- Change compatible string from "cdns,fu540-macb" to "sifive,fu540-macb"
- Add "MACB_SIFIVE_FU540" in Kconfig to support SiFive FU540 in macb
  driver. This is needed because on FU540, the macb driver depends on
  SiFive GPIO driver.
- Avoid writing the result of a comparison to a register.
- Fix the issue of probe fail on reloading the module reported by:
  Andreas Schwab <schwab@suse.de>

Yash Shah (2):
  macb: bindings doc: add sifive fu540-c000 binding
  macb: Add support for SiFive FU540-C000

 Documentation/devicetree/bindings/net/macb.txt |   3 +
 drivers/net/ethernet/cadence/Kconfig           |   6 ++
 drivers/net/ethernet/cadence/macb_main.c       | 129 +++++++++++++++++++++++++
 3 files changed, 138 insertions(+)

-- 
1.9.1

