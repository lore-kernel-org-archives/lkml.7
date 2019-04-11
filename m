Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B72C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FC32146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryLJo3O4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDKWNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:13:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43163 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDKWNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:13:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so6969525lja.10;
        Thu, 11 Apr 2019 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzVsB6ZxIzFk0wamtFqmoJUCkqG5RnPLmIU/g8gkgjA=;
        b=ryLJo3O4y56uY07i/rrQZksfhfciUBONxAlrDYbhRx8Ns1Qr9P43svLFx6k2DOP27y
         cz8icjvaGSRfdpG7GL5ZKfAS1XKPlj115HXb1MI7uBRZMVQ96pOZdCCu/nf0y10Vq0pE
         46QLicgkmingJUBYAfrIR9u9oXetZT+Qi6MX4OTMhhmQ7zyabn3uHl4bMWd31/OWAcWf
         mWhPAk4XPKo0n+F5QIUUMBxhm+c7S//c8RyR+t7cnNgndIdVHU5znM3yO/DpnioYj8qk
         fOvSMu1rGUElcqWA3pOA1VFAzmpeCUEByy+VdGgXLUVGRZfeUycDZFekZvhe9nZab1fw
         LY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzVsB6ZxIzFk0wamtFqmoJUCkqG5RnPLmIU/g8gkgjA=;
        b=ubjxT4z+k2dTr3bvQwEYGuT6PLp8g4J/p7vnOA0VxuAAHlm7LKhCw1s7hlL07dYvrP
         2McHrUXUcBQ3y5McrpUw5sATRChcwMKckxOxIhnFTwHziSDNrDgxNI4cJ5q0sFTj92s7
         zZYE0QU3i7nGiy28QLWOSsLX8KP0hpBFP0IuBxDY7VfTcRQjwlC8W5D/kRdEWnzLZ43E
         5PfegMVct3PWSG7hegLYSaTjnaveAL/K6iM+OxXjIExTTfCnQT1bttkjyrnInEjQ/h9/
         B8ZVzJREpB0iyipF9nxv+2f0dck8AO4AssKpcCv5nRzggnqw+O/wTXnku+x0g4AdYm9f
         KCmw==
X-Gm-Message-State: APjAAAWRMxM8NXyUN61NIs0LDhhpVJmHtCq8OjFSqulwZH9/ufcaYT34
        N+GEPrAB7hlzZJYKdadabYM=
X-Google-Smtp-Source: APXvYqwghcMCdmK+hDkoTs5eoYfgT3sEUGRms1HQ5Pxqtxg9Hyy+3Nh/PablUjamBxbeO8OJTnsSBA==
X-Received: by 2002:a2e:7311:: with SMTP id o17mr11907131ljc.124.1555020808699;
        Thu, 11 Apr 2019 15:13:28 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id f4sm7953526ljg.37.2019.04.11.15.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:13:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] memory: tegra: Fix memory arbitration programming
Date:   Fri, 12 Apr 2019 01:12:46 +0300
Message-Id: <20190411221250.23233-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this series properly addresses the bugged memory arbitration
programming and in result the previous suspend-resume workaround change
is reverted as it was not entirely correct.

Dmitry Osipenko (4):
  memory: tegra: Fix missed registers values latching
  memory: tegra: Fix integer overflow on tick value calculation
  memory: tegra: Replace readl-writel with mc_readl-mc_writel
  Revert "ARM: tegra: Restore memory arbitration on resume from LP1 on
    Tegra30+"

 arch/arm/mach-tegra/iomap.h         |  9 ---------
 arch/arm/mach-tegra/sleep-tegra30.S | 21 ---------------------
 drivers/memory/tegra/mc.c           | 16 +++++++++++-----
 3 files changed, 11 insertions(+), 35 deletions(-)

-- 
2.21.0

