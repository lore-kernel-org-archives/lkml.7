Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE07ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AF721848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Grg3rMCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GvX3d3NO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbfJJCHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:07:55 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60611 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfJJCFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:05:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C66B21E29;
        Wed,  9 Oct 2019 22:05:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 09 Oct 2019 22:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=j0nJ6T39mBn7jdktZT6Zi6X9sd
        fIshRqVoX28oscb1o=; b=Grg3rMCD3oBEZNUMpdLMPocNMItAkpBFGgUsksSuhr
        ur9gtvrXrNA5jSZrwrqaZOdUnenU8g6XcXo2YPeeH2FWM7uhkf7BTK+EAbLo+DbF
        RNIBDr7kZJl58FEd5i6gl9wLDBztZY+mwP/MHZgZ53S30kalDB6HKKvkDljeoGu0
        ESzuUX0F8Ihxg3L/NnwfCshobLMTVw0CnQWmtBIFsBWCtKPhlYxSBCk4N7Kj7/42
        Zjqsa41Tzsk6McYk5pCOo5Dbl17LmHGpXAirYM5WpfYorShOcwtQgrw7Jk7gBcza
        pqHwWLx0lxGzbgaF7+RHPFonEsv8bjCrGs3GRYkpm0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=j0nJ6T39mBn7jdktZ
        T6Zi6X9sdfIshRqVoX28oscb1o=; b=GvX3d3NO4LpcMPH3fnKpwpu3sSnikOWpy
        BSzMdsbTXEu33S9MIV0RGsTRxod01XuiuhQeUq0BsfbDJLLfs2bjKRnFc+tro2zP
        sLelAZj6Yx+UdwZ53vLrqAhatmrs96aRJk+AfJ36dAmujrQtHvFJoUIRrM9v7Y+W
        O/bS0EQOgcyXBT9ut+RPX+aIkyyFm4hOao+NXmNJF64mS8+hUT1gJ13q09VwY24w
        Yzo/Q4N7VA6e7Q4g3HcPJZTb+3oi07Cc5KOqJWpuAXLd6ouk0uMJajtc4n66pr/0
        12hJs9kJ4hzPrGDe03TTe/P0ME16pQ25MKRHslaWImKWtySuFMlIw==
X-ME-Sender: <xms:AJKeXcSdWl408cda4MuK2rbaRDqUfONrCFbRzETcpJeSj_ugEoDBxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddvrdekud
    drudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:AJKeXVTPykFqBY-AgGPxHXqScOD15duqhBzxy9PXbKuiJuzXMqd7pg>
    <xmx:AJKeXe4NMpZ-dEwnkcFg2ywhVq3IHJX9IHQZYKF3hkTkg7crb-6WNg>
    <xmx:AJKeXe-OzahKpL4FaXG1Bcerml1DFJIDGn2jgwpQNwIMZvME9VeVpQ>
    <xmx:AZKeXf3y_VHgP-2UDPJ4b6BjJT2PW7Y2KcYOOKZS3ydLJS83kuDiKw>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 07A12D6005E;
        Wed,  9 Oct 2019 22:05:48 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] clk: aspeed: Expose RMII RCLK gate for MACs 1-2 on AST2500
Date:   Thu, 10 Oct 2019 12:36:53 +1030
Message-Id: <20191010020655.3776-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is two small changes enable kernel support for controlling the RMII
RCLK gate on AST2500-based systems. Previously the kernel has assumed u-boot
has ungated RCLK for networking to function.

RMII is commonly used for NCSI, which itself is commonly used for BMC-based
designs to reduce cabling requirements for the platform.

v2:
* Rename macros and clock names based on Joel's feedback.

v1 can be found here: https://lore.kernel.org/linux-clk/20191008113523.13601-1-andrew@aj.id.au/

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: clock: Add AST2500 RMII RCLK definitions
  clk: aspeed: Add RMII RCLK gates for both AST2500 MACs

 drivers/clk/clk-aspeed.c                 | 27 +++++++++++++++++++++++-
 include/dt-bindings/clock/aspeed-clock.h |  2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.20.1

