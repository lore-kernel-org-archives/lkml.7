Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EA3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27A42089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128306;
	bh=jA5X1plYmWgRQCUhtQe6NencPmxPuL2//3z5Dcf3nko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K5rD4/vAS6tqJmUbAB2JTNv1Vw8fxAPgVn54rXd+l/5RadbsskcGJanBBYzcI/GNl
	 4r9KDzrfSkbELdoxXHEM/uKJlQJz50zTeKNzYr/o0aXq2ugy3qWA30qNT2UU2ri34c
	 2lk7Q0BK6BlB/zRZzYTvMNvoeDx7uI2/Gmq1m0OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbfDXR2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388734AbfDXR21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:28:27 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BAB921905;
        Wed, 24 Apr 2019 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126905;
        bh=jA5X1plYmWgRQCUhtQe6NencPmxPuL2//3z5Dcf3nko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZddJ5ags9x8lwckX5+mFAiRULJ3s5lJ9wVyTibWMGbx68koH878MPrPq3XfRfqdD
         Cjt5gNMevpuGesSkhVK6Sd+AErdZzpEUddM7brCTblxAW8xfdUhC1TOwznpIWQUZ2y
         xfAkMRLiB0VD/P1sR8KEm7F1+78x7FhLSFlZb9kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Oskolkov <posk@google.com>,
        Tom Herbert <tom@herbertland.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 58/70] net: IP6 defrag: use rbtrees for IPv6 defrag
Date:   Wed, 24 Apr 2019 19:10:18 +0200
Message-Id: <20190424170918.244507084@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d4289fcc9b16b89619ee1c54f829e05e56de8b9a ]

Currently, IPv6 defragmentation code drops non-last fragments that
are smaller than 1280 bytes: see
commit 0ed4229b08c1 ("ipv6: defrag: drop non-last frags smaller than min mtu")

This behavior is not specified in IPv6 RFCs and appears to break
compatibility with some IPv6 implemenations, as reported here:
https://www.spinics.net/lists/netdev/msg543846.html

This patch re-uses common IP defragmentation queueing and reassembly
code in IPv6, removing the 1280 byte restriction.

v2: change handling of overlaps to match that of upstream.

Signed-off-by: Peter Oskolkov <posk@google.com>
Reported-by: Tom Herbert <tom@herbertland.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ipv6_frag.h |  11 +-
 net/ipv6/reassembly.c   | 249 +++++++++++-----------------------------
 2 files changed, 77 insertions(+), 183 deletions(-)

diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index 6ced1e6899b6..28aa9b30aece 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -82,8 +82,15 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMTIMEOUT);
 
 	/* Don't send error if the first segment did not arrive. */
-	head = fq->q.fragments;
-	if (!(fq->q.flags & INET_FRAG_FIRST_IN) || !head)
+	if (!(fq->q.flags & INET_FRAG_FIRST_IN))
+		goto out;
+
+	/* sk_buff::dev and sk_buff::rbnode are unionized. So we
+	 * pull the head out of the tree in order to be able to
+	 * deal with head->dev.
+	 */
+	head = inet_frag_pull_head(&fq->q);
+	if (!head)
 		goto out;
 
 	head->dev = dev;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index e5ab3b7813d6..fe797b29ca89 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -62,13 +62,6 @@
 
 static const char ip6_frag_cache_name[] = "ip6-frags";
 
