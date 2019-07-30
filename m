Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1037C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B826F2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="UdN6jB6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKthU7jU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfG3GXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:23:11 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34979 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbfG3GXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:23:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EF934AA7;
        Tue, 30 Jul 2019 02:23:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 Jul 2019 02:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=xUyh/uFx5Pvf1Uq1MZFdHPn+B1
        1pIejp1FpFbo/nfyo=; b=UdN6jB6igo0Ty+DeyvZbWVNSAQaky7Dhy//EXdEPJj
        E3VwBUdaPoGSzU/o4BPLHloGuAkUn1/uTHkiKr3Z2Zug0YNBK9yFPehow5momf0+
        VEaWPHNe2ee0/hy7GYm/yzcjsV9KR13A3tOpiEGXirChmVzj+tCddxXOU42NNXRM
        Mefv7piyNaugsSzVZMUZRVXJMYM5MbfkaGRkuoG+8G5oozljCvgcreRNsz7v7R6x
        maXVSYXJtW4lISQ3cfhTTVP/f/81TShO9PfMm3n87blCXWCV4P8pL5DROHnmF5KN
        QKhV3PL0AB4ZHTuTm8TYHfKX0qBRk7xLYppERpmn9L3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xUyh/uFx5Pvf1Uq1M
        ZFdHPn+B11pIejp1FpFbo/nfyo=; b=pKthU7jUwLnIpxgW/pDXAhTnjyuXJJCrB
        EkpB7bOpdZyR2faU3ib1KCN9gxtnxVHtei3Apb1v94NkennpmFfXnYHlR96Dwyjc
        1puma2kqqmVej+v/mbBX/cIxfCuPePFEiWAznUXPzlh60ZOTnuAwNST4oQk8q9MI
        gANZEImUB7gZtYI6mH+qnhuB3DvvE02HjZHpTIssQUf2V3ZsIUdnadxD5eKGxQP5
        ZcDWmeT67Bv3rSKtb4W9uvmymXUFKAghBhF48XZ3avfWFFlzRcU+NHtnsg63U3gE
        /LHSGloyIolNFHBkR3Xfiiomxc0jcka1B7kNmkxFTxqdk1hgb7BNQ==
X-ME-Sender: <xms:TOI_XYrE5sZqkDUxk0kc4FPaANSiAFGzEmZV0dDyVvajl7mWFBURGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrledvgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkphepvddtvddrke
    durddukedrfedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhi
    ugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:TOI_XS6gMoGcyY4h7_EqJMkEStNAV6W1Dfwx_ej5hA50ggBnju-7zg>
    <xmx:TOI_XYN0is4b6LbHFvcjmzEjeD8XEWrn8A-jdM4nRUg93Z88G-0Wtg>
    <xmx:TOI_XUNXZGeGHXVnckNMX9Oy3YdgOcBmN5amS8wzyWFZNx357wU90A>
    <xmx:TeI_Xd4ayhocA9duTCI7EotOBL6jJ3BDN1iQ80mUnF4il8E8MnIfVQ>
Received: from mistburn.bha-au.ibmmobiledemo.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id CAE3880066;
        Tue, 30 Jul 2019 02:23:04 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        adrian.hunter@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
Subject: [PATCH v3 0/2] mmc: Add support for the ASPEED SD controller
Date:   Tue, 30 Jul 2019 15:53:14 +0930
Message-Id: <20190730062316.32037-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v3 of the ASPEED SDHCI driver makes a bunch of fixes to the driver and the
devicetree binding, including the addition of the AST2600 compatible string.

v2 can be found here:

https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/002013.html

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 100 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 328 ++++++++++++++++++
 4 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1

