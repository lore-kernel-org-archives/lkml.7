Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7296C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA8620673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="kh5/7FOW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDOgYUGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfJHLe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:34:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42301 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730691AbfJHLe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:34:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 31A6C21947;
        Tue,  8 Oct 2019 07:34:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 08 Oct 2019 07:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Pm0kXIjD5EnSX
        CMvxmhv05EI+M+VF9thTQPnyey0/W0=; b=kh5/7FOWrDpCzViUg2B1WNJJqQrsu
        BkNWaozam2jqUUV5ch+W0Ngo9WjwhTKMyA37cDd9tyCCnB2mtcGJ2YiqzcOvGa4e
        5V8ABOROBBg7fdIfpoc/RSllptIq676BF0VLVBheWhzYNqQSLAXwZwm5E5ngQlr6
        BvdgJDuCou1+dKGIN3odO0Jek2pudDJ901ytJKR1VUOM/ZKdbZy8vNZudT1g4y3D
        QW1XWiO4uwc9Qz5W9Adgbd3N29Q7syEoU/CPgcL1cemjlnksKDPvDStDzzKzcHYj
        4LopTVFRu/ij9ICifeSWrQGZ4kglwdxAhNDkPs3nEWyHKgcibiSis6N5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Pm0kXIjD5EnSXCMvxmhv05EI+M+VF9thTQPnyey0/W0=; b=gDOgYUGx
        RRCEI3hJq9Gt5RFL4dM1qPIbEI0+aBroI9FRiNohFEfvfQ8g4blLC3yGSedvm6K3
        kXTj56AijNn/lNqwzvitzsstaC7rSEmoF1sXfmqS0YGjKFROkOOYO2qcHuMyZXOg
        cw0aSwEbo1pgMs4I1YnJKMvx86ZjtPhgoRn2H+ytrvjgqsRlm1AMaRBtl6wOJ/6F
        KouOmbbO+nnw/32Wc3bG53J1BLSAI/rhvLcFeX1ptutXa5OabmPlVVNKOV8hVWJW
        bQTQNAW0UmNAPlmpOaOpN3O0qzHbo66xJm1Xj1/9g0/0xw/lrPgx+0nPBIEq+M5Q
        J2Pjrdjwoh9oFg==
X-ME-Sender: <xms:YXScXfaaubACZ_PkWPHJaFdVbgaCo5OXo48mIQyxAsjV5KPIo9lRLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheelgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtfedrheejrddvudehrddujeeknecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgepvd
X-ME-Proxy: <xmx:YXScXYA26vS1yEvEyZLjdAvy9xC2QhSDkMM2dN21lx2n4PV4vMAZKA>
    <xmx:YXScXeoHdIJe49tkm4st59yiNy_kV37pDrGOEC_vbOvZ9F3mUnYaQw>
    <xmx:YXScXXJabEV6sdJWLV1e3XtE2kKvoAFO8X6H7YGRVN3C6DOzXl2ptA>
    <xmx:YXScXUBHPusRgdMqxXzOS-cyIsfCQUGC6SA18U2bTirZBFmIxTt_Tg>
Received: from mistburn.lan (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 489E680062;
        Tue,  8 Oct 2019 07:34:53 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
Date:   Tue,  8 Oct 2019 22:05:52 +1030
Message-Id: <20191008113553.13662-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008113553.13662-1-andrew@aj.id.au>
References: <20191008113553.13662-1-andrew@aj.id.au>
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
 include/dt-bindings/clock/ast2600-clock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 38074a5f7296..ac567fc84a87 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -84,6 +84,11 @@
 #define ASPEED_CLK_MAC34		65
 #define ASPEED_CLK_USBPHY_40M		66
 
+#define ASPEED_CLK_GATE_MAC1RCLK	67
+#define ASPEED_CLK_GATE_MAC2RCLK	68
+#define ASPEED_CLK_GATE_MAC3RCLK	69
+#define ASPEED_CLK_GATE_MAC4RCLK	70
+
 /* Only list resets here that are not part of a gate */
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
-- 
2.20.1

