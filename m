Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E83EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BF821835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="FnxLoC7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUjjnziV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfJHLun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:50:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53749 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730503AbfJHLum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:50:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 756D521E3E;
        Tue,  8 Oct 2019 07:50:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 08 Oct 2019 07:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=umrX+JUQqbY3FSsNbyshpYr96O
        AybZxQrPbWF4qGYPk=; b=FnxLoC7ArxtL3Donfyk9DyhnEcnCy4f3DHUDENkyBF
        R0iHi7DxJ1sBcEcfxLT7KKv3sOPM6b3XGy77ILTf1UsjTP8Mef4ne9JYsrlkd6Ex
        4Yz8LNs6mNtVmb/A+1CNifLLF0YrTRQgbE8ANRd2GNuckP3jLB2enf8jyjtO2+gS
        f6SsuomM/Zo7cno71tR6/FAaDOZVofbD2teT2RzRPXacVeEOFK9+WOmsjKJ/S62x
        30g7b7RjgXu6yRX2EOTg9zm1Zdi+t4DCsMZ35WGkr2n5RDLAg9AXC/4BKaRywF9F
        EZSvP+kIFjA+vMiJSSI8w1rNFw4U2pO7N7KhN0u4NY8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=umrX+JUQqbY3FSsNb
        yshpYr96OAybZxQrPbWF4qGYPk=; b=RUjjnziVaMEWUEupHB139IudGeHAL0Cem
        q3KPjI73IAVWg2jvCUfs1abtQMYibDRqIVtlMgFe5yXUWrWDLXnxSipUns+kRB4o
        nHOuTlrrNYQcaFYQm78sFeo0IF0J6lc7oI52b22ze8jFapy2LDWUQOfnmmYoTmr/
        Wbew3maW399k5qpzeuXM1U0rP3Sje1q/YVJnqatT5JzBh4DRbWOOYjXQl+iVGSys
        z6aLXcH1557/T9CH+zZRtIaGnWiBTqt0vNPVEKy2/yE5EyHQbaX96Ck+YfhWcT3z
        L1sO+i9A3gkDObd4ZhZV1aOGSgsDDCEjFZb4DYrEv2/7xRRwslmUg==
X-ME-Sender: <xms:D3icXfIP6zDjWQAehaozBBeGxNJwHy4t9OvmcoNfMAFirxxK373MkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucfkphepvddtfedrheejrddvudehrddujeeknecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:D3icXdFWTX2LSPxYLecgdzwmC8Y6ie71dIaTYYV4PooUsJ42OYVQIQ>
    <xmx:D3icXeDmxPrV9bTn7d7TVSQm02yYzFMABpGn8T-4i78aqdoFA63jkA>
    <xmx:D3icXe4j5oGFNEkaE2rzqLEHSOxGC52cCfGO2d817I4dsiVfa4TbAQ>
    <xmx:EXicXR8ojn4PCVXzrojQcpAecFcp6SJcmaJnU5icZsgFg5X_0vMT1A>
Received: from mistburn.lan (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5312680063;
        Tue,  8 Oct 2019 07:50:36 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, benh@kernel.crashing.org
Subject: [PATCH 0/3] net: ftgmac100: Ungate RCLK for RMII on ASPEED MACs
Date:   Tue,  8 Oct 2019 22:21:40 +1030
Message-Id: <20191008115143.14149-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series slightly extends the devicetree binding and driver for the
FTGMAC100 to describe an optional RMII RCLK gate in the clocks property.
Currently it's necessary for the kernel to ungate RCLK on the AST2600 in NCSI
configurations as u-boot does not yet support NCSI (which uses the RMII).

Please review!

Andrew

Andrew Jeffery (3):
  dt-bindings: net: ftgmac100: Document AST2600 compatible
  dt-bindings: net: ftgmac100: Describe clock properties
  net: ftgmac100: Ungate RCLK for RMII on ASPEED MACs

 .../devicetree/bindings/net/ftgmac100.txt     |  7 ++++
 drivers/net/ethernet/faraday/ftgmac100.c      | 35 +++++++++++++++----
 2 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.20.1

