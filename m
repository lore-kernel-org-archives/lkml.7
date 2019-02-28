Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD31C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C47120C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbfB1N0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:26:54 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40115 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfB1NZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:25:22 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 960E4E000A;
        Thu, 28 Feb 2019 13:25:18 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 00/15] net: mvpp2: fixes and improvements
Date:   Thu, 28 Feb 2019 14:21:13 +0100
Message-Id: <20190228132128.30154-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series aims to improve the Marvell PPv2 driver and to fix various
issues we encountered while testing the ports in many different
configurations. The series is based on top of Russell PPv2 phylink
rework and improvement.

I'm not sending a v2 of the previous fixes series as half the patches
are not the same and lots of development happened in between.

While this series contains fixes, it's sent to net-next as it is based
on top of Russell patches that were merged into net-next. I'm also
aiming at net-next as the series reworks critical paths of the PPv2
driver, such as the reset handling of various blocks, to let more weeks
for users to tests and for possible fixes to be sent before it lands
into a stable kernel version.

The series is divided into three parts:

- Patches 1 to 3 are cosmetic changes, sent alongside the series, as I
  saw these small issues while working on this.

- Patches 5 to 8 are fixing (or improving) individual issues that we
  found while testing PPv2.1 and PPv2.2 ports while using various
  interfaces.

  Notable fixes are we support back RGMII interfaces (on both PPv2.1 and
  PPv2.2), as their support was broken by previous patches. We also
  reworked the RXQ computation as the RXQ assignment was not checking
  the maximum number of RXQ available, and was broken for PPv2.1.

- As discussed in a previous fixes series, patches 9 to 14 rework the
  way blocks are set in reset in the PPv2 engine (plus related changes).

  There are four blocks we want to control the reset status: two MAC
  (GMAC and XLG MAC) and two PCS (MPCS and XPCS). The XLG MAC is used
  for 10G connexions and uses the MPCS or the XPCS depending on the mode
  used (10GKR / XAUI / RXAUI) and the GMAC is used for the other modes.

  The idea is to set all blocks in reset by default, and when not used,
  and to de-assert the reset only when a block is used. There are four
  cases to take in account:

  1. Boot time: all four blocks should be put in reset, as we do not
     know their initial state (configured by the firmware/bootloader).

  2. Link up: only the blocks used by a given mode should be put out of
     reset (eg. 10GKR uses the XLG MAC and the MPCS).

  3. Mode reconfiguration: some ports may support mode reconfiguration,
     and switching between the GMAC and the XLG MAC (or between the two
     PCS). All blocks should be put in reset, and only the one used
     should be put out of reset.

  4. Link down: all four blocks are put in reset.

Thanks!
Antoine

Antoine Tenart (15):
  net: mvpp2: fix a typo in the header
  net: mvpp2: update the port documentation regarding the GoP
  net: mvpp2: fix alignment of MVPP2_GMAC_CONFIG_MII_SPEED definition
  net: mvpp2: a port can be disabled even if we use the link IRQ
  net: mvpp2: reconfiguring the port interface is PPv2.2 specific
  net: mvpp2: fix validate for PPv2.1
  net: mvpp2: fix the computation of the RXQs
  net: mvpp2: some AN fields require the link to be down when updated
  net: mvpp2: always disable both MACs when disabling a port
  net: mvpp2: only update the XLG configuration when needed
  net: mvpp2: force the XLG MAC link up or down when not using in-band
  net: mvpp2: rework the XLG MAC reset handling
  net: mvpp2: reset the MACs when reconfiguring a port
  net: mvpp2: set the XPCS and MPCS in reset when not used
  net: mvpp2: set the GMAC, XLG MAC, XPCS and MPCS in reset when a port
    is down

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  11 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 210 +++++++++++++-----
 2 files changed, 156 insertions(+), 65 deletions(-)

-- 
2.20.1

