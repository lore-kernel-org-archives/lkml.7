Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D65C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605912171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfIQPk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:40:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42415 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbfIQPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:40:28 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAFaZ-0003ZY-HW; Tue, 17 Sep 2019 17:40:23 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAFaY-0003yZ-Ex; Tue, 17 Sep 2019 17:40:22 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     zhang.chunyan@linaro.org, dianders@chromium.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        ckeepax@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/3] Regulator core fixes
Date:   Tue, 17 Sep 2019 17:40:18 +0200
Message-Id: <20190917154021.14693-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series address several improvements I found during devel a
battery-powered device.

The first one address the usage count. IMHO it should be possible to
disable a boot-on marked regulator because the regulator can be left on
by the fw but it isn't forbidden to disable it.

The 2nd address a probe failure. I found that the only dts using
regulator-suspend-min/max-microvolt is the at91-sama5d2_xplained.dts and
this dt use the binding as described in the documentation.
Unfortunately the doc and the implementation are different.

The 3rd adds the support for EPROBE_DEFER.

Regards,
  Marco

Marco Felsch (3):
  regulator: core: fix boot-on regulators use_count usage
  regulator: of: fix suspend-min/max-voltage parsing
  regulator: core: make regulator_register() EPROBE_DEFER aware

 drivers/regulator/core.c         | 18 ++++++++++++++++++
 drivers/regulator/of_regulator.c | 27 ++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.20.1

