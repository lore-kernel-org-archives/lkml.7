Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7592F214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="hFgLZeAQ";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="hFgLZeAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfCKXrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:47:07 -0400
Received: from node.akkea.ca ([192.155.83.177]:39744 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfCKXrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:47:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 792B04E2050;
        Mon, 11 Mar 2019 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552348026; bh=s4ivW+murFdB85YndqL2NPJuJSHUBabeE/3KVkoXbDw=;
        h=From:To:Cc:Subject:Date;
        b=hFgLZeAQGpRTX3sLB5eE1oHWkShuZs9ncJwKYqSKMaj+c8gWGS9aM8F2pJDmukNoe
         2cr2+upA5SKZSgfav1Eo49u4XBbXUXfVY0yJ6HJJfnOT86kHMJOnNquyIYj2/uRG/s
         Bq8JBtsoOvrLWj7ljYoKUG2720sh9OsITc1IuoIs=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rv7H6WzvQVX1; Mon, 11 Mar 2019 23:47:06 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 94D994E204B;
        Mon, 11 Mar 2019 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552348026; bh=s4ivW+murFdB85YndqL2NPJuJSHUBabeE/3KVkoXbDw=;
        h=From:To:Cc:Subject:Date;
        b=hFgLZeAQGpRTX3sLB5eE1oHWkShuZs9ncJwKYqSKMaj+c8gWGS9aM8F2pJDmukNoe
         2cr2+upA5SKZSgfav1Eo49u4XBbXUXfVY0yJ6HJJfnOT86kHMJOnNquyIYj2/uRG/s
         Bq8JBtsoOvrLWj7ljYoKUG2720sh9OsITc1IuoIs=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        Lucas Stach <l.stach@pengutronix.de>, abel.vesa@nxp.com,
        daniel.baluta@nxp.com, agx@sigxcpu.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 0/3] Add support for the Purism Librem5 devkit
Date:   Mon, 11 Mar 2019 16:46:52 -0700
Message-Id: <20190311234655.30357-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Librem5 devkit is based on the imx8mq from NXP. This is a default config
and devicetree to boot the board to a command prompt.

Angus Ainslie (Purism) (3):
  arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
  arm64: dts: fsl: Build the Librem5 devkit devicetree
  arm64: librem5-devkit: Add defconfig for the Librem5 devkit

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 804 ++++++++++++++++++
 arch/arm64/configs/librem5-devkit_defconfig   | 534 ++++++++++++
 3 files changed, 1339 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
 create mode 100644 arch/arm64/configs/librem5-devkit_defconfig

-- 
2.17.1

