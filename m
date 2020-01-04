Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE66CC32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 04:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0202217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 04:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1W3ZOFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgADEYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 23:24:19 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43582 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgADEYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 23:24:19 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so16974841qvo.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 20:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Og/9AHr2LARm6F9MwhhmPlp640upl2PZj/yS/R2LaOc=;
        b=r1W3ZOFkYjVpWSk7S3/aJDLLNUtH9WnBaMI1JNX6+wb4kqifz5rdzIAbxomxJux5Dt
         28n5e1/4tgd8IUwqmOScZLDQ8ufoMC2mgzMTrrAZTo8q8PHcdf3yx+0FPEPylAEpH1La
         6k/3ygdq9ua39tDXbm2HCk/umz5PbRUUQfXFIsVZPQc3rynh4f59W3IA21EtlpU+OTpe
         UEYk2XxFGROsO9S9spQzPQA5JQmm+xfbRRCIunASV8dodxT/eRmWAWIzlwIZzybpzCZn
         xLeLNTq9SvNQOUqXeMAjt/TjcgMI6JQgjKc9Hp9YojtjnXfDtCOOAzq3qTlMhpdOFsiS
         386Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Og/9AHr2LARm6F9MwhhmPlp640upl2PZj/yS/R2LaOc=;
        b=MAkSTcgvzrlOMKSqakcjQaME22roUcrLA6o4udmbqtkGgdqiZ0+P9FJOIbOqcOplka
         X6s4WdyErwidxBMmlVb5XxcPXv3eSsb8NPv3CE8INnkBsd9ldeuGLiSfjRl7OpJjSlrZ
         E/lx1v8OQd7V9OLU1DLkm6pqdRLFExkzsCCRjdorrNYYHZYyDuzB5M0vikLKZA7Yn/Lh
         3QUlIkP8UsdtHq6ayND5H86JGwXJ2uelyieiKDL3xWzyj/zmIKddPDQKyGxl6FJX5IPp
         yJb4UJiNC7PtIm0l7BVEaAgN7DQHnf69krdrQhyWScIP+1E3cCgM2poJ5Ll9OJjkdcGE
         uwQA==
X-Gm-Message-State: APjAAAUjA1dnFggECdSahDKyb83LPR+As7Mmp+haxSLifvbBG8dzkfsJ
        u4BldROniiXIXKLUPWd6J0k=
X-Google-Smtp-Source: APXvYqxdzXHGoIH+NDH8IlDdHG6UDZk0c0RW6PmH1KBZjFSokasFLOvozcbzTaG7j7K0w0rgQJbZsw==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr71884630qvs.177.1578111858130;
        Fri, 03 Jan 2020 20:24:18 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id i16sm17559961qkh.120.2020.01.03.20.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 20:24:17 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/radix-tree.c: use generic find_next_bit()
Date:   Fri,  3 Jan 2020 20:24:08 -0800
Message-Id: <20200104042408.11346-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/radix-tree.c has its own version of find_next_bit(). This patch
switches it to generic one.

Testing with tools/testing/radix-tree shows no significant difference.

Before:
$ time ./main
random seed 1578108797
running tests
XArray: 21151073 of 21151073 tests passed
vvv Ignore these warnings
assertion failed at idr.c:269
assertion failed at idr.c:206
^^^ Warnings over
IDA: 39122827 of 39122827 tests passed
tests completed

real	1m28.290s
user	2m29.610s
sys	0m32.256s
yury:radix-tree$ mutt
4440 kept, 0 deleted.

After:
$ time ./main
random seed 1578108654
running tests
XArray: 21151073 of 21151073 tests passed
qvvv Ignore these warnings
assertion failed at idr.c:269
assertion failed at idr.c:206
^^^ Warnings over
IDA: 40991309 of 40991309 tests passed
tests completed

real	1m29.035s
user	2m31.481s
sys	0m33.006s

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/radix-tree.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index c8fa1d2745302..23f86281133da 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -189,24 +189,7 @@ static __always_inline unsigned long
 radix_tree_find_next_bit(struct radix_tree_node *node, unsigned int tag,
 			 unsigned long offset)
 {
-	const unsigned long *addr = node->tags[tag];
-
-	if (offset < RADIX_TREE_MAP_SIZE) {
-		unsigned long tmp;
-
-		addr += offset / BITS_PER_LONG;
-		tmp = *addr >> (offset % BITS_PER_LONG);
-		if (tmp)
-			return __ffs(tmp) + offset;
-		offset = (offset + BITS_PER_LONG) & ~(BITS_PER_LONG - 1);
-		while (offset < RADIX_TREE_MAP_SIZE) {
-			tmp = *++addr;
-			if (tmp)
-				return __ffs(tmp) + offset;
-			offset += BITS_PER_LONG;
-		}
-	}
-	return RADIX_TREE_MAP_SIZE;
+	return find_next_bit(node->tags[tag], RADIX_TREE_MAP_SIZE, offset);
 }
 
 static unsigned int iter_offset(const struct radix_tree_iter *iter)
-- 
2.20.1

