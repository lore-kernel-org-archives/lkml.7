Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD22C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB392171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="VVvSS6nQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zct7FONo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfHIEh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 00:37:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37933 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbfHIEh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 00:37:28 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E0AF320355;
        Fri,  9 Aug 2019 00:37:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 09 Aug 2019 00:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=EoJ2wwxdmR03d
        fpAYPe+gJYviPTMS5bz+4dOnD3WST8=; b=VVvSS6nQtwp9ReVHsB74mR5ERcHfw
        LhoRQiz7hP/DsK6tJsN3qomhJX7j5v4JljfrAyjMDk8w8kEJl0Hr2yNeabuEGc63
        nvf//Dz7tVn1pVUYtf6VUQrMuZgU2H/3cUwlN7ccGbz3ZVUB6bNVhzaGyVzmC6Ur
        R0cVIJnSUNd8MC3MxrikPKqFwCgpsClyrzBHM0ATYiB1lJiz0xO4voKPYfOo1CpB
        /E3x7b+6ZYJdCQAuhZAGaW58tYdQy2kstiH5Ta6Y/kAHJuVVYD5NOt0uMWf1rBYS
        dDWlP+GnaeSy8G5MccAk0MQcvym5VdtP7UfzEKAXz1rH8HDIF7JYYIEkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=EoJ2wwxdmR03dfpAYPe+gJYviPTMS5bz+4dOnD3WST8=; b=Zct7FONo
        nij4Phl4eU2Y6zax/dG3Bh8Ly6QW4+90o794JvW1n/qDxQG3ixLi8qTZOwD5Umui
        ZmpZxIJnqV3LRH6t2zphuKPaXvre1IIwC8YlXhMfXmeIFIhjbUfhZtRW+QFwWIcp
        TsaF9TLyLDjIApMpWBr/1yUctmo7xlPI2V7jnJVccGqHsBsJVJexA/uGsirc/1t2
        o6M1mc3CYbYz0uhhMagtEfY/Huyf+AvFcjEIckYDGITVuWIIPqK6WSaXfgGoa6Gg
        salwgfjck3RMEldVWp9NQwOmaF/bpLyHmi5ysBbOSUS6zkSHzUy9wOF9W3RE3+2h
        wiTjZHfpUhIVVA==
X-ME-Sender: <xms:h_hMXfQHdaICBDrtHlhxUQhdl0ggvpCzUfAZHTMPGhUhiJu3bt7XwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduiedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
    rdhmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:h_hMXb_Y6A1vAhJDUnFlMgl2jmSLz8R1yV6vxIpzxRkK9P73b9xn5A>
    <xmx:h_hMXYphLM1MwejGBvk365Vh8aREL4Tyd447Wuja8VCbOjBVhmmGUw>
    <xmx:h_hMXZWJbLFeu3a8HyoWSJ1v6VIl9GvjMjbZvJUum0vspwGtfWJ3zg>
    <xmx:h_hMXToeHxzVZ2mhB8OEUuJHzQH5IND6utFl7l0FK6va-qtKHhai1w>
Received: from alistair-xps-14z.alistair23.me (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC01A380074;
        Fri,  9 Aug 2019 00:37:26 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     alistair23@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/2] arm64: defconfig: Enable sound drivers on Allwinner devices
Date:   Thu,  8 Aug 2019 14:37:18 -0700
Message-Id: <20190808213718.12270-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808213718.12270-1-alistair@alistair23.me>
References: <20190808213718.12270-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the sound drivers for Allwinner devices.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b17ed20e1754..3dc12c3b9bf8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -550,6 +550,12 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_CODEC=m
+CONFIG_SND_SUN8I_CODEC=m
+CONFIG_SND_SUN8I_CODEC_ANALOG=m
+CONFIG_SND_SUN50I_CODEC_ANALOG=m
+CONFIG_SND_SUN4I_I2S=m
+CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
-- 
2.22.0

