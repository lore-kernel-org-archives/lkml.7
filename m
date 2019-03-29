Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7702054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="iPlrgjEH";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="bc0lbgXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfC2PVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:21:43 -0400
Received: from node.akkea.ca ([192.155.83.177]:58944 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbfC2PVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:21:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 414694E2050;
        Fri, 29 Mar 2019 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553872900; bh=vGf7stW5+fx4AXVDt8QKDcYDM5X8aEcqMtLEjtCVjm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iPlrgjEHZx+DgUPySf6/ek5VOSHBmFt4u20HYjyciD3SO4qLmh9uqj7GApz8ttiud
         rOhfiwPlN4gygUejvNLcBAqjg7F08eopa8cnZiaxiFLcPRjH2zvKWyQIinjzYhkwYe
         llNEjZd0ESGUQYU5W9sZ+8tQ4nhE04D0Djxmqjwk=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PAZ81c-VySaa; Fri, 29 Mar 2019 15:21:39 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 0FB044E204B;
        Fri, 29 Mar 2019 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553872899; bh=vGf7stW5+fx4AXVDt8QKDcYDM5X8aEcqMtLEjtCVjm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bc0lbgXtrpZeN0nUX+WzpbCRLA+4PYiibvn4vZmF7xhC875YaSTmAlxmP3S1gZ8eo
         EUE47q/VD7u8bdfXIo+24zyWdj5uFnXq9/ramQz9/x2sqxSOLEQR8EKwQRQR2EjkDW
         ie7SiHAsW1NIZatkDmezEV9lKbyHfZ8ivNC+Pgkw=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
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
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v2 0/3] Fix imx8mq ratio 1:1 check
Date:   Fri, 29 Mar 2019 08:21:27 -0700
Message-Id: <20190329152130.18411-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328133828.20999-1-angus@akkea.ca>
References: <20190328133828.20999-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mq 1:1 check breaks some earlier imx chips so limit the
ratio check to the imx8mq.

Changes since v1:
Use the correct compatible string when fixing things.
Just add the imx8mq parts to the ratio check.
Drop the dt bindings update.

Angus Ainslie (Purism) (3):
  arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma compatible string
  dmaengine: imx-sdma: Only check ratio on parts that support 1:1
  arm64: dts: imx8mq: Change ahb clock for imx8mq

 arch/arm64/boot/dts/freescale/imx8mq.dtsi |  4 ++--
 drivers/dma/imx-sdma.c                    | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.17.1

