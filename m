Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE81C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCD5206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="QOcqzeZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1H1dbsIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfH3Hqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:46:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51115 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfH3Hqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:46:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AFE3210F2;
        Fri, 30 Aug 2019 03:46:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 30 Aug 2019 03:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=wOiPzLG3FhxjtzR8rsBkC79oy1
        3YcSX1rCw5Ip7LvOk=; b=QOcqzeZAvNkdX0XrmuI/41pdvneLhtVk+adFkiK8Jd
        xkjTDB/Z9UdtH6CVT9XFRrU/m178LYhbaH2qF6bmU7Lggshign+2mhLdsXyEWE27
        gpaAS4ua+CTurEp0IYTrFRUdowCdzsLTEIfa1fz8cK+Pmo2p5KECYYOfmMDErOsI
        Ltj1V/zoQw8Xk0PMhZtkZs2IP24Ror++YkMtw957Horncu1zNHSvL+WT3xrx9EQV
        2uznitynpymlwI2uLLx4IIfDCHUv6QEYWOexettkzzJi3I4yx02lTJan4o6T5Qmy
        XNPnVssx/tyE4D4Bxrc0hTculT/caS1QFOApUkJN0xxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wOiPzLG3FhxjtzR8r
        sBkC79oy13YcSX1rCw5Ip7LvOk=; b=1H1dbsIzWAOdpx7lcBsSNh8xQqir/bqpa
        RoEpc/IGrrncVUYSadJU7HPmajDudhVbyVrpigJNt5KyfoDRBpwBZNj0FdipJ4V3
        FVs2kG46zuICyI10xicke0dyWyXq0HlIsppHg3CEW4cJl/Q5RbY4tVmpgfOenWr+
        DgHPXTROLbPLr95ZJ0bl7qvSpK6pomU4Atc2eNVhUEZuC4TewLA+WEdJcnuT9qpp
        +zl+p5xRnTT/+o3K0syw2rE6wfa1oIGs9OaDbrFuUw4CKnR/vXH2h2/kqnMKYuW5
        gtUiMsmM7CHNp4REMN7vnO2cOV+pEIze9Mpzdpyb/WlQzMG85cdtQ==
X-ME-Sender: <xms:WtRoXRJpycpv8bq9ZYWroPC8dbNZoOC0f2YgaZHEgarQTFwEw91DuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeifedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtfedrheejrddvudehrddujeeknecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgeptd
X-ME-Proxy: <xmx:WtRoXcIydX4ajN2Gjn9zQkLTF4IiE2BLocK07jfkTD3KszNDJHPsDQ>
    <xmx:WtRoXWXWcxCsps0CZuPIVgBiChwt0G4adj1xuuBksRthQwbU6ee2ug>
    <xmx:WtRoXcndN8ysDArbdYrXJJaDuFj5qQdg9N5gmHgcQEPxfIW5VKsTsA>
    <xmx:XtRoXX_-l60JPiQyz7jdX98IQDRAUYIPlvirQihJA0cHDfMTcS3_tw>
Received: from localhost.localdomain (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id D8181D60057;
        Fri, 30 Aug 2019 03:46:30 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, joel@jms.id.au, ryanchen.aspeed@gmail.com,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mmc: sdhci-of-aspeed: Fixes for AST2600 eMMC support
Date:   Fri, 30 Aug 2019 17:16:42 +0930
Message-Id: <20190830074644.10936-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The ASPEED SDHCI driver patches sent previously were based on testing on the
AST2500. The SD controllers in the 2500 and 2600 had the same register layout
according to the documentation, so we added the necessary devicetree compatible
string at the same time.

Now that I've got access to 2600 hardware with an eMMC chip I have a couple of
patches that are fixes enabling support for it. I don't think the first patch
is too controversial - in some cases we weren't ensuring the clock was enabled
before returning from the set_clock() callback.

I'm a bit unsure about the second patch though which enables use of
max-frequency in the devicetree, it feels a bit hacky so I'm looking for any
suggestions on the approach.

Please review!

Andrew

Andrew Jeffery (2):
  mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
  mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK

 drivers/mmc/host/sdhci-of-aspeed.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
2.20.1

