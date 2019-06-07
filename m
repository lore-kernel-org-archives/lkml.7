Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E41C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5236212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfFGSsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:48:51 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.200]:15531 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730281AbfFGSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:48:50 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id DF35C379992
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 13:48:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZJuzhtoSfdnCeZJuzhWts2; Fri, 07 Jun 2019 13:48:49 -0500
X-Authority-Reason: nr=8
Received: from [189.250.134.24] (port=47344 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hZJux-002VU0-Ra; Fri, 07 Jun 2019 13:48:47 -0500
Date:   Fri, 7 Jun 2019 13:48:45 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: Use struct_size() helper
Message-ID: <20190607184845.GA13401@embeddedor>
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
X-Source-IP: 189.250.134.24
X-Source-L: No
X-Exim-ID: 1hZJux-002VU0-Ra
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.134.24]:47344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct spi_replaced_transfers {
	...
        struct spi_transfer inserted_transfers[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

insert * sizeof(struct spi_transfer) + sizeof(struct spi_replaced_transfers)

with:

struct_size(rxfer, inserted_transfers, insert)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e0cd8ccfe92d..69e492ed414a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2769,8 +2769,7 @@ struct spi_replaced_transfers *spi_replace_transfers(
 
 	/* allocate the structure using spi_res */
 	rxfer = spi_res_alloc(msg->spi, __spi_replace_transfers_release,
-			      insert * sizeof(struct spi_transfer)
-			      + sizeof(struct spi_replaced_transfers)
+			      struct_size(rxfer, inserted_transfers, insert)
 			      + extradatasize,
 			      gfp);
 	if (!rxfer)
-- 
2.21.0

