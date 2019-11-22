Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F24CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5881A2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419768;
	bh=/crUOwCOLDRvI/AH1z5HIHAZHy54kr4aKlH4Jtg9IJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hH/jyv+tiockXj6NWLUcPFiKQ+8S9WcK8OpqmQ0s/217hEoIWt5lPTkbn9duhKOif
	 nNBMQnqVT0v+zBV9Jq986iGHLxTacyo9ML5SFbt90rNDA6DZwTx5MRDV8YXsVhNMKx
	 fCCGozm3GZbOCF8RB5zqeyu9hjH6flUCCZK+Gm0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfKVKtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbfKVKtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:49:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E87820718;
        Fri, 22 Nov 2019 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419753;
        bh=/crUOwCOLDRvI/AH1z5HIHAZHy54kr4aKlH4Jtg9IJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0mIWGRW98c4p5HsxALdQzTpyLfeIgCzJ2F1R+wfBCGJtcvCRGtQpeRp2biJIC9Nq
         irTyzOf+RLGq45WpGjXm7sKTrFDCiiY5y/8aEuu9SB5/ic6rAjg7e2+nAFesHB3/4M
         MdB5/AsdViMozDTw+3mqosM0DWU4NL45mEFrjZos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 221/222] ARM: dts: omap5: Fix dual-role mode on Super-Speed port
Date:   Fri, 22 Nov 2019 11:29:21 +0100
Message-Id: <20191122100918.589485989@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

[ Upstream commit a763ecc15d0e37c3a15ff6825183061209832685 ]

OMAP5's Super-Speed USB port has a software mailbox register
that needs to be fed with VBUS and ID events from an external
VBUS/ID comparator.

Without this, Host role will not work correctly.

Fixes: 656c1a65ab55 ("ARM: dts: omap5: enable OTG role for DWC3 controller")
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 3e9e3d90f2b4f..e412373fe7bfd 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -695,6 +695,7 @@
 };
 
 &dwc3 {
+	extcon = <&extcon_usb3>;
 	dr_mode = "otg";
 };
 
-- 
2.20.1



