Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE74AC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B160B21848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119317;
	bh=RJVO5bS6hGN7PjVVg/vDRQirrvhgb5aRO4dGELRr25c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KnY6VCrKUDbz0TASv7QWU/G/Se3x4takewpcvB1iacOVFyW5TABor1OLMfSJta4U/
	 z14CZdB93fAXQZcY2TujbAg3aRT1g5hJ7IOFmkkY6CWz12NcqKEVvFLxM8GrN74TmZ
	 Ss1BSmtLR6aiFcDZxP7Ghk2ns9VXRd6W4LLq0y0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfJCQPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388829AbfJCQPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:15:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B202054F;
        Thu,  3 Oct 2019 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119311;
        bh=RJVO5bS6hGN7PjVVg/vDRQirrvhgb5aRO4dGELRr25c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDeun3UOls9S9soQcEwVB4ZtEXTmsAB/IFv7IVYIP9XnosHKx9TrgUH5Y2h58ByuP
         1eyzh98Srf5vmgDuFbRwdfVkpEtkKFISVK2dpTAAPlyOx1QE4ifi6lJbUItRrgWYHt
         9gxuTeA8/n4ygiyNaaSLceuKoBpUKQfgGRONTAcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 019/211] appletalk: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:51:25 +0200
Message-Id: <20191003154451.281556886@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ori Nimron <orinimron123@gmail.com>

[ Upstream commit 6cc03e8aa36c51f3b26a0d21a3c4ce2809c842ac ]

When creating a raw AF_APPLETALK socket, CAP_NET_RAW needs to be checked
first.

Signed-off-by: Ori Nimron <orinimron123@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/appletalk/ddp.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1028,6 +1028,11 @@ static int atalk_create(struct net *net,
 	 */
 	if (sock->type != SOCK_RAW && sock->type != SOCK_DGRAM)
 		goto out;
+
+	rc = -EPERM;
+	if (sock->type == SOCK_RAW && !kern && !capable(CAP_NET_RAW))
+		goto out;
+
 	rc = -ENOMEM;
 	sk = sk_alloc(net, PF_APPLETALK, GFP_KERNEL, &ddp_proto, kern);
 	if (!sk)


