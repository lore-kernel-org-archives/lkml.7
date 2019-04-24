Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27E020675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127315;
	bh=P3sFKFtkuDb7hi5TIx/KRVv2qcR+uaX2D962qb2EPQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X9HaYdLSMJpaiH12xg6TAqX3nUbB0Qsz4nni+Pqjo2ZGKdhMAZnEMQ1IK5cyr7yKL
	 wUig8qzFF85IYpH4FPZvh+GjE0RwVOYWRuo7/4Ek/QHZ5fdN3x9qXrvf1g/MDdrLDi
	 e5EgyRpygPXLL4IIbQui9MPMkUYlYADt7sAgIrPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391177AbfDXRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391284AbfDXRfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:07 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF0F20675;
        Wed, 24 Apr 2019 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127306;
        bh=P3sFKFtkuDb7hi5TIx/KRVv2qcR+uaX2D962qb2EPQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vH9+HPjO1kST3eHUJtAR90RTuVL4D3qKqaHgJ3XWz/L/Lbl2mfoL2vIC6TcifCBKJ
         meSpyd402+1TXAGnP19O0owNMLS4o+CvGuqEVTbNyjbLIzcWGDQFu8fbnkuMKdPCvy
         5HQKVCwTFbTm5hE28HpipX2/zsq+y4pN9NoNRZUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 024/115] net: strparser: partially revert "strparser: Call skb_unclone conditionally"
Date:   Wed, 24 Apr 2019 19:09:20 +0200
Message-Id: <20190424170926.463200926@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 4a9c2e3746e6151fd5d077259d79ce9ca86d47d7 ]

This reverts the first part of commit 4e485d06bb8c ("strparser: Call
skb_unclone conditionally").  To build a message with multiple
fragments we need our own root of frag_list.  We can't simply
use the frag_list of orig_skb, because it will lead to linking
all orig_skbs together creating very long frag chains, and causing
stack overflow on kfree_skb() (which is called recursively on
the frag_lists).

BUG: stack guard page was hit at 00000000d40fad41 (stack is 0000000029dde9f4..000000008cce03d5)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP
RIP: 0010:free_one_page+0x2b/0x490

Call Trace:
  __free_pages_ok+0x143/0x2c0
  skb_release_data+0x8e/0x140
  ? skb_release_data+0xad/0x140
  kfree_skb+0x32/0xb0

  [...]

  skb_release_data+0xad/0x140
  ? skb_release_data+0xad/0x140
  kfree_skb+0x32/0xb0
  skb_release_data+0xad/0x140
  ? skb_release_data+0xad/0x140
  kfree_skb+0x32/0xb0
  skb_release_data+0xad/0x140
  ? skb_release_data+0xad/0x140
  kfree_skb+0x32/0xb0
  skb_release_data+0xad/0x140
  ? skb_release_data+0xad/0x140
  kfree_skb+0x32/0xb0
  skb_release_data+0xad/0x140
  __kfree_skb+0xe/0x20
  tcp_disconnect+0xd6/0x4d0
  tcp_close+0xf4/0x430
  ? tcp_check_oom+0xf0/0xf0
  tls_sk_proto_close+0xe4/0x1e0 [tls]
  inet_release+0x36/0x60
  __sock_release+0x37/0xa0
  sock_close+0x11/0x20
  __fput+0xa2/0x1d0
  task_work_run+0x89/0xb0
  exit_to_usermode_loop+0x9a/0xa0
  do_syscall_64+0xc0/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Let's leave the second unclone conditional, as I'm not entirely
sure what is its purpose :)

Fixes: 4e485d06bb8c ("strparser: Call skb_unclone conditionally")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -140,13 +140,11 @@ static int __strp_recv(read_descriptor_t
 			/* We are going to append to the frags_list of head.
 			 * Need to unshare the frag_list.
 			 */
-			if (skb_has_frag_list(head)) {
-				err = skb_unclone(head, GFP_ATOMIC);
-				if (err) {
-					STRP_STATS_INCR(strp->stats.mem_fail);
-					desc->error = err;
-					return 0;
-				}
+			err = skb_unclone(head, GFP_ATOMIC);
+			if (err) {
+				STRP_STATS_INCR(strp->stats.mem_fail);
+				desc->error = err;
+				return 0;
 			}
 
 			if (unlikely(skb_shinfo(head)->frag_list)) {


