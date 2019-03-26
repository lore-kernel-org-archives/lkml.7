Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B234EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1A220811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dJR+zona"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfCZPae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:30:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40070 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732022AbfCZPab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:30:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so11137936edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tThm/x2p9W+i8tJU44hM6YhgVB9o3kMMPHMITeV1Iuc=;
        b=dJR+zona8sRJfBWWxpFZXMnyPOVdlg/YoP59nDbOjIlHopFKxHy6TM6lISzy+x27wE
         K5DgnJ31nun8ca4qyHllwI+u2lQUSIzPvjS7eeIIKHxTNSMKn/SPwltQdpbOqVgCrC4t
         t9Tv/iFQgdtieeSKGMLbH1dCWY2EdrnWKDRSnm9M39qVo4Z3pI1himljyKRWF30t8RTa
         FDf52igzEuhbxWkhh/TYYzGvAg76VxWs8dwY/vsC6Hq2TRlhKBkAHX5rgA3mtDB/2QGB
         bMMVrIkheMHTd2aomLDPqZoy6v77ynKGzRDG7TJ0X3sDAG3QICsh5W4WpQ+t6U1mIPoX
         CqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tThm/x2p9W+i8tJU44hM6YhgVB9o3kMMPHMITeV1Iuc=;
        b=rXOCV7wcEDovAwyYfL2XbnoLGOEzAgCbRfcHTA82M9VbmsZWdEumMumbBzErMwhJGw
         u5AIVvHPRUZix5QNfnMkAzeIbnefVyNxz+cUVnRBrsSu0yFcu67xVFrT0Ca2pSHBD+Cx
         H0TTOCF6nLATbF82sMVPHRf7anwbehcYFnO3oKyhPf1GCr1YbjiXubTnoHuPY1+i6wdS
         quLrxw15IcltB+pLjVvxcw88u5sspQh3b0qhIuupuLWJ37pnGIXYzEsGXLHx+aOO5f/3
         sBKZImvnqgSdkfY2IHWabwCjMB8z65WJCFWuovueAReWsTM2ASvlJ61se6XRGco9Qq0R
         PTPQ==
X-Gm-Message-State: APjAAAXFjyT4moipbuwCi64ih2P+z0rQRP+kBw5DxWtN3riZKZh2fX5B
        uCEq0Ae9o0DBQZIYn/8ADrpTKmhBcZHSug==
X-Google-Smtp-Source: APXvYqwJuVDDu/mOYKzGkZFB0X1UqTn0Qa+OVaLwLB95oIEcxAwYN0wOok1qesvkSn2uo7Jzyq10Dw==
X-Received: by 2002:a17:906:69c3:: with SMTP id g3mr17466229ejs.245.1553614229385;
        Tue, 26 Mar 2019 08:30:29 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b2sm5310830eda.36.2019.03.26.08.30.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 08:30:28 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Subject: [RFC 1/4] net/ipv4/fib: Remove run-time check in tnode_alloc()
Date:   Tue, 26 Mar 2019 15:30:22 +0000
Message-Id: <20190326153026.24493-2-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326153026.24493-1-dima@arista.com>
References: <20190326153026.24493-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TNODE_KMALLOC_MAX is not used anywhere, while TNODE_VMALLOC_MAX check in
tnode_alloc() only adds additional cmp/jmp instructions to tnode
allocation. During rebalancing of the trie the function can be called
thousands of times. Runtime check takes cache line and predictor entry.
Futhermore, this check is always false on 64-bit platfroms and ipv4 has
only 4 byte address range and bits are limited by KEYLENGTH (32).

Move the check under unlikely() and change comparison to BITS_PER_LONG,
optimizing allocation of tnode during rebalancing (and removing it
complitely for platforms with BITS_PER_LONG > KEYLENGTH).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/fib_trie.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index a573e37e0615..ad7d56c421cb 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -312,11 +312,6 @@ static inline void alias_free_mem_rcu(struct fib_alias *fa)
 	call_rcu(&fa->rcu, __alias_free_mem);
 }
 
-#define TNODE_KMALLOC_MAX \
-	ilog2((PAGE_SIZE - TNODE_SIZE(0)) / sizeof(struct key_vector *))
-#define TNODE_VMALLOC_MAX \
-	ilog2((SIZE_MAX - TNODE_SIZE(0)) / sizeof(struct key_vector *))
-
 static void __node_free_rcu(struct rcu_head *head)
 {
 	struct tnode *n = container_of(head, struct tnode, rcu);
@@ -333,8 +328,7 @@ static struct tnode *tnode_alloc(int bits)
 {
 	size_t size;
 
-	/* verify bits is within bounds */
-	if (bits > TNODE_VMALLOC_MAX)
+	if ((BITS_PER_LONG <= KEYLENGTH) && unlikely(bits >= BITS_PER_LONG))
 		return NULL;
 
 	/* determine size and verify it is non-zero and didn't overflow */
-- 
2.21.0

