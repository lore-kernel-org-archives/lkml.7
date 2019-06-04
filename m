Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79CA2231F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ttXWopE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfFDMgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:36:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:34056 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfFDMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:36:19 -0400
X-Greylist: delayed 102297 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 08:36:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559651773;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=zNeVIwI8QDla7s3sl/i++j6xztinaA93Qu+CwovgWVc=;
        b=ttXWopE+sxueafB8j8I3fQdkhqEfrMWlN5H08EPGKkB/Gh052a9GGcKbyFRcPYLDG9
        lxlYSxY3XJJCGXBbVfU7a4SzhBx5/kDrckB8Ftw7WE5CCO/IuKNyirYweF/Z4/EKamX9
        pemuwo6j9YdHygskgtYKIc/J6R2f0rVsoaaoPvkP6ZEM6hhjaQmXon5Ukf/jLlJyw78p
        j33tNlITKRsFVEtx6ju77/a7dTEtGqnNZmcXObusDoeCyNmWH/lbf08KLtXaCbcU9PYy
        ddeEtYXCVv8KjBotezui554pab+kJtwfA78vMEQaq1hjJz1Q9xPS7Fq+oetA6gMXaSfx
        zyVQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0pAzTh/eDM="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.22 DYNA|AUTH)
        with ESMTPSA id i01b98v54CZx7Rm
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 4 Jun 2019 14:35:59 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] gpio: pca953x: hack to fix 24 bit gpio expanders
Date:   Tue,  4 Jun 2019 14:35:58 +0200
Message-Id: <9bb9ca6102e795dc2495d92b7b661779509adebc.1559651758.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24 bit expanders use REG_ADDR_AI in combination with register addressing. This
conflicts with regmap which takes this bit as part of the register number,
i.e. a second cache entry is defined for accessed with REG_ADDR_AI being
set although on the chip it is the same register as with REG_ADDR_AI being
cleared.

The problem was introduced by

	commit b32cecb46bdc ("gpio: pca953x: Extract the register address mangling to single function")

but only became visible by

	commit 8b9f9d4dc511 ("regmap: verify if register is writeable before writing operations")

because before, the regmap size was effectively ignored and
pca953x_writeable_register() did know to ignore REG_ADDR_AI. Still, there
were two separate cache entries created.

Since the use of REG_ADDR_AI seems to be static we can work around this
issue by simply increasing the size of the regmap to cover the "virtual"
registers with REG_ADDR_AI being set. This only means that half of the
regmap buffer will be unused.

Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index b7ef33f63392..2b27d18410aa 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -308,7 +308,8 @@ static const struct regmap_config pca953x_i2c_regmap = {
 	.volatile_reg = pca953x_volatile_register,
 
 	.cache_type = REGCACHE_RBTREE,
-	.max_register = 0x7f,
+	/* REVISIT: should be 0x7f but some 24 bit chips use REG_ADDR_AI */
+	.max_register = 0xff,
 };
 
 static u8 pca953x_recalc_addr(struct pca953x_chip *chip, int reg, int off,
-- 
2.19.1

