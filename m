Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AAEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686A021906
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127521;
	bh=gEHx2/NtTgY/15Dh99oRaTdhvH7+AEKI5SrhEN1+VOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SBVjEUQpEZIjdrG8gaMz32BbauMhcispzz/UDksbkUQoMJ18r1wmYVFQNscAyY/BW
	 KnYPWM3So7rpAwyxOf7NLtnkbXgYQACojyTvUL1ikgvySJTQYPxmsXhctVmPeiDYAn
	 mHcB38O75mZ1Lnbo21Lg1N9zd/qC6lJU0UEi4H8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392072AbfDXRgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403930AbfDXRgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:38 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D52F520675;
        Wed, 24 Apr 2019 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127397;
        bh=gEHx2/NtTgY/15Dh99oRaTdhvH7+AEKI5SrhEN1+VOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtsnjwnajA5PQijjjZDbaA+XLCrP+MdwWyeD+jA/vDXNekZxbmKRuL2uX5PTYaYld
         8IIkjn3Dc5sTn5zRZ+kBH2o0/SEYDWU5BXTsWC3y9yfVie3XClB1Z6toXqdi2YONgt
         6H9hWEa7gQV5HnHXUQ/N8GMfv04P5fTAmc5xqKPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 022/115] net/tls: fix the IV leaks
Date:   Wed, 24 Apr 2019 19:09:18 +0200
Message-Id: <20190424170926.351892711@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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


