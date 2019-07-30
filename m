Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD6C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92EF20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMs1FvJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfG3RYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:24:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33838 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfG3RYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:24:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so62863702ljg.1;
        Tue, 30 Jul 2019 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEH0DrU2VPn5tM7KZVuLkPvwPGH6U+jg9rxw5dRufkw=;
        b=EMs1FvJOMqC3dkyeDFvvu5ThT7CVnfdJHlTnl7qyV1Awlog+PKdDI+ZLjg+AT70AQM
         vCYyb1N0w9NAxSzkUON5xYLDatvgHpvMDulduqhWMnpWNMZOhQ/+II8ZrSuIGW5t13uu
         xf8l7w6OEBRLbbQuOE6+sz8Q0VwgsOXYWGAwLGURZl5PyISettNlZUQCeaCCLI81yNQw
         3ifRthQED15E7WkOWLWyAaByoscyho2He7iTgnN1lMTUqr5EoquIJw3CHxL/+5D4E7VL
         xhCXxMB6gprqBOTBgCe4MwLyOXy1xVZ0sjRHTrKtTkpgymchTVaURED9+GflsMjH71Zl
         2qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEH0DrU2VPn5tM7KZVuLkPvwPGH6U+jg9rxw5dRufkw=;
        b=FftQ463C9y3zYDIR9fbkmng1JDwwWySYvJHsqhbxbZhhDHEAdA7h1ZlVByRnkH1B3F
         AQ2I0h6YlG/5sqK+kaKavwBeZ5J9c2TwmOLuou8QLttsa9rN+SgbipUugutGZ206yi0I
         oUOA7pa9cj9n5p7FamhpmI5We06war4777AgpTqjENCAwhgWR+yJ4L4fjzKnnTYAz/Rh
         Dqv28BenkHyUpCuHM86v+D6lbUJvkxbpJbKPyg5rSgQt34QwGhUoCfpXt84ubviLeFJ4
         El0R9OcZDkuSYOLdSSoe1gcAy1rEigUG+CP0UEhq6d+zPP4VwGOjYTdzv/D9/jRH/v5q
         Yw8g==
X-Gm-Message-State: APjAAAV1T9Zv/p/FdC8wrYN5iyPdE8+U3lnzE9B4vmasF0AzYkS/Vpn2
        bogVx4O8tGfc4wewXnTxsWg=
X-Google-Smtp-Source: APXvYqz+cWNHwCPglgibA466K4PSEJDcFdakRsePZbAAU2Re2ry8/H9Y+DuI16QbkAA4Q/CBYIl90w==
X-Received: by 2002:a05:651c:20d:: with SMTP id y13mr59546561ljn.204.1564507451190;
        Tue, 30 Jul 2019 10:24:11 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c15sm13345252lja.79.2019.07.30.10.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:24:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Tegra30+ CPU suspend-resume bug-fixes
Date:   Tue, 30 Jul 2019 20:23:38 +0300
Message-Id: <20190730172340.14037-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small series addresses two suspend-resume bugs: one affects Tegra30+
due to a typo in the code, other fixes CPU hang on Tegra30 specifically.

Changelog:

v2: Reworded comment to the code to make it sound better in the patch
    "Use WFE for power-gating on Tegra30".

Dmitry Osipenko (2):
  ARM: tegra: Fix FLOW_CTLR_HALT register clobbering by tegra_resume()
  ARM: tegra: Use WFE for power-gating on Tegra30

 arch/arm/mach-tegra/reset-handler.S |  6 +++---
 arch/arm/mach-tegra/sleep-tegra30.S |  4 +++-
 drivers/soc/tegra/flowctrl.c        | 19 +++++++++++++++++--
 3 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.22.0

