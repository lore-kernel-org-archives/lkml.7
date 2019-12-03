Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4211C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44B520803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413859;
	bh=ul5Cg8tPcy+pDFTV9nsJhnC1xFGJAPx1zaE1M0mW2/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OdFShv4IIUFB/DamP3tz8jYP/ErSdFPf8S/5dRBaPMOgZAUubfjDjGLTJmLAXt7Uw
	 WDL+gexQu2XBD/3hxtUFbVWtCrlduXhk+1OQxdvfj45rOv1A99wWKQotqTQpb4I/Gj
	 uryJQ4yo4axXBOCLKxxWzzJMp9XRE5Qgllc9YSTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfLCW5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730558AbfLCW5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:57:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D092220656;
        Tue,  3 Dec 2019 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413855;
        bh=ul5Cg8tPcy+pDFTV9nsJhnC1xFGJAPx1zaE1M0mW2/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yjXSlWNQ66giG/uAha4eYHnp6A05ahw7cN+i3HwvQDX4TUzg5Id2N4mqzNBXHjdrC
         WKUGPXUWdPgCz5aZsfAbVbx9kXSsmh2kbruqaWd2n7PjoHptYNbCxU2eNG11PfsXuk
         ++pGXE9mq/BGDoQKFtax0YiLrDsHGRt3urBcw8uA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 287/321] openvswitch: drop unneeded BUG_ON() in ovs_flow_cmd_build_info()
Date:   Tue,  3 Dec 2019 23:35:53 +0100
Message-Id: <20191203223442.067383233@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 8ffeb03fbba3b599690b361467bfd2373e8c450f ]

All the callers of ovs_flow_cmd_build_info() already deal with
error return code correctly, so we can handle the error condition
in a more gracefull way. Still dump a warning to preserve
debuggability.

v1 -> v2:
 - clarify the commit message
 - clean the skb and report the error (DaveM)

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/datapath.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -879,7 +879,10 @@ static struct sk_buff *ovs_flow_cmd_buil
 	retval = ovs_flow_cmd_fill_info(flow, dp_ifindex, skb,
 					info->snd_portid, info->snd_seq, 0,
 					cmd, ufid_flags);
-	BUG_ON(retval < 0);
+	if (WARN_ON_ONCE(retval < 0)) {
+		kfree_skb(skb);
+		skb = ERR_PTR(retval);
+	}
 	return skb;
 }
 


