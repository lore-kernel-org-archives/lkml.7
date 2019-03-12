Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D40BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79EB214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfCLJTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:19:52 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39023 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCLJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:49 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MnWx3-1gbyBQ1frp-00jbQt; Tue, 12 Mar 2019 10:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 1/9] drivers: ata: ahci_octeon: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:26 +0100
Message-Id: <1552382374-28789-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:kr2oGxND4BpkUl9BC/l59hSmx7VDkOveIv7A6gqphQc7tK113/7
 Oz9SE3yZzk+FOuHol/Gt6ARBuMpwn8oylpwi4SP0+Q1+vyMOAzmApXTwD1Lgihf/dP84pO/
 /bwKA+l1fPrt+QsgMBlRd4FKWrHGpYfRKWT0mAVDzpPaiiNkQiiMMo98zLwGGVm/TWeLe85
 hQiaZx7MHiGaJJVcsaVlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uuQ7ZQsXFQ8=:VH2HtOiIfKvxWJj2HN0KTt
 sJZf6TtT7ZBWKdipetHK7ugxQ/MmRI5kIGjYe+5Q0jkMjLscMqAvzhBxqE0aefokjOpy3A42e
 vf7NqyVILgLWYAWr+rJvs+xrolF8VYegwRpXS4qZUe76hbf0IcuuZEZeU5epTIxA3vMfBzSaK
 +tCB9UPQprZtt4Xdek8z6FZD9oUqQ2WH3WGNaLpWt44klsybPKah1mRj0Yw+bEKDOAXK8PNOZ
 qGyYApz6gpX2uGJvjZ17ukmZum4jZFvln/rZ4x1JckN1qSBNTVcxpLIVJarT3kxT23VMG7Ffu
 ylj8LoA5qGSqRXFCSv6H+5jfdd9ajPjsbk2wuEffrpiwYKkpUJZdmFRSdtNBjFVrLU3R00mB6
 0Xs4d9USjCqSf8OVmlyLIuMUeS+yseZPfbRnrtX6CuNcYHknpuhPRsgH8O6L0I5o4X2FMc7Pv
 8O3DyK7FPgeaS/T8FT5KtK8lUrLkiEkiNoLUFevWzrFOtoFuNb4Rvk81omGk1Iv0CIvFv8dxP
 soQBpSqJnSvp0qrlTM7oZGPX2SHH8aGN4bM8feo4DiE+iGBCO6pfi4hrEr8Pro7LlPQuPPHIU
 kvic5Oc+OaLKX2yM9cgnCz5V2szL1ghuBNlxTCoynIOhMlkN9Hkduc1be3V/KH3f3S2R8LMDc
 f+MFkDeb/AaXVuuqfKpVCcMtHZNwjg+m2fZZIfwwr5UM8+EVkNUVZ/JEkMB3yKmd8euVrYzie
 3RUnaoDL+V2tR5Tps1+sZiAT36JZ50o/hcR90Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/ahci_octeon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
index 5a44e08..2280180 100644
--- a/drivers/ata/ahci_octeon.c
+++ b/drivers/ata/ahci_octeon.c
@@ -32,13 +32,11 @@ static int ahci_octeon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct resource *res;
 	void __iomem *base;
 	u64 cfg;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
1.9.1

