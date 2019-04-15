Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10735C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C3D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="vCb/gXpo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Ej0UP/rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfDOXyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:54:02 -0400
Received: from node.akkea.ca ([192.155.83.177]:34126 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfDOXyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:54:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 0FCF44E2050;
        Mon, 15 Apr 2019 23:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555372442; bh=DLS9kubsTYkqiROPZWhnmJamgfUj58PlM4whFhYh0RI=;
        h=From:To:Cc:Subject:Date;
        b=vCb/gXpodM3Rx2DRtg820rdTFUq1xmECWLgdViULaZFoNCExnmQyjD2t5lT4hAY2Q
         OYwvZG3ulnX7ukLayRP6hMjhLMXwI6KjNJEGm1m53DCpWEMKf1TPFatZTGFa9m1lun
         e5YUkNohCbbo+QJS3/215kXUxlyKX9hIA1Dojp8I=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3Lk_MNjGsA6L; Mon, 15 Apr 2019 23:54:01 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 06AD94E204B;
        Mon, 15 Apr 2019 23:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555372441; bh=DLS9kubsTYkqiROPZWhnmJamgfUj58PlM4whFhYh0RI=;
        h=From:To:Cc:Subject:Date;
        b=Ej0UP/rgTfF7nlRW71MIbtf/3rlFwPPi/nQ7BUc52uvr41zLOpFOo18QNw/Afhn6R
         aFc/AdkC7HyvLz44mg0RENE4uFL8LbJtVW1yRIbFSDfw2szWAbXM0PLLQNEuwZ3MQW
         fb350/ilPyY6gnr6QkUk6NswJ0f7yzo0ahq4fKSE=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add support for the Purism Librem5 devkit
Date:   Mon, 15 Apr 2019 16:53:41 -0700
Message-Id: <20190415235343.16565-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Librem5 devkit is based on the imx8mq from NXP. This is a default
devicetree to boot the board to a command prompt.

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

Angus Ainslie (Purism) (2):
  arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
  dt-bindings: Add an entry for Purism SPC

 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 822 ++++++++++++++++++
 3 files changed, 824 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts

-- 
2.17.1

