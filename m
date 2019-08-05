Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05AFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB032067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011310;
	bh=n9eGEAa/Nk6aJ2s5kj9FdOmQGguQr2mEbKZzmIwVJVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=otbSuUtwMTrZnRvqz8j6KEQJYBNXEFOLhLIje6QluNJCSGM1cadxX3iChI2pK5Qdj
	 NeyxD6Irb8WlioxD5oXcAIgfNpUll18MKEtAXcYeXtKAQW5CKT78yR7eLMNPcZelZ1
	 nCED8KCbbMmlTKq/z6qDi7tyZkJxuhdPAL6GDyaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfHENVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbfHENVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:21:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F9C2067D;
        Mon,  5 Aug 2019 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011303;
        bh=n9eGEAa/Nk6aJ2s5kj9FdOmQGguQr2mEbKZzmIwVJVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lw/1I0JpxZgzmWwU+lnnxqf51jkoL0vO/rpFivTfowgJ49mE6/pzH6RgyzHKdC/X4
         M6QjWlJB1ykZIgE/MjflC21BkJhBfiAdb8EuGBCtsesqI57qK1xUNBrIkz1Dg9Nipx
         1rlsDrDHgoH0iP1XAOswfVhDCyW3cOfpnKb6kq0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 009/131] arm64: dts: marvell: mcbin: enlarge PCI memory window
Date:   Mon,  5 Aug 2019 15:01:36 +0200
Message-Id: <20190805124952.053910776@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d3446b266a8c72a7bbc94b65f5fc6d206be77d24 ]

Running a graphics adapter on the MACCHIATObin fails due to an
insufficiently sized memory window.

Enlarge the memory window for the PCIe slot to 512 MiB.

With the patch I am able to use a GT710 graphics adapter with 1 GB onboard
memory.

These are the mapped memory areas that the graphics adapter is actually
using:

Region 0: Memory at cc000000 (32-bit, non-prefetchable) [size=16M]
Region 1: Memory at c0000000 (64-bit, prefetchable) [size=128M]
Region 3: Memory at c8000000 (64-bit, prefetchable) [size=32M]
Region 5: I/O ports at 1000 [size=128]
Expansion ROM at ca000000 [disabled] [size=512K]

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index 329f8ceeebea1..205071b45a324 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -184,6 +184,8 @@
 	num-lanes = <4>;
 	num-viewport = <8>;
 	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
+	ranges = <0x81000000 0x0 0xf9010000 0x0 0xf9010000 0x0 0x10000
+		  0x82000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x20000000>;
 	status = "okay";
 };
 
-- 
2.20.1



