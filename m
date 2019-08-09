Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8732C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B612070D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437048AbfHIRDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:03:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38875 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436932AbfHIRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:03:07 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hw8I7-0006uW-LD; Fri, 09 Aug 2019 17:02:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next] rxrpc: fix uninitialized return value in variable err
Date:   Fri,  9 Aug 2019 18:02:59 +0100
Message-Id: <20190809170259.29859-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An earlier commit removed the setting of err to -ENOMEM so currently
the skb_shinfo(skb)->nr_frags > 16 check returns with an uninitialized
bogus return code.  Fix this by setting err to -ENOMEM to restore
the original behaviour.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: b214b2d8f277 ("rxrpc: Don't use skb_cow_data() in rxkad")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/rxrpc/rxkad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 8b4cddd8b673..c810a7c43b0f 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -248,8 +248,10 @@ static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 	crypto_skcipher_encrypt(req);
 
 	/* we want to encrypt the skbuff in-place */
-	if (skb_shinfo(skb)->nr_frags > 16)
+	if (skb_shinfo(skb)->nr_frags > 16) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	len = data_size + call->conn->size_align - 1;
 	len &= ~(call->conn->size_align - 1);
-- 
2.20.1

