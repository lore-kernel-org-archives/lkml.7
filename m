Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74D8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C67218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbfDXQh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:37:59 -0400
Received: from gateway30.websitewelcome.com ([192.185.152.11]:38239 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731700AbfDXQh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:37:56 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 22B895A7C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:37:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id JKuAhWlny2PzOJKuBh2XzW; Wed, 24 Apr 2019 11:37:55 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.223] (port=40162 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hJKu8-003F0u-Na; Wed, 24 Apr 2019 11:37:54 -0500
Date:   Wed, 24 Apr 2019 11:37:32 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH net-next] cnic: Refactor code and mark expected switch
 fall-through
Message-ID: <20190424163732.GA12492@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.223
X-Source-L: No
X-Exim-ID: 1hJKu8-003F0u-Na
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.223]:40162
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, refactor code a
bit and mark switch cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/net/ethernet/broadcom/cnic.c: In function ‘cnic_cm_process_kcqe’:
drivers/net/ethernet/broadcom/cnic.c:4044:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
    opcode = L4_KCQE_OPCODE_VALUE_CLOSE_COMP;
drivers/net/ethernet/broadcom/cnic.c:4050:2: note: here
  case L4_KCQE_OPCODE_VALUE_RESET_RECEIVED:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/broadcom/cnic.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index 510dfc1c236b..57dc3cbff36e 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -4038,15 +4038,14 @@ static void cnic_cm_process_kcqe(struct cnic_dev *dev, struct kcqe *kcqe)
 	case L5CM_RAMROD_CMD_ID_CLOSE: {
 		struct iscsi_kcqe *l5kcqe = (struct iscsi_kcqe *) kcqe;
 
-		if (l4kcqe->status != 0 || l5kcqe->completion_status != 0) {
-			netdev_warn(dev->netdev, "RAMROD CLOSE compl with status 0x%x completion status 0x%x\n",
-				    l4kcqe->status, l5kcqe->completion_status);
-			opcode = L4_KCQE_OPCODE_VALUE_CLOSE_COMP;
-			/* Fall through */
-		} else {
+		if (l4kcqe->status == 0 && l5kcqe->completion_status == 0)
 			break;
-		}
+
+		netdev_warn(dev->netdev, "RAMROD CLOSE compl with status 0x%x completion status 0x%x\n",
+			    l4kcqe->status, l5kcqe->completion_status);
+		opcode = L4_KCQE_OPCODE_VALUE_CLOSE_COMP;
 	}
+		/* Fall through */
 	case L4_KCQE_OPCODE_VALUE_RESET_RECEIVED:
 	case L4_KCQE_OPCODE_VALUE_CLOSE_COMP:
 	case L4_KCQE_OPCODE_VALUE_RESET_COMP:
-- 
2.21.0

