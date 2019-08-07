Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C14CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BF021743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="gA9Vvp23";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aI2yeZNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfHGAiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:38:01 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:48467 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbfHGAiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:38:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 49ECD2556;
        Tue,  6 Aug 2019 20:37:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Aug 2019 20:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=tekQgJr6qSz/+W1IqdMF+U0YgF
        ytbV3UNOGCshAhIFA=; b=gA9Vvp238GgD8WvNh25Nh2WviEvR1tSf9vt8SHsPqf
        mvc978ohwcSe1/MCsLGoHMOYn2gAqnXB3SgsoeiCJqQKO/GblrLvWG+sM5pJslZI
        MshuJhEUP7oYrPiB9HPUhIiD9xPnmaIAiwbvboQyLxKnDzbuhgQexTha5UG85azV
        X4ZHqu2+r6qFY+c7B7AcouV92CqeoP59lssxb3sxscKf4Sb6nnc3vygKyRbV25W6
        k6ITIO0w2LLI1PGALHlJa57Iwd1VIIDROLN6CnyDGV5dIBtPvd3Kjf0R1ZSoMZE/
        akrPl0wt8nWSDLCqERfBeDMP6GoZCBPtCoyVmtn5d3cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=tekQgJr6qSz/+W1Iq
        dMF+U0YgFytbV3UNOGCshAhIFA=; b=aI2yeZNL3PoeqQMek0jjjEKn9QrhPGipC
        HleCz3UDIMsddxW6TVI6nXUOxrwf76aG1/vp4fu9chL1PS7ICkx9CugGadgFPdFt
        pPNkkg+asTnpeHEEKkNXU4D/F+bfd6LPaIUexwThyoVsGep9DC9q7XSDXjful/Qx
        /TJCffMba9MYviuS/g8EWHYGao2eRaIBOAFq8iZNaFrn0k3kaJ7Qk3P1bCpmBB4K
        Vd2OnlG+/ZL3f1euoFNfyVIBLRgLZhwckN6qeb3lum599tj29KZtMo99n0GOn62L
        VyPrkrsA0em3egkPkqjhJbwpND61ae/u4M6OTTQCWh7pFpa08ypfg==
X-ME-Sender: <xms:ZR1KXQIykwBpiZFpp4cttIbn79GQw1b-2q7WCIXxw6Oa5rRVaEuv7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkphepvddtvddrke
    durddukedrfedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhi
    ugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ZR1KXWKOdCyo2cKMurfo1BBUwnPDZIXIxCyuKxTOcesAPbUjO1Kaxg>
    <xmx:ZR1KXbgUpXe76vTrxh_1h5dbZMx9VqLP3bzJW-uM7dhudkxE9UB2Hg>
    <xmx:ZR1KXQMz-a2FKn5GOJsmH_6fPUScfTeYNpoqHWal1kHpTFdtMJlKlQ>
    <xmx:Zx1KXUxsN6qDKRIvMqZEyrfQloS3h44v7IJDO7k_MgmKxaeMMuBCuA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15E4F38008E;
        Tue,  6 Aug 2019 20:37:53 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        adrian.hunter@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
Subject: [PATCH v5 0/2] mmc: Add support for the ASPEED SD controller
Date:   Wed,  7 Aug 2019 10:06:27 +0930
Message-Id: <20190807003629.2974-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v5 of the ASPEED SDHCI patches fixes an error-path cleanup issue pointed out by
Adrian.

v4 can be found here:

http://patchwork.ozlabs.org/cover/1141949/

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 105 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 332 ++++++++++++++++++
 4 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1

