Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD1AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FF82083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999229;
	bh=PzZjDBqROPAlAzof2XSQLBLA+qt6LlWh0YVuc2T7/2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LPQMtUiPiQcRpKzJE/iFaTgAGsQCJzxyyzLjQTPTNNtVCC0eZ7rKbLt5FuZ6uSrfo
	 sn82kCR1b0gTgRYTcC5wAKBOdlpP7eRIqRpxppVo63fKdwODku9z3xXrYETh3rAOR8
	 cQN8ZrHy4XP7e3s7rRTuTqtgUxoaY/jo3QOoXXgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392246AbfGXUNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404581AbfGXT4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:56:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37037205C9;
        Wed, 24 Jul 2019 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998159;
        bh=PzZjDBqROPAlAzof2XSQLBLA+qt6LlWh0YVuc2T7/2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0y8eAxpt2eRU4uxgxZxRXXbiA9qfFEKT35rOYnorCzli42xlUFz75XfRGO1Hv8SAZ
         hpv2dZXN73CDdV1NNpblFNJ9WhOs9lld545vWAD7qyd2f9kutZKl6doYxwNjOuulYb
         p5DEexHk2TUr4xps7KuVEyYQQM5eJUpFAzcCjD0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.1 268/371] arm64: tegra: Update Jetson TX1 GPU regulator timings
Date:   Wed, 24 Jul 2019 21:20:20 +0200
Message-Id: <20190724191744.504149475@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

commit ece6031ece2dd64d63708cfe1088016cee5b10c0 upstream.

The GPU regulator enable ramp delay for Jetson TX1 is set to 1ms which
not sufficient because the enable ramp delay has been measured to be
greater than 1ms. Furthermore, the downstream kernels released by NVIDIA
for Jetson TX1 are using a enable ramp delay 2ms and a settling delay of
160us. Update the GPU regulator enable ramp delay for Jetson TX1 to be
2ms and add a settling delay of 160us.

Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 5e6b9a89afce ("arm64: tegra: Add VDD_GPU regulator to Jetson TX1")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -322,7 +322,8 @@
 			regulator-max-microvolt = <1320000>;
 			enable-gpios = <&pmic 6 GPIO_ACTIVE_HIGH>;
 			regulator-ramp-delay = <80>;
-			regulator-enable-ramp-delay = <1000>;
+			regulator-enable-ramp-delay = <2000>;
+			regulator-settling-time-us = <160>;
 		};
 	};
 };


