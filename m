Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0447ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7999B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="IkjsmFJD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xopbKxbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbfJJCIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:08:23 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60763 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbfJJCGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:06:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 80EF421E90;
        Wed,  9 Oct 2019 22:06:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 09 Oct 2019 22:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=BbKe8lAB6aLlCjfJZgxJtnIxN4
        5+vPNsWUwa92cPHoM=; b=IkjsmFJDTlGNZMhcdiYMZUiNjofp+H76r88IYAzXiN
        WuTBqVVhfNGstxu50I3HT4g3wnANmqXqGnHN7lMrjfRe6QZOj6UqI8vA/N/CDJlT
        /9KQfZ37JV1y92ZVwV51YzXAF2EKohI3H/PGpsexi2NNQEoYPQsDrXM4W0m26B+h
        P8z2Jws7+5JFGcahZGYX9KNUe6XJtH94F2+B7hoQTfswArnzbBnVmzg1mc4Q8pdR
        bsFyXaZ4yw+Nxqkaep0r7JoWva0TrUL0V3ihhpKGXSIQi7JVIVsW/TrTNvr/Z/nm
        EQfR4cC//S5UvMj5T2FHWFypJtQw/6B9UESI+yMj8m4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=BbKe8lAB6aLlCjfJZ
        gxJtnIxN45+vPNsWUwa92cPHoM=; b=xopbKxbvIBWIRZ2xt2xLRt6jYHaIeBghS
        uxIRxQk+aXuQIzqAqNbEgpy1mtAuUH3vRP21B2tC3O3YXUSdIFoIBDr+ATx5OAM7
        s0ur2yMDmvuhfCN0tuMsJjGkRpfJ9O1kd9WJX2/Q2XZqu2KTegLI2MBlOpHk6pT5
        +hJs8pCPEzjrvVgQzO5YaNsvD2V9DaztoJ9/FefK/Qc6jlWGuI5CfOIgEKya8nWw
        PTt2kRHj1Kq18+5PBIFtYxSc6iUhz6sG/nwSA5nJMSEexiej/knNZ2IaLXcUAixS
        1jfOFdrpl9dTftpXayl4ynrGqhjZyFXlvXofJVv42LqoPpCt6fUrA==
X-ME-Sender: <xms:HZKeXQII42Z69vCLC3eQl4QskYdZGdvDyYSNlH8kP8f6mr2Cih8c7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddvrdekud
    drudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruhenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:HZKeXatCnlPNFR-ESBZ4AC0xo6CjE9-Q-CtPma4Z6E1NciFDbKvWBA>
    <xmx:HZKeXdQSDGMF0a4wjnCwi5-NKVucxhimWnp-RD3cB_lvE_4-To8-Fg>
    <xmx:HZKeXQOyv-U6SiPDk-1uTm6J8yuVjUuooDJdNCCdOeyB4ACqj-GwSA>
    <xmx:HZKeXVzii6CfDaNDRUM0xX_ObCob9TA4uzy6bETopK6S16Y8g5R5-w>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02CF580061;
        Wed,  9 Oct 2019 22:06:17 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] clk: ast2600: Expose RMII RCLK for MACs 1-4
Date:   Thu, 10 Oct 2019 12:37:23 +1030
Message-Id: <20191010020725.3990-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is similar to that for the AST2500 but I've split the patches out
as the AST2600 driver is new for 5.4 and I'm hoping we have a chance of
slipping them in. Maybe we can get both series in, but I thought decoupling
them might make it more manageable if not.

Regardless, the blurb:

This series is two small changes enable kernel support for controlling the RMII
RCLK gate on AST2600-based systems. RMII is commonly used for NCSI, which
itself is commonly used for BMC-based designs to reduce cabling requirements
for the platform. NCSI support for the AST2600 is not yet implemented in
u-boot and so unlike the AST2500 the kernel can't rely on RCLK already being
ungated.

v2: Rename some macros and clocks based on feedback from Joel

v1 can be found here: https://lore.kernel.org/linux-clk/20191008113553.13662-1-andrew@aj.id.au/

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
  clk: ast2600: Add RMII RCLK gates for all four MACs

 drivers/clk/clk-ast2600.c                 | 47 ++++++++++++++++++++++-
 include/dt-bindings/clock/ast2600-clock.h |  4 ++
 2 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.20.1

