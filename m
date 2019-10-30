Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C58CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EE4208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450590;
	bh=QkelrQeDpMB5g0UJzJENR2b4+5kFAu4fE4coBk7cjFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GSTBeRvQZ5A4TE709Livumo8RGvH2dxTNdj/DZth0YFpnsRYJdxbATYd7E/jMhmH8
	 aa6Ubs7w0JLqTADEqoew4N8rBz2euzh2+4+eww2KH1Tfxfm45WQqtZQOVhVvq94A8Z
	 ZWutyHNkzq89zieRNG0ZVvcK3TUvWarftLfriC9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfJ3Ptt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfJ3Ptq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:49:46 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A98208C0;
        Wed, 30 Oct 2019 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450585;
        bh=QkelrQeDpMB5g0UJzJENR2b4+5kFAu4fE4coBk7cjFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xz6r+wA4OUA0UQzN4aR4++2sRzR9D46zNuIj2L782TIPJOLFlhjNuNK3Dq/md6sYq
         Z4GRVxWXCJyayXsAwafMQ8ZMWWc2B0jwMDMdAZCMqNyHtJUFfEnEb6RZb028pgHv7p
         t+0Tly2Tr3cDHUyXPd5PcGSWNpLC0vvxNlSaVHfI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 08/81] arm64: dts: allwinner: a64: sopine-baseboard: Add PHY regulator delay
Date:   Wed, 30 Oct 2019 11:48:14 -0400
Message-Id: <20191030154928.9432-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
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
index e6fb9683f2135..25099202c52c9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -159,6 +159,12 @@
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

