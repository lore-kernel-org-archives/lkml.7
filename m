Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAEDC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1437920637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418972;
	bh=aciTia3+1RfNyXBqb+XcwzuBS6eJh/2Ufzi2zsqsIgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NXpSwDTwYYY/w4QsYS7JFXl2xqRu88eVzZ731FmyzmwLKXTUHEvcp8HKb8fHd+Uby
	 VKPTui87okwBbX/qtsuItgIcxoZJG3KgP/wF67CtqTfBcGt9PGiM8OQVuXcmGJCn7f
	 LJQzAO5cftSYZXJhYUr1UQYlN8dgwr4iFtbUVgDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfKVKgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:36:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbfKVKgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:36:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7940C20708;
        Fri, 22 Nov 2019 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418968;
        bh=aciTia3+1RfNyXBqb+XcwzuBS6eJh/2Ufzi2zsqsIgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fy5bgOS1LKXi+8xd3CP7kchv02iKKfRK0vkL/F5F5qo3bPBT70tcu5v4qtfw57Pc3
         y20cUp6erHZgtQGrCkTrDTNCAivbaUiKbrTLIXoQGRcp2OTW5AqP5Y/QeNvGXZBurA
         IBAD3+cmwsKGSGMn4e6e3WFj/P8XYL7xbMsgjEug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 112/159] ARM: dts: omap5: enable OTG role for DWC3 controller
Date:   Fri, 22 Nov 2019 11:28:23 +0100
Message-Id: <20191122100828.249702443@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Nikolaus Schaller <hns@goldelico.com>

[ Upstream commit 656c1a65ab555ee5c7cd0d6aee8ab82ca3c1795f ]

Since SMPS10 and OTG cable detection extcon are described here, and
work to enable OTG power when an OTG cable is plugged in, we can
define OTG mode in the controller (which is disabled by default in
omap5.dtsi).

Tested on OMAP5EVM and Pyra.

Suggested-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 41e80e7f20bea..d2398d2a0c08c 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -633,6 +633,10 @@
 	vbus-supply = <&smps10_out1_reg>;
 };
 
+&dwc3 {
+	dr_mode = "otg";
+};
+
 &mcspi1 {
 
 };
-- 
2.20.1



