Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B09BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDAA2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="fXL0NvN0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvqiKA1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfLCMDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:03:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59669 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbfLCMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:03:12 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 678DD223CD;
        Tue,  3 Dec 2019 07:03:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=PCLgeyjEmKJVx
        dVpuK/Lt0i4thMBkeilCIZdg4t3xm8=; b=fXL0NvN0X4skl+hU9FH0/6yLwtDJJ
        NutsYa+jnJwuMsuqmwIEJNq0+6DmKCFCNjjuT9ge/sxdF8E6HonA0vzc0MnM9cE4
        DiOou0/ZVAnMhbTRVCd3sQVl/xK9ZecbOHqpoL4cSt16ZetLpDKJexCt07FFmk6y
        DV9EOUsCaj9vzVwvPqR4ikc69uP9nbbHFV8LKEwX9P3IUEPjWYWeiZwldg2ht94F
        qeKzl+nPC7cPRVz9GaFP/Tja8BA/hr5UgwlLeXIJhw6KhFacpzSLgTDIb9N4D/yi
        amq5dvj2VQu/LMV7jbUKZREdqcW80aCe04ZIAldtjvNIL4x+wHTJGNdGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=PCLgeyjEmKJVxdVpuK/Lt0i4thMBkeilCIZdg4t3xm8=; b=OvqiKA1k
        /xE3GXVxbEb+aw2heRU+J2ZsdcGi4sw52FlX624jUM3mSZjq5m4ZcIfwFxH7Y41x
        aQ7TLeOIfbj430YsNd+fJnQ4BytH8ITkX2cUo5ZoKPc2tbxXqmzgQISh4FfCgyUg
        ouJZ0+7eez+pYsdPT/c3AsExCV5b9nzKnVOJwhfJEa9tHAtPwr04TJgTfGh0D/7n
        gxEUewdWbGgXXJ3ZUuUNechD9dd/ujGulf/JY1XwJsumCqr23jTQjCSM2Ajk2wh7
        6vSeD42xdZdgpgGSOY1W8ev4naZa+X+ZAlREmrhwC6XaX2JODIiZJBof6FSHhC2s
        Mxv6b3fFOQWErw==
X-ME-Sender: <xms:_07mXfZ4RKqP1eGWgujakp2Ez-Fum8CPA1iLXjHU1TfvtGdCXNAcZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepudduke
    drvdduuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpeei
X-ME-Proxy: <xmx:_07mXRVnUJuT5gTnoSYYNV3WWpSPw_1oZd_sj0-9aGz1f-Y99WYASQ>
    <xmx:_07mXVUpA8CQLA2Riqu2y5KjnwefNa21IsgOMag1PxF9QWUmtneXuQ>
    <xmx:_07mXdLjRUPj5mgBfi8Hip5-ZMEZ9aqyc3e6VyfZ_oifhjph13UIvQ>
    <xmx:_07mXTeVIiarc6YSA9AjLsiPTQ-9UBsbTr3c7bwjudEPKjgJhFp3Cw>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id ACA2130600D2;
        Tue,  3 Dec 2019 07:03:07 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, John Wang <wangzqbj@inspur.com>,
        Adriana Kobylak <anoo@us.ibm.com>
Subject: [PATCH 07/14] ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
Date:   Tue,  3 Dec 2019 22:34:08 +1030
Message-Id: <ca7ab33d96a8c20c1b09602ec6aee33374f7c5fb.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtbs_check gave the following warning:

    Warning (avoid_unnecessary_addr_size): /gpio-keys-polled: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Cc: John Wang <wangzqbj@inspur.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Adriana Kobylak <anoo@us.ibm.com>
Tested-by: Adriana Kobylak <anoo@us.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index d69da58476fe..d6bb0c91d2d3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -94,8 +94,6 @@
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <1000>;
 
 		fan0-presence {
-- 
git-series 0.9.1
