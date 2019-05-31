Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A4C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E57826D41
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfEaRfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:35:37 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.239]:35973 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfEaRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:35:36 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 6847EA54B
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:35:35 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id WlRHh2D5mYTGMWlRHh1FbM; Fri, 31 May 2019 12:35:35 -0500
X-Authority-Reason: nr=8
Received: from [189.250.123.250] (port=48162 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hWlRF-002R8Y-Qw; Fri, 31 May 2019 12:35:33 -0500
Date:   Fri, 31 May 2019 12:35:32 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i3c: master: Use struct_size() helper
Message-ID: <20190531173532.GA7141@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.123.250
X-Source-L: No
X-Exim-ID: 1hWlRF-002R8Y-Qw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.123.250]:48162
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(*defslvs) + ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc))

with:

struct_size(defslvs, slaves, ndevs - 1)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i3c/master.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b9d2b88928e1..923b04052038 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -924,9 +924,8 @@ int i3c_master_defslvs_locked(struct i3c_master_controller *master)
 		ndevs++;
 
 	defslvs = i3c_ccc_cmd_dest_init(&dest, I3C_BROADCAST_ADDR,
-					sizeof(*defslvs) +
-					((ndevs - 1) *
-					 sizeof(struct i3c_ccc_dev_desc)));
+					struct_size(defslvs, slaves,
+					ndevs - 1));
 	if (!defslvs)
 		return -ENOMEM;
 
-- 
2.21.0

