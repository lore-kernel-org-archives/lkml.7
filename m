Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63ABC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1712054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfHTMgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:36:12 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbfHTMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:36:02 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N49Ul-1iPw4H1GZl-0107e4; Tue, 20 Aug 2019 14:35:52 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 8/9] drivers: ata: sata_gemini: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:47 +0200
Message-Id: <1566304548-19972-8-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
References: <1566304548-19972-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:7x5C1yuziwweplAD/3CXQ+p5mRzeq7NIdXOCRZIcKS6qz9xQoz1
 Js3vGcomg0xZug7heujJy7I4KjwJrKZ3n84wzF5zq2iKcI98W2gxrdwn9PX63wZBR4KC4oE
 jvBYz+XxGp/W2po4w2/W7JoP2Ym4vPS9fT7etNZ+CwGYv4a0AmYM3rij4AlgGM5qxYGqEV2
 Ef/xWTsUaXjstHlGG/eGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AmAntXxXphg=:0I1Gy8JzNhuWCUwcwoqwoH
 Sgm52y3pzw9OHvYIYh3ZwHm+U68BLUHSHHND5qcuhZu/u1qVgarShlDmJNcqo18S1s7zy9S3a
 wi30lKDEfwAsHQD4cKSVPq81Fri20TZU4hbeiX+BVhRW4VaweBHlCsrmqz/1LsaXbAhS7Qutl
 YecE8B65vgQIq+3y6X6g9J3CTn/olLoD9wc3cxzp11y9ZXAkVUz94XTDuOra/Fv1D2F7ZUC4F
 zAYA6+F/HqecEeEOIG4GufDOzBbYNWED2jCodvQ2WyYo4ZB6QSumU9P27O4hequ5CQf0SVfdI
 Pl/H7JKk5Ygz0/zx9p9+yZSzJlVSIqhiraFOaCmo4l0qnRIRvdMhBzygGHrkNL2T1j7R9VA5B
 mQawtm3z7PJSVNpZmfOQQhc3mDiaASKL42G4tOW9j70A1dDQqjGnlzIfzATMTl4Rw757dGv4P
 HSBZsOzgH1LWKsb+LjvbDb7erzHXKhz0sQgEn9YmKcHOLF9MEtCeP2SvistdoO7s4dxt4pHcx
 ZIU7wUCh05DDRAsEBSaf8zqi4e11F8+EwddRHJD10gMbfvCqlpgUZMzImzZbJdC5tHQipujvH
 sBTxQOriRJBA6oj62DGk/ne8Yb7kUPOnuYP7eyMabP/Jycec9YOjHQ3FZ+UEEvH8mE2JIo5U3
 h3hMZtKJWhXwjNGMYwO+LIjQjQ3xXYRQzqEHxwPTTfJnI0c8R7I3ZfiU2GgOwRM8wchM6p4rk
 DNxumNTnZEKF0Bqjmfyq7zfmf86LRNNTPXxGMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/sata_gemini.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index f793564..55e2689 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -318,7 +318,6 @@ static int gemini_sata_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct sata_gemini *sg;
 	struct regmap *map;
-	struct resource *res;
 	enum gemini_muxmode muxmode;
 	u32 gmode;
 	u32 gmask;
@@ -329,11 +328,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	sg->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	sg->base = devm_ioremap_resource(dev, res);
+	sg->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sg->base))
 		return PTR_ERR(sg->base);
 
-- 
1.9.1

