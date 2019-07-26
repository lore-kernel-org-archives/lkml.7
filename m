Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DD4C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A611218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154830;
	bh=Sz43Jk6K+0CKPBk/2oB4wkkSjf+IM1nACiGhVNWupgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C0lzM3p0XNyafKbcUSrOGImecEWg6hOZxGzNIWXWt1JqyFROUIfHycNxgGpOlCiqG
	 M+k7IejpPpvR+vQuRvKDKBDUGP2NRxh8qQ+IsSqcE/Guqb7IO0uEWUSbomkrsOJ94J
	 2CropwHzW8gTkNtxCKi+OudCkHoXGyihh62ndnnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfGZP1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbfGZP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:27:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D24122CBF;
        Fri, 26 Jul 2019 15:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154825;
        bh=Sz43Jk6K+0CKPBk/2oB4wkkSjf+IM1nACiGhVNWupgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJ7y9QyhpspysskAEZKMAZaVsBe+DRoCidvdGAbMD8yRdlD5ncWIaaen/kBquXGuT
         a6U8MM8fjsgVh9l+yqqEnV4dbdXQY0GapVvVNwkMYV1Vx1E3GrIY0vmoXInBD56UgX
         yCa7PJd34JUAOtbnV2jrmLl+VEpDG3qtevRYQJS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Beckett <david.beckett@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 37/66] net/tls: fix poll ignoring partially copied records
Date:   Fri, 26 Jul 2019 17:24:36 +0200
Message-Id: <20190726152306.042706186@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 13aecb17acabc2a92187d08f7ca93bb8aad62c6f ]

David reports that RPC applications which use epoll() occasionally
get stuck, and that TLS ULP causes the kernel to not wake applications,
even though read() will return data.

This is indeed true. The ctx->rx_list which holds partially copied
records is not consulted when deciding whether socket is readable.

Note that SO_RCVLOWAT with epoll() is and has always been broken for
kernel TLS. We'd need to parse all records from the TCP layer, instead
of just the first one.

Fixes: 692d7b5d1f91 ("tls: Fix recvmsg() to be able to peek across multiple records")
Reported-by: David Beckett <david.beckett@netronome.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1958,7 +1958,8 @@ bool tls_sw_stream_read(const struct soc
 		ingress_empty = list_empty(&psock->ingress_msg);
 	rcu_read_unlock();
 
-	return !ingress_empty || ctx->recv_pkt;
+	return !ingress_empty || ctx->recv_pkt ||
+		!skb_queue_empty(&ctx->rx_list);
 }
 
 static int tls_read_size(struct strparser *strp, struct sk_buff *skb)


