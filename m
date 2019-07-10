Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE253C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E492087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="X2ZKFxpC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IcQ5AsDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfGJOPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:15:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50567 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbfGJOPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:15:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 09CF522110;
        Wed, 10 Jul 2019 10:15:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=T/5pb6r/UoVQt8P3l97DTHCU6/
        +Zf8y3qrrQsrsydeA=; b=X2ZKFxpCWG3Vijn9d9lOXXbc0Tm0ZcveoseEiLPESJ
        NIwSCViJpbee2BpHt8yymxP7MdVLg0GO91xe6PLRBhigOi37/mK/XmFR+mo9wGON
        lIqVqlkt2ozpkt1EM66VQChveVJ0JA2kufF+eM+cWJRci2KRLbyjoDYXSwjpiD4/
        Nzptg96Ft0X19C42uR2dpGW6L8r2jIS57RJt5poeeuN+dsYrLuvPAWZ8Pu059Den
        Vb8y8hKhzRi4IRN0ESw6KRoNbosTXTGKuf7PWVwJKza3YswZsUDkiW9/7+9ABpQG
        CIJ+R9R/+/5j/tGbzq+YTMKcpNaZkHWk87zLALvN7NNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=T/5pb6r/UoVQt8P3l
        97DTHCU6/+Zf8y3qrrQsrsydeA=; b=IcQ5AsDfvkKnRbGfZ6moQEyceuLeKth25
        u9gVS3tkhfdIcS8zFsPNe+GPGvQOd1rWG4kQGTtmvitHkHtjVPogEX1PHn44NK2L
        EXQE+oCOb3sfRv/sY3kX0IAE1HuF3kwrGyd5OfGLTw5p9CJbzjq+Ftb6OsLIl+my
        fND3QEsmO9ydoYBooSJ/v5vp040VsKtUuC4STYhI1rrUk2aEhI3le3z7hoqI7lQ9
        NosJ/lmkmnEFhh7aX0tjPUECWBEOZ8CITaW3ngpm8b0ZdEkwggGC5GOkk6ESd7TS
        f5ZEuAsZikckqMRLSKfx5vP1wd1emIOyeQmNS10MEUFmREFdzH67w==
X-ME-Sender: <xms:7_IlXQpoHYjDQmCVOpHmjt_-tpzTaFGY4XpbHeVYzZSpyPBIa_uMgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucfkphepudegrddvrdekhedrvddvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:7_IlXdetVpmyM7uZUhUAOnWmVbJG7FsDMXo6el8cQohmnS3MrF-3_A>
    <xmx:7_IlXeLE2LtUOUMDARsIYouBCvUpOZuproX_7c17LH1oeftv9-ACZw>
    <xmx:7_IlXauriFBbV7gwAcvljpN1_T4NWD532XBj-AI6UMofAr747060Ig>
    <xmx:8fIlXXDNKuZJTMZtWUR2d-z9tV5LUB72y9Ot435UDHbg7jfEzdt31g>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E8408005B;
        Wed, 10 Jul 2019 10:15:08 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM: dts: aspeed: Enable SD controllers
Date:   Wed, 10 Jul 2019 23:45:00 +0930
Message-Id: <20190710141503.21026-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series describes the ASPEED SD controller in relevant devicetree files,
enabling the MMC slots on the AST2500 EVB and Swift machines.

Please review!

Andrew

Andrew Jeffery (2):
  ARM: dts: aspeed: Describe SD controller in DTSIs
  ARM: dts: aspeed: Enable both MMC slots on AST2500 EVB

Joel Stanley (1):
  ARM: dts: aspeed: Enable both MMC slots on Swift

 arch/arm/boot/dts/aspeed-ast2500-evb.dts      | 18 +++++++++++
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 18 +++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi              | 30 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi              | 30 +++++++++++++++++++
 4 files changed, 96 insertions(+)

-- 
2.20.1

