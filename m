Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3522EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA0A206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412941;
	bh=TeMxWrB3UXHB/EgbkjabYlZmhItS38mHhSM45D1yGGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=skRl9+K+oKI/hOJpPFdAlS6idCVhz5JV9SwJ4uaDNzG6Wc/wDhrKLy/HLwOvQ9A/O
	 D8cII/MpZurfybf0ZKvyABGn5LcqPMP4aFRmsNWPqj5hbxWQLY1ehs2ZZe6ErFTwpj
	 NWerPVOQt+AUGJr0FpydTNeTkYPzVMkgEflA1fB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfLCWmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:42:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfLCWmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:42:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7977820848;
        Tue,  3 Dec 2019 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412933;
        bh=TeMxWrB3UXHB/EgbkjabYlZmhItS38mHhSM45D1yGGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBCWqD7LzPGMz79hWdqJRkFqMgQxENGr3FmxFZ0+1pZUmt5YBQVy9dW8s8SS28z6V
         quA9Zu/boTuMVyIfhFHiqaz2o5yGimTQE+qY4sTUs0fMo6tv+wj7lCqMo5gW4DQ7Lw
         KJfmJygzxodkj5DNebwrJLtilvlqUOhir75xxMug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Roullier <christophe.roullier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 071/135] ARM: dts: stm32: Fix CAN RAM mapping on stm32mp157c
Date:   Tue,  3 Dec 2019 23:35:11 +0100
Message-Id: <20191203213026.657066619@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Roullier <christophe.roullier@st.com>

[ Upstream commit 9df50c2e16de7fd739d11d37303afec9e573b46f ]

Split the 10Kbytes CAN message RAM to be able to use simultaneously
FDCAN1 and FDCAN2 instances.
First 5Kbytes are allocated to FDCAN1 and last 5Kbytes are used for
FDCAN2. To do so, set the offset to 0x1400 in mram-cfg for FDCAN2.

Fixes: d44d6e021301 ("ARM: dts: stm32: change CAN RAM mapping on stm32mp157c")
Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 0c4e6ebc35291..31556bea2c933 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -914,7 +914,7 @@
 			interrupt-names = "int0", "int1";
 			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
 			clock-names = "hclk", "cclk";
-			bosch,mram-cfg = <0x1400 0 0 32 0 0 2 2>;
+			bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
 			status = "disabled";
 		};
 
@@ -927,7 +927,7 @@
 			interrupt-names = "int0", "int1";
 			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
 			clock-names = "hclk", "cclk";
-			bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
+			bosch,mram-cfg = <0x1400 0 0 32 0 0 2 2>;
 			status = "disabled";
 		};
 
-- 
2.20.1



