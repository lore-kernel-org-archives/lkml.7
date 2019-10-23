Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7054A205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbfJWKN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:13:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390935AbfJWKN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 546CEB4D6;
        Wed, 23 Oct 2019 10:13:27 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/11] arm64: Realtek RTD1295 reset controllers
Date:   Wed, 23 Oct 2019 12:13:06 +0200
Message-Id: <20191023101317.26656-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds reset controllers for the Realtek RTD1295 and RTD1195 SoCs.

v2 adopts reset-simple driver and DesignWare bindings as simplification
and covers RTD1195, too.

Note that reset-simple driver would allow to cover RTD1195's reset1-3 in one
DT node, but it only maps the first resource, so RTD1295's reset4 would need
to remain separate due to a gap in between. I've therefore left them all as
separate nodes for now.

Also note that my initial 32-bit arm patch already selects RESET_CONTROLLER,
to avoid needing a separate patch here to add that one line as done for arm64.

If I can take the bindings patches through the Realtek tree then I can squash
the two final DT patches depending on them into the patches added the resets,
otherwise they need to go into v5.6 or be merged via a topic branch.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Drop custom reset driver
* Drop "realtek,rtd1295-reset" binding
* Reordered to not depend on irqchip or clk patches
* Extended with RTD1195 patches

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org

Andreas Färber (11):
  dt-bindings: reset: Add Realtek RTD1295
  dt-bindings: reset: Add Realtek RTD1195
  reset: simple: Keep alphabetical order
  reset: simple: Add Realtek RTD1195/RTD1295
  arm64: realtek: Select reset controller
  arm64: dts: realtek: Add RTD129x reset controller nodes
  arm64: dts: realtek: Add RTD129x UART resets
  ARM: dts: rtd1195: Add reset nodes
  ARM: dts: rtd1195: Add UART resets
  arm64: dts: realtek: Adopt RTD129x reset constants
  ARM: dts: rtd1195: Adopt reset constants

 arch/arm/boot/dts/rtd1195.dtsi              |  27 +++++++
 arch/arm64/Kconfig.platforms                |   1 +
 arch/arm64/boot/dts/realtek/rtd129x.dtsi    |  34 +++++++++
 drivers/reset/Kconfig                       |   5 +-
 include/dt-bindings/reset/realtek,rtd1195.h |  74 +++++++++++++++++++
 include/dt-bindings/reset/realtek,rtd1295.h | 111 ++++++++++++++++++++++++++++
 6 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/realtek,rtd1195.h
 create mode 100644 include/dt-bindings/reset/realtek,rtd1295.h

-- 
2.16.4

