Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6A5C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95CC20863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfCCM1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:27:25 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:27563 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCCM1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:27:25 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x23CR9XT064824;
        Sun, 3 Mar 2019 21:27:09 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sun, 03 Mar 2019 21:27:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x23CR61p064800
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 3 Mar 2019 21:27:09 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] arm64: dts: rockchip: decrease rising edge time of UART2
Date:   Sun,  3 Mar 2019 21:27:05 +0900
Message-Id: <20190303122705.27094-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch increases drive strength of UART2 from 3mA to 12mA for
getting more faster rising edge.

RockPro64 is using a very high speed rate (1.5Mbps) for UART2. In
this setting, a bit width of UART is about 667ns.

In my environment (RockPro64 UART2 with FTDI FT232RL UART-USB
converter), falling time of RockPro64 UART2 is 40ns, but riging time
is over 650ns. So UART receiver will get wrong data, because receiver
read intermediate data of rising edge.

Rising time becomes 300ns from 650ns if apply this patch. This is not
perfect solution but better than now.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index beaa92744a64..e3c8f91ead50 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2000,6 +2000,11 @@
 			drive-strength = <8>;
 		};
 
+		pcfg_pull_up_12ma: pcfg-pull-up-12ma {
+			bias-pull-up;
+			drive-strength = <12>;
+		};
+
 		pcfg_pull_up_18ma: pcfg-pull-up-18ma {
 			bias-pull-up;
 			drive-strength = <18>;
@@ -2521,8 +2526,8 @@
 		uart2c {
 			uart2c_xfer: uart2c-xfer {
 				rockchip,pins =
-					<4 RK_PC3 RK_FUNC_1 &pcfg_pull_up>,
-					<4 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC3 RK_FUNC_1 &pcfg_pull_up_12ma>,
+					<4 RK_PC4 RK_FUNC_1 &pcfg_pull_none_12ma>;
 			};
 		};
 
-- 
2.20.1

