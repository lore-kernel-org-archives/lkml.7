Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C6AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DD82089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfG3RaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:30:13 -0400
Received: from mxout014.mail.hostpoint.ch ([217.26.49.174]:61009 "EHLO
        mxout014.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728891AbfG3RaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:30:12 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsVwv-000GMa-Gt; Tue, 30 Jul 2019 19:30:09 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsVwv-000BNr-D6; Tue, 30 Jul 2019 19:30:09 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>
Subject: [RFC PATCH 0/2] Hello
Date:   Tue, 30 Jul 2019 19:30:03 +0200
Message-Id: <20190730173006.15823-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>


On our Colibri iMX6ULL board there is a circuit for switching the
power supply of the ethernet PHY with the 50MHz RMII clock.

This works quite fine but has one big problem. It is quite slow when
switching the supply, so Linux has to wait there. I think this switch
is at best represented as a fixed-regulator. In that way I can use
"startup-delay-us" to represent slow switching regulator.

But there's no current possibility to enable fixed-regulator with a
clock. In this RFC I send a patch after we would be able to add a clock
to a fixed-regulator in devicetree and then add the "startup-delay-us"
which would solve all my problems relatively elegant.
This works also the other way, if the PHY now needs power the
clock is not powered off because regulator depends on it.

Because this would need to change code in regulator core I like to
ask for your oppinion first, or if anyone has another idea how
I could solve that problem.

Thanks in advance for your feedback!

Philippe


Philippe Schenker (2):
  Regulator: Core: Add clock-enable to fixed-regulator
  ARM: dts: imx6ull: Add phy-supply to fec

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 drivers/regulator/core.c               | 15 +++++++++++++++
 drivers/regulator/fixed.c              |  6 ++++++
 include/linux/regulator/driver.h       |  3 +++
 include/linux/regulator/fixed.h        |  1 +
 5 files changed, 37 insertions(+)

-- 
2.22.0

