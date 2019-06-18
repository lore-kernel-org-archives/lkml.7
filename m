Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C3C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A8520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXXv6lHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfFROEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:04:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35806 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFROEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:04:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so3674477ljh.2;
        Tue, 18 Jun 2019 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRsqt/jb8lgBcOz/dnBTtpAXvq2EAkriRLFP/IPTkfI=;
        b=iXXv6lHpkvoPe6L8zswzO8zsadDQmmCGo8XY6+a+1RkUYcsM+eKxzDgkQ4QjPGcWve
         Gb70HS+9j60ac/L2BmSZ1EvZuCcyieNIRVfxrD99uRTIaCRoydcHcLY8EnoGDvCiDPy+
         ktbTwXqZpeiWvWMkjNSrgn31gSYoTNV47P1WfUbWVfmU92oAOB45bPWuOtBhvZK/AOkh
         GI9gdt5j/oLSlH2tfSkHDdsgY6QBVhf5y7NIwpZw44OfnNUqN2mLd3WATheFh8jeijUX
         7YwqYoCUTtEf9Brk9/0RyaUOAutQ9dl41aI+Xk6DsRttFAhJ8PWejgheJsRA7ZhnU1KK
         Noug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRsqt/jb8lgBcOz/dnBTtpAXvq2EAkriRLFP/IPTkfI=;
        b=f75r1TUX5UYKBPBit0CF9ZoYoXnDojJ6HuJHQ2q03hiWDt65zXiXg9F1L9dIhXMYSV
         Q5uon6ycXRHHNZgcbYqMvrbgHguRMaYCL93lwehwvfYNk6qEiTqCWIwCiU4zyN3S2ghP
         xWRddAb+4vZ+8tffbQYAdB30iopYboOkwwDx9HwhRVZ3TUJt659Vlli9vMwN/Uog0GyS
         MMUbnCgjJY40ZG5GaG2fz50yVuA+mUXUUHLgSo/7wN/L4adIrZZq/MGQQITi730V1b+j
         5bp4kAJ5mUDMfloDL20ELCCqpFnnqfadVtjkk/8jPH7DY/Qaa1K8ZSu5b57d0vMn9Eu4
         JI2w==
X-Gm-Message-State: APjAAAXuCTNQ8vKKhdT6WyJQBAyGoyg41SLXWiUdiOKCL4zm/UJ4C5an
        Uo4bS+k+vHfHlTVwVrDtV+0=
X-Google-Smtp-Source: APXvYqwr6+g5URrS11S4EwIk3EMj3zGzM1wPeH0B1ytMIPbelo7w03Nb/OM3nY4lFi4FXSQy8p4HQQ==
X-Received: by 2002:a2e:3e01:: with SMTP id l1mr47922443lja.208.1560866675480;
        Tue, 18 Jun 2019 07:04:35 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q6sm2650538lji.70.2019.06.18.07.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:04:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Few more cleanups for tegra-timer
Date:   Tue, 18 Jun 2019 17:03:50 +0300
Message-Id: <20190618140358.13148-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This a followup to [0] that includes some more fixes and further
prettifies the driver's code.

[0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=111529

Changelog:

v3: Addressed request from Jon Hunter that was made in a review comment
    to v2 by dropping the timer's period rounding-up in the "Set and use
    timer' period" patch.

    Appended two new patches to this series that were already sent out
    and reviewed after the v2 of this series:

      clocksource/drivers/tegra: Cycles can't be 0
      clocksource/drivers/tegra: Set up maximum-ticks limit properly

    In this two new patches I addressed review comments that were made by
    Thierry Reding by adding clarifying comments to the code and extending
    the commit messages a tad.

    Corrected the "Fixes" tag in a "Restore timer rate on Tegra210"
    patch such that linux-next checker won't complain about the shortened
    commit's subject.

v2: Fixed a bug that was introduced by [0] in a newly added patch:
    "Restore timer rate on Tegra210".

    Fixed potential problem in regards to error handling in another new
    patch: "Restore base address before cleanup".

    Added new patch "Add verbose definition for 1MHz constant" as per
    Daniel's Lezcano recommendation.

    Fixed a code typo that was made in "Remove duplicated use of per_cpu_ptr"
    of v1.

Dmitry Osipenko (8):
  clocksource/drivers/tegra: Restore timer rate on Tegra210
  clocksource/drivers/tegra: Remove duplicated use of per_cpu_ptr
  clocksource/drivers/tegra: Set and use timer's period
  clocksource/drivers/tegra: Drop unneeded typecasting in one place
  clocksource/drivers/tegra: Add verbose definition for 1MHz constant
  clocksource/drivers/tegra: Restore base address before cleanup
  clocksource/drivers/tegra: Cycles can't be 0
  clocksource/drivers/tegra: Set up maximum-ticks limit properly

 drivers/clocksource/timer-tegra.c | 82 +++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 26 deletions(-)

-- 
2.22.0

