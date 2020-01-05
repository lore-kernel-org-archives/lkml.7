Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD5C32767
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 02:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBE32465B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 02:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="nXyuboOW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wejcvVZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAECLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 21:11:39 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53793 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgAECLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 21:11:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C30221A4B;
        Sat,  4 Jan 2020 21:11:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 04 Jan 2020 21:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=m/3Nc6uySMl3gk1KAG4ocFWmEJ
        bnhbMHB3CYmRsk9nU=; b=nXyuboOWAxcY4KlDmOPI3Ixgtg34SZtdmGkhmvr3HW
        31iru6La3vS5LmonuyK7txKGBNu5PQGuNK5vCrzncbXu6IcAZ6+mFAiN1Vdo8MUl
        BiRfG/CPuV8ujXiaJLSluPDDXiVHgMdxcR08k12WWU5rxL2Lo3wbr60tqIJhOEVZ
        X/3HR6rQ1YpVoFC7yZYhicxp8Oqwd6+ysyESuXChLvAkbEVLWsxDgZKyrjrdRUZ/
        ox8yfzNa5B2Bg20Y7ANX6jROxtxz8C+7SsLkwWCNewjHGJ52Gwx3LZIizd5txfdk
        PkmsBmrdlz7LsMmW5r+wMf7kiaS8Vmmf0SAAKuUIgMcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=m/3Nc6uySMl3gk1KA
        G4ocFWmEJbnhbMHB3CYmRsk9nU=; b=wejcvVZDPlBmWh3R+EV0L2epQ13uXnjHP
        YpRm13jm5oEpGfv15gA86CtG/46FLPsVtIm3Nx+3aDXGAKl+vF/YNdBihpy0Ned/
        hNvl34/sTdoa/nAEJMb2f4wRDrinOfNWO06hzykD5CdV+ro4Xht1HobyNKprd7W6
        RUVLI3pJWF0M+SyYyd899FuNBAqJmlV4W204BhhUiCQyKWPW9eM+dRBU3aKGCWC8
        WgIsL8EbqK+pCV1lkXPV8Mz9jHrxTM5blbOaUMKC50ch2OB1VmrJNda5o3QLu6X4
        BF/xgetopi7H3M8IE9PfYUTPHRaAv2rilfv3b9V/lWmDJ1p+UFyrw==
X-ME-Sender: <xms:10URXna5LDAoTAeec4CsV_eHcGE01NdDw9Qee6QFXikBtJa-dbmXTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegiedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepje
    dtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgv
    lhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:10URXq0JUFJ657-lx_hWEMLzMIJwUpJUAzQZzSXHYSOw5m6e9wLvcA>
    <xmx:10URXlShesIXM7E7iUs3UQfnC5wKnZzF3ZdXbJX6IZdjH-KnwjNW9A>
    <xmx:10URXq_UPG_XWwnrlEYnFSjddiGJLS2VAswOQstdEEI6aiHbTGshNw>
    <xmx:2UURXss3jRw2ZC4jjl8-BP-wyUMsw3zFi9X3bIfpX6A9x8EQrt7xRA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C027C3060741;
        Sat,  4 Jan 2020 21:11:34 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH] arm64: dts: allwinner: a64: pinebook: Fix lid wakeup
Date:   Sat,  4 Jan 2020 20:11:37 -0600
Message-Id: <20200105021137.46542-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, gpio-keys configures the pin to trigger wakeup IRQs on
either edge. The lid switch should only trigger wakeup when opening the
lid, not when closing it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 78c82a665c84..836ae51e5c2a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -10,6 +10,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 
@@ -60,6 +61,7 @@
 			linux,code = <SW_LID>;
 			linux,can-disable;
 			wakeup-source;
+			wakeup-event-action = <EV_ACT_DEASSERTED>;
 		};
 	};
 
-- 
2.23.0

