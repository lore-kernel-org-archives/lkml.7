Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B318CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895552084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikqTmUR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfDNTYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:24:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43329 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNTYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:24:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so7488436pfd.10;
        Sun, 14 Apr 2019 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Iv/AiYklJqnq9LxBDUHpc9lxvbh33d/3LijVMJ7970=;
        b=ikqTmUR8a85B9A4fTcwVgvYrD6ZYo6eB+bKYk7tMyKphQYC+t3hzQJblMzRiGWsLT7
         TCApufnFOpt3dXuqBnq9t/n9Hiuj4UXY1SnXDLTPP8QWju9FcVT+I2Uucwwv34GdIiQh
         MsjmcDHeu0lJLlR6URXNfNVU9MLHx5WkbtoZHxFqs52jrF9z3qDbbSKWepwgy5OqK8aL
         CVDJK79hGACwtEdWZEXb9eEJwRyd7oBVt5o+h/0eg8e9KBxMeNFDCO0Iw7DmvCE5QM9u
         wZ2CbToJ5TLbT8nC6Bp8UTTC3VG2uqCGCDkgolS/fOweVu2nkxhjHvg0Vx84waLMG1Xb
         FVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Iv/AiYklJqnq9LxBDUHpc9lxvbh33d/3LijVMJ7970=;
        b=qyjE81BL4fBtcLYdRRYfA/CVc0WvQfTKAT4SPvEoD97OQsPd1rt7OgvUdcgBacizcA
         Uwp77mR0pm4JQoiufjVXzpZ4JHDw0oyx4jX0HUQkzZ4sG0hsAEfoy/00Iqc0TtqXueHn
         90ZVZYc6OI9pK9mIBkUrrFulXTBnFU4HbcN3F3TRBmY1VzEMRVK092RkonRFW4pzF+tA
         /oJHqXgqLpG30rQbvDkl6Ny1TyMj8efXhDIEbwFXISXbbltzZj65T1RXCbSIQwUOP7z8
         X1tVUKSjH3JMEV1/WbkKpoQT6p6xnF1ZXSlZWwiNxQi4EOkFtCH/DDxGxe1S9H/iwzvD
         H1zw==
X-Gm-Message-State: APjAAAWyMhFywf3ko27TqwX71b8ECe+yf+tweDc/uG2pR9fkYb2/9bqc
        yeknnNUniUuQEb5bkJQmjJE=
X-Google-Smtp-Source: APXvYqy2w8gxbwMP8ta9y/Lke5CYmOx1KgPMtxT936BN9/CUKnNZoByoVOZDYY0roVJyvKdQeW5Ntg==
X-Received: by 2002:a62:19c3:: with SMTP id 186mr72112401pfz.172.1555269887208;
        Sun, 14 Apr 2019 12:24:47 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j4sm17837398pgi.71.2019.04.14.12.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:24:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] clk: tegra: EMC/MC clock fixes and improvements
Date:   Sun, 14 Apr 2019 22:23:16 +0300
Message-Id: <20190414192321.23294-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was helping with fixing EMC clock scaling on T124 Nyan Big and
in process found some weak points in the code. Primarily the ram code
parsing didn't work if device-tree defines memory timings for multiple
ram codes and after fixing that I spotted few other things that could be
improved.

Changelog:

v2: Corrected "Mark Memory Controller clock as read-only" patch that
    had the "read-only divider" flag being set in a wrong place. Note
    it also turned out that this patch is needed for a proper EMC freq
    scaling on Tegra30 because some of memory timings may have
    configuration where MC clock configuration should be changed
    simultaneously with the EMC change and currently CLK framework
    reconfigure the divider back to /2 mode after EMC clock changes
    since it's the parent clock for MC. Although it's not really critical
    since system remains fully functional if MC clock configuration
    doesn't match the memory arbitration configuration.

Dmitry Osipenko (5):
  clk: tegra: emc: Don't enable EMC clock manually
  clk: tegra: emc: Support multiple RAM codes
  clk: tegra: emc: Fix EMC max-rate clamping
  clk: tegra: emc: Replace BUG() with WARN_ONCE()
  clk: tegra: divider: Mark Memory Controller clock as read-only

 drivers/clk/tegra/clk-divider.c |  3 +-
 drivers/clk/tegra/clk-emc.c     | 57 ++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 23 deletions(-)

-- 
2.21.0

