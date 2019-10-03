Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE86C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA0E20862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124598;
	bh=fH7xEbLSbHI/G2E3fCNaLnww3DvBBPdljFfySDZlM1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W1rIUsrLik57AcXHiP7RpLczVnEiVJBM0WSlRJ0iU3SsS1HnABgUu/iSldfUcgVlh
	 vYt7GRaoxuPn7l5Xh5iFGR9XKapBPZ1E95z5VFFlWXQN3N7tEPwK94wUc+q0fRFDbF
	 bWqdOEbrVLzQA/zMtiJlPtLUeQ/2oahimOXuYzuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390620AbfJCRnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbfJCP4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:56:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1883D207FF;
        Thu,  3 Oct 2019 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118193;
        bh=fH7xEbLSbHI/G2E3fCNaLnww3DvBBPdljFfySDZlM1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zsU6sq2S3UQDAj9qEPKF/y1dNgp4zXlv0WyhX31Dqdkd522KayDRReEzj08CnmRDA
         ab8Fpc6WyawYHx8BZZ7/a2RQRdFMicznUgzaMLgscllTLpWzM4MMMvyFVgY1INh19x
         ekKf941jQ6Ezpw0BLqTOEB2DvMnZRT8rTN+u0Uwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 23/99] openvswitch: change type of UPCALL_PID attribute to NLA_UNSPEC
Date:   Thu,  3 Oct 2019 17:52:46 +0200
Message-Id: <20191003154305.326578184@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit ea8564c865299815095bebeb4b25bef474218e4c ]

userspace openvswitch patch "(dpif-linux: Implement the API
functions to allow multiple handler threads read upcall)"
changes its type from U32 to UNSPEC, but leave the kernel
unchanged

and after kernel 6e237d099fac "(netlink: Relax attr validation
for fixed length types)", this bug is exposed by the below
warning

	[   57.215841] netlink: 'ovs-vswitchd': attribute type 5 has an invalid length.

Fixes: 5cd667b0a456 ("openvswitch: Allow each vport to have an array of 'port_id's")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/datapath.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2152,7 +2152,7 @@ static const struct nla_policy vport_pol
 	[OVS_VPORT_ATTR_STATS] = { .len = sizeof(struct ovs_vport_stats) },
 	[OVS_VPORT_ATTR_PORT_NO] = { .type = NLA_U32 },
 	[OVS_VPORT_ATTR_TYPE] = { .type = NLA_U32 },
-	[OVS_VPORT_ATTR_UPCALL_PID] = { .type = NLA_U32 },
+	[OVS_VPORT_ATTR_UPCALL_PID] = { .type = NLA_UNSPEC },
 	[OVS_VPORT_ATTR_OPTIONS] = { .type = NLA_NESTED },
 };
 


