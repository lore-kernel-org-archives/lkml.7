Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85002C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F34F206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099512;
	bh=xeSHTjHw5FlDqtyGFzehkBt0I2QT5H9ITeHORj+bs48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rl1y2jIMnfLxERJsQbVze9LMQYGXfyYZZ78giCprcg7U/r6lX3NQfl8DxekoZJG5w
	 abOwZdcKikwP191pNEWsid9rcxKjL9Lg4M0Fv35B9dWDXopi1ABtMDm7XJNUPzmcna
	 JIAQJNIEb/EkOsgDjO6rS0rv//TfsGYHw6GI1FsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfFIQ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbfFIQ61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:58:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62CC20843;
        Sun,  9 Jun 2019 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099507;
        bh=xeSHTjHw5FlDqtyGFzehkBt0I2QT5H9ITeHORj+bs48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oThWBxp7pQlIC4me4mLkNI8PWYX9pX2/XS7zfoe5nuF5K9WAWNtm6YavhcWiK0Y2b
         W988STzFZEp823J570GdfY1/HQqzgrCiwer5975pfuSJGAi0dqbJIARgSs54LhBmkw
         aufWMaj1cB5A0TqebMLgORWn3+mKtXdOnyqw0knU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 065/241] xfrm6_tunnel: Fix potential panic when unloading xfrm6_tunnel module
Date:   Sun,  9 Jun 2019 18:40:07 +0200
Message-Id: <20190609164149.657415203@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6ee02a54ef990a71bf542b6f0a4e3321de9d9c66 ]

When unloading xfrm6_tunnel module, xfrm6_tunnel_fini directly
frees the xfrm6_tunnel_spi_kmem. Maybe someone has gotten the
xfrm6_tunnel_spi, so need to wait it.

Fixes: 91cc3bb0b04ff("xfrm6_tunnel: RCU conversion")
Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/xfrm6_tunnel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -391,6 +391,10 @@ static void __exit xfrm6_tunnel_fini(voi
 	xfrm6_tunnel_deregister(&xfrm6_tunnel_handler, AF_INET6);
 	xfrm_unregister_type(&xfrm6_tunnel_type, AF_INET6);
 	unregister_pernet_subsys(&xfrm6_tunnel_net_ops);
+	/* Someone maybe has gotten the xfrm6_tunnel_spi.
+	 * So need to wait it.
+	 */
+	rcu_barrier();
 	kmem_cache_destroy(xfrm6_tunnel_spi_kmem);
 }
 


