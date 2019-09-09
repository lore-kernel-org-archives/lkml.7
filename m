Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE65C4360D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 00:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494FA20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 00:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwJljbZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfIIAck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 20:32:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34564 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbfIIAck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 20:32:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so6784036pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWI+gzhvQ/sFr1tmoKeGjXR/vGqSIS/dhZvWWkXThpY=;
        b=WwJljbZT7E8v22P6J6wXYmaqc58XRYZESj8eX5VdIG015eFHaHNOtSNKwABgRxRFWw
         EnYbrt1LzeBZdGQ4QL5l51YHAzHbOglalONyNsNGrJb29nc4NHtXdrwXwSfRYBLI4/eV
         wiVmdl1gHeAJKbzfpO2BtSJLYdzUHNgj4Ty6pBPPN8Bn2h6cZEQhxsguaaLQE1n0bXyr
         bJWxPz0oQ2SrttfV7XHNEbd8xFfu6QpCp09w/Krz0mKgUV4LDNDQMZxHQqBWA9fEGY/a
         lUwy6uIEYYMw7VUchN98DqBrdPtTvjOONLNRrV0eij2OpVLDopXyMfLjZRVM2JEt9CZz
         9KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWI+gzhvQ/sFr1tmoKeGjXR/vGqSIS/dhZvWWkXThpY=;
        b=sSepTzmDWEsGK61fnIfi5iDlC0cbFsYwGCpSuQO1jFSk3YkgFB5mG3v0Yh/usfyyhs
         F4R+3YUcvOQGcXja4X5rryevYUNg54IEGp21IIr44PeaTW3BUx1QhVJc3OGBvUMz04k1
         eosrQrbCKWUNF/gVglkXyPv63HMP1SferIyKausAMk8pE6IRv8YnEvRiVS8bxp0zsLph
         iPfw9o0+N0gwJd8nKfFVzuBOjDcqPJy5ZumcPI7aV2BN3i/nCj/oTctNtUsoS6UTC2q8
         1/P721mjBOJ/98PwDz8yH5fIAUPgmPciZMoZXIcpx6YMKR/dFkoxMcMuNRghUkOk+7zs
         ivJw==
X-Gm-Message-State: APjAAAUsaio9knGhCTHThJ5Y/Od44JCsSOY+e87F2x4g5+AhXY/TXiMd
        HZlH7kYkHlwJrAKLAFY1Uo8=
X-Google-Smtp-Source: APXvYqwVWPyyKcsOvgFGVfF4nLetC05tdxCvblMEYpjCP64DV8wKx/c0GbHMj3gmIB5qTU9PiNYEbg==
X-Received: by 2002:a63:6c02:: with SMTP id h2mr19794497pgc.61.1567989159256;
        Sun, 08 Sep 2019 17:32:39 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id 7sm2033610pfi.91.2019.09.08.17.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 17:32:38 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] ftrace: simplify ftrace hash lookup code
Date:   Mon,  9 Sep 2019 08:31:59 +0800
Message-Id: <20190909003159.10574-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ftrace_lookup_ip() will check empty hash table. So we don't
need extra check outside.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: fix incorrect code remove.
---
 kernel/trace/ftrace.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9821a3374e9..92aab854d3b1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1463,8 +1463,7 @@ static bool hash_contains_ip(unsigned long ip,
 	 */
 	return (ftrace_hash_empty(hash->filter_hash) ||
 		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
-		(ftrace_hash_empty(hash->notrace_hash) ||
-		 !__ftrace_lookup_ip(hash->notrace_hash, ip));
+	       !ftrace_lookup_ip(hash->notrace_hash, ip);
 }
 
 /*
@@ -6036,11 +6035,7 @@ clear_func_from_hash(struct ftrace_init_func *func, struct ftrace_hash *hash)
 {
 	struct ftrace_func_entry *entry;
 
-	if (ftrace_hash_empty(hash))
-		return;
-
-	entry = __ftrace_lookup_ip(hash, func->ip);
-
+	entry = ftrace_lookup_ip(hash, func->ip);
 	/*
 	 * Do not allow this rec to match again.
 	 * Yeah, it may waste some memory, but will be removed
-- 
2.20.1

