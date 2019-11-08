Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17EEFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03421D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239931;
	bh=QkelrQeDpMB5g0UJzJENR2b4+5kFAu4fE4coBk7cjFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ePJQG2EQTWYEwLVrjSWQ1v8aEJ1KHSghjbImyFVueD+oj5WTLK9kiQ22zlm8P1oO+
	 FIpkwTBfQexfarOIWfw/QEpDPh6lv/zoLCdS+XHay2Wz/u6geY12cVx6pkj3jf1KxQ
	 47rNgN1pzFkp3Y4hSqwznXXiAEAcUaE8tr6vSiXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389548AbfKHTFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390462AbfKHTF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:05:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DFD02067B;
        Fri,  8 Nov 2019 19:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239926;
        bh=QkelrQeDpMB5g0UJzJENR2b4+5kFAu4fE4coBk7cjFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0cAtIfKNF59FsVyTBcG6ZNDUqgCB+3DALgi7MWg5tu6RPoMGUoRjiFLB7qhO+SZOM
         qO/K/h1HcG596NgwZJtFHRLi/97S65GKVACpJUHRCaXme7lwUQecHFaa9WocGoWj3f
         0a4mQgKZ6cPDm73GYOgopNsQoZRgt/NlkFp6h9LU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 008/140] arm64: dts: allwinner: a64: sopine-baseboard: Add PHY regulator delay
Date:   Fri,  8 Nov 2019 19:48:56 +0100
Message-Id: <20191108174901.478751742@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



