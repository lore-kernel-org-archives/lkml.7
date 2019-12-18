Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B8CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4703A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHaGM9jJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfLRDgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:36:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36778 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRDgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:36:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id w1so618216otg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 19:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYB4s3dvVBFCPnFe96WhIWyZL+IYAzuGd8QdASVaQzI=;
        b=cHaGM9jJ9roslLovU0wb1Uub0glLUUeZKQblJlCKa08iAsnHfFGDswDd1Hby6n96g4
         CfakAUsbpWnJc4SLkBwFMaIGe8R2zm2839Z5y0E+Z7x5APGSdAqzRoyTHo90zYuEvs5o
         65EnWxh5W/ynowWsninJeEudHsh+QvrXZWtNnEvgaHZU/w02//FSJX1CNC739c3e9Cmf
         Ne0tj9P/HgXJx7/vaXP7GK8TxfxGnHG3X2UugiYurE79dN5yqOZlzofivJWYCUv3GonJ
         q1CaJ3oWyA86QGVCst1ZpLBhNxE2Eptq+8bRwQ253Ts8tbNbHsiEIkSfqQDQa0r101n6
         rzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYB4s3dvVBFCPnFe96WhIWyZL+IYAzuGd8QdASVaQzI=;
        b=B8rWPPr3zBCGcNrQ7J0K1uUZUU1We6a/j54rjqPoI74IoOyfM1bs+Me2TQ/sxdNrKD
         dnzFmjEzSy63eTrM2q4KtlXDDXsJVfOv2ppI492NXdfFVIgD++MJPPadhriM9ygRJxRL
         xIRqUR6JjiINNlPQnxq6H5+y2Y6/qCrSUozWs1p21h4XRI1e2nJ5iGt51LjPgyK/6qyu
         ogqw0lOjPkf/ss+1O7jcl0LnJID9+/Z+mznQErk2/TEzdM8P0OSpBOnFrzOGVwSRW+dB
         mgbZXVQzYJSEncp5K/RJhfcVd/fBPw7gknyO5S0MGN7wQSYJAAEYknOgz6sS/gYg9K8m
         7Nuw==
X-Gm-Message-State: APjAAAV73IITnsURzVxE4IfMZL3xAlsW7mCVSSBfBJzRzMv3adCbPgdL
        IMJHvljo0/3Yt+ucuIGH8Ecokg6vNX0=
X-Google-Smtp-Source: APXvYqzObQ9rGEWdI/Jq1RlSSZhA0FouSgPPmFtl7QH1YwOP9GRzHWmnYxZQv90a7FdfNnN/I+J1GA==
X-Received: by 2002:a9d:67d2:: with SMTP id c18mr198633otn.362.1576640210342;
        Tue, 17 Dec 2019 19:36:50 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 101sm341164otj.55.2019.12.17.19.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 19:36:49 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] lib/scatterlist: Adjust indentation in __sg_alloc_table
Date:   Tue, 17 Dec 2019 20:36:07 -0700
Message-Id: <20191218033606.11942-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../lib/scatterlist.c:314:5: warning: misleading indentation; statement
is not part of the previous 'if' [-Wmisleading-indentation]
                        return -ENOMEM;
                        ^
../lib/scatterlist.c:311:4: note: previous statement is here
                        if (prv)
                        ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

Fixes: edce6820a9fd ("scatterlist: prevent invalid free when alloc fails")
Link: https://github.com/ClangBuiltLinux/linux/issues/830
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

This file doesn't seemt to have a formal maintainer but Jens seems to
have a few signoffs. If not, I assume Andrew will take it.

 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index c2cf2c311b7d..5813072bc589 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -311,7 +311,7 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 			if (prv)
 				table->nents = ++table->orig_nents;
 
- 			return -ENOMEM;
+			return -ENOMEM;
 		}
 
 		sg_init_table(sg, alloc_size);
-- 
2.24.1

