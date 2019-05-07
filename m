Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C816DC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D4920989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfEGHrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:47:36 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54374 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfEGHrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:47:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B6F37FB03;
        Tue,  7 May 2019 09:47:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DAVuvV9XCslZ; Tue,  7 May 2019 09:47:27 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0FCAB4619A; Tue,  7 May 2019 09:47:27 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v10 0/2] Mixel MIPI DPHY support for NXPs i.MX8 SOCs
Date:   Tue,  7 May 2019 09:47:24 +0200
Message-Id: <cover.1557215047.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds initial support for the Mixel IP based mipi dphy as found on i.MX8
processors.  It has support for the i.MX8MQ, support for other variants can be
added - once the platform specific parts are in - via the provided devdata.
The driver is somewhat based on what's found in NXPs BSP.

Public documentation on the DPHY's registers is currently thin in the i.MX8
reference manuals (even on the i.MX8QXP form 11/18) so most of the values were
taken from existing drivers. Newer NXP drivers have a bit more details so where
possible the timings are calculated and validated.

This was tested with the an initial version of a NWL MIPI DSI host
controller driver

    https://lists.freedesktop.org/archives/dri-devel/2019-March/209685.html

and a forward ported DCSS driver on linux-next 20190506.

Robert Chiras (the author of the corresponding driver in NXPs vendor
tree) got this driver to work in his tree as well using mxsfb:

    https://www.spinics.net/lists/arm-kernel/msg711950.html

Changes from v9
* As per review comments from Fabio Estevam
  * Sort includes alphabetically
  * Remove excessive new lines between functions
  * Drop error message on devm_ioremap_resource, handled by
    the core already.
  * Don't default to it on i.MX8
* As per review comments from Sam Ravnborg
  * Use clearer variablenames:
       struct regmap *regs -> regmap
       void __iomem *regs -> base
  * Use u32 for all parameters of get_best_ratio()
  * Don't use non-ascii symbols in debug message
  * Change MODULE_LICENSE to GPL
* As per review comment from Andreas Färber
  * Change co-authored-by: to co-developed-by:
* Collect Signed-off-by from Robert Chiras

Changes from v8
* Collect Reviewed-by from Rob Herring
* Fix {hs,clk}_prepare vs {hs,clk}_zero debug print out

Changes from v7
* As per review comments from Rob Herring
  * Use fsl, as vendor prefix
  * Drop changes to vendor-prefixes.txt due to that
  * Shorten mixel_dphy to dphy in the example
* Fix an indentation error noticed by checkpatch that got introduced in v6
* Use lowercase letters in hex addresses in DT bindings example

Changes from v6
* Depend on HAS_IOMEM (fixes a build problem on UM spotted by kbuild)

Changes from v5
* Fix build problems on mips (spotted by the kbuild test robot) by using u32
  consistently and long long for lp_t.

Changes from v4
* Build by default on ARCH_MXC && ARM64

Changes form v3
* Check correct variable after devm_ioremap_resource
* Add Robert Chiras as Co-authored-by since he's the author
  of the driver in NXPs BSP.

Changes from v2
* As per review comments from Fabio Estevam
  * KConfig: select REGMAP_MMIO
  * Drop phy_read
  * Don't make phy_write inline
  * Remove duplicate debugging output
  * Comment style and typo fixes
  * Add #defines's for PLL lock timing values
  * Return correct error value when PLL fails to lock
  * Check error when enabling clock
  * Use devm_ioremap_resource
* As per review comments from Robert Chiras
  * Deassert PD_DPHY after PLL lock (as per mixel ref manual)
  * Assert PD_{DPHY,PLL} before power on (as per mixel ref manual)manual
* Add exit phy_op to reset CN/CM/CO

Changes from v1
* As per review comments from Fabio Estevam
  * Kconfig: tristate mixel dphy support.
  * Drop unused 'ret' in mixel_dphy_ref_power_off.
  * Match values of DPHY_RXL{PRP,DRP} to those of
    https://source.codeaurora.org/external/imx/linux-imx/log/?h=imx_4.14.78_1.0.0_ga
    The previous values were based on 4.9.
  * Use resource size on devm_ioremap, we have that in dt already.
  * Use regmap so it's simple to dump the registers.
  * Use regmap_read_poll_timeout instead of open coded loop.
  * Add undocumented rxhs_settle register
* As per review comments from Sam Ravnborg
  * Move driver to d/phy/freescale/
  * Move SPDX-License-Identifier to top of file.
  * Drop '/* #define DEBUG 1 */'.
  * Use GPL-2.0+ since the vendor driver uses that as well.
  * Drop the mutex, register access is now protected by regmap.
  * Fix various style / indentation issues.
* Check for register read, write and ioremap errors
* Improve phy timing calculations
  * Use LP clock rate where sensible, check for errors
  * Use ad hoc forumulas for timings involving hs clock
* Switch from dphy_ops to devdata. Other i.MX8 variants
  differ in register layout too
* Add Mixel Inc to vendor-prefixes.txt

Guido Günther (2):
  dt-bindings: phy: Add documentation for mixel dphy
  phy: Add driver for mixel mipi dphy found on NXP's i.MX8 SoCs

 .../bindings/phy/mixel,mipi-dsi-phy.txt       |  29 +
 drivers/phy/freescale/Kconfig                 |  10 +
 drivers/phy/freescale/Makefile                |   1 +
 .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 499 ++++++++++++++++++
 4 files changed, 539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c

-- 
2.20.1

