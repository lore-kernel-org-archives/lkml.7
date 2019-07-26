Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E68C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4A122BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="nJtUPr2d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="koCsYE2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGZFlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:41:16 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51205 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbfGZFk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9076F2230E;
        Fri, 26 Jul 2019 01:40:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=oSDr1xjwZ4K40
        /MK5vRNInuje81HUcQkw7+j8FhaZBE=; b=nJtUPr2doNBzYfahf8HEQokqeiFLZ
        sxeJD+ChRqORwbEUNp2ySw0VWf/IW4BFBtsj8LF7E3xy4azYDmrqEwWTZH/XylqU
        6ExCjwaOdxoR3x5V4+xW3lmboHwDfLRv+x+GyBXHroFn0Udupku4/8PfZRK0iaHz
        OIcbJP9v7oK1XMLmyVNtjxQeNc7Ylq1LLSkvpSxQ5qNsP479LkzvmllqT15OEDkD
        +Hg8b66dHkUxawRoVBDxRxIY1BWsUkQkRDjvHyabgigeKgOVonW7Q+zXkdi9mbJA
        x95QvYoh5Py91eRV/KGM27DzbGB+BM5eywVuw2cPqt1HWL9YXApa5Q1Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=oSDr1xjwZ4K40/MK5vRNInuje81HUcQkw7+j8FhaZBE=; b=koCsYE2C
        IS3NbTVKd205d2oxynUGvnCbRE+BzZ2S7gSFgGE6pLPpu6TzObSirDmZEgFHTlDR
        Uh+7CeQ5dj3l0NEey+0jbDWFa5Us0IB5tqWsAaouibGTulb13XenSoZdSY0ENxdG
        SJgY6aAGAxGPg2Wg2VbtQ/UuiqxehM9wMMvTZKuGSxrzbyMU89kwu4afLR4vrbMC
        asYL1onjFlM1edk1I5Bhq3Ee8ets+iiy+BH0d5P1qzn/2uF3nM+PeWa7GoAdJY54
        482QIu1fFfKbbUFwsJJLkCzFNAfKkWOjLmzu4VFclD9928yPTJC53xqlIV8qvRQd
        41p5QBA2htFYlA==
X-ME-Sender: <xms:S5I6XfUrr0Gmg07ph10mXzZUDMAXM-CP0EE6xar9s5fY7_Ih7B_OPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    he
X-ME-Proxy: <xmx:S5I6XZH_kNpc_dcrOsnGt_JkI8VMWZuPEGTGxWgr8QMOA0ju1li6wA>
    <xmx:S5I6XbfTGuLD2lfstgbNJUp4younmbw9PgMHVsYDcU7ExFBZDAdWnA>
    <xmx:S5I6XaLoUkJX4Ziz1S267mH719wEXmgMNya4XB8HMZLcfhL1m3wdUw>
    <xmx:S5I6XV7hUmOJCV17GTVRUg4FwAceJNDlkG5Farmrh2b3GjXrkTOHvA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D6F8380076;
        Fri, 26 Jul 2019 01:40:24 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
Date:   Fri, 26 Jul 2019 15:09:49 +0930
Message-Id: <20190726053959.2003-8-andrew@aj.id.au>
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

Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 08facb2120b2..06319c6771ca 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -77,8 +77,6 @@
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <1000>;
 
 		fan0-presence {
-- 
2.20.1

