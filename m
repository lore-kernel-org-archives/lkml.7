Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF0C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3922064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="D4kYOq39";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zr6KNcoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfGJOQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:16:32 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35299 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726617AbfGJOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:16:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6D3B4160C;
        Wed, 10 Jul 2019 10:16:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=pU/ZJD/W/LSUZ7docvxRW9NDp5
        g+z+9zh0aNagTZBXU=; b=D4kYOq39R5yaReEh7G3luGqW0UfZE1/qxpun4Df9zW
        XJ8vi83u3o4FLc10yVRjN+VlUylh1w1Ac8Aq2jkT9vNeCtkrEAJpTuowmZ+yIIIg
        RyzNNtA0VG2pGbXG36JelnF/I856XSBsG8k+LlTkvmkShNkODlK9uCE+hqJetJmQ
        GIcsjRN4KFRhk//k/A/92jU/Azev63qGN2INs4ThIg6u8Jb+RW8ubUkiqLCLdi36
        QUgIknlL0yiYToxpmes27ZNRJi0YHQNNugln4XE0ym1ECsY/TJTy21tUz0nXkmk6
        3ZYO8vhljwC0DoSquMzybm1hRaTkKJnx2X1g74tasypg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pU/ZJD/W/LSUZ7doc
        vxRW9NDp5g+z+9zh0aNagTZBXU=; b=zr6KNcoWBQzAjCHN6n23n3x+KoCEcsfVm
        ydGRWqXpXdOwAHa4yX+f2V1y/fAmEtY5bd23ZY8pLs+wBfTlKEKzKXpAYqkScBqH
        4RPiOocJ2C0TRfTfzU6ChCQ/hHA60ZdkUDLHz1WJONm2E0CVCoH7zPFTgCbHAtBd
        QNxc2PSxZGU2ITJGPKa2AA4bS+VaiEKXJLRuqQV3b0msjvdiWtJ3vRu8eIwsjH2b
        Bjc5GKCunyIvHW/LEFIJqloJx1901e0xnqf4tgZ5DDX6ou7Z6dwychT8Tdn77eET
        KLSSNy9Q4rfJTX/mPOr6Oiii60WDSddjTjw0d7T20YW3fgYMMp30w==
X-ME-Sender: <xms:O_MlXcjzK-xLWk4cI7qJv9Qw34H1oPMYwl9db4l3SnZa0xrdVyEHpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucfkphepudegrddvrdekhedrvddvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:O_MlXYzj6lwL8H5aVd3eLWJCL8CLQ22NXh0Quhg1AXqkNYcMEOXNbw>
    <xmx:O_MlXT2X8Z_GnJuzF12_9IifdL9fmLyPvmZzpNWemX7cSpb8o7Vq7g>
    <xmx:O_MlXclJBRzqINO-vg202mwBT4QvqGAXLcWoaDCsaQ74b2HCPk2NTw>
    <xmx:PPMlXYR0R3tjk-ZoC-ip6q7Tlxv83HZhK2kcnsRFr_gT5A5dqVprSQ>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E2FC380088;
        Wed, 10 Jul 2019 10:16:22 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        adrian.hunter@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
Subject: [PATCH 0/2] mmc: Add support for the ASPEED SD controller
Date:   Wed, 10 Jul 2019 23:46:09 +0930
Message-Id: <20190710141611.21159-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This short series introduce devicetree bindings and a driver for the ASPEED SD
controller. Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../bindings/mmc/sdhci-of-aspeed.yaml         |  91 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 307 ++++++++++++++++++
 4 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1

