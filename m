Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D19AC74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31892064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="UjhvK8Wy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZnSFQJZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfGJONi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:13:38 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49811 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbfGJONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:13:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5AD75216CA;
        Wed, 10 Jul 2019 10:13:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=5v+hHlvidFmtFgjlAm3pBo2Tz+
        GoKLc5rUvGwtlDRfI=; b=UjhvK8Wyhx1ZV33kRimOa4uTyTlXlS9qqz4B0PEdy/
        pqtBMjnHxlL6U0qzZ7uwfbeHZ6XHfx4Y2VdvRog7tOSMNpXxeVJ6t7TDR534VISG
        jrCqUhXIkQb44AsCK+QRPb6C+i3YB9vk0+heVW3y+rVPvAUHmdTewNc96KwyTOA1
        vurtdnQx8lpJbNyK6PXWkj2rRLJj/ZOJnprezTPMb2qGqgzGyAQsBk0S4v9bhP9t
        XqAHMYmEzsD5rd7MkxpCSFyswD11WgvnCIFhzydKO7nrMVBV/qzPql3Dj0Zj0iyC
        6QeA+IHrISYFwNKe1amAW8XCpHJSLLAtOpqTJltbofNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5v+hHlvidFmtFgjlA
        m3pBo2Tz+GoKLc5rUvGwtlDRfI=; b=ZnSFQJZjNMJbxNMefR08ouzswfBXEdBkC
        dM3EJ5by9Mvt9okUvPzyG6FuRVjWpv2+yHYLiKglNvP1S+WouK1PMdNTEjBbc39k
        JJHGP7T7/rYCN8/kwMwzIPp/1MHzmcWaFn7b6gO2fFFPHsBURAfSxshyzXcNBpy1
        VQ+KyaX82n8d49we7bxMK7vVNiQwhAVbCxmmKCVKtwzYUgtm3qol0Lmq0jqlGgH5
        hKanjKp/xcPK9tU8lEVayrYDrQYOd3IY5YvedFKZmdjhZXeND5BfjKfJVD7cnFNa
        knjps+1Z41meU8/LbQJNxJSggsNeFZeAC5zAXDlVM+Tgs8QqvsvKw==
X-ME-Sender: <xms:jvIlXTXRXnLZtST76DPU1uXq_K8okxZpsf6JWfLQwuOuOMChic3nHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucfkphepudegrddvrdekhedrvddvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:jvIlXXSB08Fd9eGNS0FTotHtfnt1k97BhdcZQKMOxw3JEgZ1e7qKnQ>
    <xmx:jvIlXaGvlBgj01ZpDRFQjjqxg0Gwhzp6pIp6r6grlniSKxcpOa79DA>
    <xmx:jvIlXfS0r2GV-C-Nwcyv5U7bbYwg2rJh24nBk_a_AK_U0tUKC1CI7A>
    <xmx:kfIlXU-nxT3rL2IjsA7AspTCVFV729-B9KbNcKCok6sSNywHwrwhgA>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E724380086;
        Wed, 10 Jul 2019 10:13:31 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, joel@jms.id.au,
        ryanchen.aspeed@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM: configs: aspeed-g5: SD Controller support
Date:   Wed, 10 Jul 2019 23:43:22 +0930
Message-Id: <20190710141325.20888-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds SD controller related bits to the aspeed_g5_defconfig.

Please review!

Andrew

Andrew Jeffery (1):
  ARM: config: aspeed-g5: Refresh on 5.2

Joel Stanley (1):
  ARM: config: aspeed-g5: Enable EXT4, VFAT

Ryan Chen (1):
  ARM: config: aspeed-g5: Enable SD Controller

 arch/arm/configs/aspeed_g5_defconfig | 64 ++++++++++++++--------------
 1 file changed, 32 insertions(+), 32 deletions(-)

-- 
2.20.1