-struct ip6frag_skb_cb {
-	struct inet6_skb_parm	h;
-	int			offset;
-};
-
-#define FRAG6_CB(skb)	((struct ip6frag_skb_cb *)((skb)->cb))
-
 static u8 ip6_frag_ecn(const struct ipv6hdr *ipv6h)
 {
 	return 1 << (ipv6_get_dsfield(ipv6h) & INET_ECN_MASK);
@@ -76,8 +69,8 @@ static u8 ip6_frag_ecn(const struct ipv6hdr *ipv6h)
 
 static struct inet_frags ip6_frags;
 
-static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *prev,
-			  struct net_device *dev);
+static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
+			  struct sk_buff *prev_tail, struct net_device *dev);
 
 static void ip6_frag_expire(struct timer_list *t)
 {
@@ -118,21 +111,26 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 			  struct frag_hdr *fhdr, int nhoff,
 			  u32 *prob_offset)
 {
-	struct sk_buff *prev, *next;
-	struct net_device *dev;
-	int offset, end, fragsize;
 	struct net *net = dev_net(skb_dst(skb)->dev);
+	int offset, end, fragsize;
+	struct sk_buff *prev_tail;
+	struct net_device *dev;
+	int err = -ENOENT;
 	u8 ecn;
 
 	if (fq->q.flags & INET_FRAG_COMPLETE)
 		goto err;
 
+	err = -EINVAL;
 	offset = ntohs(fhdr->frag_off) & ~0x7;
 	end = offset + (ntohs(ipv6_hdr(skb)->payload_len) -
 			((u8 *)(fhdr + 1) - (u8 *)(ipv6_hdr(skb) + 1)));
 
 	if ((unsigned int)end > IPV6_MAXPLEN) {
 		*prob_offset = (u8 *)&fhdr->frag_off - skb_network_header(skb);
+		/* note that if prob_offset is set, the skb is freed elsewhere,
+		 * we do not free it here.
+		 */
 		return -1;
 	}
 
@@ -152,7 +150,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 		 */
 		if (end < fq->q.len ||
 		    ((fq->q.flags & INET_FRAG_LAST_IN) && end != fq->q.len))
-			goto err;
+			goto discard_fq;
 		fq->q.flags |= INET_FRAG_LAST_IN;
 		fq->q.len = end;
 	} else {
@@ -169,70 +167,36 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 		if (end > fq->q.len) {
 			/* Some bits beyond end -> corruption. */
 			if (fq->q.flags & INET_FRAG_LAST_IN)
-				goto err;
+				goto discard_fq;
 			fq->q.len = end;
 		}
 	}
 
 	if (end == offset)
-		goto err;
+		goto discard_fq;
 
+	err = -ENOMEM;
 	/* Point into the IP datagram 'data' part. */
 	if (!pskb_pull(skb, (u8 *) (fhdr + 1) - skb->data))
-		goto err;
-
-	if (pskb_trim_rcsum(skb, end - offset))
-		goto err;
-
-	/* Find out which fragments are in front and at the back of us
-	 * in the chain of fragments so far.  We must know where to put
-	 * this fragment, right?
-	 */
-	prev = fq->q.fragments_tail;
-	if (!prev || FRAG6_CB(prev)->offset < offset) {
-		next = NULL;
-		goto found;
-	}
-	prev = NULL;
-	for (next = fq->q.fragments; next != NULL; next = next->next) {
-		if (FRAG6_CB(next)->offset >= offset)
-			break;	/* bingo! */
-		prev = next;
-	}
-
-found:
-	/* RFC5722, Section 4, amended by Errata ID : 3089
-	 *                          When reassembling an IPv6 datagram, if
-	 *   one or more its constituent fragments is determined to be an
-	 *   overlapping fragment, the entire datagram (and any constituent
-	 *   fragments) MUST be silently discarded.
-	 */
-
-	/* Check for overlap with preceding fragment. */
-	if (prev &&
-	    (FRAG6_CB(prev)->offset + prev->len) > offset)
 		goto discard_fq;
 
-	/* Look for overlap with succeeding segment. */
-	if (next && FRAG6_CB(next)->offset < end)
+	err = pskb_trim_rcsum(skb, end - offset);
+	if (err)
 		goto discard_fq;
 
-	FRAG6_CB(skb)->offset = offset;
+	/* Note : skb->rbnode and skb->dev share the same location. */
+	dev = skb->dev;
+	/* Makes sure compiler wont do silly aliasing games */
+	barrier();
 
-	/* Insert this fragment in the chain of fragments. */
-	skb->next = next;
-	if (!next)
-		fq->q.fragments_tail = skb;
-	if (prev)
-		prev->next = skb;
-	else
-		fq->q.fragments = skb;
+	prev_tail = fq->q.fragments_tail;
+	err = inet_frag_queue_insert(&fq->q, skb, offset, end);
+	if (err)
+		goto insert_error;
 
-	dev = skb->dev;
-	if (dev) {
+	if (dev)
 		fq->iif = dev->ifindex;
-		skb->dev = NULL;
-	}
+
 	fq->q.stamp = skb->tstamp;
 	fq->q.meat += skb->len;
 	fq->ecn |= ecn;
