Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E350DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68A92183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfCVPpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:45:39 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfCVPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:45:38 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MIMT4-1hAiPn1nlM-00EKiE; Fri, 22 Mar 2019 16:45:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Tobin C. Harding" <me@tobin.cc>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 03/25] mmc: pwrseq_simple: Make reset-gpios optional to match doc
Date:   Fri, 22 Mar 2019 16:43:54 +0100
Message-Id: <20190322154425.3852517-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pXc1FdV5baiz8nobVE1STGDw+yPyuO8D5aCB7/njBTG3bn2KmqX
 B54PkMpx2O48DEyo0oTsTQh2OqB99IvxhcqDqcLvpXZfvWcMbXb7DI02DPEHVMTHsR3zJAE
 C9EHBZBp/8tdh65r5gU1/Y/445Fw9vYXoq0ruLJnN8yeCxvQTazXKptL+lHAGGDfU2I1jOn
 mHrJNqxoVwc9g9fUUdmAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9vy6Ber0Rw=:2FHa5XeVUadCz07UFhhK8Q
 N0/0jVYWsP57lD454t4yBp3B0pMSi49Qhk91shLAA0gYXRziF7WzAhFGZb8HRpnLhzNG4Cy+p
 EKK9kGmm++e9Okqii/UqYDRyl9vm0sKbxeqnmPnsdfT5czujW9EtFnxBIwJ20d/3Kr6sP9Oqz
 ejEcFBLcob/fe69f6SA7rpv3leb9mBpLXoIh/RPAtkMqVbnU6nBasI6dgLbHHM+K/NBk+HuCR
 E8jfZOCpMhzGG74+M1flAByPNFDF0PZA0F4mNOM2XbjXwn9YX1TWgu/5rTBVnkX8YYwTo96Yw
 E/oMPXjPgR4WPml1T1N/RmMq/mMTcYN2+N6iVLgeaN0vIJ2xxM1rSp4DuQ+RdJuGDSZwgkc9a
 7uYaCoeJHIBUq8jHP4+l4t5pvLDeefD0MbhLW/A/aSR+xjy98khe4K9+kjQhsKZ4zebaQHxut
 i1HPbQ7bPD6NhpL4xGIRAlHLnzSsEZsX/dG/KtOh/r1ehU4E4LrrBV0Uy32Cn83jipe5kNwfG
 JlML2T7xhU9LFYSG28pYJxJskHtCjgaqNtp7QllVwgSC6tRjaaQ2MAYC3dXy1brfzTGR3GIbi
 4MU/u9CVT3iJVKShy2+1D5xr6DRX3UU3or2zQO+K/eZQ0Cmdxi85UYebUTr59mnuTpY2TGDWA
 lg2xDtZxAWmh6bXSVxvzlALJBRO3lhFYTgAXkslDkiVvOIe0HEj1d31AWGsDSaR7bsb1pN/R8
 e3Lu5RZUO9igX40C8mSYHLWqDsc4sR2Hk1eigw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Fuzzey <mfuzzey@parkeon.com>

The DT binding doc says reset-gpios is an optional property but the code
currently bails out if it is omitted.

This is a regression since it breaks previously working device trees.
Fix it by restoring the original documented behaviour.

Fixes: ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 64a67d4762ce3ce4c9466eadd152d825fbf84967)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/pwrseq_simple.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 2b16263458af..aba786daebca 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -29,15 +29,18 @@ struct mmc_pwrseq_simple {
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 					      int value)
 {
-	int i;
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
-	int values[reset_gpios->ndescs];
 
-	for (i = 0; i < reset_gpios->ndescs; i++)
-		values[i] = value;
+	if (!IS_ERR(reset_gpios)) {
+		int i;
+		int values[reset_gpios->ndescs];
 
-	gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
-				       values);
+		for (i = 0; i < reset_gpios->ndescs; i++)
+			values[i] = value;
+
+		gpiod_set_array_value_cansleep(
+			reset_gpios->ndescs, reset_gpios->desc, values);
+	}
 }
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
@@ -79,7 +82,8 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
-	gpiod_put_array(pwrseq->reset_gpios);
+	if (!IS_ERR(pwrseq->reset_gpios))
+		gpiod_put_array(pwrseq->reset_gpios);
 
 	if (!IS_ERR(pwrseq->ext_clk))
 		clk_put(pwrseq->ext_clk);
@@ -112,7 +116,9 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
 	}
 
 	pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(pwrseq->reset_gpios)) {
+	if (IS_ERR(pwrseq->reset_gpios) &&
+	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
+	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
 		ret = PTR_ERR(pwrseq->reset_gpios);
 		goto clk_put;
 	}
-- 
2.20.0

