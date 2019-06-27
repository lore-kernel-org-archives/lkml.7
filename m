Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D421C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B17A21738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595428;
	bh=jJl5kpA+E32dBal3DNwg0dA7AW6IVwSm/fbfo6drkYw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oBKIQm8049dqo9SZEZULSaGD3pxS6v7knXJvWdiYp9/LzAvdoHcNGuXGAhePJYrCb
	 qtTA/dLZOtiQBnUqzcZICOOyG/ELjKco5SmCMNic5lPhmOCe/q3dSJEqv3mWQnHF4x
	 0UxYTgefBD8f/CvbcVZYHsDqpOa/vllB7ID0M1TA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfF0Aa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfF0Aa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:30:26 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CAE2083B;
        Thu, 27 Jun 2019 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595426;
        bh=jJl5kpA+E32dBal3DNwg0dA7AW6IVwSm/fbfo6drkYw=;
        h=From:To:Cc:Subject:Date:From;
        b=d5IdQFqP2sUpqxxv28WzsyYTCaHZcFTQ3srQ7jjMmSu2EbFNRELYaBglP6P1Js++4
         /nma/Rgo1A43IGZASrqbJSt+fPsoPmTi35/Z19UGKpmO1fbs4k8qavlLe3c0lcNvZl
         OyApoPB4KmySijwQZRS41wbIMq0qHHCKiWhk8xx8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 01/95] ARM: dts: dra76x: Disable rtc target module
Date:   Wed, 26 Jun 2019 20:28:46 -0400
Message-Id: <20190627003021.19867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit f7b9cb944a5d41fdede4e928a47e9d5fce5169d7 ]

rtc is fused out on dra76 and accessing target module
register is causing a boot crash hence disable it.

Fixes: 549fce068a3112 ("ARM: dts: dra7: Add l4 interconnect hierarchy and ti-sysc data")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 2 +-
 arch/arm/boot/dts/dra76x.dtsi  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 414f1cd68733..73f5c050f586 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3543,7 +3543,7 @@
 			};
 		};
 
-		target-module@38000 {			/* 0x48838000, ap 29 12.0 */
+		rtctarget: target-module@38000 {			/* 0x48838000, ap 29 12.0 */
 			compatible = "ti,sysc-omap4-simple", "ti,sysc";
 			ti,hwmods = "rtcss";
 			reg = <0x38074 0x4>,
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 9ee45aa365d8..5c437271d307 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -81,3 +81,7 @@
 		reg = <0x3fc>;
 	};
 };
+
+&rtctarget {
+	status = "disabled";
+};
-- 
2.20.1

