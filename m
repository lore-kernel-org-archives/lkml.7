Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06802C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBB82171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFeXzTR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbfB1O75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:59:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44382 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfB1O74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:59:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id q128so17375568ljb.11;
        Thu, 28 Feb 2019 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BldZyq/PlnyG/d2J4f3pJeyBfmYa3p3MVFqeW8B07Qc=;
        b=MFeXzTR+ujNEnERQuY7TbmdtyfDbVXy8eCHrEDKw3QW/8HfZD3Op/zV1fuFJp54vtj
         U1R/RA9h5lWksOhuATMswJqAkVMI49SxpzC0kEII/1XOAnDsp0MiC9VToLUTpR0ssr8j
         o2D3txScVIDS2sNtJCjJ6mFaNVS9NsEo4jmuf5J+Trj1HIRqMcW1NENgUrpTWW5lu+EX
         2tAgWLI+gLMg2Bf23rOnfDmix8ZRUZfqDDx1xwFmZnhvyXdtCjHSgNbnLhncKKmERTLf
         YyjswO7+7GKPyHTmHPPxjNDbZjGGCyCUDppQjVuh00R23h0IebZACwa0CvvkNA0GcuGB
         as8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BldZyq/PlnyG/d2J4f3pJeyBfmYa3p3MVFqeW8B07Qc=;
        b=W44f/7pUO/E6qNF6/YaalYdYY81ZOUWs5Wdo4CQk8gG4h+ouIfoghhEPIq4d2RbyFP
         2aJd+JTzmfmH9jPO/L93z/OstsM1jMGd9YYarpPg5+LXui77C+rbAImVLylWyljAHI1U
         Mn2PWZhppTBOq+uwkqUPcNwfdcZ0Y7vIzmAFkGEpEPNNXDvYm6a1d8y+PNv21KIerjHf
         SNxo6VAKeE1XyCQmVa6fO3nQP3IGfw0/SeeTdQWphzc2Pqoys8zxhAT+CvZN+V5mbKeg
         qdyGsLBjzEsfrFndrpIgq2RNpoKySaS2PrBpTaySSceY4GTywNDoQgml68N5JfpmcrNm
         7tSw==
X-Gm-Message-State: AHQUAuaACq/zyPnXUZUoxfr1FGy8TIFk4PwaXUzjdDz+dQtBQKp7nhvN
        zse60Or3v9IiKYqEGa/zqA0=
X-Google-Smtp-Source: AHgI3IbJqUcKt94Yq28mpsgwIad6vXg+nMx3kyhMCXxpZ1T49YgeBBDXPZK6voWO9IyEeEn+jFNJmA==
X-Received: by 2002:a2e:408:: with SMTP id 8mr5044706lje.15.1551365993678;
        Thu, 28 Feb 2019 06:59:53 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id z20sm4728309lff.87.2019.02.28.06.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:59:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/7] Support Trusted Foundations firmware on Tegra30
Date:   Thu, 28 Feb 2019 17:59:30 +0300
Message-Id: <20190228145937.27725-1-digetx@gmail.com>
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

