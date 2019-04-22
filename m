Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F99C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244F420874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfDVPkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:40:43 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:26369 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbfDVPkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:40:42 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id D01A7400CB727
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 10:40:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ib3hhI3IcYTGMIb3hhOUd6; Mon, 22 Apr 2019 10:40:41 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.103] (port=38134 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hIb3h-001651-0x; Mon, 22 Apr 2019 10:40:41 -0500
Date:   Mon, 22 Apr 2019 10:40:38 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: most: core: replace strcpy() by strscpy()
Message-ID: <20190422154038.GA27411@embeddedor>
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
X-Source-IP: 189.250.104.103
X-Source-L: No
X-Exim-ID: 1hIb3h-001651-0x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.103]:38134
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strcpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warning:

"You might overrun the 80-character fixed-size string iface->p->name
by copying iface->description without checking the length."

Addresses-Coverity-ID: 1444760 ("Copy into fixed size buffer")
Fixes: 131ac62253db ("staging: most: core: use device description as name")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/most/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 956daf8c3bd2..f0b834300c6e 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -1431,7 +1431,7 @@ int most_register_interface(struct most_interface *iface)
 
 	INIT_LIST_HEAD(&iface->p->channel_list);
 	iface->p->dev_id = id;
-	strcpy(iface->p->name, iface->description);
+	strscpy(iface->p->name, iface->description, sizeof(iface->p->name));
 	iface->dev.init_name = iface->p->name;
 	iface->dev.bus = &mc.bus;
 	iface->dev.parent = &mc.dev;
-- 
2.21.0

