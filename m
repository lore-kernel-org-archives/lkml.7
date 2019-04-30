Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03ACC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDD120449
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624858;
	bh=wQYNk2uhaBXecovP1IXWiB971SGFgdrDNZ+tcTGf43Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oGAILXGWcyjXBTaUQh0h4DgQb5QQjWX9lb6R8E4uYT/ZT/Py6vXX2DNWcAnit/SL9
	 5cKmJNjaaB0G5VCbTYteMfW5AqhP6B1KS6E8v5aP4tj2JEtVbVdbJQI5/ZBcwmVvcc
	 N1XC++y4ErZy3iiDeWq4HgnXhdH4fiPGNP4GHPn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfD3Lrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730148AbfD3Lrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:47:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D602054F;
        Tue, 30 Apr 2019 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624854;
        bh=wQYNk2uhaBXecovP1IXWiB971SGFgdrDNZ+tcTGf43Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjZ5XLYgj/tmXXp1o3+X6/Hejo6jz9k1tYjBXvGloMuddnpt8n/oXJuJAbtF+XJ6K
         K306lQ65Bd/6vGs0xsfOW+V+o+FgMs+F/oBeEcCuYjNgQgO2e0F0PO11YMmA2UBOse
         Flj3m6ZOyL2NlwoqoiCPxVn2MGdzTDq6TGSAWa/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 099/100] net/tls: avoid potential deadlock in tls_set_device_offload_rx()
Date:   Tue, 30 Apr 2019 13:39:08 +0200
Message-Id: <20190430113613.514018491@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 62ef81d5632634d5e310ed25b9b940b2b6612b46 ]

If device supports offload, but offload fails tls_set_device_offload_rx()
will call tls_sw_free_resources_rx() which (unhelpfully) releases
and reacquires the socket lock.

For a small fix release and reacquire the device_offload_lock.

Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -874,7 +874,9 @@ int tls_set_device_offload_rx(struct soc
 	goto release_netdev;
 
 free_sw_resources:
+	up_read(&device_offload_lock);
 	tls_sw_free_resources_rx(sk);
+	down_read(&device_offload_lock);
 release_ctx:
 	ctx->priv_ctx_rx = NULL;
 release_netdev:


