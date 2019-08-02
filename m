Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF1C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B16206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739074;
	bh=bvh+rZz4l1IFH8gR+xxGk8M2ZG7FO7wx8lJ/CZJaJ3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gb8Slktq9CJowwnbm0O5lRPaNDBLEpxw8Wd3FFiI41pYVDaJD6ayeUaWWfFW6aqv7
	 N3vtLKmXcd2PMNnU8QbIlDOsJyaSkHe6QMaufDIIn3+bEIBR8l26x38rFsEoFjtEC3
	 XlrVMgT4fjhq76ozb65w6aj92imvQvM6nYW9CeC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405260AbfHBJod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404270AbfHBJo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:44:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4D12087E;
        Fri,  2 Aug 2019 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739067;
        bh=bvh+rZz4l1IFH8gR+xxGk8M2ZG7FO7wx8lJ/CZJaJ3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kkug6PU6rSAJQirnpNq1sL/leuxlEsVDu6hxJ/kPb1JwVvIt7bkgEm0gZ1yXyuvpt
         4a8d1JO2kZL322SRvj95wFd3YcsV3LmpzzMNbgMN63Qlhelk0YQMC8ziLyzznBuv/J
         mis4fZvDO20ghuJ7mKeAzS86b1x2mmJyhDxqF7EY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.9 085/223] arm64: tegra: Update Jetson TX1 GPU regulator timings
Date:   Fri,  2 Aug 2019 11:35:10 +0200
Message-Id: <20190802092244.493486079@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
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
@@ -306,7 +306,8 @@
 			regulator-max-microvolt = <1320000>;
 			enable-gpios = <&pmic 6 GPIO_ACTIVE_HIGH>;
 			regulator-ramp-delay = <80>;
-			regulator-enable-ramp-delay = <1000>;
+			regulator-enable-ramp-delay = <2000>;
+			regulator-settling-time-us = <160>;
 		};
 	};
 };


