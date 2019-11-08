Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A30C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD32214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lbk0ljkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfKHJpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:45:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34189 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbfKHJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:45:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id v3so6910016wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=w0FiN6gyAyacF2gs8LToS4qHDjvvIl4Fdx7KgNHxcPA=;
        b=lbk0ljknocwIdkmF9k7GAivkHRDTe/IAjZGyeQYpGPDyWtGzQmSXi4OPx48dAgQO0J
         TMvYwp/agAMuRMGZj6lkbkJ+rTmtdHV52hEpEf1LJfXOcKs1uYdC7rSy+vs/M8ZR6SKx
         NU+mmP3iv3Pl2/Y/LVuUzmpS/b3BpIIYVYuCK6Y9GnUbTs/slK8qwiPZzPfCj4GUDkhT
         OGhdrWrwzuQfnXXtLYvvdNhAV+aANu6mo0CcXevdI5/q3duUfaB1RAoX2SEHj5YztOmt
         rVtHFeQqKCG1RiVCj1gxnZmQy5THOMv3RalfhBY9RGDSGtgOm5d6M67bKxxnJLiIqyZ2
         948g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w0FiN6gyAyacF2gs8LToS4qHDjvvIl4Fdx7KgNHxcPA=;
        b=DOFu9ykGEx9gVOfFtvErg+7yaTFbW5pxombZ0m9SAd7KuTXzp4KIWn2JmkGmCjQkEK
         pPZeT07F2fD5E6AzYoA8RM67P/OqREknn9q+S1vS7Auomr4y+0yhoU8ej12i2d0osSgA
         xL/toBQp5/qWsBTR4hZAHPUdzktxuc4WfPLqFjC4Gc3zKoUHMQlR49bcz6lWcKrTOb7f
         7JnnsW7GZSEEnhem6w4bQgHsSrxGTifQXI5mzTdI/NdTjnWazbdi5LuHBBmlPQldAwB4
         wJsTHM19N2Wy0s35YC20LBNRYgk1PRnf2KGjp6vID9nnpcgeI9eqkItyZlfL+eH10sti
         OEWg==
X-Gm-Message-State: APjAAAVECr8K3jr6q2M29GTBAQifZVUHfaK/jiGaFtj7/Gt2SqTQUP7/
        yjNWQ/uN7IJvhZ0CjmeWXkL1zQ==
X-Google-Smtp-Source: APXvYqxyMB4JCp9NWE1ioQbruVXzPQumvhGWe31zInW2/Ji/Iz9hHST1fhd3vJd3yu3ksEJkV7WIVg==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr7125636wmh.45.1573206334295;
        Fri, 08 Nov 2019 01:45:34 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c24sm10601737wrb.27.2019.11.08.01.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 01:45:33 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        keescook+coverity-bot@chromium.org, narmstrong@baylibre.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: amlogic - fix two resources leak
Date:   Fri,  8 Nov 2019 09:45:17 +0000
Message-Id: <1573206317-9926-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two resources leak that occur on error path.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1487403 ("RESOURCE_LEAK")
Addresses-Coverity-ID: 1487401 ("Resource leaks")
Fixes: 48fe583fe541 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index e9283ffdbd23..58b717aab6e8 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -131,7 +131,8 @@ static int meson_cipher(struct skcipher_request *areq)
 	if (areq->iv && ivsize > 0) {
 		if (ivsize > areq->cryptlen) {
 			dev_err(mc->dev, "invalid ivsize=%d vs len=%d\n", ivsize, areq->cryptlen);
-			return -EINVAL;
+			err = -EINVAL;
+			goto theend;
 		}
 		memcpy(bkeyiv + 32, areq->iv, ivsize);
 		keyivlen = 48;
@@ -151,9 +152,10 @@ static int meson_cipher(struct skcipher_request *areq)
 
 	phykeyiv = dma_map_single(mc->dev, bkeyiv, keyivlen,
 				  DMA_TO_DEVICE);
-	if (dma_mapping_error(mc->dev, phykeyiv)) {
+	err = dma_mapping_error(mc->dev, phykeyiv);
+	if (err) {
 		dev_err(mc->dev, "Cannot DMA MAP KEY IV\n");
-		return -EFAULT;
+		goto theend;
 	}
 
 	tloffset = 0;
@@ -245,7 +247,6 @@ static int meson_cipher(struct skcipher_request *areq)
 	if (areq->iv && ivsize > 0) {
 		if (rctx->op_dir == MESON_DECRYPT) {
 			memcpy(areq->iv, backup_iv, ivsize);
-			kzfree(backup_iv);
 		} else {
 			scatterwalk_map_and_copy(areq->iv, areq->dst,
 						 areq->cryptlen - ivsize,
@@ -254,6 +255,7 @@ static int meson_cipher(struct skcipher_request *areq)
 	}
 theend:
 	kzfree(bkeyiv);
+	kzfree(backup_iv);
 
 	return err;
 }
-- 
2.23.0

