Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D365C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5032067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240945;
	bh=H8DwnQzxdmC9AtSbI+5z2WagDrrcQST/upFS0U/jWFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EVCXnuz9CbujL0kd/+nmmK3/S9XKi4c/80zueype4lw+IF0+czUZ7s9sBslt1cphi
	 bOYBVzv2+I5ONS/XN7YZGZGPKCBHyGb0R0URjRzR6Ei4zlBMWKFZIlkfAOBejyC9by
	 vxXIpKq8bPL2zLqFWBAhzCuxqt+eIzgIXSKDs3KY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbfKHS41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388133AbfKHS4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:56:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ECAB218AE;
        Fri,  8 Nov 2019 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239374;
        bh=H8DwnQzxdmC9AtSbI+5z2WagDrrcQST/upFS0U/jWFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNnaL5ekdVNTtI85o3Bgvd/UE4iadRSOlBNX20Qm/micE23oW3yUUjRmJYj1Ab9kb
         ikYAMx8s67f8G+AdGnUQU6vRSt1pPMoYxzCKL2UgTLg1GeOjTwwT/oQnlyKWA63Fjn
         roHXpCUzckC2YtKztVBL1BKKcnDYqmTjp5WFeUPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Thiemo Nagel <tnagel@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 18/34] dccp: do not leak jiffies on the wire
Date:   Fri,  8 Nov 2019 19:50:25 +0100
Message-Id: <20191108174638.029422308@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3d1e5039f5f87a8731202ceca08764ee7cb010d3 ]

For some reason I missed the case of DCCP passive
flows in my previous patch.

Fixes: a904a0693c18 ("inet: stop leaking jiffies on the wire")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Thiemo Nagel <tnagel@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ipv4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -417,7 +417,7 @@ struct sock *dccp_v4_request_recv_sock(c
 	RCU_INIT_POINTER(newinet->inet_opt, rcu_dereference(ireq->ireq_opt));
 	newinet->mc_index  = inet_iif(skb);
 	newinet->mc_ttl	   = ip_hdr(skb)->ttl;
-	newinet->inet_id   = jiffies;
+	newinet->inet_id   = prandom_u32();
 
 	if (dst == NULL && (dst = inet_csk_route_child_sock(sk, newsk, req)) == NULL)
 		goto put_and_exit;


