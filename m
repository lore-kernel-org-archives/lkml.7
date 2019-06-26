Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18706C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76B52147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="S0omCvpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tpI9QgLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfFZHVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:21:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58819 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbfFZHVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:21:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 150301C0D;
        Wed, 26 Jun 2019 03:15:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Jun 2019 03:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=jWnT3U2Yd8PxeSNAZtgVSCgMRj
        OIJ80r4MORo/itpzI=; b=S0omCvpXCSNZGkzFEb/fFP8K1x9J5eYLs6pVmWWcCh
        TEPEKCX+ucQP/dX3Dac6dRrz0Oz7E9jmP3VoXi4Jf7BFA+e7BC7yYTBcHP32PSu8
        zSGdyWsXAuYSXZrEEbu378n+WdZWp4lH4RRbicWA5oQJbz2xxwC8QWF7VgQIrw36
        D4CYRu8Oi6WwkyiBRhg6kKVjRxZ+I8Pxc62amLs63Fko6DEftBoLHF4syAnCx29y
        P3xZDiPXnA0wgMW6y/LQVKtv88R6hGLtQqGYJ6JTZUTgylVf6hGv9MA7KHKvnA1w
        r5XGnq5SQu665bEhM0/XxBecmO7DkPQG/Fl3XVa8/Iug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jWnT3U2Yd8PxeSNAZ
        tgVSCgMRjOIJ80r4MORo/itpzI=; b=tpI9QgLTdpE8CpCxyMjw58lvXc+6nHo3Q
        ZFKdctfd27el5gac2AGGnf5+MLX+ehyz//w7G55ti9mwoLxfni85FthpbOBl4gWE
        Ob6bgaMKGDbOZ1bVme79PTd7Konua0ctQb+S7kDFh9361TSmoD4fl9GYv01BGUTN
        pvQnSo8R/3857b5wf2h/wIoLR1s95vyS3GMbGXU/ORgriagdh89Aj88Fc6O9cZCC
        FsUw+khIf7cuHEQjOckHyssvQCYn6oTFQSlTv55XA5OJ2dXX94hzMRHsHQtvK6lV
        t3mM2mQCT+gkRCO7eVfLPIdl+QlTYFP40Ax60A+PdKe6YBHEwSoig==
X-ME-Sender: <xms:mhsTXeawLyZAI5GrnS6l-vWzUHOeJvmadF8mjKSeMaiPwOequ2riFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilh
    hfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:mhsTXcT_FxEgnN8JYjTHrUD6gsCY5oeyPxrndatJ1vsZzXnqwXQ_Kg>
    <xmx:mhsTXQy_4PrGd6zTj2Ulv6whoGjKwbDBD-2YjY-xwzmDDX6O3YseqQ>
    <xmx:mhsTXe0tULIKSwiMJ4drYOHVC8wx0QxRrvR7ADmi_4f0TZ_i9pEnlQ>
    <xmx:nBsTXeZv7d_xKWXNpSht-SawLfNf8pDmUpyDepw3I94un5Yjb2_ItQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id B8E81380076;
        Wed, 26 Jun 2019 03:15:34 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-gpio@vger.kernel.org
Cc:     ryan_chen@aspeedtech.com, Andrew Jeffery <andrew@aj.id.au>,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] pinctrl: aspeed: Preparation for AST2600
Date:   Wed, 26 Jun 2019 16:44:22 +0930
Message-Id: <20190626071430.28556-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The ASPEED AST2600 is in the pipeline, and we have enough information to start
preparing to upstream support for it. This series lays some ground work;
splitting the bindings and dicing the implementation up a little further to
facilitate differences between the 2600 and previous SoC generations.

I've added a bit more documentation to the private header to help outline the
structures that are generated from the jungle of macros. There will be some
tweaks to their behaviour in the future series to support multiple pin groups
per function while maintaining the property that improperly describing the
pin/signal/group/function relationships causes a failure to compile.

Regarding the bindings this is my first attempt at using the json-schema
approach. It has previously bugged me that there was no way to enforce the
documented bindings on the devicetree, so I think this is an interesting
development. Hopefully I've done an okay job there. I think I could better
exploit the schema to constrain the function and group names used in the DTS,
but I think that can be left as future work.

Finally I've added myself in MAINTAINERS as the PoC for the drivers to make
sure anyone unfortunate enough to stare at the implementations can ping me
about them.

Please review!

Andrew

Andrew Jeffery (8):
  dt-bindings: pinctrl: aspeed: Split bindings document in two
  dt-bindings: pinctrl: aspeed: Convert AST2400 bindings to json-schema
  dt-bindings: pinctrl: aspeed: Convert AST2500 bindings to json-schema
  MAINTAINERS: Add entry for ASPEED pinctrl drivers
  pinctrl: aspeed: Correct comment that is no longer true
  pinctrl: aspeed: Clarify comment about strapping W1C
  pinctrl: aspeed: Split out pinmux from general pinctrl
  pinctrl: aspeed: Add implementation-related documentation

 .../pinctrl/aspeed,ast2400-pinctrl.yaml       |  73 ++
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       | 124 +++
 .../bindings/pinctrl/pinctrl-aspeed.txt       | 172 ----
 MAINTAINERS                                   |   9 +
 drivers/pinctrl/aspeed/Makefile               |   2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c    |  94 ++-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    | 123 ++-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c       | 250 +-----
 drivers/pinctrl/aspeed/pinctrl-aspeed.h       | 549 +------------
 drivers/pinctrl/aspeed/pinmux-aspeed.c        |  96 +++
 drivers/pinctrl/aspeed/pinmux-aspeed.h        | 735 ++++++++++++++++++
 11 files changed, 1294 insertions(+), 933 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
 create mode 100644 drivers/pinctrl/aspeed/pinmux-aspeed.c
 create mode 100644 drivers/pinctrl/aspeed/pinmux-aspeed.h

-- 
2.20.1

