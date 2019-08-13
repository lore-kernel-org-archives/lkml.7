Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7A4C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509E2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfHMO2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:28:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57512 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfHMO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:28:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hxXmc-0001H7-F2; Tue, 13 Aug 2019 14:28:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ieee802154: remove redundant assignment to rc
Date:   Tue, 13 Aug 2019 15:28:18 +0100
Message-Id: <20190813142818.15022-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable rc is initialized to a value that is never read and it is
re-assigned later. The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/ieee802154/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index dacbd58e1799..badc5cfe4dc6 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1092,7 +1092,7 @@ static struct packet_type ieee802154_packet_type = {
 
 static int __init af_ieee802154_init(void)
 {
-	int rc = -EINVAL;
+	int rc;
 
 	rc = proto_register(&ieee802154_raw_prot, 1);
 	if (rc)
-- 
2.20.1

