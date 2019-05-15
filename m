Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854C5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DF6206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919452;
	bh=GfhtyttpR9e4STYqhRJbAfPWRn+8c4aYPgYsUzV6DzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KsIeddLEMDJ5btudv/4YQyLgSBcogGm1depJ0JUL1z/8obyyaXzuVa5G5laiOc/D6
	 mdojJqT+nIPNWVE9fJu8HakSQBMAAiJKRgWyiXmkvXTd9ZwSthFXgrPohPcz0sF4q0
	 OVF1wk+JHRy7iZlEQFF9/iqkxMDUvwR2KtjEUng0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbfEOLYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731286AbfEOLYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:24:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF51A206BF;
        Wed, 15 May 2019 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919446;
        bh=GfhtyttpR9e4STYqhRJbAfPWRn+8c4aYPgYsUzV6DzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjCvmh1FkE3nyVJeq2b+CPaMmJH5d0evTmbtYdpfPgC8CaTyrSOZaFyp0twaZiy7z
         TEVIZq/criTlRp/iZXIAi5nWHnnO8ylnKBoLKawe/Lyh/AlfXZUKxJ3b2AElXZjKeF
         FUUTIFv1IwzDYmODok6hykPti38NZyoIssGLdRic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.19 077/113] net/tls: fix the IV leaks
Date:   Wed, 15 May 2019 12:56:08 +0200
Message-Id: <20190515090659.425348533@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5a03bc73abed6ae196c15e9950afde19d48be12c ]

Commit f66de3ee2c16 ("net/tls: Split conf to rx + tx") made
freeing of IV and record sequence number conditional to SW
path only, but commit e8f69799810c ("net/tls: Add generic NIC
offload infrastructure") also allocates that state for the
device offload configuration.  Remember to free it.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tls/tls_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f4a19eac975db..fdf22cb0b3e6b 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -52,8 +52,11 @@ static DEFINE_SPINLOCK(tls_device_lock);
 
 static void tls_device_free_ctx(struct tls_context *ctx)
 {
-	if (ctx->tx_conf == TLS_HW)
+	if (ctx->tx_conf == TLS_HW) {
 		kfree(tls_offload_ctx_tx(ctx));
+		kfree(ctx->tx.rec_seq);
+		kfree(ctx->tx.iv);
+	}
 
 	if (ctx->rx_conf == TLS_HW)
 		kfree(tls_offload_ctx_rx(ctx));
-- 
2.20.1



