Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B2C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5120818
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifkbec61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfCCRN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:13:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34490 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:13:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so1292663pfn.1;
        Sun, 03 Mar 2019 09:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0cbmHNU9sdXErChCdcfhO2l3UVzOMrQ6zgsov0jEJ0=;
        b=Ifkbec61NDcbXPhbTGnLBd6/33Bi+2PhiKGMyy1fDJEFuHEw5gsyF6J+wmh5xYOMT8
         Sg2X2eL806y18dh/DzUjUKoEOqo4sf9CVJRc7xnYlVvczVf2eD4g5FjVQsKg8oioEa3s
         weWPkGfVrneIGrfoNTZ/0ncOF/WKpA51JpyOvD/pYDVPK63E5WFRFEmJTbbJ8L0ir8+p
         hFG3333q99rh9yisL/+Ml28BttO4uwN4rolSOIRhFUXHToe+3QkJXrqAiBmOKBbdxmQz
         ipogzajC33AlmlVCrVNTxhExmfZYAkwqr7huXN37ZpOhqy/cy5WChAJqRrp0kjviloRH
         WZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0cbmHNU9sdXErChCdcfhO2l3UVzOMrQ6zgsov0jEJ0=;
        b=ESGeTZC2JJEfywbnmv0FyTqKVx12+1XEwsb6CaFRHaCYVeg0pHebIoZ5jSwcSJYWdN
         YQY5KhzLh7JLJ7dL6vT4+OUAeIzknx8LCBu0hNYXtBXGc1gg+DiMb7a0mtORX+hWWLfl
         0ZiA0xg2v8RgIjPPYsi5o3qAqKNfu3ioApd9tXyS8KL0jVJj9dhK5GS+SMi3K8JdJmco
         PhCairJhm2M+lOEGWj1ivXLV+L0jtUwcHNtTL0dGLLbEvpnifax7D4MqFbjDwMwDhyA0
         XshUEK4JFsN2zjxWW4dhkOFn/QWs7xyd5UaQ29BiSd/CnacKxUhdj4UbqnSGq/wQ/pwT
         p4CA==
X-Gm-Message-State: APjAAAUzEpoGys7Js2K35taRisV1NZToZljtyzuQwgEFtJYrOrNHE/Fs
        aNoV6r3iYj7yUycNyIhfw1M=
X-Google-Smtp-Source: APXvYqwvbDtMyGdzdIn+LgTbymShKCZWVTs2G/9O4pOgrYRFv0gJiTY3LBjqXCE2tOgggAvtrRQMsw==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr14181400pgc.366.1551633205508;
        Sun, 03 Mar 2019 09:13:25 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e22sm5349412pfi.126.2019.03.03.09.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:13:24 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/7] Support Trusted Foundations firmware on Tegra30
Date:   Sun,  3 Mar 2019 20:12:07 +0300
Message-Id: <20190303171214.24821-1-digetx@gmail.com>
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

v9:     - Rebased on recent linux-next, resolved one conflict.

v8:     - Replaced BIT() macro with a definition provided by cache-l2x0.h
          in the "Support L2 cache maintenance" patch as was suggested by
          Russell King in the review comment to v7.

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

