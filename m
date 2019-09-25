Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94038C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63383222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pX0x+D6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbfIYKBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:01:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44888 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732929AbfIYKBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:01:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so2181713pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 03:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uzZ8DPf6NIW9EBVqRR0XbHjRTYj7wBRwWhdqQxzfdOc=;
        b=pX0x+D6ebrVJDrq5zD4RO2FtBs2ewMN6Zi/1V5mPNy4/LeQD/H8OU62wxE15vOw03M
         b1YduOzP5xSt5nCc15YWYBN54koL6AD/dhoDXbsi3wl4KeUwMInH/Vw9KM6lwLVNpeIF
         f0pazUbc4kvNC0TrMPANcX1bLJhHUa+Kl5wNrD3uSuQu+hg/Dc260ZIBq9Lf0xPwNUyi
         8AXPHo7/PSDtRLPf8erC0ORT5eDosl7dw0e66r5mBmCRM/QsNGjrgQHQHJ9fSLt+Mqfj
         yvmyvSF4G4Gnv8SIMRoCZbzz3mcfYmgWut6yahdqK9jrB3ZMCwf1tlUkO+01MmyHHbZN
         bOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uzZ8DPf6NIW9EBVqRR0XbHjRTYj7wBRwWhdqQxzfdOc=;
        b=jdigU3OEeKjqzDQWZBsXSXtDSw7mRtxRBy3divQh2x8/8NIzib7EtDpxdMjkbFa0qn
         iYVOwKxur6qr02WR2QLw+XhxPO7698D4C1ybaJKS+rDvJ87z1DWDoQrVyu6/ObfMP5Hq
         2skG8hNdSKw+CW6txwnOtTq3T8hGAtwNnOmPBG+UeliEikq2CGZUKM5nOkeSSHGJ+EL8
         7JvJ27xCABa6ETZfo+Q6bO3eBU7a7w2UQ6BcIi27EUBLianOjsWpw1za+spYXGTJZsHO
         x+abNO1MdOG94eSTgxy8mhXl66uT7CNx4VGEUebtUTaXAoKfxQgf8MhYL2nG4KpXeLYa
         YFsg==
X-Gm-Message-State: APjAAAUG4chHExNOJ2V38FznG/kRfQMPq3s+qQhtZp9qvVLZtnubVX22
        hoKODd+SiuTdth2Jr94GVt+3WA==
X-Google-Smtp-Source: APXvYqyZiVNZNLInx8rqubvBh27cWe1x6GJopIyzVDed+DSk7m3a79qaCZlOpAkdTjZ+xXYikJ/O2w==
X-Received: by 2002:a17:902:d201:: with SMTP id t1mr7842966ply.337.1569405669418;
        Wed, 25 Sep 2019 03:01:09 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x10sm6348741pfr.44.2019.09.25.03.01.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 03:01:08 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linus.walleij@linaro.org, natechancellor@gmail.com, sre@kernel.org
Cc:     longman@redhat.com, linux-gpio@vger.kernel.org,
        david@lechnology.com, linux-pm@vger.kernel.org, arnd@arndb.de,
        baolin.wang@linaro.org, orsonzhai@gmail.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y v3 0/3] Candidates from Spreadtrum 4.14 product kernel
Date:   Wed, 25 Sep 2019 18:00:49 +0800
Message-Id: <cover.1569405445.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Arnd's script [1] help, I found some bugfixes in Spreadtrum 4.14 product
kernel, but missing in v4.14.146:

513e1073d52e locking/lockdep: Add debug_locks check in __lock_downgrade()
957063c92473 pinctrl: sprd: Use define directive for sprd_pinconf_params values
87a2b65fc855 power: supply: sysfs: ratelimit property read error message

[1] https://lore.kernel.org/lkml/20190322154425.3852517-19-arnd@arndb.de/T/

Changes from v2:
 - Drop 2 unnecessary patches (patch 1 and patch 6) from v2 patch set.
 - Backport these patches to 4.19.y.

Changes from v1:
 - Drop 2 unnecessary patches (patch 1 and patch 4) from v1 patch set.
 - Add upstream commit id in change log for each stable patch.

David Lechner (1):
  power: supply: sysfs: ratelimit property read error message

Nathan Chancellor (1):
  pinctrl: sprd: Use define directive for sprd_pinconf_params values

Waiman Long (1):
  locking/lockdep: Add debug_locks check in __lock_downgrade()

 drivers/pinctrl/sprd/pinctrl-sprd.c       |    6 ++----
 drivers/power/supply/power_supply_sysfs.c |    3 ++-
 kernel/locking/lockdep.c                  |    3 +++
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
1.7.9.5

