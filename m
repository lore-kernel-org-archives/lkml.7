Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A916C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A6622C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="mMz39AGz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9A9eeM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGZFk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51403 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfGZFkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AE12922304;
        Fri, 26 Jul 2019 01:40:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=FGnrb1We2FOVt
        /++AKR6ddEpH2XDEzYVw5O9qXjrW4c=; b=mMz39AGz6K22TPx02gYs+cd59F73Q
        ymNswcu7ZcjW8sC5jQb2+sBNJk2lLnZj/KM/E4Yw6MfYOLeAVSv9/N9Cyxc5dInI
        ILm4BfzIYhLTVMnb/VA3G8ulzuC7zrALU0t4TLAt2+vTLqgBZb/N6PxeGXj3M1ta
        m4B1Lph2fv1fVOtWIQDKRJfqZYeFAU4ZBpQkMrTduGMhE3XRVrprjs0caXI4AzqQ
        nI4CfrUwMJQfFMZry/9Yt7r6aRanLysbRzbtT4R4av26ZcDe082uluVrH6jY/zHB
        V3zZku9zXXgoUt94WQg6bKflBpEUzCoKIowj8drii6hG6xOjCHPEtDMKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FGnrb1We2FOVt/++AKR6ddEpH2XDEzYVw5O9qXjrW4c=; b=O9A9eeM3
        4BtcB66bgmHNI18lEjrkyqKy9eO+g/Ecx+meEOju5Jn26CgYggOtFLmeU5NxL/Fs
        JvFNeIkhhOX5OM4Eg5JjDoXhHsRhGmlHgzoSIlHUVyoua9bEdI+cFr0VZcIGSKxS
        GmH2C8nBpdojs0JHnZ8Tcfzh5wf7oH1342ovzcGhAqD1pqHLQKQfgw8+3LW9UTl2
        xby2nJ1WEXBwznBBbjHUsjH/SJ7p2TdWnFkExKo+ZCJvlKTnrsviAt42+qS1wN1T
        SCnhLfkiqoeoR8otGEw7Otb0LYLdaztVe1O55OXyzZIcVd3ayVQqO0Cw+MKYpJwg
        UUMiXN7/bdnd9g==
X-ME-Sender: <xms:RJI6XaQrHM3bllWNNzUdCXWaPW2UuhkmQKG9ygJpgMYg8U5npw4unQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:RJI6XdLEgXOUllC0AhkhBvsi8jHtnpu1jcBQrlD8G7zLr4ucZIEaHg>
    <xmx:RJI6XfLwrysAEgLKcPaFS5aa4FmlIxEQguEWkANwXclTjpeX355g0A>
    <xmx:RJI6XQhsOzujfQ4yGGF-QAISLMsI7bt7MZVpWQ7-rCJgfR8ax30U2A>
    <xmx:RJI6Xd4D749w7J3o9KEiMOEU-GWvHneHbHE3qyiE8eHfXvi5OCMicw>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84613380079;
        Fri, 26 Jul 2019 01:40:17 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Wang <wangzqbj@inspur.com>
Subject: [PATCH 05/17] ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
Date:   Fri, 26 Jul 2019 15:09:47 +0930
Message-Id: <20190726053959.2003-6-andrew@aj.id.au>
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

Cc: John Wang <wangzqbj@inspur.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index 2dd664bff928..aa5efd1dfa70 100644
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
2.20.1

