Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F68C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F04229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6ZsRsEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbfGYPU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:20:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44416 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbfGYPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:20:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so17821562lfm.11;
        Thu, 25 Jul 2019 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDW/FJUrsVu6k7T07Pr+H7tkQH/WLpxDim2Ftq6lvk8=;
        b=B6ZsRsEqN8Zh0idaADwGb4x9RAwcSBnpeuKnZayoZHOJrUb+l0bvaz9a1VFzJ72+2v
         HF2QuqbQRC45Nn78C1FMVW/SfrftgrfYkxDchUL8TyFqzJRrh+M3gA8Mnc8rUdk3PRk6
         WkfnYbT7/H7YnC7q10pvBQ1iU5sfLH5R/khQxmDf2wqyQ+rrXa06D2u8sait/Bsl8J2d
         LiGwyGn13EuwR6yDjVnzdVijr2rbRiCgI/91wO5fsWjLq1Exx79GgeHzY+jNTgRRIvWa
         z5u5Ps3PMrYon6ql0eGzYusvSnS9O1PEWarfXBQeqTyuw1s7g8pWTk9217SNl18gvGPZ
         0OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDW/FJUrsVu6k7T07Pr+H7tkQH/WLpxDim2Ftq6lvk8=;
        b=CZi6yZVafb1UquIPuW2mRhAasU+om3xLifI367M5Rh7u2E35o5ip0VaxvEl6G/N+6M
         AP3OGk0QPhusgu0qrjW/iCdKtV4gZOrA6yZ5mvsGDDkC0dzQd+Nxb25q4SoTqnJ7JRL0
         PMDJHhb/wdIdIZTPUCmUvjdIYq3EuqjQXAPnQN8l3W1A0GE6NHPpRycD+tgFIYwlncJ1
         jXTZNPqHFBHIgoek/l3Js899mBnsu94v38zSFGW75xff0O2fufRA333BkqLMGE8nFqWX
         DZmssijrONDVZRK/SLnRnr10mUYu9CrJzc7KJ0byApJXX777OJDdhqUZkMe6soZHsuP6
         WELA==
X-Gm-Message-State: APjAAAW6A03M+JiKsnj6UuN6AMwWNWfWVh3L6/cXOuZCz7BaSZV74K0V
        BLbjbicWuXe1bmG0O0YxOyQ=
X-Google-Smtp-Source: APXvYqx8YvOPn9GvdCLiMGAu2EV1xlTrSrVOqxrRUY0MeAQA7lrEb0GBpmSEvYLU+kVIhM8L4WbOgQ==
X-Received: by 2002:ac2:482d:: with SMTP id 13mr30015249lft.132.1564068056133;
        Thu, 25 Jul 2019 08:20:56 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id e87sm10452281ljf.54.2019.07.25.08.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:20:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Support regulators coupling on NVIDIA Tegra20/30
Date:   Thu, 25 Jul 2019 18:18:29 +0300
Message-Id: <20190725151832.9802-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The voltage regulators need to be coupled on NVIDIA Tegra20 and Tegra30
SoCs in order to provide voltage scaling functionality in a generic way.
All necessary regulator-core patches that added support for the regulators
coupling are already have been merge into mainline kernel. This series
adds customized voltage couplers for Tegra20/30 SoCs, paving the way for
a refined CPUFreq driver that will utilize voltage scaling and other neat
features. This is a resend of a leftover patches from a previous series
[1] that was partially applied by Mark Brown. Please review, thanks in
advance!

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=115626

Changelog:

v2: - Some days ago OPP framework got a change that makes CPU regulator
      to be enabled at the time of CPUFreq's driver initializing OPPs.
      In a result the CPU's voltage is dropped to a minimum value on
      CPUFreq's setting up because there are no consumers at the time
      of regulator's enabling, thus CPU is getting into a big trouble.
      This problem is now resolved in the couplers code by assuming
      that min_uV=current_uV for CPU's regulator if it doesn't have
      any active consumers.

Dmitry Osipenko (3):
  dt-bindings: regulator: Document regulators coupling of NVIDIA
    Tegra20/30 SoCs
  soc/tegra: regulators: Add regulators coupler for Tegra20
  soc/tegra: regulators: Add regulators coupler for Tegra30

 .../nvidia,tegra-regulators-coupling.txt      |  65 ++++
 drivers/soc/tegra/Kconfig                     |  10 +
 drivers/soc/tegra/Makefile                    |   2 +
 drivers/soc/tegra/regulators-tegra20.c        | 364 ++++++++++++++++++
 drivers/soc/tegra/regulators-tegra30.c        | 316 +++++++++++++++
 5 files changed, 757 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
 create mode 100644 drivers/soc/tegra/regulators-tegra20.c
 create mode 100644 drivers/soc/tegra/regulators-tegra30.c

-- 
2.22.0

