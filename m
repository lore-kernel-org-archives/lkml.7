Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD65C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D7F21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgABOEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:04:43 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:41586 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgABOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:04:42 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id lS4g2100B5USYZQ01S4gFM; Thu, 02 Jan 2020 15:04:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in15c-0006GP-Mp; Thu, 02 Jan 2020 15:04:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in0gG-0007eJ-A5; Thu, 02 Jan 2020 14:38:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/6] spi: rspi: Add support for multiple native and GPIO chip selects
Date:   Thu,  2 Jan 2020 14:38:16 +0100
Message-Id: <20200102133822.29346-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

Currently the Renesas SPI (RSPI/QSPI) driver supports a single native
chip select only.  This patch series adds support for multiple native
and GPIO chip selects.

As the RSPI controller always drives a native chip select when
performing a transfer, at least one native chip select must be left
unused, just like on MSIOF.  To avoid code duplication, the first two
patches add generic handling of unused native chip selects to the SPI
core, and converts the MSIOF driver to make use of this.  I expect
spi-orion can be converted, too.

Patches 3 and 4 contain two small drive-by cleanups.

on older SuperH and R-Mobile SoCs only, unfortunately, and thus
untested.  But it is too trivial not to implement ;-)

Patch 6 adds support for GPIO chip selects.

This has been tested with concurrent access to two cs-gpio slaves
connected to the two PMOD connectors on the RSK+RZA1 development board,
and regression-tested on Koelsch (single native chip select).

Thanks for your comments!

Geert Uytterhoeven (6):
  spi: Add generic support for unused native cs with cs-gpios
  spi: sh-msiof: Convert to generic unused native cs handling.
  spi: rspi: Use dev_warn_once() instead of open-coding
  spi: rspi: Remove set_config_register() macro
  spi: rspi: Add support for multiple native chip selects
  spi: rspi: Add support for GPIO chip selects

 drivers/spi/spi-rspi.c     | 21 ++++++++++-----
 drivers/spi/spi-sh-msiof.c | 53 +++-----------------------------------
 drivers/spi/spi.c          | 17 ++++++++++++
 include/linux/spi/spi.h    |  8 ++++++
 4 files changed, 42 insertions(+), 57 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
