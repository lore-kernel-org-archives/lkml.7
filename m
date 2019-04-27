Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF11C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB392206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfD0PUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:20:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33962 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727591AbfD0PPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:34 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP35-0000zO-Ka; Sat, 27 Apr 2019 16:15:31 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0004UJ-RU; Sat, 27 Apr 2019 16:15:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jacob Wen" <jian.w.wen@oracle.com>,
        "Guillaume Nault" <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.545615296@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 080/202] l2tp: copy 4 more bytes to linear part if
 necessary
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Wen <jian.w.wen@oracle.com>

commit 91c524708de6207f59dd3512518d8a1c7b434ee3 upstream.

The size of L2TPv2 header with all optional fields is 14 bytes.
l2tp_udp_recv_core only moves 10 bytes to the linear part of a
skb. This may lead to l2tp_recv_common read data outside of a skb.

This patch make sure that there is at least 14 bytes in the linear
part of a skb to meet the maximum need of l2tp_udp_recv_core and
l2tp_recv_common. The minimum size of both PPP HDLC-like frame and
Ethernet frame is larger than 14 bytes, so we are safe to do so.

Also remove L2TP_HDR_SIZE_NOSEQ, it is unused now.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
Acked-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -82,8 +82,7 @@
 #define L2TP_SLFLAG_S	   0x40000000
 #define L2TP_SL_SEQ_MASK   0x00ffffff
 
-#define L2TP_HDR_SIZE_SEQ		10
-#define L2TP_HDR_SIZE_NOSEQ		6
+#define L2TP_HDR_SIZE_MAX		14
 
 /* Default trace flags */
 #define L2TP_DEFAULT_DEBUG_FLAGS	0
@@ -897,7 +896,7 @@ static int l2tp_udp_recv_core(struct l2t
 	__skb_pull(skb, sizeof(struct udphdr));
 
 	/* Short packet? */
-	if (!pskb_may_pull(skb, L2TP_HDR_SIZE_SEQ)) {
+	if (!pskb_may_pull(skb, L2TP_HDR_SIZE_MAX)) {
 		l2tp_info(tunnel, L2TP_MSG_DATA,
 			  "%s: recv short packet (len=%d)\n",
 			  tunnel->name, skb->len);

