Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98429CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6591C20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450864;
	bh=Pkh8O6u6Xi3YkNZ+kgSiq60tEkoy6kaOzhQaxlLsPqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f2TgtjUaaabGglTZiRnUmT94g6AaDDSldhEvRvBocCxPC7sMJ0Y11btUinsX1sSf4
	 s8O3JryHaScQWxHUha8ysBhTPUB32LkLEbedVM+cDfGx9I3istNNKXjChyvJ/CCqvr
	 5c3kSM0xzVAlJErOPlofKOPwgEesaE86vCU9FdXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfJ3PyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbfJ3PyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:54:19 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D79521734;
        Wed, 30 Oct 2019 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450858;
        bh=Pkh8O6u6Xi3YkNZ+kgSiq60tEkoy6kaOzhQaxlLsPqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13HjwxueiSx+RBCJKaoKMIdjQGzaZ1Ss1amqlGss+lGaNZeREkI1HqRsZa22pKKio
         o2OGXZAkpEjFyuX2tMbLq0HJT4Uk6UjXkAVWKQlxDNu/0VY9Jm+LyFEPNArvB1SfIF
         avB1AtHqhHAdEW0g+56rRLXWTRMsMvSrBQfDf9zc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/38] arm64: dts: allwinner: a64: sopine-baseboard: Add PHY regulator delay
Date:   Wed, 30 Oct 2019 11:53:32 -0400
Message-Id: <20191030155406.10109-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155406.10109-1-sashal@kernel.org>
References: <20191030155406.10109-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit ccdf3aaa27ded6db9a93eed3ca7468bb2353b8fe ]

It turns out that sopine-baseboard needs same fix as pine64-plus
for ethernet PHY. Here too Realtek ethernet PHY chip needs additional
power on delay to properly initialize. Datasheet mentions that chip
needs 30 ms to be properly powered on and that it needs some more time
to be initialized.

Fix that by adding 100ms ramp delay to regulator responsible for
powering PHY.

Note that issue was found out and fix tested on pine64-lts, but it's
basically the same as sopine-baseboard, only layout and connectors
differ.

Fixes: bdfe4cebea11 ("arm64: allwinner: a64: add Ethernet PHY regulator for several boards")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index c21f2331add60..285cb7143b96c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -113,6 +113,12 @@
 };
 
 &reg_dc1sw {
+	/*
+	 * Ethernet PHY needs 30ms to properly power up and some more
+	 * to initialize. 100ms should be plenty of time to finish
+	 * whole process.
+	 */
+	regulator-enable-ramp-delay = <100000>;
 	regulator-name = "vcc-phy";
 };
 
-- 
2.20.1

