Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C2DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6271B2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Qez5sgL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfHNTHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 15:07:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45053 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfHNTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:07:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id d79so83366250qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zyoIBpx7/gJHmaFznO/SH+g+uzVx91CUA54PVlAZVQY=;
        b=Qez5sgL7Apb/YnWIWGP6n/H3UhluSnVb84n0he9o4TL9RE8ltVbcBfNG/xA2RN5PRe
         CxZlUXpa5olpCIqZCzTY39l5YnAKrhvzrPMnVAuAbXwhSL5bcAp4E+u2sPHlZ13XSgeZ
         XgIB1ZyqYnq7G1H/nZESNIKSaalDfqsRMHzKwhxU/uhBupDEKxl3ORnPAA7CLoKlPmD4
         zzkgESxXZ0pCsLJFpadok+GE8Seg79IG4xy/rAqcWrj46ZPU1ENXgUpX7TTzTzywxMkR
         SCld4EdYriuaE7RMeuBBkbe8yiMPW6mCqcKo6QcF9sdZaac4mnFNqJY1DTERJOFkBv3i
         L33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zyoIBpx7/gJHmaFznO/SH+g+uzVx91CUA54PVlAZVQY=;
        b=Wtf46WCZK7hfI2disGDzaZr+MUb8M1I98p9MjL8ABmRYE0Dewhu5VJzqjah3rjS3lw
         /zeOz/SbzwJLOcs1FkXMYObBKMr2I+ZKJjo8amKn5p60CU1B4KHnNvXrYumw0l45ts/H
         SsdwKJy4xDWQnkGfpKveGs6+0MAmrRWUXAwOL0k67HQxLNErRSHiBl+ooI1uYG4eNP4S
         T/etqYNyBeepdK9hUkF9GMReVZnOWuiSmyQKxsH62BGXL94YgWj9FIyAENpeMza5aPad
         iRPOD1hTiK1bmDj0yKbnJuRBJOoPNA7H1H2KbZyw+pWsC2T0yJbbyHT0CW2LyXqkFpDD
         gjQQ==
X-Gm-Message-State: APjAAAXpoGzooIQn6EyP+RVOWwx6jp6UGzIJsNT4bpxmblk8A3o6xypv
        SdCcl9GQOrdxFN3XdDID81Xse0Mg2Cc=
X-Google-Smtp-Source: APXvYqw1P6cMwe1NTa1gC092e9XveAA2gGUcbg3V1W2zUhtNyuO6/ml0oHYwyBVlorz5snc/utKykA==
X-Received: by 2002:a37:a16:: with SMTP id 22mr959766qkk.85.1565809642155;
        Wed, 14 Aug 2019 12:07:22 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o33sm312969qtd.72.2019.08.14.12.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 12:07:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/kmemleak: record the current memory pool size
Date:   Wed, 14 Aug 2019 15:07:11 -0400
Message-Id: <1565809631-28933-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only way to obtain the current memory pool size for a running kernel
is to check back the kernel config file which is inconvenient. Record it
in the kernel messages.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/kmemleak.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index b8bbe9ac5472..1f74f8bcb4eb 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1967,7 +1967,8 @@ static int __init kmemleak_late_init(void)
 		mutex_unlock(&scan_mutex);
 	}
 
-	pr_info("Kernel memory leak detector initialized\n");
+	pr_info("Kernel memory leak detector initialized (mem pool size: %d)\n",
+		mem_pool_free_count);
 
 	return 0;
 }
-- 
1.8.3.1

