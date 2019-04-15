Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54679C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CAA20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="FL9jWMQv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="FL9jWMQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfDOQDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:03:54 -0400
Received: from node.akkea.ca ([192.155.83.177]:48426 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfDOQDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:03:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B1BDC4E2050;
        Mon, 15 Apr 2019 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555344233; bh=eDQC5TpUfQ7wNkeG0Mp4oWT1pPGfkWlbOdsl3H182/Q=;
        h=From:To:Cc:Subject:Date;
        b=FL9jWMQvLUxS2KLm+bGkGQNtb2hEAikGex7L7bPiM3C+BpBupdduIxWfDIeuhZv3o
         2/1b6ZQmBdKafeKY4qhj9QCD0tVq0a3qgCKebxh0dTZxRvWoFhqLxGBTqhbd0lX8YF
         DrewiU069vZc6e2W5T55EsuVqCCmfHFTw80ro110=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sUhmEJiyWBgo; Mon, 15 Apr 2019 16:03:53 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id CACEE4E204B;
        Mon, 15 Apr 2019 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555344233; bh=eDQC5TpUfQ7wNkeG0Mp4oWT1pPGfkWlbOdsl3H182/Q=;
        h=From:To:Cc:Subject:Date;
        b=FL9jWMQvLUxS2KLm+bGkGQNtb2hEAikGex7L7bPiM3C+BpBupdduIxWfDIeuhZv3o
         2/1b6ZQmBdKafeKY4qhj9QCD0tVq0a3qgCKebxh0dTZxRvWoFhqLxGBTqhbd0lX8YF
         DrewiU069vZc6e2W5T55EsuVqCCmfHFTw80ro110=
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
Subject: [PATCH v3 0/2] Add support for the Purism Librem5 devkit
Date:   Mon, 15 Apr 2019 09:03:44 -0700
Message-Id: <20190415160346.7324-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Librem5 devkit is based on the imx8mq from NXP. This is a default
devicetree to boot the board to a command prompt.

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
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 844 ++++++++++++++++++
 3 files changed, 846 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts

-- 
2.17.1

