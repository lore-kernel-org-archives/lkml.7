Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A91C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0060B20665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522247;
	bh=hfi/4GbU4kNHzerw7NGabh5F2RnawJTJAI4w2HXp5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IKz09gw2BMFQl/nA6s3K4Ji54mElEKaEAwLE8M7e1QxvJ0pyOTeMT7LZMGlyL7FmV
	 MhOz0BUTRVsVkPMAxZPCjZtNfehsGafXxSFfzcy3KxxKMt9fytM0DQy1xac+M7sS+J
	 xh78yiKe4F3acK6dWe/mFvg8epZ4CZ/oVQoO1zpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLPRvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfLPRvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:51:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E42812072D;
        Mon, 16 Dec 2019 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518668;
        bh=hfi/4GbU4kNHzerw7NGabh5F2RnawJTJAI4w2HXp5Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlXRu0oaIf6s97mmDdQkISyKqfulAgA5oMvxsp8DnqQaNK1vfQkBR85ZdCxlvQy/D
         Erov7T4SfY/wfJ5sr7fj3IZzjT1mcPdjwYu4csQJm81rVixgqHK4Bi55MMQy8dZABK
         VyoHRpwu0luophK3lL4CSX2m9yv4V2+uWXbYqsfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.14 002/267] arm64: tegra: Fix active-low warning for Jetson TX1 regulator
Date:   Mon, 16 Dec 2019 18:45:28 +0100
Message-Id: <20191216174849.000350424@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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
@@ -1584,7 +1584,7 @@
 			regulator-name = "VDD_HDMI_5V0";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&exp1 12 GPIO_ACTIVE_LOW>;
+			gpio = <&exp1 12 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 			vin-supply = <&vdd_5v0_sys>;
 		};


