Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86979C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5290F24654
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576076896;
	bh=jsS+mafvUDdazFn243kdG/M6SPwWy7C9orpXvZRhJUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XoKDVWq8VsvdZ6334pN9I9Jh/09RPVV2FHJv2DURapcCY5c9MJx/utAQl5el0/2kK
	 m6DgHRSNp5pSFZH44foM+mF8egD6Jy9wBStYRKnFt9pYIHaWKKqSQKayHJi8Y4tNBx
	 eskAb68j2m9Y6X6JGBwL38QITWAXCq8Ort7Fajd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfLKPIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbfLKPIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:08:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B022173E;
        Wed, 11 Dec 2019 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076892;
        bh=jsS+mafvUDdazFn243kdG/M6SPwWy7C9orpXvZRhJUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUJjvpBNROHoVT2G4ZQjlyEcQgBsM24aC2aRTa1Pu1k4y3LgalnyWQZHqKnc8Kakl
         2otBtPj3J5k+P6eiQgc6+ZBgk3qS6NBY0aob26bMiCl9CHfiaFrboC30kDNIvrxF6A
         tn1z7apFSWjBamib6EFnaJcEUzx8UXEjAgBzP2WE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.4 03/92] arm64: tegra: Fix active-low warning for Jetson Xavier regulator
Date:   Wed, 11 Dec 2019 16:04:54 +0100
Message-Id: <20191211150222.702353122@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

commit d440538e5f219900a9fc9d96fd10727b4d2b3c48 upstream.

Commit 4fdbfd60a3a2 ("arm64: tegra: Add PCIe slot supply information
in p2972-0000 platform") added regulators for the PCIe slot on the
Jetson Xavier platform. One of these regulators has an active-low enable
and this commit incorrectly added an active-low specifier for the GPIO
which causes the following warning to occur on boot ...

 WARNING KERN regulator@3 GPIO handle specifies active low - ignored

The fixed-regulator binding does not use the active-low flag from the
gpio specifier and purely relies of the presence of the
'enable-active-high' property to determine if it is active high or low
(if this property is omitted). Fix this warning by setting the GPIO
to active-high in the GPIO specifier. Finally, remove the
'enable-active-low' as this is not a valid property.

Fixes: 4fdbfd60a3a2 ("arm64: tegra: Add PCIe slot supply information in p2972-0000 platform")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -309,9 +309,8 @@
 			regulator-name = "VDD_12V";
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
-			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 1) GPIO_ACTIVE_LOW>;
+			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 1) GPIO_ACTIVE_HIGH>;
 			regulator-boot-on;
-			enable-active-low;
 		};
 	};
 };


