Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29152C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02521213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMmpJ10h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfFXBmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:42:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39699 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfFXBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:42:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so8753082lfo.6;
        Sun, 23 Jun 2019 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAaIEeaw8b+tY17bCMux1o12jOT0tbHuJNxXmYk7btg=;
        b=EMmpJ10h7+wKElBzLrjlEBB/rQw2Nl+GeGTINx61aCAEC0ZpoFg+705EZD1WZjIYHu
         zNfXrXk+PLTkGVrTBb0SVWD/ssoh+QE1UwLznGToNGHFzfv5wLRUiEpny+K2+xUgpVgf
         ZvzusBsUn6MM0zIY0c96JtsgF9JaqdXJ2oAJYvt6UDIdYOY+dBcC7XYnfDgkjGlerV0A
         nR1lFMtGu+b5CdWMVsGG2397JN3NF1Djea2Ra/pA+rdgF1TZzO9fQBjAhlEjJ9TZCbg9
         4pnEGJM8SbOKZgzg4mFwEeh7XTEBP9fKLFp6Blu/xDeqcp09AAVjMV72hIxmZP79mvWw
         eqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAaIEeaw8b+tY17bCMux1o12jOT0tbHuJNxXmYk7btg=;
        b=jciRtljG1kqscdh1U4A0FZu32h9ja2KsHtKeOGA/chQHtagqZyIxTEPlG29pXhZ4e7
         TvOhAgUGbdknQsnBbAF8DV0rMx0PmQmiHeA++JyVwhbig9hLx5VYe6pDTF4vqgijOLB/
         67wtCE6MyfJMOjXCuxjHCUuOgRUKnKqN2EmPlzoejOGpthX3gmPc9JnJsplJh4qGPYgg
         cMVzNde9PPjFDs+gU67+0LAU25r8jdO1Fo0J5YUOmUtX5BaKwDXIKawR2yDuZ8H2O4gB
         ckU0Iw1cgN5fBu8bNO3pAfXh3wHDHI9BmkB7ilzf0/iARUcQf04itxzVk7UCA9JJPfZ3
         gJaQ==
X-Gm-Message-State: APjAAAUdCGJ0dUG8vqdngvo1pU28cNixETAw8XQ08IxvMf0Nhs1z/jkw
        ugGDhSCR7T2AJtIYg+Ayl3Twkmgv
X-Google-Smtp-Source: APXvYqx7UhsnviQCljugSLWiGQv8kuKLpTeqI0FJYxjd4xmBH3rA38rb5eTdQDvEU/jYvRxlH9cS4w==
X-Received: by 2002:ac2:5636:: with SMTP id b22mr44686440lff.2.1561326515040;
        Sun, 23 Jun 2019 14:48:35 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/11] More improvements for Tegra30 devfreq driver
Date:   Mon, 24 Jun 2019 00:46:47 +0300
Message-Id: <20190623214658.11680-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is a followup to [1] which addresses some additional review
comments that were made by Thierry Reding to [1] and makes several
important changes to the driver, fixing excessive interrupts activity.
In the end I'm proposing myself as a maintainer for the driver.

[1] https://lore.kernel.org/lkml/0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com/T/

Dmitry Osipenko (11):
  PM / devfreq: tegra30: Change irq type to unsigned int
  PM / devfreq: tegra30: Keep interrupt disabled while governor is
    stopped
  PM / devfreq: tegra30: Handle possible round-rate error
  PM / devfreq: tegra30: Drop write-barrier
  PM / devfreq: tegra30: Rework frequency management logic
  PM / devfreq: tegra30: Reset boosting on startup
  PM / devfreq: tegra30: Reset boosting if clock rate changed
  PM / devfreq: tegra30: Stop de-boosting once it's finished
  PM / devfreq: tegra30: Don't enable consecutive-down interrupt on
    startup
  PM / devfreq: tegra30: Add debug messages
  PM / devfreq: tegra30: Add Dmitry as maintainer

 MAINTAINERS                       |   8 +
 drivers/devfreq/tegra30-devfreq.c | 542 ++++++++++++++++++++++--------
 2 files changed, 409 insertions(+), 141 deletions(-)

-- 
2.22.0

