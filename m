Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0884C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF48F218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239712;
	bh=Pkh8O6u6Xi3YkNZ+kgSiq60tEkoy6kaOzhQaxlLsPqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a+BNAsRXIbuvmyG2v198JRtHYFRJo73FEc8nLcu023M6Md3Tjh/dZxxvO7lbxuw/h
	 GJ5BQvQ/Y06FNcKUF9cpKits2XxlRl4XvPJ3xqYP7JL6joHnnLdDFcUzf5ZML9SUCJ
	 NVHYWpUzTX1UfdhVKNlvaSb0QNkqCtU1bRuhu6ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390345AbfKHTBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390314AbfKHTBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:01:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D63222C5;
        Fri,  8 Nov 2019 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239705;
        bh=Pkh8O6u6Xi3YkNZ+kgSiq60tEkoy6kaOzhQaxlLsPqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUWEOVAclTfLlOPVb2lwYcSz4Ib7Pq6M0OwdofICONncksDiufLPupFt0jlr+9+an
         4FHEYHopmHE5YB9BXMDPO0UvxzE/049KTqD7AkNNI6hCgf2oweL/9IbH4RMiLWi6mq
         TrhewygcU5lrg3lZwBXty/PXInrHVTwyUxomEBwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/79] arm64: dts: allwinner: a64: sopine-baseboard: Add PHY regulator delay
Date:   Fri,  8 Nov 2019 19:49:45 +0100
Message-Id: <20191108174748.006012861@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
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



