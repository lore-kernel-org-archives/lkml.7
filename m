Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D95C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53ED2465E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613460;
	bh=tc1JC7MpyaeK+qFSFEsyTqWDgm32iu8OyE7yhl2cKUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXQuf2u8h/S90gse7jAUlf99ThRj4mIGFzlL+Z3p7NTJj0z+QYQLudeQ0OcgyhMVT
	 Sol0UqEJ4xSsCaRBB0tZW4Im3W7hKGBq30Ml01tCI+PJemKXzIlVxm2C3imAVY22dV
	 bZ4vlb6NJ6vCnQQ7B3/gw9dMucHEWhN4bTxD8hSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfLQUK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:10:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfLQUK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:10:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A04206D7;
        Tue, 17 Dec 2019 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613456;
        bh=tc1JC7MpyaeK+qFSFEsyTqWDgm32iu8OyE7yhl2cKUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ac/Q/3mBkdgXt6gp2XNj4q9/ZqMlpFelKHsRQTcNzCeT6GiGASJoDgWfeMGG2J0It
         vHScyleXErISprNxaaMmdRJtIlZPEAjnQalT3mrue788BNf9b3xV+8aMFbv+xo2HrA
         DRkieO4Ue0qTZ4ZJD/i6A8lA/f8nhQabWQ5Nr3vI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 28/37] act_ct: support asymmetric conntrack
Date:   Tue, 17 Dec 2019 21:09:49 +0100
Message-Id: <20191217200732.321097920@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Conole <aconole@redhat.com>

[ Upstream commit 95219afbb980f10934de9f23a3e199be69c5ed09 ]

The act_ct TC module shares a common conntrack and NAT infrastructure
exposed via netfilter.  It's possible that a packet needs both SNAT and
DNAT manipulation, due to e.g. tuple collision.  Netfilter can support
this because it runs through the NAT table twice - once on ingress and
again after egress.  The act_ct action doesn't have such capability.

Like netfilter hook infrastructure, we should run through NAT twice to
keep the symmetry.

Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")
Signed-off-by: Aaron Conole <aconole@redhat.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ct.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -329,6 +329,7 @@ static int tcf_ct_act_nat(struct sk_buff
 			  bool commit)
 {
 #if IS_ENABLED(CONFIG_NF_NAT)
+	int err;
 	enum nf_nat_manip_type maniptype;
 
 	if (!(ct_action & TCA_CT_ACT_NAT))
@@ -359,7 +360,17 @@ static int tcf_ct_act_nat(struct sk_buff
 		return NF_ACCEPT;
 	}
 
-	return ct_nat_execute(skb, ct, ctinfo, range, maniptype);
+	err = ct_nat_execute(skb, ct, ctinfo, range, maniptype);
+	if (err == NF_ACCEPT &&
+	    ct->status & IPS_SRC_NAT && ct->status & IPS_DST_NAT) {
+		if (maniptype == NF_NAT_MANIP_SRC)
+			maniptype = NF_NAT_MANIP_DST;
+		else
+			maniptype = NF_NAT_MANIP_SRC;
+
+		err = ct_nat_execute(skb, ct, ctinfo, range, maniptype);
+	}
+	return err;
 #else
 	return NF_ACCEPT;
 #endif


