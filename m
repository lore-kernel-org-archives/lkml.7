Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EEDC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A53205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208160;
	bh=6rqeJIpOxgLw/JjrqCTGWN5oEHnbMtARRiJU296VwB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JFq2kwtWCCX7yW4zUaxSIL328Dw1hJ9mz/1pXqpa7OhTwOtrd5poUDRS64nHouri9
	 PQe9/68nKcCaJIzR0gbZo0O5rxxYSakSEA1Pmhpi8UC5eUKfr0rcOk5OJ0iRHjevak
	 SlmboPHJwhd+C0j+kHNtUU8iQm+mFkFOE2dHGIcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfEGFtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfEGFkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12172087F;
        Tue,  7 May 2019 05:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207632;
        bh=6rqeJIpOxgLw/JjrqCTGWN5oEHnbMtARRiJU296VwB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhxL6kclzZ7TEwIrSRmca9vDRbC2Gd8ghKbeGfZrET42LpfUa7svyCt9xYLrXUWjY
         a2XmyloCCXkia6FUxgoTBjgKbZ/GfLglMO6vCjzzV1og9MlzwNj3LeWUtjQsn6syTf
         Z7pO/MemYk3w4Zx/uFCQ1zcqjcKBYK7wOVScSO34=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 69/95] arm64: dts: marvell: armada-ap806: reserve PSCI area
Date:   Tue,  7 May 2019 01:37:58 -0400
Message-Id: <20190507053826.31622-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

[ Upstream commit 132ac39cffbcfed80ada38ef0fc6d34d95da7be6 ]

The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
attempt to access it from Linux leads to an immediate crash.

So let's make the same memory reservation as the vendor kernel.

[gregory: added as comment that this region matches the mainline U-boot]
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 30d48ecf46e0..27d2bd85d1ae 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -65,6 +65,23 @@
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * This area matches the mapping done with a
+		 * mainline U-Boot, and should be updated by the
+		 * bootloader.
+		 */
+
+		psci-area@4000000 {
+			reg = <0x0 0x4000000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.20.1

