Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24071C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 20:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D1220882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ntRYZFTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfLZUhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:37:38 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:47800 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLZUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 15:37:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47kMG90SL5z9wK02
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 20:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lUPUYKM_CnnW for <linux-kernel@vger.kernel.org>;
        Thu, 26 Dec 2019 14:37:36 -0600 (CST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47kMG86QJ7z9wK03
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 14:37:36 -0600 (CST)
Received: by mail-yb1-f200.google.com with SMTP id y204so19817930yby.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 12:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HImTIUDKCkz90/mVqDadf//lbgFZThYHx2fxEWAm4HE=;
        b=ntRYZFTwgt+z1MZhyPlGfNMPLcxw29JgS0WhPgImNkqaBbFTC1vOGk7K1oK669JK7+
         RM5f0Ij/xY/9H40Bz+uHIC9x3IU8wAB6weVq9ayqxNWVeOoEMTGBb9Bzo4ukPCNXGYtX
         2nBwS+0PmrB0Y58rQrQzr0mnQTDSqySqmfx5wrqy0Nfn7a3NZu9v+4a+DRbR1HBU+tjY
         k5HyTZ6umwEaA0Yjrkqal4bqG0pmNPL70+batjcNnnCHq+MB+1e+9cRveq6aO3Jme/Bv
         oM6uP2mcJn3qMyEWDFcYDxBBBdSnGxJqg9fJAyoqWgrAXSPR1tP7adiPTb6Voa6D7kw2
         S2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HImTIUDKCkz90/mVqDadf//lbgFZThYHx2fxEWAm4HE=;
        b=b1MRWPolLRonJrDqw3QzdP9AzbW1wWchc5sPGL8K8WozwYGmMSWbiGNPcsstMlixEP
         qBzzsygcYZDMAElqVlX5K5kxyAyaEsP+bF7GgL2uxPl2fRg6vhUM0g+zDxD888r9JPpl
         gNeORGQT/qBsO8NXjCx3jNuMXUDoqtTJsK1np4xy7WpRlFtwvrTxcplZGmF6wAAT4f3c
         ZKEqyx6yh8FsAoM71BD2TTfkmMb8J1MmVcTnsoxdoWnwp7IPq5KlHe09cZUVGdND9ECs
         RUtJtEJ0pI1YuPtdNs38lJqFz6tJCdC9sVvFFoqTNemtHYn/qkFarveNKBBaoq5miTVY
         NFjg==
X-Gm-Message-State: APjAAAVZQm1TvTNeGQDxD9bLKT4ojg/X65arw3dpiNKCZImCzLyrnNgH
        pMACPw5kJ86kpkiOpG65UpOId5/ZIvEfdp3vQ+8A8nX+JETU0kxnK07v/JBuN4CvZej6DGK5VUb
        anTgIhCK48gNPTCVGPKntcauV9M/O
X-Received: by 2002:a81:6fd4:: with SMTP id k203mr34295349ywc.370.1577392656417;
        Thu, 26 Dec 2019 12:37:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0nn/4FSfZJVjPBvPs8yj+Byn1PGJYTHXNh9kAPj7PGWn9gUqx3rxnw6ePhGqE1GZBTI4thQ==
X-Received: by 2002:a81:6fd4:: with SMTP id k203mr34295336ywc.370.1577392656189;
        Thu, 26 Dec 2019 12:37:36 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id w74sm12621083ywa.71.2019.12.26.12.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 12:37:35 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: remove unnecessary assertion in nfsd4_layout_setlease
Date:   Thu, 26 Dec 2019 14:37:33 -0600
Message-Id: <20191226203733.27808-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nfsd4_layout_setlease, checking for a valid file lock is
redundant and can be removed. This patch eliminates such a
BUG_ON check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/nfsd/nfs4layouts.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 2681c70283ce..ef5f8e645f4f 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -204,7 +204,6 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 		locks_free_lock(fl);
 		return status;
 	}
-	BUG_ON(fl != NULL);
 	return 0;
 }
 
-- 
2.20.1

