Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A75C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D08A21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfEUExx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:53:53 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:47702 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfEUExs (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 21 May 2019 00:53:48 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 06:53:46 +0200
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 05:53:17 +0100
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@kernel.org,
        mgorman@techsingularity.net, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 10/14] net: teach the mm about range locking
Date:   Mon, 20 May 2019 21:52:38 -0700
Message-Id: <20190521045242.24378-11-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190521045242.24378-1-dave@stgolabs.net>
References: <20190521045242.24378-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion is straightforward, mmap_sem is used within the
the same function context most of the time. No change in
semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 net/ipv4/tcp.c     | 5 +++--
 net/xdp/xdp_umem.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53d61ca3ac4b..2be929dcafa8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1731,6 +1731,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	struct tcp_sock *tp;
 	int inq;
 	int ret;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	if (address & (PAGE_SIZE - 1) || address != zc->address)
 		return -EINVAL;
@@ -1740,7 +1741,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 
 	sock_rps_record_flow(sk);
 
-	down_read(&current->mm->mmap_sem);
+	mm_read_lock(current->mm, &mmrange);
 
 	ret = -EINVAL;
 	vma = find_vma(current->mm, address);
@@ -1802,7 +1803,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 		frags++;
 	}
 out:
-	up_read(&current->mm->mmap_sem);
+	mm_read_unlock(current->mm, &mmrange);
 	if (length) {
 		tp->copied_seq = seq;
 		tcp_rcv_space_adjust(sk);
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 2b18223e7eb8..2bf444fb998d 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -246,16 +246,17 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem)
 	unsigned int gup_flags = FOLL_WRITE;
 	long npgs;
 	int err;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	umem->pgs = kcalloc(umem->npgs, sizeof(*umem->pgs),
 			    GFP_KERNEL | __GFP_NOWARN);
 	if (!umem->pgs)
 		return -ENOMEM;
 
-	down_read(&current->mm->mmap_sem);
+	mm_read_lock(current->mm, &mmrange);
 	npgs = get_user_pages(umem->address, umem->npgs,
 			      gup_flags | FOLL_LONGTERM, &umem->pgs[0], NULL);
-	up_read(&current->mm->mmap_sem);
+	mm_read_unlock(current->mm, &mmrange);
 
 	if (npgs != umem->npgs) {
 		if (npgs >= 0) {
-- 
2.16.4

