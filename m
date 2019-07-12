Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB2C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2916A214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Rfe5+eXu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FuxgV8Iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfGLDhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:37:35 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38057 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729404AbfGLDhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:37:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 774A922196;
        Thu, 11 Jul 2019 23:37:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jul 2019 23:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=bzkTfMhJlLnueEo28/kxpkBvpN
        8gKMiWuRYbkXw0wjU=; b=Rfe5+eXuxJ6UQh2jCP3Gqz+NopKtTMxWrzCwbz4LhT
        GFwII3XdQoBAmEwDZaM/mLwBANHg0fyPh9F/xYmqJ2z+YsLFKVaaDlyRFPsFaT00
        bKOWlpiRrTiBjBOtqWEotqGC/AHOudz3mREpmUkoYa78goN/1rpkL0CKooiYOMHz
        XwAz3s0TELWyVkFYJ1ktRtfCrEPlmPxXG4up+FWrpdgcTgnfGIdDPmrWY0R7dbaj
        tu+HLw+7L3zC+a/WBw0m6dgRM22ge7RM2m9YsinZcwQ3WWI3+0+ifZ1V8J2Ad5fs
        6mRUM83E/B8sN67V5EIkU2dBAGRGscClJuxbBAQRwo9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bzkTfMhJlLnueEo28
        /kxpkBvpN8gKMiWuRYbkXw0wjU=; b=FuxgV8Iu6kVa+P6POmQGOd86Wc3QaIgiG
        tuGsH3tiyc2Xr0eJIguy3YMVCU/o0A1Oyr/GRi0IRqXNYGCaSnOfSeea74BgQ/A/
        Mh3xChOqJu2D//+qpQaU1wdCIhDhbRzy19Jr78VwmxSRlIOFn/lRjo3WF3wnjir2
        jy89HESCc5n0pKuXmqyWZWcRzudt3N2Q7JpUAbdrnicsxTzrg6nFt5IpO/SVkxAn
        zO4swmB53LysJC3pla9xvTzxefmMe8qMWY8lwJa/2XGbpBDx3+ERWJDD5tJlwDLP
        D2avjKMLR7txmiV5fnIrQM50Fel/n3Hy5xeakwuXJoAZV2BPPvpug==
X-ME-Sender: <xms:fAAoXfmQB6Kgou_Ho2-YWzYiwAPU3OcZ9A6AFijvQkZEYPJunjfutg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedvtddvrdekud
    drudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:fAAoXdmAMLXHke1Mf8skr-Vq7j-4-Q_cv18c-YFYIBr41b5Mj7RfXA>
    <xmx:fAAoXUiiGLzAG6mb9J2WXHfRVmbOdyV4IuS8wURvH9cKO5HBuZLaSA>
    <xmx:fAAoXeUh8t6Y6wJP0QRSh7--ISy-pr2fDu0pPZjT3PEMZqGwAU3OAQ>
    <xmx:fQAoXfC0A5rLU7UzjxpmPtJ-mNAG26uYezfbToU_LtZ-8xmuLUn9rw>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E968380079;
        Thu, 11 Jul 2019 23:37:29 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        ryanchen.aspeed@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Enable SD controllers
Date:   Fri, 12 Jul 2019 13:07:24 +0930
Message-Id: <20190712033726.25237-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v2 drops the "Swift" patch that accidentally modified witherspoon.dts instead
(thanks Joel), and leaves sdhci1 disabled on the EVB. v1 of the series can be
found here:

https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/001984.html

v2 reflects some of the changes driven by Rob's review of the bindings document
in v1 of the driver series:

https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/001994.html

As ever, please review!

Andrew

Andrew Jeffery (2):
  ARM: dts: aspeed: Describe SD controllers
  ARM: dts: aspeed: Enable first MMC slot on AST2500 EVB

 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 11 ++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi         | 28 ++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi         | 28 ++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

-- 
2.20.1

