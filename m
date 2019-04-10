Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2441BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03E320820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfDJMys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:54:48 -0400
Received: from smtp.asem.it ([151.1.184.197]:61694 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbfDJMyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:54:47 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003804506.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:54:43 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 14:54:41 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Wed, 10 Apr 2019 14:54:41 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Date:   Wed, 10 Apr 2019 14:51:36 +0200
Message-ID: <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0214.5CADE792.005C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With dw_dmac, sometimes the request of a DMA channel fails because
the DMA driver is not ready, so an explicit dependency request
is necessary.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c9560a1..e8ac26b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1962,3 +1962,5 @@ static void __exit pxa2xx_spi_exit(void)
 	platform_driver_unregister(&driver);
 }
 module_exit(pxa2xx_spi_exit);
+
+MODULE_SOFTDEP("pre: dw_dmac");
-- 
2.7.4

