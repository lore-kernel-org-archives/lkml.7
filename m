Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAD0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7352920715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574400621;
	bh=32RnjBQhpMMpcnJsfK6ZgNHLIRuZH059M6OSVlzGlZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PRpVcXE19JP9Pjyd5q1/yBNwbAs7OEH90b/fPW0TRCm9rct48mLtvf8Pl8vofl/TP
	 BeNCJOQ9pnXZann8YmmoxUhLyr+xwTeBtZhVS9lcGszMrOKt+j9ZED8FDpzSlubEbC
	 inj0OqEGA+l29jrF5z3owzyBEvYSdWVyoMirv+B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfKVFaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKVFaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:30:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AAFF2070B;
        Fri, 22 Nov 2019 05:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574400615;
        bh=32RnjBQhpMMpcnJsfK6ZgNHLIRuZH059M6OSVlzGlZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vfR2+jZgMP0JgSMthjns2AMcou/KvrSPupyqxoxUfH2UfbbqTCHCFz7+f7Ii6s1q
         2fEd/qqdiw9UIgLUSC1E+fFZIHvLsMlEnxPiL17Rs2wgTEgjJ7IBXtK8AK0GVxwaEP
         TFJzcF3iA7TimhzKGIVacwmzBtrrIfFaBJ7IzC5U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 016/219] ARM: dts: imx50: Fix memory node duplication
Date:   Fri, 22 Nov 2019 00:26:38 -0500
Message-Id: <20191122053001.752-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122053001.752-1-sashal@kernel.org>
References: <20191122053001.752-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit aab5e3ea95b958cf22a24e756a84e635bdb081c1 ]

imx50-evk has duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx50.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx50-evk.dts | 1 +
 arch/arm/boot/dts/imx50.dtsi    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 682a99783ee69..a25da415cb02e 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -12,6 +12,7 @@
 	compatible = "fsl,imx50-evk", "fsl,imx50";
 
 	memory@70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index ab522c2da6df6..9e9e92acceb27 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -22,10 +22,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
-- 
2.20.1

