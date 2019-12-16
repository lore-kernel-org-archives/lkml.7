Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7AAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D372072D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519490;
	bh=nlCm/i/vz9gRTy1TTk/VR1vVaAHeSydTSN+G0wRG3vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R6r7FBtXWcr1yX+0DWIt9qm0DAeUBZpsSyxNup5/vxLbryGoTwyXpVQx+m2KoUI4g
	 MeVFzvyq7n8hQB9c4kREZcZRAA+UNeQAllDqxfG6tCr7He22pQwc0+rczH7TWC0Q6w
	 N7ShcuS0VBqFOC7UlnVXhwOaMeXyNlTmSFgZAQjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfLPSEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729706AbfLPSEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:04:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910CE20717;
        Mon, 16 Dec 2019 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519485;
        bh=nlCm/i/vz9gRTy1TTk/VR1vVaAHeSydTSN+G0wRG3vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1BjaWkzKq2f69un2Mjzlb38wAPTAlgNuU7Qnjrobh6beOu0q3DEY10WD6VIIzZix
         Nxl3Dc96XS3m9MzepdBI6xgK+XlFdrmVRe0I9dLS4MCfu1zBkIvF4TKGxKSj1hzUua
         wxO7Nk6bxuz0MUZ3IYEfAz8HdOT5rjyofiq69USY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.19 084/140] ARM: dts: omap3-tao3530: Fix incorrect MMC card detection GPIO polarity
Date:   Mon, 16 Dec 2019 18:49:12 +0100
Message-Id: <20191216174809.783706048@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@bitmer.com>

commit 287897f9aaa2ad1c923d9875914f57c4dc9159c8 upstream.

The MMC card detection GPIO polarity is active low on TAO3530, like in many
other similar boards. Now the card is not detected and it is unable to
mount rootfs from an SD card.

Fix this by using the correct polarity.

This incorrect polarity was defined already in the commit 30d95c6d7092
("ARM: dts: omap3: Add Technexion TAO3530 SOM omap3-tao3530.dtsi") in v3.18
kernel and later changed to use defined GPIO constants in v4.4 kernel by
the commit 3a637e008e54 ("ARM: dts: Use defined GPIO constants in flags
cell for OMAP2+ boards").

While the latter commit did not introduce the issue I'm marking it with
Fixes tag due the v4.4 kernels still being maintained.

Fixes: 3a637e008e54 ("ARM: dts: Use defined GPIO constants in flags cell for OMAP2+ boards")
Cc: linux-stable <stable@vger.kernel.org> # 4.4+
Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/omap3-tao3530.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -225,7 +225,7 @@
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
 	vqmmc-supply = <&vsim>;
-	cd-gpios = <&twl_gpio 0 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
 	bus-width = <8>;
 };
 


