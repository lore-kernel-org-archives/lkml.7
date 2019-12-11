Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC988C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2D24671
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077391;
	bh=ATFsUaYlhEkZu6e7CBBYEk7GWFdSEEHIXtJl23rL5lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eSy5rC/6+UDGPz+uuOHCKmp1uJdqlwEpHNRcPazs30oDfV4fA97Ky0KSqhhVR92Cc
	 ltCmA2dJCrb7GIOs2ef0H6f4q8cyyXDBuxFQdPJ12AYPguMm5Zmu90fLUOajugBn4O
	 D7nfFXFiMFToSKegvrozGjOiG3MglFeuY/VC44SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfLKPQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:16:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731607AbfLKPQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:16:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E3922B48;
        Wed, 11 Dec 2019 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077385;
        bh=ATFsUaYlhEkZu6e7CBBYEk7GWFdSEEHIXtJl23rL5lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ej+8G7dbSyth3op0RJODra4lGTbK300yquophCfSl4nnE5OxPd7WwsH8qDvVbGhkZ
         Go+PfpDqzO7hGaG/FSQqzBNp0yska9KSc64yNQlzmY9m7onf5VUILoLPuUSKjjXwfx
         h/HfLRxw8N66M4vP8vAvkEMPAG1n0zXGFcMcfjOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.19 002/243] arm64: tegra: Fix active-low warning for Jetson TX1 regulator
Date:   Wed, 11 Dec 2019 16:02:44 +0100
Message-Id: <20191211150339.319676132@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

commit 1e5e929c009559bd7e898ac8e17a5d01037cb057 upstream.

Commit 34993594181d ("arm64: tegra: Enable HDMI on Jetson TX1")
added a regulator for HDMI on the Jetson TX1 platform. This regulator
has an active high enable, but the GPIO specifier for enabling the
regulator incorrectly defines it as active-low. This causes the
following warning to occur on boot ...

 WARNING KERN regulator@10 GPIO handle specifies active low - ignored

The fixed-regulator binding does not use the active-low flag from the
gpio specifier and purely relies of the presence of the
'enable-active-high' property to determine if it is active high or low
(if this property is omitted). Fix this warning by setting the GPIO
to active-high in the GPIO specifier which aligns with the presense of
the 'enable-active-high' property.

Fixes: 34993594181d ("arm64: tegra: Enable HDMI on Jetson TX1")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1589,7 +1589,7 @@
 			regulator-name = "VDD_HDMI_5V0";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&exp1 12 GPIO_ACTIVE_LOW>;
+			gpio = <&exp1 12 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 			vin-supply = <&vdd_5v0_sys>;
 		};


