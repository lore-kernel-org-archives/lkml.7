Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E572FC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CC220726
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jkfJBUJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfLORYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:24:11 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:45130 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfLORYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 12:24:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47bWV24kvYz9vY9V
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 17:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WXcHSaoWwK3Z for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 11:24:10 -0600 (CST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47bWV23Y6xz9vY9l
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:24:10 -0600 (CST)
Received: by mail-yb1-f200.google.com with SMTP id g132so4670496ybf.21
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pecgs7ML7Vk7tWrjFYP98uMh9IdJ4hgC/me6N1U0MqY=;
        b=jkfJBUJcQoX1yFjzdjzLoe6pY8qFLcPsJcRicv8sUQ3KI7lJHM7wqg+Chr1001bMPD
         W0XsUrqobdn0msYcUN4TjL5exX0UMw7kQoOY6P9+0jUi7bfoxbjBoQJSuMYSE3uSTBFF
         OkOLAYaUMmu20lBSqyQRpbnA45FEYZrOqhcijBpNbSByPR85MMdpUNOj0P8+pdcBYv/H
         z2iFxZy3LIzlFRBYDNsSVARyQdsrcjJQsSoHj001/cE63omL5zHgY9Eypl6Vzl5yFNOq
         cVkZV8X2/NUrc7M9t8coomBP5LcBhg0S7lfU61ZpPEuF6BI6giwm5uzNOQXF5SHOkaCh
         8pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pecgs7ML7Vk7tWrjFYP98uMh9IdJ4hgC/me6N1U0MqY=;
        b=VqOb2E2R4be1HeRvW9R7WyR/nqRrAbz/mXQyHbi70yloyuZnBa+kMhqL9SPHdKs+Oo
         lhic4sPF1dJpqZFTNssBg/mBggIclkKgeXcgNVkw3vjqSlLK5inqxn84ZQHgYDkJulvk
         rKvcFMZeaj/iAl1pPHiD/kD8JiyknQVdtCHMLSV0icMtBnFHx9DEav3pLraWTdUCqfqb
         MZ0HK7XX9WEneFhEMuklLH4UZCibtdu4alPpWxyiVZ3zU0rUhNY+gIcPV3eJ2w51+CuM
         ilfINreaPOtBmorM2LyMeBSt69WR0BscXKarDsvlaQl2PtY6vUjwe8pxAtXIUVks/K5i
         lpSQ==
X-Gm-Message-State: APjAAAVs1nBRB8KWiUWuTe8ooGjOM8sw9YZ9G3ENmUoqR9fZ5OkvCC7e
        HrKTdKGmFvMWq08DxW9dp5gWLbQgWfF+CmemZ30vq4o6PxqIM6KMXXiy96ThfRyyEKOComOmA53
        ISkU+/5LemQvmtZ+NFeoPs0fmXmDP
X-Received: by 2002:a25:c4c6:: with SMTP id u189mr16155467ybf.145.1576430649875;
        Sun, 15 Dec 2019 09:24:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqztTQTtMit3I1wZgX7qTMNPjPQRMZAa5AVd+u0lgsRsZTteFqWzJH36T48vebwVZixwVly3DA==
X-Received: by 2002:a25:c4c6:: with SMTP id u189mr16155458ybf.145.1576430649672;
        Sun, 15 Dec 2019 09:24:09 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 205sm69295ywm.17.2019.12.15.09.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 09:24:09 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Tyler Hicks <tyhicks@canonical.com>,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: replace BUG_ON with error handling code
Date:   Sun, 15 Dec 2019 11:24:04 -0600
Message-Id: <20191215172404.28204-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In crypt_scatterlist, if the crypt_stat argument is not set up
correctly, we avoid crashing, by returning the error upstream.
This patch performs the fix.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/ecryptfs/crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f91db24bbf3b..a064b408d841 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -311,8 +311,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 	struct extent_crypt_result ecr;
 	int rc = 0;
 
-	BUG_ON(!crypt_stat || !crypt_stat->tfm
-	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
+	if (!crypt_stat || !crypt_stat->tfm
+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
+		return -EINVAL;
+
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
 				crypt_stat->key_size);
-- 
2.20.1

