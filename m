Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8707F218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788318;
	bh=XiuiRCDKUzJagGSX8GVvQrHCcld29/Eke8+NlEPwfP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vaGWyOXThmZxDe+Z7F2VgpZxq346OvlwwrA3TEkvejOj5iWHShJ55hpqk6o2S2+EN
	 xXQ3Jx220c8J0AmzzVml4oVtHvONNuuSU68jXKikNXw4jhOtzRBD+NAy1/KBjsT04j
	 6yrPngoiOuOKYWsm09Ll3aE/Jim0pfIRsmYXa4iU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfIRGb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfIRGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:22:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EFF7218AE;
        Wed, 18 Sep 2019 06:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787773;
        bh=XiuiRCDKUzJagGSX8GVvQrHCcld29/Eke8+NlEPwfP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbYJ+e8FJ+pC44mJJjxh+gdlRp9Z3Ic3B0hjGe5INRlTLUhR1FlYXd4XbVriyq7QW
         xW2L4ZNZyONDnTHdb7n311v4h8zBMVCvTNm0oys1IhEhAUa04dwcXbTAqBPKXXw9RD
         v5Lp9SsdfMH87ZDpwgnFpLHM8FCz6gjJaPwtIaVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Tranchetti <stranche@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 06/50] net: Fix null de-reference of device refcount
Date:   Wed, 18 Sep 2019 08:18:49 +0200
Message-Id: <20190918061223.708235949@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
References: <20190918061223.116178343@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit 10cc514f451a0f239aa34f91bc9dc954a9397840 ]

In event of failure during register_netdevice, free_netdev is
invoked immediately. free_netdev assumes that all the netdevice
refcounts have been dropped prior to it being called and as a
result frees and clears out the refcount pointer.

However, this is not necessarily true as some of the operations
in the NETDEV_UNREGISTER notifier handlers queue RCU callbacks for
invocation after a grace period. The IPv4 callback in_dev_rcu_put
tries to access the refcount after free_netdev is called which
leads to a null de-reference-

44837.761523:   <6> Unable to handle kernel paging request at
                    virtual address 0000004a88287000
44837.761651:   <2> pc : in_dev_finish_destroy+0x4c/0xc8
44837.761654:   <2> lr : in_dev_finish_destroy+0x2c/0xc8
44837.762393:   <2> Call trace:
44837.762398:   <2>  in_dev_finish_destroy+0x4c/0xc8
44837.762404:   <2>  in_dev_rcu_put+0x24/0x30
44837.762412:   <2>  rcu_nocb_kthread+0x43c/0x468
44837.762418:   <2>  kthread+0x118/0x128
44837.762424:   <2>  ret_from_fork+0x10/0x1c

Fix this by waiting for the completion of the call_rcu() in
case of register_netdevice errors.

Fixes: 93ee31f14f6f ("[NET]: Fix free_netdev on register_netdev failure.")
Cc: Sean Tranchetti <stranche@codeaurora.org>
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8562,6 +8562,8 @@ int register_netdevice(struct net_device
 	ret = notifier_to_errno(ret);
 	if (ret) {
 		rollback_registered(dev);
+		rcu_barrier();
+
 		dev->reg_state = NETREG_UNREGISTERED;
 	}
 	/*


