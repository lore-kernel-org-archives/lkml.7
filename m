Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F062C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521BF20673
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfJLL5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 07:57:10 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:35814 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfJLLzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 07:55:09 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 85B511A40556; Sat, 12 Oct 2019 04:55:09 -0700 (PDT)
Date:   Sat, 12 Oct 2019 04:55:09 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: core: datagram: tidy up copy functions a bit
Message-ID: <20191012115509.jrqe43yozs7kknv5@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate some verbosity by using min() macro and consolidating some
things, also fix inconsistent zero tests (! vs. == 0).

Signed-off-by: Vito Caputo <vcaputo@pengaru.com>
---
 net/core/datagram.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 4cc8dc5db2b7..08d403f93952 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -413,13 +413,11 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 					    struct iov_iter *), void *data)
 {
 	int start = skb_headlen(skb);
-	int i, copy = start - offset, start_off = offset, n;
+	int i, copy, start_off = offset, n;
 	struct sk_buff *frag_iter;
 
 	/* Copy header. */
-	if (copy > 0) {
-		if (copy > len)
-			copy = len;
+	if ((copy = min(start - offset, len)) > 0) {
 		n = cb(skb->data + offset, copy, data, to);
 		offset += n;
 		if (n != copy)
@@ -430,39 +428,33 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 
 	/* Copy paged appendix. Hmm... why does this look so complicated? */
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-		int end;
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		int end = start + skb_frag_size(frag);
 
 		WARN_ON(start > offset + len);
 
-		end = start + skb_frag_size(frag);
-		if ((copy = end - offset) > 0) {
+		if ((copy = min(end - offset, len)) > 0) {
 			struct page *page = skb_frag_page(frag);
 			u8 *vaddr = kmap(page);
 
-			if (copy > len)
-				copy = len;
 			n = cb(vaddr + skb_frag_off(frag) + offset - start,
 			       copy, data, to);
 			kunmap(page);
 			offset += n;
 			if (n != copy)
 				goto short_copy;
-			if (!(len -= copy))
+			if ((len -= copy) == 0)
 				return 0;
 		}
 		start = end;
 	}
 
 	skb_walk_frags(skb, frag_iter) {
-		int end;
+		int end = start + frag_iter->len;
 
 		WARN_ON(start > offset + len);
 
-		end = start + frag_iter->len;
-		if ((copy = end - offset) > 0) {
-			if (copy > len)
-				copy = len;
+		if ((copy = min(end - offset, len)) > 0) {
 			if (__skb_datagram_iter(frag_iter, offset - start,
 						to, copy, fault_short, cb, data))
 				goto fault;
@@ -545,13 +537,11 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 int len)
 {
 	int start = skb_headlen(skb);
-	int i, copy = start - offset;
 	struct sk_buff *frag_iter;
+	int i, copy;
 
 	/* Copy header. */
-	if (copy > 0) {
-		if (copy > len)
-			copy = len;
+	if ((copy = min(start - offset, len)) > 0) {
 		if (copy_from_iter(skb->data + offset, copy, from) != copy)
 			goto fault;
 		if ((len -= copy) == 0)
@@ -561,24 +551,21 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 
 	/* Copy paged appendix. Hmm... why does this look so complicated? */
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-		int end;
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		int end = start + skb_frag_size(frag);
 
 		WARN_ON(start > offset + len);
 
-		end = start + skb_frag_size(frag);
-		if ((copy = end - offset) > 0) {
+		if ((copy = min(end - offset, len)) > 0) {
 			size_t copied;
 
-			if (copy > len)
-				copy = len;
 			copied = copy_page_from_iter(skb_frag_page(frag),
 					  skb_frag_off(frag) + offset - start,
 					  copy, from);
 			if (copied != copy)
 				goto fault;
 
-			if (!(len -= copy))
+			if ((len -= copy) == 0)
 				return 0;
 			offset += copy;
 		}
@@ -586,14 +573,11 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 	}
 
 	skb_walk_frags(skb, frag_iter) {
-		int end;
+		int end = start + frag_iter->len;
 
 		WARN_ON(start > offset + len);
 
-		end = start + frag_iter->len;
-		if ((copy = end - offset) > 0) {
-			if (copy > len)
-				copy = len;
+		if ((copy = min(end - offset, len)) > 0) {
 			if (skb_copy_datagram_from_iter(frag_iter,
 							offset - start,
 							from, copy))
-- 
2.11.0

