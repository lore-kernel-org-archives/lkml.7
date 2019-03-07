Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDF9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C23520851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCGK0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:26:38 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:37721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfCGK0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:26:37 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1JJC-1h4bO90XEY-002sbN; Thu, 07 Mar 2019 11:26:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: da903x: don't build with clang
Date:   Thu,  7 Mar 2019 11:26:02 +0100
Message-Id: <20190307102630.1281128-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5JOSTbMkOxCILg/7zsBphxG2ETMzvQVil/SS8LR2ZYDBP3yKxxy
 Klww+zCm+V5bgf2CgYSW170zoHMbw42Cv6rf0nxYkUkSZd0rftBYkbGAyiwxNn/7/ae0Nqa
 gYdk3OnXuTJORsncjbMMoWpurbR/UPVmdo6FV9qVtFARvKKTDbdnbbBTpXOXBzHCr0RihPS
 DC08VFXBtquKeuPOZgaJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RKVKqadit/Y=:3RHGXPNB4/S4bP4cgNovXB
 D3DpCwCmdEMAlAfpgotflDxboQw+ZffOUUfWmiD+2WxKQtnz6lN8xfTTEEAj+74wmJYKqrddD
 SN1qlF4Zf1XQHmRr6C8GRBmgpuKVAZFR9b11j0ekbQOpf7XYB++ez+Pj4p0ylJijpn7+T1olz
 IsBD1fFZBWlq70m9KdzqXKWfmTWry8W/pLgU+vNjaEF65tRsZ0w4ZA4+ukMLagrG12jJ1Rs+R
 ryteVgC10T6FRBbylE2BPJzDV3B06TUqayLR3UAwGhoObBZjf53llCoNG2X97URon3GWE5Jd2
 Vfep4eFq8gA16kz/TWM/h8ne4eCEBeOQnvgTBDAx+T5ZradVk256F267oWH17InlWwsHJg5Ph
 +zY9iS3yPErn7y/A7IHJbO4E2SIHE45E63a61LxXITwbQqUj0lC2r9J51N9kwV6jOkNtfemD/
 KQF0h9cowFFh3uQkSVM9GJfjAyTJsDpmOgHeGkaJdEVHLZ0mzQ5PaLKZzldw9nSS5lOweyM08
 YSB3HFPmXC2iXb+F6rGt6IpEHsxZB3s+sVdayNG2CTrAwJs92nxryYJSy2/FFTuMNF1AdmFFH
 SsL/8TlD6YAqw+M3HOC4qsiWt0p+za/dbB/jBGJ8GsjJmeT6XmLjtAy7GerxH93DHOINK+QMg
 NkuU8VHFR+8BLP0ghsTBy82Z461jXXDkX4UtUfH1PmefEdIF64tU9gqC6NjGcuiW0G8BUdVdW
 ZeG+f2l5ZDsFIvzp+5IZphqiyx1sdKlqCusjIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The da903x driver produces an annoying false-positive warning
when built with clang:

drivers/regulator/da903x.c:395:2: error: division by zero is undefined [-Werror,-Wdivision-by-zero]
        DA9030_LDO(13, 2100, 2100, 0, INVAL, 0, 0, RCTL11, 3), /* fixed @2.1V */
        ^                          ~
drivers/regulator/da903x.c:359:2: note: expanded from macro 'DA9030_LDO'
        DA903x_LDO(DA9030, _id, min, max, step, vreg, shift, nbits, ereg, ebit)
        ^                                 ~~~~
drivers/regulator/da903x.c:320:39: note: expanded from macro 'DA903x_LDO'
                .n_voltages = (step) ? ((max - min) / step + 1) : 1,    \
                                                    ^ ~~~~
drivers/regulator/da903x.c:415:2: error: division by zero is undefined [-Werror,-Wdivision-by-zero]
        DA9034_LDO(5, 3100, 3100, 0, INVAL, 0, 0, OVER3, 7), /* fixed @3.1V */
        ^                         ~
drivers/regulator/da903x.c:356:2: note: expanded from macro 'DA9034_LDO'
        DA903x_LDO(DA9034, _id, min, max, step, vreg, shift, nbits, ereg, ebit)
        ^                                 ~~~~
drivers/regulator/da903x.c:320:39: note: expanded from macro 'DA903x_LDO'
                .n_voltages = (step) ? ((max - min) / step + 1) : 1,    \
                                                    ^ ~~~~

I already reported this as a bug in clang, but it may take a
while to fix it. As I have not been able to come up with any
reasonable workaround, I would just disable compilation here.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b7f249ee5e68..6d2651cd9887 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -223,6 +223,7 @@ config REGULATOR_CPCAP
 config REGULATOR_DA903X
 	tristate "Dialog Semiconductor DA9030/DA9034 regulators"
 	depends on PMIC_DA903X
+	depends on !CC_IS_CLANG # https://bugs.llvm.org/show_bug.cgi?id=38789
 	help
 	  Say y here to support the BUCKs and LDOs regulators found on
 	  Dialog Semiconductor DA9030/DA9034 PMIC.
-- 
2.20.0

