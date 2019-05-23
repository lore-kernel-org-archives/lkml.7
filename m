Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04267C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D718320851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbfEWTo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:44:59 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.107]:17793 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389131AbfEWTQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:16:12 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 6EA441BAAE
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:16:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TtCEhFKcm2qH7TtCEhUDBK; Thu, 23 May 2019 14:16:10 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=55194 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hTtCB-0043Zg-MW; Thu, 23 May 2019 14:16:07 -0500
Date:   Thu, 23 May 2019 14:16:06 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] mtd: onenand_base: Avoid fall-through warnings
Message-ID: <20190523191606.GA9838@embeddedor>
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
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hTtCB-0043Zg-MW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:55194
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOTICE THAT:

"...we don't know whether we need fallthroughs or breaks here and this
is just a change to avoid having new warnings when switching to
-Wimplicit-fallthrough but this change might be entirely wrong."[1]

See the original thread of discussion here:

https://lore.kernel.org/patchwork/patch/1036251/

So, in preparation to enabling -Wimplicit-fallthrough, this patch silences
the following warnings:

drivers/mtd/nand/onenand/onenand_base.c: In function ‘onenand_check_features’:
drivers/mtd/nand/onenand/onenand_base.c:3264:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (ONENAND_IS_DDP(this))
      ^
drivers/mtd/nand/onenand/onenand_base.c:3284:2: note: here
  case ONENAND_DEVICE_DENSITY_2Gb:
  ^~~~
drivers/mtd/nand/onenand/onenand_base.c:3288:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
   this->options |= ONENAND_HAS_UNLOCK_ALL;
drivers/mtd/nand/onenand/onenand_base.c:3290:2: note: here
  case ONENAND_DEVICE_DENSITY_1Gb:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Also, notice that this patch doesn't change any functionality. See the
most recent thread of discussion here:

https://lore.kernel.org/patchwork/patch/1077395/

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

[1] https://lore.kernel.org/lkml/20190509085318.34a9d4be@xps13/

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Add breaks instead of fall-through markings without altering any
   functionality.
 - Update changelog text.

 drivers/mtd/nand/onenand/onenand_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index f41d76248550..fd0da5c347db 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -3280,12 +3280,15 @@ static void onenand_check_features(struct mtd_info *mtd)
 			if ((this->version_id & 0xf) == 0xe)
 				this->options |= ONENAND_HAS_NOP_1;
 		}
+		this->options |= ONENAND_HAS_UNLOCK_ALL;
+		break;
 
 	case ONENAND_DEVICE_DENSITY_2Gb:
 		/* 2Gb DDP does not have 2 plane */
 		if (!ONENAND_IS_DDP(this))
 			this->options |= ONENAND_HAS_2PLANE;
 		this->options |= ONENAND_HAS_UNLOCK_ALL;
+		break;
 
 	case ONENAND_DEVICE_DENSITY_1Gb:
 		/* A-Die has all block unlock */
-- 
2.21.0

