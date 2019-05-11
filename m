Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11497C04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 01:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5358217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 01:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfEKBCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 21:02:53 -0400
Received: from www.osadl.org ([62.245.132.105]:35735 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfEKBCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 21:02:52 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x4B12Ipc001823;
        Sat, 11 May 2019 03:02:18 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes.berg@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] net: qrtr: use protocol endiannes variable
Date:   Sat, 11 May 2019 02:56:33 +0200
Message-Id: <1557536193-11949-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse was unable to verify endiannes correctness due to reassignment
from le32_to_cpu to the same variable - fix this warning up by providing
a proper __le32 type and initializing it. This is not actually fixing
any bug - rather just addressing the sparse warning.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located by an experimental coccinelle script to locate
patters that make sparse unhappy (false positives):

V2: Reorder variables to preserve reverse christmas tree ordering
    as requested by David Miller <davem@davemloft.net>.

sparse was unhappy about:
net/qrtr/qrtr.c:811:24: warning: cast to restricted __le32

The patch does change the binary - from inspection of the .lst files
it seems that the additional variable as well instruction reordering
constraints change the code even if the code-logic is the same.

Patch was compile-tested with: qcom_defconfig + QRTR=m
(with some unrelated warnings about not implemented system calls)

Patch is against 5.1 (localversion-next is next-20190510)

 net/qrtr/qrtr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index dd0e97f..801872a 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -728,12 +728,13 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	DECLARE_SOCKADDR(struct sockaddr_qrtr *, addr, msg->msg_name);
 	int (*enqueue_fn)(struct qrtr_node *, struct sk_buff *, int,
 			  struct sockaddr_qrtr *, struct sockaddr_qrtr *);
+	__le32 qrtr_type = cpu_to_le32(QRTR_TYPE_DATA);
 	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct qrtr_node *node;
 	struct sk_buff *skb;
+	u32 type = 0;
 	size_t plen;
-	u32 type = QRTR_TYPE_DATA;
 	int rc;
 
 	if (msg->msg_flags & ~(MSG_DONTWAIT))
@@ -807,8 +808,8 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		}
 
 		/* control messages already require the type as 'command' */
-		skb_copy_bits(skb, 0, &type, 4);
-		type = le32_to_cpu(type);
+		skb_copy_bits(skb, 0, &qrtr_type, 4);
+		type = le32_to_cpu(qrtr_type);
 	}
 
 	rc = enqueue_fn(node, skb, type, &ipc->us, addr);
-- 
2.1.4

