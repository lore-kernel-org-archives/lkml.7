Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB61C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F6A2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413079;
	bh=Fqy2V9pstkUaLR5WHnRKMDI0Hyl7tpgth3ERKdbjpQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BfplzZIvTGUrBe3tMLku94CgUrIBPtFSfLdq11ndp9pAS4Q5yVSHjvSMpjm6rqovp
	 vXhfTAD40GE3bNs2MfU6LH1d8oSe4yKgc01ZafQQPyPzxb/C5GMHqUDyG1E9nimAPs
	 kWE6Zmnw+YQrQtGYzQPRruhDDFdQinzCymxzTlM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfLCWoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbfLCWoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:44:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E22B2084F;
        Tue,  3 Dec 2019 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413071;
        bh=Fqy2V9pstkUaLR5WHnRKMDI0Hyl7tpgth3ERKdbjpQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTk6biJsWme+oDfPtnEEoTIcYN2YPO1uLZTLag9UK9zHwdEGHjAwiDluWtBHtkpnt
         pciT1J/DrWX65bgd5x0G6DFDjehBgRyikH/vy3Fqn3XA2dX0DoMZaNGtR6dVpYOyfD
         3E+tLT9AKTws91N6YUee7a7dh+N02Xycc2v3FiMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 121/135] openvswitch: remove another BUG_ON()
Date:   Tue,  3 Dec 2019 23:36:01 +0100
Message-Id: <20191203213044.359229942@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
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


