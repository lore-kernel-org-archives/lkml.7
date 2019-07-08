Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249F7C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5392166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599686;
	bh=bnBg8bSk1oBoZuw31yBBPLVRo5aAPKtDhkgR04AM0/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BaB5V3H7UEEgT8R/uQxitKrgLYHiHmD2w7sKKt5MF/9vQ089th/6v4jSID3TUnBD/
	 CzAZK5y8+3bUAQKFmEiftg4Kf/YsCN8gSjWnHKNKk6mfBj4TSYzGKBOpgBKATarJD9
	 euqlcgj2/tbdA7RCzVkWdWVq23pNExVmcmjBzqDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbfGHP2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731881AbfGHP2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:28:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD032173E;
        Mon,  8 Jul 2019 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599679;
        bh=bnBg8bSk1oBoZuw31yBBPLVRo5aAPKtDhkgR04AM0/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9v+7xuItGXyhcoe4+Kv6G3iCvLAqaRyWke2FJKAsj2vKK4ndunss7bTbZYe3cvFK
         xhp4o4JR+MAPj33ko7KjobD5WgaeDJOzaWlpQI94VR3d/0II4qUFlMNCOLJ2sW7BUs
         QC9Ojc2QcVO5rgn8nRMDnKBTcUxrzre5JWbqzjSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 05/90] netfilter: nft_flow_offload: set liberal tracking mode for tcp
Date:   Mon,  8 Jul 2019 17:12:32 +0200
Message-Id: <20190708150522.638828851@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 8437a6209f76f85a2db1abb12a9bde2170801617 upstream.

Without it, whenever a packet has to be pushed up the stack (e.g. because
of mtu mismatch), then conntrack will flag packets as invalid, which in
turn breaks NAT.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_flow_offload.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -72,6 +72,7 @@ static void nft_flow_offload_eval(const
 	struct nf_flow_route route;
 	struct flow_offload *flow;
 	enum ip_conntrack_dir dir;
+	bool is_tcp = false;
 	struct nf_conn *ct;
 	int ret;
 
@@ -84,6 +85,8 @@ static void nft_flow_offload_eval(const
 
 	switch (ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum) {
 	case IPPROTO_TCP:
+		is_tcp = true;
+		break;
 	case IPPROTO_UDP:
 		break;
 	default:
@@ -109,6 +112,11 @@ static void nft_flow_offload_eval(const
 	if (!flow)
 		goto err_flow_alloc;
 
+	if (is_tcp) {
+		ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
+		ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
+	}
+
 	ret = flow_offload_add(flowtable, flow);
 	if (ret < 0)
 		goto err_flow_add;


