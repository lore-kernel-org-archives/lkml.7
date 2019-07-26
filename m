Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC8BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011B322BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="QR5/9S5O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnH9utGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfGZFkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:32 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50827 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbfGZFkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D404222D2;
        Fri, 26 Jul 2019 01:40:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=/iT1MTk1oKRrE
        njkLxpsHJsTgTurlfgvdf/YXz3Xh0c=; b=QR5/9S5OAR1o9JfaaovYhbPDOOu/m
        nRcQ9F4FGb5xlQjwaVFWi5PGSdziwoDGgQBni42TgFdnoqsK+khHdH1JOwSRLhWY
        aNawF5J+P6o99xKu3rpbwRyA+2aY261t8H1a9mcixArC7E8JfISsaXRQ469HCTFA
        4JLnPB7g3lC3tWuLntagu3CTaRsRMYxxhykuIy4xvQRO2wBxrk66f8d2e9ZS8Aqx
        HFTraM1yS2lWxYmwuWRQU+vnyatKKyjlVhUljnvW0LZk0pvgnycbwZzmAVHAEJJ6
        OhSpvcdUVEeCcZVqxDRJURVjEQ3aEipKM8VIu0H1yuTbwnuRljAdwyXfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/iT1MTk1oKRrEnjkLxpsHJsTgTurlfgvdf/YXz3Xh0c=; b=HnH9utGY
        q+bypQ5TAg7SQpLFGakmyV7ul4a0xJWHWrKjZI4SIAQO0QBB3xh2/aPMUJXxfJQI
        1nEZSABOB3j3Yl/c/C7NRdOYr6mjPlpLFT3e7gfIGSe2ZsoaiE7zxxjJ+vgzUvgS
        a0hTGmpXg8TLzdHK2xPif1fQOG9g0bIaBefbaOAVoJEiLAjLOVH+D+QUpdoZPSMU
        DbcewYhJ01KvplSttcZGaupdKvSYPHI1G6XVLFDw+lQmWZgpawDDy0jygj0hOrV+
        CmDTa71sTUk9XlAR4teYwRSahejhmQMM1HFlpyGELpxIw2/TQx32dzm1wApl9EwF
        dNqmLXgfm2NzkA==
X-ME-Sender: <xms:SJI6XVJnmfqlIod26b9fhxMMiuJ1jBxYAqaMSJpUkaX3jOOAq6VHQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    he
X-ME-Proxy: <xmx:SJI6XfYvNUQ96KBk3i3O0X_pZ6b07rwvobAeTK6MeTljclwN3lcnXw>
    <xmx:SJI6XXCz0lUE2YFnNDFaGZk5aenft_DjI5-u8LDe8Jt2kQs4y8WfRA>
    <xmx:SJI6XZbZEVrqPJcfYoUbIqy4u1n0i0d7XVbLsNy912fWOc-FJJv4aQ>
    <xmx:SJI6XdeXLTGkF59UyS_ne131-Bi4Zgp1Le4ybwiw5SHu9ukZAN8g9g>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0183380076;
        Fri, 26 Jul 2019 01:40:20 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adriana Kobylak <anoo@us.ibm.com>
Subject: [PATCH 06/17] ARM: dts: swift: Cleanup gpio-keys-polled properties
Date:   Fri, 26 Jul 2019 15:09:48 +0930
Message-Id: <20190726053959.2003-7-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtbs_check gave the following warning:

    Warning (avoid_unnecessary_addr_size): /gpio-keys-polled: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Cc: Adriana Kobylak <anoo@us.ibm.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index 2077e8d0e096..9f934509ca1b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -82,8 +82,6 @@
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <1000>;
 
 		scm0-presence {
-- 
2.20.1

