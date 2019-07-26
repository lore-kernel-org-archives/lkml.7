Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F8AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C589F218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155027;
	bh=ZR35wzuuqft4MCSMoZUmWn/SZjadH6eInU+f59OcpAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14LApQ4eqltSIKWOo09Ie8Tp9788E0vlGg7A/zlgkftZfysatsoiqfQVUdnGP8sS9
	 bK+AXR1ib/YwA2zqhdq0+77ihpv9QN5QQvpPIWAcGivcBZyIU+6Fd5qK8rsNPCjYSa
	 jsD9hxQiXvfm7aPA+5v+MczqtWf4Oi+THBJacQfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfGZPa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389064AbfGZPaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034E5205F4;
        Fri, 26 Jul 2019 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155021;
        bh=ZR35wzuuqft4MCSMoZUmWn/SZjadH6eInU+f59OcpAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGg8IVIbY1zOIjXGOy4IJsVQUCqzhujAolkt8/Q2EuU8tUf8WL4yeu+qNBZ94eRxF
         2wjjMDp8p4RykRlOTybk/sTDRAslJqTziyNIJeXdetP41rnVAs9fYUj0+daA3QmXZ8
         AOKcY/cnwDhwd9sdJBhdLxvPVQaxBcxPBkMB3zFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 38/62] net/tls: reject offload of TLS 1.3
Date:   Fri, 26 Jul 2019 17:24:50 +0200
Message-Id: <20190726152305.969679023@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 618bac45937a3dc6126ac0652747481e97000f99 ]

Neither drivers nor the tls offload code currently supports TLS
version 1.3. Check the TLS version when installing connection
state. TLS 1.3 will just fallback to the kernel crypto for now.

Fixes: 130b392c6cd6 ("net: tls: Add tls 1.3 support")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -746,6 +746,11 @@ int tls_set_device_offload(struct sock *
 	}
 
 	crypto_info = &ctx->crypto_send.info;
+	if (crypto_info->version != TLS_1_2_VERSION) {
+		rc = -EOPNOTSUPP;
+		goto free_offload_ctx;
+	}
+
 	switch (crypto_info->cipher_type) {
 	case TLS_CIPHER_AES_GCM_128:
 		nonce_size = TLS_CIPHER_AES_GCM_128_IV_SIZE;
@@ -880,6 +885,9 @@ int tls_set_device_offload_rx(struct soc
 	struct net_device *netdev;
 	int rc = 0;
 
+	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
+		return -EOPNOTSUPP;
+
 	/* We support starting offload on multiple sockets
 	 * concurrently, so we only need a read lock here.
 	 * This lock must precede get_netdev_for_sock to prevent races between


