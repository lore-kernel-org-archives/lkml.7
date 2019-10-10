Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B8CC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3CA20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="R5iHXfX5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIUeHivC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfJJCIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:08:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57589 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbfJJCF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:05:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 15E1121F14;
        Wed,  9 Oct 2019 22:05:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 09 Oct 2019 22:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=WvQCoXY2dn2Zv
        ZQTKce1J5UaJ12CgomxgQSt/e8KvKU=; b=R5iHXfX5XBgnc5dhScVpq9T2TBg5L
        YAJE+D1S+dKraSyAWYPExaH+Xai2CI2AejmX0KNPJamZzzGCYJMKo0DJatrpDkvX
        TcWbUX0kLUL9AEghrNX9FcaPUTsj+qge1wfCHl8tRfxKrAjIXhovaN6wybdpc4M+
        PHQ52f2A8TKfjOXADKP/wfOfpbGGACUiXm297AyroVx1hv3AFzrwllftPjSJ0sx+
        jhqgB7pzSQ8BmDgOwE51wDhwQX2Waihak8OuqVI5mrFM6v/TlZ3/kENBYrKvNx+s
        1czrNFdrFr25aNA7Dbf2dm9U4BoFSxpyWusW0PaJEV+rblp9nRgUrOGJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=WvQCoXY2dn2ZvZQTKce1J5UaJ12CgomxgQSt/e8KvKU=; b=uIUeHivC
        NvAXpNrD5z3/ElBHP7PWKjQVl1SqElBBcSWVFUHlONlQmyCtJ+ErkOs8MTmPKpbh
        ZWv4tA32h17iceDu5qm23+0zQHnZ2K+i/BNPgy2hJyPwjWMO8pggWNDFkDcUvNSf
        N3bEZl0IXjzFXs2hxEASxL41okOxyD1eeyQKJpdEqEvfKY/xTQ25FvZORG5KV28x
        hmq5+K7idYnff0KEXa3xQmeab4QW18a9BTAoiFKJS7kcwZsbh9cPSPFu0xgMxtTG
        auBC8ZLNKtAxJASKPVLPtgZU7fTX2cP00glO4+jv1eeFu+dkxBZ9m++RxSNB4+ju
        C15cbvKp4BlWqA==
X-ME-Sender: <xms:A5KeXVa3WlA82QFyXE2KP3WgZhUPxBoWGwn7F5BFr01Mn1kQ_3X04Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:A5KeXQZEMpH41JZRk_o82SV0iSlij7M1gelhC7gHymd-jlTJmW0v0Q>
    <xmx:A5KeXYmPvLgr1OFQiD8ku9ewFBvrRbYvyBQY3rGNa9c0T7UKmg1WCg>
    <xmx:A5KeXTiBjcZFLtytc8BbDq5CUSk9GFi65RKrn4JO4UCkeoj51zQ7cQ>
    <xmx:BJKeXVxOpiNWIvlgrxVJ5pLzf4ynfOH4JymXNvkTxZpGJecLm3SnTQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id B48B7D6005D;
        Wed,  9 Oct 2019 22:05:52 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: Add AST2500 RMII RCLK definitions
Date:   Thu, 10 Oct 2019 12:36:54 +1030
Message-Id: <20191010020655.3776-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191010020655.3776-1-andrew@aj.id.au>
References: <20191010020655.3776-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AST2500 has an explicit gate for the RMII RCLK for each of the two
MACs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
v2: Drop "_GATE" from symbol names

 include/dt-bindings/clock/aspeed-clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index f43738607d77..9ff4f6e4558c 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -39,6 +39,8 @@
 #define ASPEED_CLK_BCLK			33
 #define ASPEED_CLK_MPLL			34
 #define ASPEED_CLK_24M			35
+#define ASPEED_CLK_MAC1RCLK		36
+#define ASPEED_CLK_MAC2RCLK		37
 
 #define ASPEED_RESET_XDMA		0
 #define ASPEED_RESET_MCTP		1
-- 
2.20.1

