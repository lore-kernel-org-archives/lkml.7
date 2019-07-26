Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF939C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A6822C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ZFvrZA4/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fny9/EN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfGZFko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:44 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52381 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfGZFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 81E8322304;
        Fri, 26 Jul 2019 01:40:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=rG3ViSoD+/QE/
        VXNi2QRXWRcPzsPK+KCQfU2NAzrabU=; b=ZFvrZA4/NROfeW3BhqjDH6Pq/IF74
        IQNAntwYgA7a0dpYRagWuIPGA4QKb+7nl/n/QP/wXyXDKGJLM/0cYfsFa16sDH6K
        wLVxTkKWnt1LuJpDmShImd6KCBEZE0VgXLUQXBDrc7QmDx4oMmTSOzpQcRRLc6b2
        GKx7ZNhz1rS9SHZiCPji/jReQsdd/FgzPfwosJq05mvY1T2o7zC9ZrFGuWBHGj6U
        b5mK8bZq83GeQF4nsn7WGtek2aP533EGIAzEaFQVD2+rTZNIg51gQCFyau4rO+vf
        PVStSvYNaMVCDhp1aIGRZVZkyKVb5GOFMR3bSGwzkpXixvn6mhbdJoSdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rG3ViSoD+/QE/VXNi2QRXWRcPzsPK+KCQfU2NAzrabU=; b=fny9/EN6
        AqWnZP1i3ik8OyT0QgcuJp0Pwpx+U2xGXQib5GcSmrc1Sa/lPO3/4HFcrW56p73A
        /pRbp3TU3ege7PAtyWBPNwDq2zbTOnfuGfp0+n3ET0cI8/y+WUGYZ9xbaNsJ9PZb
        1DkoFrfhpY/+KJDUSTWWvoOvOfYVc9O4fpax5ba5XOHrOCgvsTDRrPUbgOdOO/sT
        hWoD07VN3wbEb8iw1vtXUbERXLzbG/CjsjrUyPAfjV4d4i4TViNIMZMgrH0u11s3
        xTLNcJf2yvq4ox5ArgCmZ/b53b2Walbyauy2b4x/RLf8+vcY5uE+S/GHP6ZgNTtO
        CmVRXFp33FR7vQ==
X-ME-Sender: <xms:WpI6XUztnZzH09GPCPGTYY4DpUWTYVgBT4tR7B0rAu9Gmujh9rBUVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:WpI6XYbiO39PRBEFLxsPziRXU0fmTwfVxtr60nFwIbtPttATfdEi5w>
    <xmx:WpI6XdzrwIiBNu_uETptr4EFaXvlbR8r34C5afBlpKzVcoJXF6OmVQ>
    <xmx:WpI6XZG0onGA5qGAcg_oAOn-qSJeyqDf5qYzsY_x1B8-fbd5pqkrkg>
    <xmx:WpI6XTtWs_B06LNwzoiuZVcBiNYgg4YzjhfFc4P-A3ALnPuahVaF1w>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6014380074;
        Fri, 26 Jul 2019 01:40:38 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Patrick Venture <venture@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 11/17] dt-bindings: misc: Document reg for aspeed,p2a-ctrl nodes
Date:   Fri, 26 Jul 2019 15:09:53 +0930
Message-Id: <20190726053959.2003-12-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The P2A controller node sits under a syscon device, and can assume
offsets from the base of the syscon based on the compatible. However,
for devicetree correctness allow a reg property to be specified, which
an associated driver may choose to use to discover associated resources.

Cc: Patrick Venture <venture@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
index 854bd67ffec6..091d1c5ec58f 100644
--- a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -18,6 +18,7 @@ Required properties:
 Optional properties:
 ===================
 
+- reg: A hint for the memory regions associated with the P2A controller
 - memory-region: A phandle to a reserved_memory region to be used for the PCI
 		to AHB mapping
 
-- 
2.20.1

