Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA673C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B382184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="iqQ148Ks";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="AK1DVFXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfEXSdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:33:07 -0400
Received: from node.akkea.ca ([192.155.83.177]:52586 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfEXSdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:33:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 8BC524E2056;
        Fri, 24 May 2019 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558722785; bh=GjTxWLl04/VBrp89zY7pbkJt4uF3uLA357204mKJBEw=;
        h=From:To:Cc:Subject:Date;
        b=iqQ148KskLDabUqs7ziDLJqI1JbmGYdXQTsH70U6NGTr19O8PeHiEFJh3Rf+0hzQL
         4aBWLhwTCqKPsY4fWOIAJNg/LA4Gs55svP2HBtiDcjZTGe/F/4G/15TjzAN3Dsz8q2
         /4/VSbZkMfI+Nv+LXmrrIZ6T58kA5AW/Lx+WvMEQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CNbJyUawJgxq; Fri, 24 May 2019 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [24.244.23.228])
        by node.akkea.ca (Postfix) with ESMTPSA id 29B944E204B;
        Fri, 24 May 2019 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558722784; bh=GjTxWLl04/VBrp89zY7pbkJt4uF3uLA357204mKJBEw=;
        h=From:To:Cc:Subject:Date;
        b=AK1DVFXHN3gSR8L2WvNAJAmFPwV9JmFN2/9E0ZJydzJGBJOiiynU5QhXsMFEd2WWy
         ANZf6ey7e3nWYE5E/y4d3lP8tGwAPUP0rLHSWONJ7ZXK4yOF+f5P+Xtr4c6ZArOR8d
         3byebZw9C814EVdtmeKOyQSE77Gl1P0m1v2lyKjg=
From:   Angus Ainslie <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v14 0/3] Add support for the Purism Librem5 devkit
Date:   Fri, 24 May 2019 12:32:54 -0600
Message-Id: <20190524183257.16066-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Librem5 devkit is based on the imx8mq from NXP. This is a default
devicetree to boot the board to a command prompt.

Changes since v13:

Moved haptic motor from pwm-led to gpio-vibrator.
Cleaned up regulator node naming.
Whitescpace cleanup.
Re-indent pinmux stanzas.
Drop pwm2 node.
Drop MAINTAINERS patch.

Changes since v12:

Updated patch to vendor-prefixes.yaml.
Dropped always on from regulators.

Changes since v11:

Added reviewed-by tags.
Fixed subject typo.

Changes since v10:

Moved MAINTAINERS entry to "ARM/FREESCALE IMX" section

Changes since v9:

Added a MAINTAINERS entry for arm64 imx devicetree files.

Changes since v8:

Fixed license comment.
Changed regulators to all lower case.
Changed clock frequency for NXP errata e7805.
Dropped blank line.

Changes since v7:

More regulators always on for USB.
Add vbus regulator.
Drop vbat regulator.
Replace legacy "gpio-key,wakeup" with "wakeup-source".
Add vbus-supply to get rid of warning
imx8mq-usb-phy 382f0040.usb-phy: 382f0040.usb-phy supply vbus not found,
using dummy regulator

Changes since v6:

Dropped unused regulators.
Fix regulator phandles case.
Dropped extra whitespace.

Changes since v5:

Added reviewed-by tags.
Moved USB port links to USB controller node.

Changes since v4:

Compiled against linux-next next-20190415.
Added imx8mq to the arm yaml file.
Re-arrange regulator nodes to drop undefined supplies.
Additional ordering for aesthetics.
Split some long lines.
Added lots of blank lines.
Moved pinctl muxes to where they are used.
Cleaned out reg defintions from regulator nodes.

Changes since v3:

Freshly sorted and pressed nodes.
Change the backlight to an interpolated scale.
Dropped i2c2.
Dropped devkit version number to match debian MR.

Changes since v2:

Fixed incorrect phy-supply for the fsl-fec.
Dropped unused regulator property.
Fixup Makefile for linux-next.

Changes since v1:

Dropped config file.
Updated the board compatible label.
Changed node names to follow naming conventions.
Added a more complete regulator hierachy.
Removed unused nodes.
Removed unknown devices.
Fixed comment style.
Dropped undocumented properties.

Angus Ainslie (Purism) (3):
  arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
  dt-bindings: Add an entry for Purism SPC
  dt-bindings: arm: fsl: Add the imx8mq boards

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 794 ++++++++++++++++++
 4 files changed, 804 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts

-- 
2.17.1

