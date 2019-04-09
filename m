Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60264C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ACB2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfDIM7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:59:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55225 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfDIM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:59:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hDqLJ-0001qy-6B; Tue, 09 Apr 2019 12:59:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dns: remove redundant zero length namelen check
Date:   Tue,  9 Apr 2019 13:59:12 +0100
Message-Id: <20190409125912.11600-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The zero namelen check is redundant as it has already been checked
for zero at the start of the function.  Remove the redundant check.

Addresses-Coverity: ("Logically Dead Code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/dns_resolver/dns_query.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 76338c38738a..19aa32fc1802 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -94,8 +94,6 @@ int dns_query(const char *type, const char *name, size_t namelen,
 		desclen += typelen + 1;
 	}
 
-	if (!namelen)
-		namelen = strnlen(name, 256);
 	if (namelen < 3 || namelen > 255)
 		return -EINVAL;
 	desclen += namelen + 1;
-- 
2.20.1

