Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BCC20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431149;
	bh=WHcO5EoZl0fr/lRyk3dvLveSy6NFjKp82pGRFirSzA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tu0MYYdUfqMouRUp5l9gQbEnLW0J/Tea+Xfsc4YPXr95jDqIYcQ2wOT0ey0YcZviS
	 yjjawmapxEShUKUr3zYIfzZEYW1aodN38c2I0JVZv388cWlMc8XHeIBrsrNM1E1uw+
	 7OQQUq7Cy44yS+/K4jQWPAL+wD/PGghap/zWsK2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfG2UM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbfG2Tbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:31:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8E621655;
        Mon, 29 Jul 2019 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428708;
        bh=WHcO5EoZl0fr/lRyk3dvLveSy6NFjKp82pGRFirSzA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpVVF/ANdqEYzm1aW2trJnZPKrZP778zggiLyn3b6VXrmQjDtYNeT9wQYqTTh7ojK
         hlP3JeJcrCLlQbNMsKWJYq7r5WC0E+cKy7iGzWv5scCcHB4gr7UCQgo1kYdh7zwMHx
         p3pcF9ftcAX0eFKabEIa7fslmbC6Wr2s6tqFBw/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.14 144/293] arm64: tegra: Fix AGIC register range
Date:   Mon, 29 Jul 2019 21:20:35 +0200
Message-Id: <20190729190835.563268178@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

commit ba24eee6686f6ed3738602b54d959253316a9541 upstream.

The Tegra AGIC interrupt controller is an ARM GIC400 interrupt
controller. Per the ARM GIC device-tree binding, the first address
region is for the GIC distributor registers and the second address
region is for the GIC CPU interface registers. The address space for
the distributor registers is 4kB, but currently this is incorrectly
defined as 8kB for the Tegra AGIC and overlaps with the CPU interface
registers. Correct the address space for the distributor to be 4kB.

Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: bcdbde433542 ("arm64: tegra: Add AGIC node for Tegra210")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1103,7 +1103,7 @@
 			compatible = "nvidia,tegra210-agic";
 			#interrupt-cells = <3>;
 			interrupt-controller;
-			reg = <0x702f9000 0x2000>,
+			reg = <0x702f9000 0x1000>,
 			      <0x702fa000 0x2000>;
 			interrupts = <GIC_SPI 102 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&tegra_car TEGRA210_CLK_APE>;


