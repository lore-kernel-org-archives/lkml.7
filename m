Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E41AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B9622CBE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155006;
	bh=aXuFXmvuOCl4TOVeyEZep3uEELKMMorlx56lvwHF+Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A7TlW88D5/b8H5NhRQBO30HH5mQ4EiylPRMbkA9ScENWhrPxp4Q2ihExgwHU4VTrr
	 0oGN/nDDo+VPVuNOeAdo92L9Aj2rirX+x+qh6YSEHNohRpimKrOb45wgkwj0JXd2L+
	 QCb+P63zAzGPdqw+VObimYIenxx0lDxwY84VVrMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbfGZPaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfGZPaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9C322CB9;
        Fri, 26 Jul 2019 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155001;
        bh=aXuFXmvuOCl4TOVeyEZep3uEELKMMorlx56lvwHF+Wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4cc0CK3EYog5ARZWK36iRdZvBcGRGxeNqd746JZgY8cGwhbKjA8QTRWsY+WA6HkM
         fvRJHMBMZPa7xYTfsbHUX1JSTkL1AJTefNU4dK28uNOztnhH8OUU1WuHEK8OwvN7jJ
         7grZZ349XmJA8fqg8NKlrVEcp8z8ZnSs7FpkTOp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 14/62] net_sched: unset TCQ_F_CAN_BYPASS when adding filters
Date:   Fri, 26 Jul 2019 17:24:26 +0200
Message-Id: <20190726152303.180484684@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 3f05e6886a595c9a29a309c52f45326be917823c ]

For qdisc's that support TC filters and set TCQ_F_CAN_BYPASS,
notably fq_codel, it makes no sense to let packets bypass the TC
filters we setup in any scenario, otherwise our packets steering
policy could not be enforced.

This can be reproduced easily with the following script:

 ip li add dev dummy0 type dummy
 ifconfig dummy0 up
 tc qd add dev dummy0 root fq_codel
 tc filter add dev dummy0 parent 8001: protocol arp basic action mirred egress redirect dev lo
 tc filter add dev dummy0 parent 8001: protocol ip basic action mirred egress redirect dev lo
 ping -I dummy0 192.168.112.1

Without this patch, packets are sent directly to dummy0 without
hitting any of the filters. With this patch, packets are redirected
to loopback as expected.

This fix is not perfect, it only unsets the flag but does not set it back
because we have to save the information somewhere in the qdisc if we
really want that. Note, both fq_codel and sfq clear this flag in their
->bind_tcf() but this is clearly not sufficient when we don't use any
class ID.

Fixes: 23624935e0c4 ("net_sched: TCQ_F_CAN_BYPASS generalization")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_api.c      |    1 +
 net/sched/sch_fq_codel.c |    2 --
 net/sched/sch_sfq.c      |    2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2162,6 +2162,7 @@ replay:
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held);
 		tfilter_put(tp, fh);
+		q->flags &= ~TCQ_F_CAN_BYPASS;
 	}
 
 errout:
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -600,8 +600,6 @@ static unsigned long fq_codel_find(struc
 static unsigned long fq_codel_bind(struct Qdisc *sch, unsigned long parent,
 			      u32 classid)
 {
-	/* we cannot bypass queue discipline anymore */
-	sch->flags &= ~TCQ_F_CAN_BYPASS;
 	return 0;
 }
 
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -828,8 +828,6 @@ static unsigned long sfq_find(struct Qdi
 static unsigned long sfq_bind(struct Qdisc *sch, unsigned long parent,
 			      u32 classid)
 {
-	/* we cannot bypass queue discipline anymore */
-	sch->flags &= ~TCQ_F_CAN_BYPASS;
 	return 0;
 }
 