@@ -252,44 +216,48 @@ found:
 
 	if (fq->q.flags == (INET_FRAG_FIRST_IN | INET_FRAG_LAST_IN) &&
 	    fq->q.meat == fq->q.len) {
-		int res;
 		unsigned long orefdst = skb->_skb_refdst;
 
 		skb->_skb_refdst = 0UL;
-		res = ip6_frag_reasm(fq, prev, dev);
+		err = ip6_frag_reasm(fq, skb, prev_tail, dev);
 		skb->_skb_refdst = orefdst;
-		return res;
+		return err;
 	}
 
 	skb_dst_drop(skb);
-	return -1;
+	return -EINPROGRESS;
 
+insert_error:
+	if (err == IPFRAG_DUP) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+	err = -EINVAL;
+	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+			IPSTATS_MIB_REASM_OVERLAPS);
 discard_fq:
 	inet_frag_kill(&fq->q);
-err:
 	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
 			IPSTATS_MIB_REASMFAILS);
+err:
 	kfree_skb(skb);
-	return -1;
+	return err;
 }
 
 /*
  *	Check if this packet is complete.
- *	Returns NULL on failure by any reason, and pointer
- *	to current nexthdr field in reassembled frame.
  *
  *	It is called with locked fq, and caller must check that
  *	queue is eligible for reassembly i.e. it is not COMPLETE,
  *	the last and the first frames arrived and all the bits are here.
  */
