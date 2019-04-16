Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367A320693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfDPMZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:25:24 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:25:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mpkwn-1gUhzM1wir-00q8ZO; Tue, 16 Apr 2019 14:25:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sun6i-prcm: fix build warning for non-OF configurations
Date:   Tue, 16 Apr 2019 14:24:59 +0200
Message-Id: <20190416122506.3180853-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uXt/bVk7UTlZHOx7EaNNOcd19LgXvMFy/q7rIR2NeYH3g+eBN47
 iVj22SmLi34fvCBHRZE/yVS8mP1GRXu+Iy/YdkF8BbAlh7sgVOy7ZLKTLRmzTpy6TZhT6GF
 JuWhI3sIkK1PYsWhhuWcXjxhRaqPqTcOQ37mJaFLcvfcDKRqyBwD+Gilc2ZFKHp+Jf4Ugou
 LS3zqEuOdibC1sdbrU+Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n2VucTqvRDQ=:V8AVL2eVTQrJ2oHu6N7SOo
 mC2DoPUWc4toGE4L6YtWz73DFiFNNXIQGkC9gBCVil0dPdHu99V7sqsjU1gwD7Nm7K8/UZzL6
 8jH4drfoXx0UotQ6tzhd/YK6jIwDKdpfC8ImBEYdg+b+mA6USYSj/VvotelqkkHY0L2gpLyxL
 dZCl7qSKqrmPw2mO8Y13p4WUBq6HRXT+QdWZsJQiL12o5ucw3Ig20HEBnNviVgat/bKMplDm4
 MTdUKdC3Lk71L8bXgVonPe80qtrheX3UIV/5PfqJ2abBMG1/qcPNnGLFrEHY5PhLrr+75gWKY
 o00dyEU+ZlVn0/7UE6JDRetCLN0GVAj47ZnvvEE+jqCcPw3wZL/QBUhPNNMPaPDl/n0UOR1sZ
 TXOHnJXSmoHcHiCCG7lbntd+aqDxBULBAjNuEaZsyhHTdaiKqB1I6ONGq2xID5BP3rx7snH6E
 g2nKp3FtbN6Uolm8XxtyF1R1hQHCKfJfC+baVHziFS6E/9vzYMvJWICZ8iBF5XZ8Xu1mfx1op
 N3jkfU9HFoNBw9nKY1xJNg4TxdxN2hgSIw2BbeiAco7skt1SBdFlayZdFlBfxjT+BEmihHLnh
 EoHF99FlQ36K3HhLmlxcBj3GHJPGc/eH6HdmF8raOXWkFUQK9HE8jfjDrs4JXNgmLFPaLGMui
 dh7lv4F+B/FPTE98eFFdDfxiMtvfjIEPET5H45eTqYyUgjZ60+WUMwInst8snKnS9NssHpHOK
 BtY9oUaA56T/Q8Urp3KlQTS9QSf0mlHHIPYN1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF is disabled, we get a harmless warning about an
unused variable:

drivers/mfd/sun6i-prcm.c: In function 'sun6i_prcm_probe':
drivers/mfd/sun6i-prcm.c:151:22: error: unused variable 'np' [-Werror=unused-variable]

Remove the variable and open-code the value in the only place
it is used, so it can get left out as well without CONFIG_OF.

Fixes: a05a2e7998ab ("mfd: sun6i-prcm: Allow to compile with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/sun6i-prcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index 2b658bed47db..2f12a415b807 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -148,13 +148,12 @@ static const struct of_device_id sun6i_prcm_dt_ids[] = {
 
 static int sun6i_prcm_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
 	const struct prcm_data *data;
 	struct resource *res;
 	int ret;
 
-	match = of_match_node(sun6i_prcm_dt_ids, np);
+	match = of_match_node(sun6i_prcm_dt_ids, pdev->dev.of_node);
 	if (!match)
 		return -EINVAL;
 
-- 
2.20.0

