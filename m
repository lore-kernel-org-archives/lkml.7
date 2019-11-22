Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C5CC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3728F2071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420177;
	bh=3HupZYx6MhBx2F4Mzie0QMEcyeLD1vimJQsbHaUp8Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mKWOoOKg2PKGgwjiMxOAXxB+UtCBOEPDcZ06Qtj/cTJ3WsLj00fYl3PR1C4VHPOOK
	 KAE5A7uY3vBe1gpIhPKp0jui+y5AKOElhcvzujSqbByliFrGP/RsYm4XpvK6NQt7+1
	 uo4jImCQgkwLSfE6pibgDxShvf3UPkdS2zFIM8D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKVK4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729945AbfKVK4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:56:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BC520637;
        Fri, 22 Nov 2019 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420171;
        bh=3HupZYx6MhBx2F4Mzie0QMEcyeLD1vimJQsbHaUp8Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+Ow85NM7a/7OPrA6YFSMKJiZp55Ff8XJjRzQ1XjmdtQG5RZ59zuKcGGlnyMngZUs
         ttM4cdXzNXQJrV++VMCN6NnFhcSpyBJb5Iq6tZyqDQHAPeuJdOSc4U0lO7PD+XVQ8q
         UNJbgdD4u7j9p1Ld0AOHAME6FEQ2mA8mIIR0OfGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/220] ARM: dts: omap5: enable OTG role for DWC3 controller
Date:   Fri, 22 Nov 2019 11:26:23 +0100
Message-Id: <20191122100913.846907236@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
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
index 8b8db9d8e9126..c2dc4199b4ec2 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -703,6 +703,10 @@
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



