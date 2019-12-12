Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491C9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2501F22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfLLN22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:28:28 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbfLLN20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:28:26 -0500
Received: from orion.localdomain ([77.9.34.244]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3Gok-1hfLzv0MEc-010PqN; Thu, 12 Dec 2019 14:28:25 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform: x86: pcengines-apuv2: detect apuv4 board
Date:   Thu, 12 Dec 2019 14:27:56 +0100
Message-Id: <20191212132756.23767-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:uYYbIXN6u977H9q2Z7ur9CNmsRycQWJnvxo7HOOu296jowcOUQq
 vWCwj+YdqYxO7l1Vv/pIsjvOLImJsIyZ0roYxGJrCZ18GVrGPYvidnwrQuPIZnNNOzHhSe7
 VsZriHCDsIzD7sqHNpTxdSTGYDMaAUgTlrwF5iKaL/ellvpiJuDQBptv+T861saiXljbUHa
 DuyFOH/WMnHQ1zXy86r9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pC0Z+e3jamc=:ufdPHa2HX7OwotodO9gCr3
 b33f6XAYXOkQ5tUALcFwY/U5kDslDf0dJ33SFXJs7PEfRlxt2zfRFkVH1pmW1f9aFS79JgHEH
 eHmvj/rOBd2/4L5I6hBFUtf2Srk0Ysb2cwQBCrzWTz8zLVpEPTxMc/T1Ntt0ptgw8QOKYDRHb
 yyT+H7VDCrcY4AFWqmk2iaR/uQn9m7NWNWEJQhj6csRqvbpOqI1hNOq36L3QHk81oVmcGRu65
 qkp7LN7HJbreCn+yKgyyI2EBRJBrafNlpPWKKtgfZ6pizphzb/eSBCcRncuKm8brW3ywPcI3t
 zR0OT1qrzMwSNg2rgn06dETVl8IPfoMoxpt+Fw+Fh7y7Il4bNigxM3ghaWDNqaop+o7QIQ2sg
 kJWzJq27cGtmBXfCHbwxj/6Q1jYgkVguYN0OybAGM7e82u3mmbu/Z13NB48wjPf+YOeBi22oL
 1pYiMK1vStL3PWmzX/ivhEmB/yL7Sq4TZn+bt7doS0mXe/9K+/dS/8bS05K+io1y+04jr9D6i
 kdvmAJeiIue92/pWZFaUAAodCE7j6mnp8Vb3PXc3bxmx0a7TJPh/uBje0BdX1mcuFtosdpeDn
 yZ5iyNPkHfgLf33IVENaRNjjoQQp66ldKlBF26EgLDtH47M0pCkinxEqIG8sn3vvdA2Yf8Dou
 b4jOYSOrWXxSMuODwRq5tt9m4E3eU5UxZLeez7oH48P9wf7kgLiT4R0xKoVfIez6Rzx+Aqohy
 3+q/G7YQKEasMJwr/cnbW+y885aRl4mz2Sm6SicIFtrTnUwNvDZWRWzEpgIYqA6REpJHpv/xk
 BjiqrYUgTHfRxXb5kayDmCcUFR/7+p+PYLNjG5wtt1hvQVXz3rl5JYdJnZNvkJdbKhDTjitKJ
 mJPD8fMO8YecZwLHbMxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO stuff on APUv4 seems to be the same as on APUv2, so we just
need to match on DMI data.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/platform/x86/pcengines-apuv2.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index 48b112b4f0b0..49f25bffce3c 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -189,6 +189,33 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 		},
 		.driver_data = (void *)&board_apu2,
 	},
+	/* APU4 w/ legacy bios < 4.0.8 */
+	{
+		.ident        = "apu4",
+		.matches    = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU4")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
+	/* APU4 w/ legacy bios >= 4.0.8 */
+	{
+		.ident       = "apu4",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu4")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
+	/* APU4 w/ mainline bios */
+	{
+		.ident       = "apu4",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu4")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
 	{}
 };
 
-- 
2.11.0

