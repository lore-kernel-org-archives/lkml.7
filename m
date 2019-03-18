Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76574C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533D020880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCRPs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:48:58 -0400
Received: from sauhun.de ([88.99.104.3]:36790 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfCRPs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:48:58 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id 41E752C2817;
        Mon, 18 Mar 2019 16:48:55 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 0/6] mfd: da9063: remove platform_data
Date:   Mon, 18 Mar 2019 16:47:52 +0100
Message-Id: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When working with this driver while debugging something else, I noticed that
there are no in-kernel users of platform_data anymore. Removing the support
simplifies the code and gets rid of quite some lines. The biggest refactoring
went to the regulator driver which could maybe benefit from more
refactorization. However, there is no in-kernel user of that driver, so no
testing. I left it at this stage. I think the changes are still at a level
where review and build-testing will give enough confidence.

Besides the regulator thing, it was tested on a Renesas Lager board (R-Car H2).
No regressions encountered. buildbot was happy, too.

The patches are based on v5.1-rc1. I'd vote for all of them going through the
MFD tree. Looking forward to comments!

   Wolfram


Wolfram Sang (6):
  regulator: da9063: remove platform_data support
  input: da9063_onkey: remove platform_data support
  mfd: da9063: remove platform_data support
  regulator: da9063: move definitions out of a header into the driver
  mfd: da9063: remove leftover platform_data definitions
  regulator: da9063: platform_data is gone, depend on OF

 drivers/input/misc/da9063_onkey.c    |  11 +---
 drivers/mfd/da9063-core.c            |  20 +-----
 drivers/mfd/da9063-i2c.c             |   1 -
 drivers/mfd/da9063-irq.c             |   1 -
 drivers/regulator/Kconfig            |   2 +-
 drivers/regulator/da9063-regulator.c |  61 +++++++++++++------
 include/linux/mfd/da9063/pdata.h     | 114 -----------------------------------
 7 files changed, 49 insertions(+), 161 deletions(-)
 delete mode 100644 include/linux/mfd/da9063/pdata.h

-- 
2.11.0

