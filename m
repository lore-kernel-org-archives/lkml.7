Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCF0C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8A6229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwYzjHg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGXKCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:02:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33734 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGXKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:02:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so20698444pfq.0;
        Wed, 24 Jul 2019 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Q3f3xydka7q3ymH0VxHJXXLNdtWTBhTzvay6ryonzE=;
        b=gwYzjHg8wMJUW0gU6PSlyM/gtX6tHNT93Avn0ySZQkTj2uKOHqd0+eTJbDvJNkgQKR
         sz4lR15xN1XC3gA8NXCghnts7CY677fukDapKHw+5E2eoZ55k/U0zmtJ4by6fogMqrsg
         lsDF3kya2tKsNzavMe3sgbNQgp9zHp4KBKVxswIU/BM0d3SvjT1mj4aWpXlvHXfPbgp8
         VJYjZpH6bJoo6yhxEHuq3pj8CysXP3FJHFl/B4K/NL23JRQRhWhWZqXnULjOPNOgOPPG
         ycGpOCMTwYGQN1fYsvfR2Q9bSg/jueJvm8bjM/7KrBXtyickJZnrlskdJp3y9365J1xq
         O1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Q3f3xydka7q3ymH0VxHJXXLNdtWTBhTzvay6ryonzE=;
        b=tMcPDKlgkVhA49UEcoB3snldbttvCWyRBitNMA+Us5Oqxr8ajI+dsSdw/OPu3UvP6C
         kTj5c/IkQW/mZQolsZIaA0XSwlm6rlDLjmf9gPwXsILY45lXmpYLXOmjjRQYmSyoo9wa
         U0gD1kzjC0POzNR0CPokDaTo3TkyVuZk/6CNrswWJm+4xF0fKAw0aOu4DB9u/+aIeNOi
         t06adze10uTiM2pKY08Xd5h+/GuZBjbFV68f/ZwgnIlvqGspKAQdxbCckbpMCro5U1Yv
         PDCZyfwJfEoIYhbbgTi4ArxCjGQqLm9yiTaJnaT9hW3Ppto0/f8ZNIAzWnV9MPKm2KEW
         QdVA==
X-Gm-Message-State: APjAAAVzG1IX+s70flKd+0hGYT1gXWKiTTo1lmztJVY41wOu8zUszDBW
        xChLebdkZGyOoIMiA5g/cARMmBPaw3M=
X-Google-Smtp-Source: APXvYqy9h9/h7AcvlkRbZ+l2a5DNDLfouT8ZdbDL1piYeGZBNiVBUwhJfBxxoS03lyvL1Gy4wTxgNg==
X-Received: by 2002:a17:90a:214e:: with SMTP id a72mr45532046pje.0.1563962531944;
        Wed, 24 Jul 2019 03:02:11 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id q69sm64083603pjb.0.2019.07.24.03.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 03:02:11 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     tytso@mit.edu, jaegeuk@kernel.org, ebiggers@kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: crypto: keyinfo: Fix a possible null-pointer dereference in derive_key_aes()
Date:   Wed, 24 Jul 2019 18:02:04 +0800
Message-Id: <20190724100204.2009-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In derive_key_aes(), tfm is assigned to NULL on line 46, and then
crypto_free_skcipher(tfm) is executed.

crypto_free_skcipher(tfm)
    crypto_skcipher_tfm(tfm)
        return &tfm->base;

Thus, a possible null-pointer dereference may occur.

To fix this bug, tfm is checked before calling crypto_free_skcipher().

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/crypto/keyinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 207ebed918c1..b419720cac54 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -66,7 +66,8 @@ static int derive_key_aes(const u8 *master_key,
 	res = crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
 out:
 	skcipher_request_free(req);
-	crypto_free_skcipher(tfm);
+	if (tfm)
+		crypto_free_skcipher(tfm);
 	return res;
 }
 
-- 
2.17.0

