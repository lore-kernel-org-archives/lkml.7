Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BF3C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D3821920
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962535;
	bh=hvtDhhqWcaPuoAZSU01O0kZ/YMcq6KIZtAyMTXVUexQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CTHH/Ts7GPSqxKcHHmNKMxqPSVPZ3N6jsbbhAIP75CP5DJMKl/OPjLVoVVi4mwXff
	 hftocVF/I3Mt2pfQ6dfnqj79j6u0aCErhsv3oqDUkWOQ9mvp7uV/CENerhCPxSCXvo
	 HaOxv807y5WspccGhgel1xDyXcYS5vI6n1q2Cwr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfDVTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbfDVTsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93EDF21907;
        Mon, 22 Apr 2019 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962530;
        bh=hvtDhhqWcaPuoAZSU01O0kZ/YMcq6KIZtAyMTXVUexQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DSzWiKrYv6S67WyxSd5ihExiN8EzCgc/phHZwbE2SepN8xWCjBUIOillAydMTI3aP
         mWxE0OqLBsN/LuHE7lcODMO+uxu2Kdkh7O7LkbFV8J3dXAHab35CQjmWwHeSADFoHd
         9uB4KbqRecS6UN7zDzVtPFae8QcYAKm9K1JdwMlQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helen Koike <helen.koike@collabora.com>,
        Eric Anholt <eric@anholt.net>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/29] ARM: dts: bcm283x: Fix hdmi hpd gpio pull
Date:   Mon, 22 Apr 2019 15:48:20 -0400
Message-Id: <20190422194848.13049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

[ Upstream commit 544e784188f1dd7c797c70b213385e67d92005b6 ]

Raspberry pi board model B revison 2 have the hot plug detector gpio
active high (and not low as it was in the dts).

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Fixes: 49ac67e0c39c ("ARM: bcm2835: Add VC4 to the device tree.")
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 84df85ea6296..7efde03daadd 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -26,5 +26,5 @@
 };
 
 &hdmi {
-	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
 };
-- 
2.19.1

