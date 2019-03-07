Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C805C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2222520854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCGKJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:09:54 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:47261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:09:54 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDPuq-1hCFYZ1YRS-00AZ2j; Thu, 07 Mar 2019 11:09:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: pxamci: fix enum type confusion
Date:   Thu,  7 Mar 2019 11:09:19 +0100
Message-Id: <20190307100948.570006-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dLg/EnprOSV+AG5rIOUAbfhnAkCXqZLaPxorfGVq19dXI7tPAXw
 f9pQVKwPp07Aqn+Gzq5B17hfMRbkVeAxZYujcCjbvzdUAdKmVYmCljsn5ERFOUqnFn9n5Fy
 emGnbd3PGeBwnyM37xl+dwVP4R5xRi+35k+Ih2Fhoyt7O9sHMeIESmEBoE9II32Ughg0CqU
 pLc+DUZkyFqfboTpf74Kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HTPr5zcU7jQ=:fCx+jyDj+/sUC9vrD1YFUj
 fjbSkyTMAnJBQuEynYNoYRGHvIB831+vs08w8/s1rTa8IcXiIqCB9/hzaCzYEK6t7J5T+diPt
 sqmzsv+sBXTbVJrgycjM99j25BTe0K2msiQr10fVtfwSS1tVHVxKQpThR7mlf53HdRn4a9Nc6
 bMWbmHbuVYG0poYnUxmJjKv7vd1f+EEjYoG6os8ljxzBCzsWen0B2EdtW3NTdmRInMnQUf3Ek
 bd+VSShOGdDGsIor5PItOcrfochsXXNNGui/2oM3zjZST6e7gxvOeAvbgjz2upQrBywE+46tS
 0t5u6urmyLS5Lsr6kEW/Bf7Q8smNsuB2zyf1SDEtMqn+ldayOTqCT++guVaYKWrqexDoU2IDp
 gjSZ8HQXKF6K/YyjtysQzXBZ/mbajqtOBMSQ8joONf8HKQ0Fyhh5wlNjgrf4hXsVUHHGi6RIS
 zXdzOdeLSm1BEbF9hBtrNYaMOrdTqdF/mlJCE7y2FYmFLE0QaUlEatyiawd0sSKDKLfkAScb8
 VUyZhPJMj0M1Ej3tw6+MIzBo/cvWdjCbabNqDYPszt2pFRkgCAAqmXlaXq0KSpI/+WmGrXbbz
 FdHjNIqmyKkA1OO59EWbPahEfOaSJ4kliu/J4yisjmgUBcZ3WQU0cWpJ+gZ7RzY/IpIc1UP24
 moaBfvxN2ms0jTI5jHgkgDMH9hQly8l8GCmEmKWOzev3GGG5ptYB55bPWHPwV6/ZekoMV5OVW
 PBvOvKmn7qnr28PDXjkPFGQw038sM0fhPN1Ruw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out several instances of mismatched types in this drivers,
all coming from a single declaration:

drivers/mmc/host/pxamci.c:193:15: error: implicit conversion from enumeration type 'enum dma_transfer_direction' to
      different enumeration type 'enum dma_data_direction' [-Werror,-Wenum-conversion]
                direction = DMA_DEV_TO_MEM;
                          ~ ^~~~~~~~~~~~~~
drivers/mmc/host/pxamci.c:212:62: error: implicit conversion from enumeration type 'enum dma_data_direction' to
      different enumeration type 'enum dma_transfer_direction' [-Werror,-Wenum-conversion]
        tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,

The behavior is correct, so this must be a simply typo from
dma_data_direction and dma_transfer_direction being similarly named
types with a similar purpose.

Fixes: 6464b7140951 ("mmc: pxamci: switch over to dmaengine use")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c907bf502a12..c1d3f0e38921 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -162,7 +162,7 @@ static void pxamci_dma_irq(void *param);
 static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 {
 	struct dma_async_tx_descriptor *tx;
-	enum dma_data_direction direction;
+	enum dma_transfer_direction direction;
 	struct dma_slave_config	config;
 	struct dma_chan *chan;
 	unsigned int nob = data->blocks;
-- 
2.20.0