-static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *prev,
-			  struct net_device *dev)
+static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
+			  struct sk_buff *prev_tail, struct net_device *dev)
 {
 	struct net *net = container_of(fq->q.net, struct net, ipv6.frags);
-	struct sk_buff *fp, *head = fq->q.fragments;
-	int    payload_len, delta;
 	unsigned int nhoff;
-	int sum_truesize;
+	void *reasm_data;
+	int payload_len;
 	u8 ecn;
 
 	inet_frag_kill(&fq->q);
@@ -298,120 +266,40 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *prev,
 	if (unlikely(ecn == 0xff))
 		goto out_fail;
 
-	/* Make the one we just received the head. */
-	if (prev) {
-		head = prev->next;
-		fp = skb_clone(head, GFP_ATOMIC);
-
-		if (!fp)
-			goto out_oom;
-
-		fp->next = head->next;
-		if (!fp->next)
-			fq->q.fragments_tail = fp;
-		prev->next = fp;
-
-		skb_morph(head, fq->q.fragments);
-		head->next = fq->q.fragments->next;
-
-		consume_skb(fq->q.fragments);
-		fq->q.fragments = head;
-	}
-
-	WARN_ON(head == NULL);
-	WARN_ON(FRAG6_CB(head)->offset != 0);
+	reasm_data = inet_frag_reasm_prepare(&fq->q, skb, prev_tail);
+	if (!reasm_data)
+		goto out_oom;
 
-	/* Unfragmented part is taken from the first segment. */
-	payload_len = ((head->data - skb_network_header(head)) -
+	payload_len = ((skb->data - skb_network_header(skb)) -
 		       sizeof(struct ipv6hdr) + fq->q.len -
 		       sizeof(struct frag_hdr));
 	if (payload_len > IPV6_MAXPLEN)
 		goto out_oversize;
 
-	delta = - head->truesize;
-
-	/* Head of list must not be cloned. */
-	if (skb_unclone(head, GFP_ATOMIC))
-		goto out_oom;
-
-	delta += head->truesize;
-	if (delta)
-		add_frag_mem_limit(fq->q.net, delta);
-
-	/* If the first fragment is fragmented itself, we split
-	 * it to two chunks: the first with data and paged part
-	 * and the second, holding only fragments. */
-	if (skb_has_frag_list(head)) {
-		struct sk_buff *clone;
-		int i, plen = 0;
-
-		clone = alloc_skb(0, GFP_ATOMIC);
-		if (!clone)
-			goto out_oom;
-		clone->next = head->next;
-		head->next = clone;
-		skb_shinfo(clone)->frag_list = skb_shinfo(head)->frag_list;
-		skb_frag_list_init(head);
-		for (i = 0; i < skb_shinfo(head)->nr_frags; i++)
-			plen += skb_frag_size(&skb_shinfo(head)->frags[i]);
-		clone->len = clone->data_len = head->data_len - plen;
-		head->data_len -= clone->len;
-		head->len -= clone->len;
-		clone->csum = 0;
-		clone->ip_summed = head->ip_summed;
-		add_frag_mem_limit(fq->q.net, clone->truesize);
-	}
-
 	/* We have to remove fragment header from datagram and to relocate
 	 * header in order to calculate ICV correctly. */
 	nhoff = fq->nhoffset;
-	skb_network_header(head)[nhoff] = skb_transport_header(head)[0];
-	memmove(head->head + sizeof(struct frag_hdr), head->head,
-		(head->data - head->head) - sizeof(struct frag_hdr));
-	if (skb_mac_header_was_set(head))
-		head->mac_header += sizeof(struct frag_hdr);
-	head->network_header += sizeof(struct frag_hdr);
-
-	skb_reset_transport_header(head);
-	skb_push(head, head->data - skb_network_header(head));
-
-	sum_truesize = head->truesize;
-	for (fp = head->next; fp;) {
-		bool headstolen;
-		int delta;
-		struct sk_buff *next = fp->next;
-
-		sum_truesize += fp->truesize;
-		if (head->ip_summed != fp->ip_summed)
-			head->ip_summed = CHECKSUM_NONE;
-		else if (head->ip_summed == CHECKSUM_COMPLETE)
-			head->csum = csum_add(head->csum, fp->csum);
-
-		if (skb_try_coalesce(head, fp, &headstolen, &delta)) {
-			kfree_skb_partial(fp, headstolen);
-		} else {
-			if (!skb_shinfo(head)->frag_list)
-				skb_shinfo(head)->frag_list = fp;
-			head->data_len += fp->len;
-			head->len += fp->len;
-			head->truesize += fp->truesize;
-		}
-		fp = next;
-	}
-	sub_frag_mem_limit(fq->q.net, sum_truesize);
+	skb_network_header(skb)[nhoff] = skb_transport_header(skb)[0];
+	memmove(skb->head + sizeof(struct frag_hdr), skb->head,
+		(skb->data - skb->head) - sizeof(struct frag_hdr));
+	if (skb_mac_header_was_set(skb))
+		skb->mac_header += sizeof(struct frag_hdr);
+	skb->network_header += sizeof(struct frag_hdr);
+
+	skb_reset_transport_header(skb);
+
+	inet_frag_reasm_finish(&fq->q, skb, reasm_data);
 
-	head->next = NULL;
-	head->dev = dev;
-	head->tstamp = fq->q.stamp;
-	ipv6_hdr(head)->payload_len = htons(payload_len);
-	ipv6_change_dsfield(ipv6_hdr(head), 0xff, ecn);
-	IP6CB(head)->nhoff = nhoff;
-	IP6CB(head)->flags |= IP6SKB_FRAGMENTED;
-	IP6CB(head)->frag_max_size = fq->q.max_size;
+	skb->dev = dev;
+	ipv6_hdr(skb)->payload_len = htons(payload_len);
+	ipv6_change_dsfield(ipv6_hdr(skb), 0xff, ecn);
+	IP6CB(skb)->nhoff = nhoff;
+	IP6CB(skb)->flags |= IP6SKB_FRAGMENTED;
+	IP6CB(skb)->frag_max_size = fq->q.max_size;
 
 	/* Yes, and fold redundant checksum back. 8) */
-	skb_postpush_rcsum(head, skb_network_header(head),
-			   skb_network_header_len(head));
+	skb_postpush_rcsum(skb, skb_network_header(skb),
+			   skb_network_header_len(skb));
 
 	rcu_read_lock();
 	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMOKS);
@@ -419,6 +307,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *prev,
 	fq->q.fragments = NULL;
 	fq->q.rb_fragments = RB_ROOT;
 	fq->q.fragments_tail = NULL;
+	fq->q.last_run_head = NULL;
 	return 1;
 
 out_oversize:
@@ -430,6 +319,7 @@ out_fail:
 	rcu_read_lock();
 	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMFAILS);
 	rcu_read_unlock();
+	inet_frag_kill(&fq->q);
 	return -1;
 }
 
@@ -468,10 +358,6 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 		return 1;
 	}
 
-	if (skb->len - skb_network_offset(skb) < IPV6_MIN_MTU &&
-	    fhdr->frag_off & htons(IP6_MF))
-		goto fail_hdr;
-
 	iif = skb->dev ? skb->dev->ifindex : 0;
 	fq = fq_find(net, fhdr->identification, hdr, iif);
 	if (fq) {
@@ -489,6 +375,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 		if (prob_offset) {
 			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
 					IPSTATS_MIB_INHDRERRORS);
+			/* icmpv6_param_prob() calls kfree_skb(skb) */
 			icmpv6_param_prob(skb, ICMPV6_HDR_FIELD, prob_offset);
 		}
 		return ret;
-- 
2.19.1



