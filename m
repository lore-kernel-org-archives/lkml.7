Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08191C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BF52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127763;
	bh=3TbLcuFwlu1Tk3iqgGesrxWiD8uIOc3zA7AZtHsAOj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hNimDyWx70CEA5chhTnqiL0/K3pyvcOCa1EgactEV3HURfdrMhWMN/MetNcpeEh+R
	 9ilfLzbGLUAreQbpvo1olihdUi65bJWy+TIgEEYuaJcDODDn7X4ak/xA4ZsIRJO6hb
	 D+U9h4uhr7jLCRlDuKqg87P3q8FjdXKdb4bI+RjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391958AbfDXRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391927AbfDXRff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:35 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9C721905;
        Wed, 24 Apr 2019 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127335;
        bh=3TbLcuFwlu1Tk3iqgGesrxWiD8uIOc3zA7AZtHsAOj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBw3ZQVHCJV0webxnYPj+kEPrws7Izoh49nxcritwxy9pTfv0orwI4KqAcPrE5EIL
         1Z+p+r9rLsSFh1BaHhTDbelYvCUatqtyS7r+ccbNfxUUJHjLO+3wHSDtf3kBLWUHAJ
         Nlo04spJgGpBOWoT/Dre5xRpx510u3fuS5shE4ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 025/115] net/tls: fix build without CONFIG_TLS_DEVICE
Date:   Wed, 24 Apr 2019 19:09:21 +0200
Message-Id: <20190424170926.519593198@linuxfoundation.org>
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

[ Upstream commit 903f1a187776bb8d79b13618ec05b25f86318885 ]

buildbot noticed that TLS_HW is not defined if CONFIG_TLS_DEVICE=n.
Wrap the cleanup branch into an ifdef, tls_device_free_resources_tx()
wouldn't be compiled either in this case.

Fixes: 35b71a34ada6 ("net/tls: don't leak partially sent record in device mode")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -298,8 +298,10 @@ static void tls_sk_proto_close(struct so
 		kfree(ctx->tx.rec_seq);
 		kfree(ctx->tx.iv);
 		tls_sw_free_resources_tx(sk);
+#ifdef CONFIG_TLS_DEVICE
 	} else if (ctx->tx_conf == TLS_HW) {
 		tls_device_free_resources_tx(sk);
+#endif
 	}
 
 	if (ctx->rx_conf == TLS_SW) {


