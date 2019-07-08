Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4452C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0452086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfGHMn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:43:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfGHMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:43:26 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N9Mh8-1iY7ev3NFE-015Mij; Mon, 08 Jul 2019 14:43:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: stm32: fix building without ARM SMCC
Date:   Mon,  8 Jul 2019 14:42:51 +0200
Message-Id: <20190708124311.3448056-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AkGDgfgp15g2CwVR7Facqvx2UQWGiD85o226q8pCrj+7T3ngYhv
 IfLF3dxuiyn7foiSJbI+CjDMOWeNFw4kgugGEH9s7CEP/ITyLDc0js2XWpv06vcn8jwcVdi
 htFSeTonIiSmWhiJ6NokkctrmpdXI6ajXctroI5KnraqIYGMuHO339AkvcR2SGhILxsSPPp
 oXbARlZOVAkKCNuffxW2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NOG3AWT7dhY=:I1yuk6/XhruMMQoRCnVKYH
 Dprmazilp2kNoyya7NhsRMMlH3fEEHyN+t7vYmASH7wZsnO8z9QnyNDYZD8PoF3PYbRSudiJr
 beYiBGXOaQDkiZAklGiIcNdrspzn35663iyk0GQfGE9iK7UrGgJIHznTWOtzrtjtNLGhAYLRr
 vVp1P2qtvMpmIk01cKQUB4BMDTDMHGU7IkkZHt+PtfqbkJD4ZqaPyNwpAKBnnFtEHJThM/rOc
 mTKdXDWuUc0e8XsvFrwD8FN+5L4eBVlO0fkt2Bj8deLez+mlSgC75Bk++RkbBTAXKgtqYwlj5
 4Ir7mGd2pIZRTZk1Hyb5EKQdvhWXWClUp2sRj1lKVTQ5wBq2zhdk63UKWUmr16rgK+CdZZteb
 XEKXOIEAfhTry3H0vfA8bm8WyJy4ZaJF7vFLzmxLit52Lt73TE9XN6giBVvGYS+hdoNcbNm3C
 GCDm3qZZYwx9kM2wq/NoJE3S7283goKM3I7NfeaNIzon+gR9SQCxDQIE1OJOvrIPulXpjd51R
 0tUD9uoBueidEyEuuoRo+70FeDZZgh+PxOSgJFtOFxfS25GLarZZN5Ezaq+wacrZQ4DVFqZ8S
 kmm1yamO+hiwkGBvfEC17KEgSZoRmfRDrGYdwG1X842K8zQCkf/Yrxw5PaPEQMtlk28+F2Qie
 Clb7hFMAFS8EayWbwBwUwmuGm8WCiTDZ+uff7WLeLLuCyLgm+yfCb2YL/PGJrq56E4kUi6UcY
 asXjZrOREjS+2fK2M//YtVvqIQpUbo66EFHOQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compile testing this driver without SMCC support enabled,
we get a link error:

drivers/remoteproc/stm32_rproc.o: In function `stm32_rproc_start':
stm32_rproc.c:(.text+0x776): undefined reference to `__arm_smccc_smc'
drivers/remoteproc/stm32_rproc.o: In function `stm32_rproc_stop':
stm32_rproc.c:(.text+0x92c): undefined reference to `__arm_smccc_smc'

Make the actual call to arm_smccc_smc conditional on the Kconfig
symbol controlling its implementation.

Fixes: 13140de09cc2 ("remoteproc: stm32: add an ST stm32_rproc driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index e83077b9ebf5..e2da7198b65f 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -344,7 +344,7 @@ static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
 
 	val = hold ? HOLD_BOOT : RELEASE_BOOT;
 
-	if (ddata->secured_soc) {
+	if (IS_ENABLED(CONFIG_HAVE_ARM_SMCCC) && ddata->secured_soc) {
 		arm_smccc_smc(STM32_SMC_RCC, STM32_SMC_REG_WRITE,
 			      hold_boot.reg, val, 0, 0, 0, 0, &smc_res);
 		err = smc_res.a0;
-- 
2.20.0

