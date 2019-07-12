Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C29EC742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD6A214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Fvlec1Jq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9mRD1Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfGLDcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:32:22 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42123 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728955AbfGLDcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:32:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 458DB6A;
        Thu, 11 Jul 2019 23:32:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jul 2019 23:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=0/ELW1INd9ZqSD2iZt9/xN6YTT
        BSlrGKdOYRNFKIJUg=; b=Fvlec1JqxpZpVwTKbLfwLKFE04wzCcdk8i1EZaFGr2
        ZzpcXbiFhQNj1yx/AEXqDHQ9Sm3gLkC0CYXzTZsSVUbkOYFBsofkPcr3wuwV/FNz
        6w28BN4CKQEwTznF+gw2rrmCUHKSrtPhsPoL9KMm0C8iuqMDEypGZIZ2AfrNTi/Z
        8NHm4HBtBiDHvyybIOgMgG+l9uMb4FdHyX63nGBdm1bStV9R0mvwiqxjxsp/Z5qE
        /1NMdPdd7L69Psx3T6T5zajbxJZL86Kem8/gHO1Hl4PmeR14pD1JdZs75qyGAVPV
        4DU4T+p1LCPojanvrjq4i1Ufw8nL2x/ZTnpqeecMYiOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0/ELW1INd9ZqSD2iZ
        t9/xN6YTTBSlrGKdOYRNFKIJUg=; b=Q9mRD1QjsjyrkWoHz3RBxWy8mnvRMPD0i
        55YXDJWdg6+gf170T/VczeiyTaGBYuRg0ZVh9U4zj7qQ6MG5co+2UMP+2q8LGjst
        Xn1RtmERh9h0NtC79ra59js5DJy717Toj6Lw736k5NT7Tly2sRZvE2zxmIdSMC8N
        BC+py1aRqwOsN/Xq8E4bl9n/bKnh+MFaoQb2fuBE4WVBLVXCVoGLxj+yHdVYZJK0
        ieKyvyM2K6qz55lZaWcYUuBg/TqP1Xnafs5sxUjFlsME/MrxnNfmXW0ts4QO/IJu
        fdbDytVQMT+9dA5+bmFgxkqAwwLgGuiCYFsLE2P5zN6CJFNl1Sbxw==
X-ME-Sender: <xms:Q_8nXQSdE5Erss_8QGL61LhbuZjUCt5Mwy_FM3ZOU3CnuyI4AYtndA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeelgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedvtddvrdekud
    drudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Q_8nXbQi68ssdcsMFb_0pb_VRRKJyffOPTyfAmIgDfdA-nYAwqZoFg>
    <xmx:Q_8nXZ6UsDQk92KtFurGIkDvBCvvpwSGEVI4kuothvpFXHB2VLheug>
    <xmx:Q_8nXRQjzrie9wXFy0adIKGp-9xxNxNFv40V2CTQFN_XoP7KQujpsg>
    <xmx:RP8nXTwqR9PV6Po46uzcDzzT7U6ki-Rkf2a2xnKl2UeggYyY2im12Q>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5AA238005A;
        Thu, 11 Jul 2019 23:32:15 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        adrian.hunter@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
Subject: [PATCH v2 0/2] mmc: Add support for the ASPEED SD controller
Date:   Fri, 12 Jul 2019 13:02:12 +0930
Message-Id: <20190712033214.24713-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is v2 of the ASPEED SD controller driver. v2 primarily addresses Rob's
comments on the bindings in v1. The v1 series can be found here:

https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/001988.html

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |  90 +++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 326 ++++++++++++++++++
 4 files changed, 429 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1

