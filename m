Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617EC2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUJr9vAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfB1NSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:18:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43966 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfB1NSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:18:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id j1so15200956lfb.10;
        Thu, 28 Feb 2019 05:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a15wzvx7tFLD8LiZo50Ded0D042ullA6pwTPr/5iHRU=;
        b=HUJr9vAZvh/TW9bGAyDTWKkWHrPmvV0Pxy/1TiVl6XO6QgRg7vWbV6nKDEeNMRitAi
         791rEx42MP5STEkQTL2Nd17CoOn4x6pGCPmAHrAX4SiMyrsmUcONm66Nd8mLKBkBXOcj
         ie0dEIx3fbNMYkPeUGCC1dcoz+Iero/x2VwRI+sAx9RMDr1kXu0fEwUjO/hhaUrk4bZg
         9qQImsFx9EuT2ZYNXA2cCjetY0MzzPdweLfuP/Q6rcYrN97kn/z9y6egYK8jDgDDiMMm
         5kiXfd81FsevwDCoc+S2xuWUOC0uJQaDrZKAVqkZpkVTVDy712KY+ugd9OZRO8xoRabB
         2hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a15wzvx7tFLD8LiZo50Ded0D042ullA6pwTPr/5iHRU=;
        b=hO6HzRCagqTeG6jJoqtBeZ3SHqlcB+oOJjbh7zJtJKCy/jTxwDwz6tG9w4Wa0NKZ9M
         EihBzJz0r5nAT6sHqILvYpZpjYoUqy6nTq50ts+LaiNcN1rX6UzxR+T2I3X0R2NPJZUn
         JMlpogoW6nDBRaOyHpqRUfgYfvLNZLjdOgDBZ4gQtFgKCv0KBOqZrmfBagJj26dn3afz
         KISfANbGoTJNIdpXQaV6vthOEYkZY3l7nP4sQB3/M2sPf1XpwCuhaECsO9AnJ+i5WDLX
         LHdWi2rWMRWckqPat0cnip6xAIOcm3o7/ElwDMSmITUzxUmn5n3aigORCEv2D6aoFffH
         uxTA==
X-Gm-Message-State: AHQUAuaM5IWMmImGmDynYLgzPb27KHvu19CQUaUvFMYsFNLeoSfjYZpU
        UhCdpCvuBIRmkBTKD0TIRRo=
X-Google-Smtp-Source: AHgI3IabfSJ7j1EIejYzHUsjuMH4tPYrOfEjI7SgPIAngX35tNR2SFLEBk39/8C9N6i6FdA/tigEKw==
X-Received: by 2002:a19:5601:: with SMTP id k1mr3813948lfb.99.1551359922936;
        Thu, 28 Feb 2019 05:18:42 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id l26sm4600069lfc.37.2019.02.28.05.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:18:42 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/7] Support Trusted Foundations firmware on Tegra30
Date:   Thu, 28 Feb 2019 16:17:00 +0300
Message-Id: <20190228131707.2592-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds support for the Trusted Foundations firmware on
NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
firmware and upstream kernel can't boot on those devices without the
firmware support. This series was tested on Nexus 7, TF300T and Ouya
Tegra30 devices.

Changelog:

v7:     - Fixed kernel booting with CONFIG_TRUSTED_FOUNDATIONS=n by
          providing a dummy L2C write_sec implementation in the
          "Support L2 cache maintenance" patch.

        - Minor clean up: no static variables anymore, replaced
          white spaces with a tab in one place, etc.

        - Added Michał's and Robert's Tested-by/Signed-off-by to the
          patches.

v6:     - One patch got messed up accidentally in v5, this is fixed now.

        - Squashed "Support L2 cache maintenance done via firmware" patch
          into the "Add firmware calls..." patch.

        - The l2x0_init() firmware callback is now invoked unconditionally
          because it is always a NO-OP on T114+ and is a NO-OP on T20/30
          if firmware node is missed in device-tree, hence there is no
          need to check the machine's DT compatible as it was done in the
          previous versions of the series.

v5:     - Fixed machine hanging on disabling D-cache during suspend,
          turned out there are slight variations in behaviour between
          firmware version in regards to cache-management. Thanks to
          Robert Yang for reporting the problem and helping with the
          solution.

v4:     - Fixed Thumb2-kernel hanging on Tegra20, turned out it was not a
          good idea to switch CPU into Thumb2 mode right after jumping into
          the reset handler.

        - Moved LP2-mode-set firmware call invocation to a later stage to
          better replicate what downstream kernel does. This change was
          suggested by Robert Yang and fixes system hang on Ouya game
          console.

        - Added references to the original work made by Michał Mirosław
          into commit messages of the relevant patches.

v3:     - Implemented suspend-resume support.

        - Reworked arm/firmware/trusted_foundations.c a tad. Now cache
          is getting properly initialized, cache enabling / disabling is
          supported.

v2:
        - The "Don't apply CPU erratas in insecure mode" patch got some
          cleanup, in particular resolved the messiness in
          __tegra_cpu_reset_handler_data.

        - Added a comment to tf_cache_write_sec(), justifying the warning
          message.

Dmitry Osipenko (7):
  ARM: trusted_foundations: Support L2 cache maintenance
  ARM: trusted_foundations: Make prepare_idle call to take mode argument
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Set up L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode
  ARM: tegra: Add firmware calls required for suspend-resume on Tegra30

 arch/arm/firmware/trusted_foundations.c    | 75 +++++++++++++++++++++-
 arch/arm/include/asm/firmware.h            |  2 +-
 arch/arm/include/asm/trusted_foundations.h | 25 ++++++++
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +-
 arch/arm/mach-tegra/pm.c                   | 49 ++++++++++++++
 arch/arm/mach-tegra/reset-handler.S        | 50 +++++++++++----
 arch/arm/mach-tegra/reset.c                |  3 +
 arch/arm/mach-tegra/reset.h                |  9 ++-
 arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
 arch/arm/mach-tegra/sleep.S                | 14 ++--
 arch/arm/mach-tegra/tegra.c                |  2 +
 11 files changed, 214 insertions(+), 22 deletions(-)

-- 
2.20.1

