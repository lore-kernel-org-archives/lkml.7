Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CAF20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="rvzZ8G0k";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="pkHgRTVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfC1NjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:39:01 -0400
Received: from node.akkea.ca ([192.155.83.177]:39698 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfC1NjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:39:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 4A61F4E204E;
        Thu, 28 Mar 2019 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780340; bh=Z+i5nDpI88Adq0oEdVE89mdSgT+qwKL6/taAhRpbDh0=;
        h=From:To:Cc:Subject:Date;
        b=rvzZ8G0kqrpyhVHS93afvnNJ+ewoqhHPwE5+TyzROMDIBlsDFypPOw4V6w9jo0Qy6
         h9wo2bc3YM55be6903h+sAVcB02miCmUQtfQG3zI3rPkWbMrF7QiFJQctRR3/CtlsZ
         NyembLLZ+iVKoi2YmAK1OeNAMKgmW1k6RWC8g308=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CPgqYQqHc47J; Thu, 28 Mar 2019 13:38:59 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 056624E204B;
        Thu, 28 Mar 2019 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553780339; bh=Z+i5nDpI88Adq0oEdVE89mdSgT+qwKL6/taAhRpbDh0=;
        h=From:To:Cc:Subject:Date;
        b=pkHgRTVmsr+JWFQdeNn5/DKXHGBO8DgJXQyJ1Ye1mW9B620rAtnlmHygPKXASXRn0
         p22hwILlyRj7P3o1wQm9joZzXYeb+Gb9BSu1BtHyBbJ/9+Vj6kDWwVEqJRt50NIc3z
         Xj7Y0sqkNYvlQy5I1bojmJsWRQ4B3npbLDPlZkGw=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 0/4] Fix imx8mq ratio 1:1 check
Date:   Thu, 28 Mar 2019 06:38:24 -0700
Message-Id: <20190328133828.20999-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mq 1:1 check breaks some earlier imx chips so limit the
ratio check to the imx8mq.

Angus Ainslie (Purism) (4):
  arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma compatible string
  dmaengine: imx-sdma: Add clock ratio 1:1 check
  dt-bindings: Document the new imx8mq-sdma compatible string
  arm64: dts: imx8mq: Change ahb clock for imx8mq

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  4 +--
 drivers/dma/imx-sdma.c                        | 31 ++++++++++++++++---
 3 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.17.1

