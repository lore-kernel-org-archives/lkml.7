Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7363721773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbKbz5tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfDXXPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37879 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfDXXPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id h126so5359773lfh.4;
        Wed, 24 Apr 2019 16:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kX01giboL2Ff0GM72mDGDzKFbIbv0wGAkZBqhpPr0Qs=;
        b=QbKbz5tqwHulq3nJu17XH9BCyDaJO5FE1R0p3W2JWuAw2M/qvwiBL0lIPGVrwmYNka
         s+EoQeohD9axrOWESSEVtKgDpSttljdGZ55d+AFHLoz6TMU6Fhob8IiAzreXZx86bgQ+
         NSXyGy8n4A8qLt4JYh9RWGw0TSj96ONtLNCKmomYveTG+yACIjF/CLYQMPwE08GymkcF
         CehKGY7Tlz8CuOyHEgiNVnqhMB2HO5KAK0aXb5HuDEZLF6JETDqLYGlpWdA+7MYqXYh2
         hfCq2AOiEqncLSSaalOfgYqRG3W7lSOMYQU/qvh2oJHTW+UYBCcB9aNex8dyn3YhiwcY
         E4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kX01giboL2Ff0GM72mDGDzKFbIbv0wGAkZBqhpPr0Qs=;
        b=pzyKs7jq6vMU/I3WyoSBq5SE7A53dIPhyR17ZqODFmHGiXEeDSQtQiUwFcBqXdrqAG
         GnDWmmRSCA/Q8aCyXWzrKLFj7mnPu859pFzbU2Ly54e/LPCt30905y3nbtm427T/BRbU
         OPEj+G9QhKF9Xb3PCXXGm5enNmOATIgsr707bruLq3z11zjbgDUZwRltYQSei3VASlo6
         ZCWmdpL4hCOqrocnKvnHXngqW/SlmgjEhOhAG3WeYqYNCP4yWLxGSoTxsLk6TQbjcdEr
         YrWaBIo8q261YUieVrjcU5TKpNUvqooyGxb7huHRKfyGZG+BVbpGjo4YIUr4O/3OqK4b
         79sQ==
X-Gm-Message-State: APjAAAUL1UuFm9YQ62CbbiAh8tbRl7TA7ObGEv3nQghi4XGGGTPSR6NB
        qLghDzfKFhgz2/jVbuDCG7A=
X-Google-Smtp-Source: APXvYqyboaYAgrefu4fhF0KEqEdhuTVOeAm1LsyI2YC68EluBgVx9r3Hwb/UaJcAWgpATC774Nndqw==
X-Received: by 2002:a19:3f09:: with SMTP id m9mr18653946lfa.36.1556147706333;
        Wed, 24 Apr 2019 16:15:06 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j13sm830192lfb.34.2019.04.24.16.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] NVIDIA Tegra clocksource improvements and clean up
Date:   Thu, 25 Apr 2019 02:14:37 +0300
Message-Id: <20190424231444.20876-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series primarily unifies the driver code across all Tegra SoC
generations. In a result the clocksources are allocated per-CPU on
older Tegra's and have a higher rating than the arch-timer, the newer
Tegra210 is getting support for microsecond clocksource and delay-timer
and the driver's code is getting much cleaner. Note that arch-timer usage
is discouraged on all Tegra's due to the time jitter caused by the CPU
frequency scaling.

Dmitry Osipenko (7):
  clocksource/drivers/tegra: Support per-CPU timers on all Tegra's
  clocksource/drivers/tegra: Unify timer code
  clocksource/drivers/tegra: Reset hardware state on init
  clocksource/drivers/tegra: Replace readl/writel with relaxed versions
  clocksource/drivers/tegra: Release all IRQ's on request_irq() error
  clocksource/drivers/tegra: Minor code clean up
  clocksource/drivers/tegra: Use SPDX identifier

 drivers/clocksource/timer-tegra20.c | 287 +++++++++++++---------------
 1 file changed, 136 insertions(+), 151 deletions(-)

-- 
2.21.0

