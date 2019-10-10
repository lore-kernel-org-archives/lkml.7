Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856BFECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFE020B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="RjaegqIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lgrKLx3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfJJCI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:08:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54009 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732157AbfJJCG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:06:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D5CC21F5A;
        Wed,  9 Oct 2019 22:06:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 09 Oct 2019 22:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=KDItDJsFBQom2
        Sf6FH9mRJIzJqOmoka2T+mY3RP2gCM=; b=RjaegqIhn6V4Zt4cnx4uS4cdLpbfn
        ryAhRPfao/9aKkwIjisqSrX6TdaM9NEkH6Plsvtiok/i9uKURq3zOG/a2JFngjaC
        deki3bF3YOKQqhJZUjF13JvExcrGpkfGS7u+KDzRxUgl7UEXcnvfu42gNU7yMWub
        1+Q/zx4GMvbSmh09TSYoESFjdF6e5wcGsC6Oi68joyYjcXZPrXG1Xw3cAZyVW8IE
        6FkdLCLeUKYLBDkbqBJP7eeYykC9lSu9/iFFKYiDvTuKTEOn6E3N56/nIkkOXs2N
        +hyjnjd4bdlWJUiorMr0f2DTL/mD3npoYXqtJ1aih45FqGaUQr+0hX/iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=KDItDJsFBQom2Sf6FH9mRJIzJqOmoka2T+mY3RP2gCM=; b=lgrKLx3T
        Hi1Z09ZVQ04453umwSVXmkcM8rPzleABmLS9RzGzEV09BQzIPgQLNEsPM6WG1ZzP
        XwMgAT3DULxIMtxYZuFmDAALhQZxm2pLefsOBGDrt2btwa2aJYeUPfmHnaHsp1Q2
        +ccVkEm222Pn5zjFk1VgscWqqnIbki+1lGu3obvu2yA18VZpZeFaKcSM8HnlEG5f
        C/YQLGjnc61WzREOWrT63sfffvgfyF8lQueuBLEZvpGCPSte18HsCsF8ljT32vfn
        fxyMWhlK4u9fu00eQTD1w1Yh4xEUupixt7zCi13apucxocEI0coitL8bcFgQak8y
        zrCnk4P2W1XdOg==
X-ME-Sender: <xms:IZKeXcEnjHcV79PDuAnKbgf1T8EPepXIPIE3Z5gM_iRCrQMSJ1_OlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedriedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    vd
X-ME-Proxy: <xmx:IZKeXZlIdXdQ6xA39TGEW6Y75K1Su2jknNhwnbWMmYIBlD9yR-avhg>
    <xmx:IZKeXRJM4JjJWZWj-8d0zaNar4vj8MmrZB46gtM8WF8esrnwymVjhw>
    <xmx:IZKeXSaZb2f4g9gbnz6SQrKFHwM3-_7y3o4x-iMT30ZiLV7j3_l9fA>
    <xmx:IZKeXXPpTThZZiexiCDrU3DFYN_r6UI1vi7-ukS1sW6BmHn5Xh2SZg>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id C2E6A80061;
        Wed,  9 Oct 2019 22:06:21 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
Date:   Thu, 10 Oct 2019 12:37:24 +1030
Message-Id: <20191010020725.3990-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191010020725.3990-1-andrew@aj.id.au>
References: <20191010020725.3990-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AST2600 has an explicit gate for the RMII RCLK for each of the four
MACs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 include/dt-bindings/clock/ast2600-clock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 38074a5f7296..62b9520a00fd 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -83,6 +83,10 @@
 #define ASPEED_CLK_MAC12		64
 #define ASPEED_CLK_MAC34		65
 #define ASPEED_CLK_USBPHY_40M		66
+#define ASPEED_CLK_MAC1RCLK		67
+#define ASPEED_CLK_MAC2RCLK		68
+#define ASPEED_CLK_MAC3RCLK		69
+#define ASPEED_CLK_MAC4RCLK		70
 
 /* Only list resets here that are not part of a gate */
 #define ASPEED_RESET_ADC		55
-- 
2.20.1

