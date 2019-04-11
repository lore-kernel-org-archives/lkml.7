Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349D420850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8Csvej5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDKWaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38948 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKWaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so7015209ljg.6;
        Thu, 11 Apr 2019 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SFmotJZjdO6m8TOabcmiWgIrcO/Q8MUArwCARRNxGjs=;
        b=V8Csvej5wMgAehqB5FDtiV+Fd4q1H7rPUanAHwkTjdax8fALDh863DaA/5pwGrKeVC
         XYFsOeQ+LiDEEQ/zZOkAxm1aTHtTZZV/6orvFyh6dsPAALObYEzSfGhO5ewaV+3YHlED
         zE9vJRcpfvpDCEUr0Fexd4Dl9CtLz8NI1e3YGWDkx1P0gQkaC2J0QTD0mQ5eAQEk14gG
         mPxiiKV1sjbI6mDkkDbcKUGRVAP2k3VpnFmZ/6TtY7HkrpKO/Sxa2SLC6GI/IC2Lmhjt
         dJdF7uJmqGnVmYfNzW8IAw4/XwJcbtZur9ZUI52hbpn94JpyAq6N0C9vNoacnLBRiwn+
         IO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SFmotJZjdO6m8TOabcmiWgIrcO/Q8MUArwCARRNxGjs=;
        b=jg7wOmcbX+Ve7FIknRjcOpzl9WCh0a3bbqZzwz5UsowVMPFemOT6wT41guqlS8HsZy
         +A+nfAGG1P4g2eybR+4lwvL4e/cQQ7PVTM5UxiX+alQLoxoeyEWLEp2E1jsi+agm556d
         0gf2S9isMePeVJKCYKEG6kbJtUYmGvzjTl4wDUO3xZFutFVW1OA9i77DtVbQbCazs4d3
         HwNP9IYBs6Ow/+j1aUT5UsiT7YvxJgdLvfqTi5+BVRh7AeVT51gVQQ2lYpVdDshar1ne
         rXoJeCKPWvbpVt6WuJYHsFS7laJG++S5eZZ0wIaBkIVfy/NRZtH675L6TXZ+Cu9avhpw
         Pf2Q==
X-Gm-Message-State: APjAAAW1QNCpAFYGa6l3EDt6vmvLwr899oGjO8CGaEubMSXPFQ5/cnGC
        ZQvwCTzDHjsgQKeUl4LvbNTVw+W5
X-Google-Smtp-Source: APXvYqxSHU+7L8Yi9ncFe9LtYIdvEY3JaTkhKXfHa6OjWClQj7sx2lF7T8zIyD0M3YoEd0mpHBH8lQ==
X-Received: by 2002:a2e:844a:: with SMTP id u10mr11219335ljh.41.1555021798579;
        Thu, 11 Apr 2019 15:29:58 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:29:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 0/8] devfreq: Tegra devfreq fixes / improvements and Tegra30 support
Date:   Fri, 12 Apr 2019 01:29:06 +0300
Message-Id: <20190411222914.25539-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to utilize the Tegra devfreq driver on Tegra30 and found out that
it doesn't work properly due to improper Hz<->kHz conversions made by the
driver. After fixing that problem and doing some more testing I noticed
that there are things that could be improved and in result here is this
patchset that fixes the problems, makes some improvements and adds support
for NVIDIA Tegra30 SoC's. This series was tested on Tegra30 and Tegra124
machines.

Dmitry Osipenko (8):
  PM / devfreq: tegra: Fix kHz to Hz conversion
  PM / devfreq: tegra: Replace readl-writel with relaxed versions
  PM / devfreq: tegra: Don't ignore clk errors
  PM / devfreq: tegra: Don't release IRQ manually on driver removal
  PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
  PM / devfreq: tegra: Drop spinlock
  PM / devfreq: tegra: Remove OPP entries on driver removal
  PM / devfreq: tegra: Support Tegra30

 drivers/devfreq/Kconfig         |  2 +-
 drivers/devfreq/tegra-devfreq.c | 66 ++++++++++++++-------------------
 2 files changed, 29 insertions(+), 39 deletions(-)

-- 
2.21.0

