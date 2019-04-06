Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C7C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B154020863
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDFPgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:36:21 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:26653 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfDFPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 11:36:21 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x36Fa5xY062795;
        Sun, 7 Apr 2019 00:36:05 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Sun, 07 Apr 2019 00:36:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x36Fa0B6062767
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 7 Apr 2019 00:36:05 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] arm64: dts: rockchip: fix cts, rts pin assign of UART3 for rk3399
Date:   Sun,  7 Apr 2019 00:35:57 +0900
Message-Id: <20190406153557.25930-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes pin assign of cts and rts signal of UART3.

Currently GPIO3_C2 and C3 pins are assigned but TRM says that
GPIO3_C0 and C1 are correct.

Refer:
  RK3399 TRM v1.4 - Table 19-1 UART Interface Description

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index f54c855f8cdf..196ac9b78076 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2543,12 +2543,12 @@
 
 			uart3_cts: uart3-cts {
 				rockchip,pins =
-					<3 RK_PC2 2 &pcfg_pull_none>;
+					<3 RK_PC0 2 &pcfg_pull_none>;
 			};
 
 			uart3_rts: uart3-rts {
 				rockchip,pins =
-					<3 RK_PC3 2 &pcfg_pull_none>;
+					<3 RK_PC1 2 &pcfg_pull_none>;
 			};
 		};
 
-- 
2.20.1

