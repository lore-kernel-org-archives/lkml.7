Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A70DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324A42070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="J2bgWrEK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVEeZKv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfJHLe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:34:29 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34529 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730156AbfJHLe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:34:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 795A521947;
        Tue,  8 Oct 2019 07:34:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 08 Oct 2019 07:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=FwWI9/MDx5th9
        3BPylor5pCFZ4biSV3bwPlyQ31srtU=; b=J2bgWrEKdLiSxVKsQHfspdwIW4M/o
        nP89ghxsFqU8xdG1vHZvtuDlte3JCnWb2Vs6ztb44LMJdzqWJ9OUs/PZSKNSZKGn
        EtxlL0cvPj0KCBCaETT5kd+2Fjw89yfLKbPqqwFENYlhJWFZMrSSABZRLO9noHNu
        vyxfeG+cbMrukkywZvd4u18ZXx31HGQcVL9eLA0B8d7u7MjJSP4hcF/vSwjU4FAF
        jRLE2oWUPbrZsRf4rvFw6GcPa5Rjip4M1PjgyOu0UfYjjzVceTZBSKxBcn283SmR
        hz6/6teBWTkmKnIYU59AiV7YHzrkZI2QSEcLhGCgRbW2q5Ufq2gob21sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FwWI9/MDx5th93BPylor5pCFZ4biSV3bwPlyQ31srtU=; b=iVEeZKv+
        eF+dvDxO9NHd0GbE1lc+WBUkCjWbVlpHWX7Sx8e/ufcDhLOfwuvF21zC9vf4nfo8
        HKykZntvU+MAGbRy+dhkOI+Yi6DTAf+hV1egvYfBrfT8EcvjbSgjnqxXw+7dVI32
        DwAKZgFYIxxtw4chJegrZX0yNxMCDnJmJ8Kpvo1a8FjQAYV/ojlMmLCbv39nSxI1
        uvfa8iyD1UXD2aaQZIz0VIO71Stv5GIwMAobCzaKKDhXqpoqldmQzY9GvAKBuB1T
        Qhkk1Pu1xfLW7xGKrsJEjAAWJ8/J1wDzascmWgyHwzUWj6sOrTVh4X/eao9kPHm9
        2yHVekz4ZXhaXw==
X-ME-Sender: <xms:Q3ScXaTEm5jDzj34Gkwp05BVzIeLpC_w07WjRfPdgCelnQ6oihQ2Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtfedrheejrddvudehrddujeeknecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgeptd
X-ME-Proxy: <xmx:Q3ScXV78YvhlYY68_5UbLoBCwc_MNVrgJg839NfJELG_qFGZbVlukA>
    <xmx:Q3ScXag45dVG3gEmP11uihciUzFXfVAIxt3j4JNucZhZsW3lLa72fg>
    <xmx:Q3ScXT0euz7fG1BwZiu103X8FAQlI7y6Nso9MncdxcRh-JBr-EJ1Hg>
    <xmx:Q3ScXVqHIIG9FstAwuNS4vK672vAfPLvRpol7b0OF6LhzuRtYiBTNA>
Received: from mistburn.lan (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C2EDD6005B;
        Tue,  8 Oct 2019 07:34:23 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: Add AST2500 RMII RCLK definitions
Date:   Tue,  8 Oct 2019 22:05:22 +1030
Message-Id: <20191008113523.13601-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008113523.13601-1-andrew@aj.id.au>
References: <20191008113523.13601-1-andrew@aj.id.au>
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
 include/dt-bindings/clock/aspeed-clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index f43738607d77..64e245fb113f 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -39,6 +39,8 @@
 #define ASPEED_CLK_BCLK			33
 #define ASPEED_CLK_MPLL			34
 #define ASPEED_CLK_24M			35
+#define ASPEED_CLK_GATE_MAC1RCLK	36
+#define ASPEED_CLK_GATE_MAC2RCLK	37
 
 #define ASPEED_RESET_XDMA		0
 #define ASPEED_RESET_MCTP		1
-- 
2.20.1

