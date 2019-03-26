Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233ADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C5120823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iSkg4fsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfCZPah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:30:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45312 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbfCZPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:30:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id m16so11114522edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5AmL7INQVSixEXzYLcTw3S29fd2fYSbdnmlsd37WMAc=;
        b=iSkg4fsQ1JIKR5iFGa0idGSRotE+/wEzkJemA3rfncwWltbkHAc40xCj1zGnU7N1SE
         eIntoPpA3CnoxM6AI5qO2qtE6u5X1NReLNr1jVOjqO41ile3rBJxQ0vFM/qeTThijGUh
         lMLozqP3h3oy7uN3yxESN51FQOHFR02BYDXEKWT0E1bxOl4sC/xbdJFD+Dan+dHQrutd
         15ooAM8hoDRlgOnT3lazFN/gWzjTWYfDNE1M5NhsOp0N3EZzd36bVf1SngVksPmM9dBV
         5yYJtdZTU5X6vmNkXkCh86uuys6XZwOd4JMRbSvSCsHeue/bAVj6d4fW2UVFTuX6zcXU
         NhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5AmL7INQVSixEXzYLcTw3S29fd2fYSbdnmlsd37WMAc=;
        b=kvBPEaxAUQ91fmSYxXbWLi0UEI9M1OmPqnBZ597RiMduuq+c9rm5uJRrtYvdbP1kIH
         I7In+eh03J8O2zJt1qshusVcAUj8axxVQsXKt4ZQJTTKVuyAqUx5z8WXK2tI453IDy7i
         yC/fSloh7lTRuKYp6mcqW943ss4uSSoQne18vbj+XVgt+n7vvtAAQFkUYam1N2Mzz+y2
         QrNTZ08HLcaiCKv+/acjEOv7YWF3dXV9DBLpV9FMIa/oM+Rga5SZ8ImlNj7tJmE2Boa5
         iXkji2C2yVxvQpnExKVqo75xe63pBwnowpmE+L2vCGYSjitKirFW3xjD3OsjRgb44Fe5
         dQGg==
X-Gm-Message-State: APjAAAWJmnMxy6Et8GXYpzCPZ7ShoGmDd41v6jjyymga0DbhLsKeu1OV
        nU/lIOiQRylrNTsHCuYQOiq/1TiFfiPCzA==
X-Google-Smtp-Source: APXvYqw+sJ0YtUytYc08TB+MyZlXTvsgHWcF3mji94/+J7Lknij1mIcHXIP1nVcwtsbEMpG2PRr9vQ==
X-Received: by 2002:a50:ca87:: with SMTP id x7mr20705284edh.165.1553614232059;
        Tue, 26 Mar 2019 08:30:32 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b2sm5310830eda.36.2019.03.26.08.30.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 08:30:31 -0700 (PDT)
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
Subject: [RFC 3/4] net/fib: Check budget before should_{inflate,halve}()
Date:   Tue, 26 Mar 2019 15:30:24 +0000
Message-Id: <20190326153026.24493-4-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326153026.24493-1-dima@arista.com>
References: <20190326153026.24493-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those functions are compute-costly, if we're out of budget - better
omit additional computations.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/fib_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index d90cf9dfd443..2ce2739e7693 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -868,7 +868,7 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn,
 	/* Double as long as the resulting node has a number of
 	 * nonempty nodes that are above the threshold.
 	 */
-	while (should_inflate(tp, tn) && *budget) {
+	while (*budget && should_inflate(tp, tn)) {
 		tp = inflate(t, tn, budget);
 		if (!tp) {
 #ifdef CONFIG_IP_FIB_TRIE_STATS
@@ -894,7 +894,7 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn,
 	/* Halve as long as the number of empty children in this
 	 * node is above threshold.
 	 */
-	while (should_halve(tp, tn) && *budget) {
+	while (*budget && should_halve(tp, tn)) {
 		tp = halve(t, tn, budget);
 		if (!tp) {
 #ifdef CONFIG_IP_FIB_TRIE_STATS
-- 
2.21.0

