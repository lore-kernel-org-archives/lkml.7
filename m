Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B816C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522812089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128229;
	bh=o6dfvxVLTN6bUyrNkt4QNFimpnMomLKx90wVkhuIxP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpZvzGWnqLxsgS4Mnpe6cfwJGoY8qsILx1l1pCBYPfaWKI7OztU+VXRO+5Ts1T5t+
	 J0hJ15fOCSFFxg3s2mJezfUt3Ow9YGyHDsp4lv4sQvKSfLJOuEAuHwaXqeuf9CfQoT
	 56NKknCJPctHhZXecnAyNjRES9cb4mpTwVgJLROc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbfDXR3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390832AbfDXR3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:42 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B342120811;
        Wed, 24 Apr 2019 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126981;
        bh=o6dfvxVLTN6bUyrNkt4QNFimpnMomLKx90wVkhuIxP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nB5WTmcajDqhQKJv7nl2PjVX15R8qFZ6v+qmlHyY8Cf9gKSXXWsFzp1xReMgX0129
         UCRDCcPGYERXRczYD+pnl7s1c75GPEtmegFnlEH2tcZuRUtU4Fltj7e1q5UvdF2oq1
         Ud4ZhdyMZuvK6hElz4sqY/p5muPsYUaf0ZOq4vqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 17/96] net/tls: prevent bad memory access in tls_is_sk_tx_device_offloaded()
Date:   Wed, 24 Apr 2019 19:09:22 +0200
Message-Id: <20190424170920.919405999@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit b4f47f3848eb70986f75d06112af7b48b7f5f462 ]

Unlike '&&' operator, the '&' does not have short-circuit
evaluation semantics.  IOW both sides of the operator always
get evaluated.  Fix the wrong operator in
tls_is_sk_tx_device_offloaded(), which would lead to
out-of-bounds access for for non-full sockets.

Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tls.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -317,7 +317,7 @@ tls_validate_xmit_skb(struct sock *sk, s
 static inline bool tls_is_sk_tx_device_offloaded(struct sock *sk)
 {
 #ifdef CONFIG_SOCK_VALIDATE_XMIT
-	return sk_fullsock(sk) &
+	return sk_fullsock(sk) &&
 	       (smp_load_acquire(&sk->sk_validate_xmit_skb) ==
 	       &tls_validate_xmit_skb);
 #else


