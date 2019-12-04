Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC83C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478152081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfLDPLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:11:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59536 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDPLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:11:49 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1icWJd-0007Tp-2m; Wed, 04 Dec 2019 15:11:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/decnet: fix -EFAULT error that is not getting returned
Date:   Wed,  4 Dec 2019 15:11:44 +0000
Message-Id: <20191204151144.1434209-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently an -EFAULT error on a memcpy_to_msg is not being returned
because it is being overwritten when variable rv is being re-assigned
to the number of bytes copied after breaking out of a loop. Fix this
by instead assigning the error to variable copied so that this error
code propegated to rv and hence is returned at the end of the function.

[ This bug was was introduced before the current git history ]

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/decnet/af_decnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
index e19a92a62e14..e23d9f219597 100644
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -1759,7 +1759,7 @@ static int dn_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			chunk = size - copied;
 
 		if (memcpy_to_msg(msg, skb->data, chunk)) {
-			rv = -EFAULT;
+			copied = -EFAULT;
 			break;
 		}
 		copied += chunk;
-- 
2.24.0

