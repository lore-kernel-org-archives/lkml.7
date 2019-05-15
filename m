Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB04320818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919119;
	bh=if+cigsVb9L5vqMDI0IdmjwNkCaIJB4Q0xkEqqjUYls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ImsqaT9WqeIEhUXMiaIiiIqLAhdLt+U3ldwOhn5Sv8zsgWstpOExVhZUkaazpYq5l
	 nN3XuNjYz2NtgQ3QH7p4VYK+8nFzLI4eNm31Sx1IDrV/nLyK0CB8WF/BCJXR4k2j55
	 3kNwGgKkGsphNeREzKg88FwqfMTE20b9rFPkDXWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfEOLSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730833AbfEOLSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:18:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B997D2084F;
        Wed, 15 May 2019 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919114;
        bh=if+cigsVb9L5vqMDI0IdmjwNkCaIJB4Q0xkEqqjUYls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtWSk8fIAWESpEZ8pFIHjqEXV7CNRbDqv+X5IeSSod2CSlTKVMlwd9zXjeQvRb6nK
         BeANFnZIysUTkjdcjT87/qxLA6pr+T7m5J4IxDZfBjkXKwf4kO8OGadNd4aYrIvalG
         4Cj+7lP3oq4zLRysCoJoMj4OgO/cxlVzhjQ5HjGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 072/115] arm64: dts: marvell: armada-ap806: reserve PSCI area
Date:   Wed, 15 May 2019 12:55:52 +0200
Message-Id: <20190515090704.676783539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 30d48ecf46e08..27d2bd85d1ae9 100644
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



