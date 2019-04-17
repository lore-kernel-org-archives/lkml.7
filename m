Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38086C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0232320693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoD831QF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbfDQWmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:42:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37756 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:42:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so213495pgc.4;
        Wed, 17 Apr 2019 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1R99iL8zt7pYA8QWKvwvqndRoGPVaYvfjEKGwYpQl8=;
        b=HoD831QFjDx4BlpQhDI/TD3XXHvVVHsgOBIGfwMfKF7qnRPAgecLhMeFdTu8ine4PT
         pS/K5fvyguJfbjW8xANbSOvNYyW3q0wsCPCzfPqsId/p7AON+5U0NVLFwMKfwR5vYLL1
         yxzAwnPRoZFX7VdS3mZK+DFy06kNksUxXADdKePPW/iQcY4Mri71ZYeZcADrr/ffOWpB
         V+XtePo1RZYdLEkhiaKau3fPSD4ge3w9rxVS/VkRJR7hfRwnXvjwpscWPulUie9sNOX8
         /xKEJI1D5Fpzlf79qU3DiaSr4bHnyUuabem/rp3lCpaI5r5FyAfeMv/w34fUBaT7wCK1
         0JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1R99iL8zt7pYA8QWKvwvqndRoGPVaYvfjEKGwYpQl8=;
        b=la9mvPji93TREBWlY7Wrvj92tiDsMaaDdMlhk5ALIYTHJlqdGOvNacqeUxpGxRF2au
         424IA0Q6SAYGfF+Z2mE0CnXXJds0/SN6y41UAslJ8WdGl7Yl/2aRjG0+xvi/7z0nCM0C
         Onx7o03vEuk7INmYu5ioddao5Nznbj5QiiCloVQCWYntwn6bwpOTJ4soS1xRzhEK7ywY
         0wnYoY+8FnxCTorfbFO5U37esTe+nXccJ2c/ofVEKNJwdaWuNkR3N2gtjPifGB5cEryf
         6wTIQtLQQCA0bsdMUGVxxEaTRCWmSvucnRofS6F5FXyBVIV54lMmIwZS9YdfIMoGKuwH
         ueiQ==
X-Gm-Message-State: APjAAAWHUTzFA2nTyRj27eJ8fIyY3sWv/glMQ8JU8zObTEUwlpRLyYh8
        giPnU9e0b9Y/AWNptD2sQGg=
X-Google-Smtp-Source: APXvYqzfsqxb6oCf19KQ69nee6vwb/j4LlN53CNGTZed7Ee/lThOPjR/LlupIPNI1J3gQWbhe9CSgg==
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr85176635pgf.336.1555540436865;
        Wed, 17 Apr 2019 15:33:56 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:33:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 00/16] NVIDIA Tegra devfreq improvements and Tegra20/30 support
Date:   Thu, 18 Apr 2019 01:29:09 +0300
Message-Id: <20190417222925.5815-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

v3: Addressed all review comments that were made by Chanwoo Choi to v2.

    Patch "Synchronize IRQ after masking it in hardware" morphed into
    "Properly disable interrupts", which disables interrupts more solidly.

    Added new minor patch: "Rename tegra-devfreq.c to tegra30-devfreq.c".

    Added missed error handlings for dev_pm_opp_add().

v2: The patchset was quite heavily reworked since v1, few patches we
    dropped or squashed into the new ones and more patches we added.
    In a result more bugs and potential problems are fixed now, driver's
    code got more clean up.

    The Tegra20 driver-addition patch is now a part of this series, it has
    no changes since v1.

    https://patchwork.ozlabs.org/project/linux-tegra/list/?series=102823

Dmitry Osipenko (16):
  PM / devfreq: tegra: Fix kHz to Hz conversion
  PM / devfreq: tegra: Replace readl-writel with relaxed versions
  PM / devfreq: tegra: Replace write memory barrier with the read
    barrier
  PM / devfreq: tegra: Don't ignore clk errors
  PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
  PM / devfreq: tegra: Drop primary interrupt handler
  PM / devfreq: tegra: Properly disable interrupts
  PM / devfreq: tegra: Clean up driver's probe / remove
  PM / devfreq: tegra: Avoid inconsistency of current frequency value
  PM / devfreq: tegra: Mark ACTMON's governor as immutable
  PM / devfreq: tegra: Move governor registration to driver's probe
  PM / devfreq: tegra: Reconfigure hardware on governor's restart
  PM / devfreq: tegra: Support Tegra30
  PM / devfreq: tegra: Enable COMPILE_TEST for the driver
  PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
  PM / devfreq: Introduce driver for NVIDIA Tegra20

 MAINTAINERS                                   |   8 +
 drivers/devfreq/Kconfig                       |  15 +-
 drivers/devfreq/Makefile                      |   3 +-
 drivers/devfreq/tegra20-devfreq.c             | 202 +++++++++++
 .../{tegra-devfreq.c => tegra30-devfreq.c}    | 315 ++++++++----------
 5 files changed, 369 insertions(+), 174 deletions(-)
 create mode 100644 drivers/devfreq/tegra20-devfreq.c
 rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (81%)

-- 
2.21.0

