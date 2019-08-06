Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36400C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B07206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jRJr7Jqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbfHFIcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:32:31 -0400
Received: from gateway20.websitewelcome.com ([192.185.4.169]:32818 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfHFIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:32:31 -0400
X-Greylist: delayed 1460 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Aug 2019 04:32:31 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3E372400CCC9F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2019 02:04:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uuVuhKzHT3Qi0uuVuh4Lqf; Tue, 06 Aug 2019 03:08:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tqouW1qc7UK4ejwDOesOIcmQuJMwuxvioRsJeeb5IM4=; b=jRJr7JqsYbSOKqd3gMKqlUEGdo
        P3OgHdi2UEwTbXofL3M+SRi1gJ2Z4GjkdghudNwCHsdYrMJkwpFcWX+0UbTYUX+g2UZYBDHMss7RY
        1v9RcUlL3gZI0JB/wonWbx1xTppZ7c0L5/luX6ETiDSh8PCNRtX/j04bfAx5Km1AjSASCjRQXvtKU
        wUmmu0YtI2mqcVQPswZx5+FrCe2CAUgQxi9y8xu+4J2WGaeKjzKpsr+GbBhAf8ySTfcs8Xj5AyCSU
        yabIKstVHzxCdxNqDLqDCNAXwfAO/3idG1hHr3reEdXk2bmjvHo+fU2n7tXGGVY68sT47qwcBqP1j
        CCkwmx0Q==;
Received: from [187.192.11.120] (port=43488 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1huuVt-000ibV-Rp; Tue, 06 Aug 2019 03:08:09 -0500
Date:   Tue, 6 Aug 2019 03:08:08 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ata: rb532_cf: Fix unused variable warning in
 rb532_pata_driver_probe
Message-ID: <20190806080808.GA30026@embeddedor>
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
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1huuVt-000ibV-Rp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:43488
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning (Building: rb532_defconfig mips):

drivers/ata/pata_rb532_cf.c: In function ‘rb532_pata_driver_remove’:
drivers/ata/pata_rb532_cf.c:161:24: warning: unused variable ‘info’ [-Wunused-variable]
  struct rb532_cf_info *info = ah->private_data;
                        ^~~~

Fixes: cd56f35e52d9 ("ata: rb532_cf: Convert to use GPIO descriptors")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ata/pata_rb532_cf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 7c37f2ff09e4..deae466395de 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -158,7 +158,6 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 static int rb532_pata_driver_remove(struct platform_device *pdev)
 {
 	struct ata_host *ah = platform_get_drvdata(pdev);
-	struct rb532_cf_info *info = ah->private_data;
 
 	ata_host_detach(ah);
 
-- 
2.22.0

