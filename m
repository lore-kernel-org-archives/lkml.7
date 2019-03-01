Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78346C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3868E20838
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="TJw38H65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbfCAH1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:27:04 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:38841 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCAH1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:27:03 -0500
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 413DFA36C8;
        Fri,  1 Mar 2019 08:27:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1551425222;
        bh=U0/CXybEquAYKSj4JpuTOuLjIaDciCa3HJX7Q0eaTLw=;
        h=From:To:Cc:Subject:Date:From;
        b=TJw38H653y+kIxfMhNYhyk8GW5zDzsZzzmZWckW+V4ZCAEObbcRhYzM3m+BdOyq+f
         kfL+BVOo3sjXNUMbVtRODoGHwrfoCXUmjcJmeE5noxHxX5IunVyi3Jkb6HotlXkhmF
         a5CUkzApBKAU9ncwq/cjwNkMkJTIhJHzFgc6sFRY=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2] ARM: dts: imx6dl-yapp4: Use rgmii-id phy mode on the cpu port
Date:   Fri,  1 Mar 2019 08:26:42 +0100
Message-Id: <1551425202-8871-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rgmii-id phy mode for the CPU port (MAC0) of the QCA8334 switch
to add delays to both Tx and Rx clock.

It worked with the rgmii mode before because the qca8k driver
(incorrectly) enabled delays in that mode and rgmii-id was not
implemented at all.

Commit 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode")
removed the delays from the RGMII mode and hence broke the networking.

To fix the problem, commit a968b5e9d587 ("net: dsa: qca8k: Enable delay
for RGMII_ID mode") was introduced.

Now the correct phy mode is available so use it.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes in v2:
 - Reworded commit message - added more details regarding the issue.

 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index b715ab0fa1ff..091d829f6b05 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -125,7 +125,7 @@
 				ethphy0: port@0 {
 					reg = <0>;
 					label = "cpu";
-					phy-mode = "rgmii";
+					phy-mode = "rgmii-id";
 					ethernet = <&fec>;
 
 					fixed-link {
-- 
2.1.4

