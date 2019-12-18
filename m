Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE875C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9EA2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLRKQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:16:59 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:60630 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbfLRKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 05:16:59 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihWO0-00073q-Sq; Wed, 18 Dec 2019 10:16:56 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1ihWO0-00AFWW-Cp; Wed, 18 Dec 2019 10:16:56 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     ben.dooks@codethink.co.uk
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@axis.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: artpec6: fix __iomem on reg in set
Date:   Wed, 18 Dec 2019 10:16:02 +0000
Message-Id: <20191218101602.2442868-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The artpec6_pconf_set should have marked reg as __iomem,
 which ends up making sparse complain about address
space conversions. Add the __iomem to silence the
following warnings:

drivers/pinctrl/pinctrl-artpec6.c:814:13: warning: incorrect type in assignment (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:814:13:    expected unsigned int *reg
drivers/pinctrl/pinctrl-artpec6.c:814:13:    got void [noderef] <asn:2> *
drivers/pinctrl/pinctrl-artpec6.c:825:34: warning: incorrect type in argument 1 (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:825:34:    expected void const volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-artpec6.c:825:34:    got unsigned int *reg
drivers/pinctrl/pinctrl-artpec6.c:827:25: warning: incorrect type in argument 2 (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:827:25:    expected void volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-artpec6.c:827:25:    got unsigned int *reg
drivers/pinctrl/pinctrl-artpec6.c:837:34: warning: incorrect type in argument 1 (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:837:34:    expected void const volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-artpec6.c:837:34:    got unsigned int *reg
drivers/pinctrl/pinctrl-artpec6.c:840:25: warning: incorrect type in argument 2 (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:840:25:    expected void volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-artpec6.c:840:25:    got unsigned int *reg
drivers/pinctrl/pinctrl-artpec6.c:850:34: warning: incorrect type in argument 1 (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:850:34:    expected void const volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-artpec6.c:850:34:    got unsigned int *reg
drivers/pinctrl/pinctrl-artpec6.c:853:25: warning: incorrect type in argument 2 (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:853:25:    expected void volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-artpec6.c:853:25:    got unsigned int *reg
drivers/pinctrl/pinctrl-artpec6.c:864:34: warning: incorrect type in argument 1 (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:864:34:    expected void const volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-artpec6.c:864:34:    got unsigned int *reg
drivers/pinctrl/pinctrl-artpec6.c:867:25: warning: incorrect type in argument 2 (different address spaces)
drivers/pinctrl/pinctrl-artpec6.c:867:25:    expected void volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-artpec6.c:867:25:    got unsigned int *reg

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@axis.com
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pinctrl/pinctrl-artpec6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
index 986e04ac6b5b..439a997b6bdb 100644
--- a/drivers/pinctrl/pinctrl-artpec6.c
+++ b/drivers/pinctrl/pinctrl-artpec6.c
@@ -798,7 +798,7 @@ static int artpec6_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	enum pin_config_param param;
 	unsigned int arg;
 	unsigned int regval;
-	unsigned int *reg;
+	unsigned int __iomem *reg;
 	int i;
 
 	/* Check for valid pin */
-- 
2.24.0

