Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBD5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E385F206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483325;
	bh=Fqy2V9pstkUaLR5WHnRKMDI0Hyl7tpgth3ERKdbjpQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AC1bmjQRBYHLZ96wciwsThLwvyPf6quQMW0njSQwaQgWdfTPLO1QPATtyWDlLQHlh
	 TupKvY8dr77Aw4/pn8oBSRvtGwF9PI4LnGi8coUmOI5hpYvskS0GYG0pnqwc0nkvLh
	 Akg+EEHV3sFoUJh9e0VMdZNCDm/ZzU0ZfwfiNQp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfLDSO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731902AbfLDSOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:14:23 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE0DA2084B;
        Wed,  4 Dec 2019 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483263;
        bh=Fqy2V9pstkUaLR5WHnRKMDI0Hyl7tpgth3ERKdbjpQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xByFWaflxGdA1VQQ1e/7nmP/TrgxYXPCb84kyEKj3QOVz6zYQLRW6kwJBRSMeg3qP
         s2ddEeYwwuWKK47IaYQLjbMlqv+0Rn9ao4Jg7hw/uS6P/TxrrDdNEZAr1oInGpewjN
         9AUKBr4gWIsXfXtOq4ecUVEMJ6cb0a9mJhcKu5tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 118/125] openvswitch: remove another BUG_ON()
Date:   Wed,  4 Dec 2019 18:57:03 +0100
Message-Id: <20191204175326.412838887@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 8a574f86652a4540a2433946ba826ccb87f398cc ]

If we can't build the flow del notification, we can simply delete
the flow, no need to crash the kernel. Still keep a WARN_ON to
preserve debuggability.

Note: the BUG_ON() predates the Fixes tag, but this change
can be applied only after the mentioned commit.

v1 -> v2:
 - do not leak an skb on error

Fixes: aed067783e50 ("openvswitch: Minimize ovs_flow_cmd_del critical section.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/datapath.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1350,7 +1350,10 @@ static int ovs_flow_cmd_del(struct sk_bu
 						     OVS_FLOW_CMD_DEL,
 						     ufid_flags);
 			rcu_read_unlock();
-			BUG_ON(err < 0);
+			if (WARN_ON_ONCE(err < 0)) {
+				kfree_skb(reply);
+				goto out_free;
+			}
 
 			ovs_notify(&dp_flow_genl_family, reply, info);
 		} else {
@@ -1358,6 +1361,7 @@ static int ovs_flow_cmd_del(struct sk_bu
 		}
 	}
 
+out_free:
 	ovs_flow_free(flow, true);
 	return 0;
 unlock:


