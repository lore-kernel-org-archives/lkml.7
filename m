Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD0DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F32E206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DWdHrQLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfHFHu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:50:57 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.31]:28558 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731946AbfHFHu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:50:57 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 2B5C23D2B0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2019 02:50:56 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uuFEhKpVx3Qi0uuFEh4CDX; Tue, 06 Aug 2019 02:50:56 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BLQJA0ZrIGSjNwAj/WHSkr6DM6khrjzA0+pF5VmmsmM=; b=DWdHrQLk2XlqdgAc9eA42TO10d
        TxRxW4ldd8yVBZOzcglkunMfnY3Dc/NCGpSRGLtGsY15dF0mMnGjEEZpXHMYHOxOVmUjS6Uf+VTt2
        qe5b7EFfDKEUQZ9ffTMSjRK/uF79FRbVp8XNQqzlGSHoJ6OUIVF3gbDH8wEe5VsXDwBYK/o2jNLfX
        HVDqMXqnppkEt/pl7BKCl9Fi+zRXxnStJ3Zf4Hhfjrfxl/0I4K2FxsU+set7Zt26ZxX0xF2VDxaMJ
        fy6tdsN2qSDg3n/1JGTTxly3sge5LJhuFSGOmbDMFMDOOM7T2UDehOLFZWsNvCOF5t9Rr4/Oih8KW
        MBuYnMPQ==;
Received: from [187.192.11.120] (port=43460 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1huuFC-000YPs-U1; Tue, 06 Aug 2019 02:50:55 -0500
Date:   Tue, 6 Aug 2019 02:50:54 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c: designware: Fix unused variable warning in
 i2c_dw_init_recovery_info
Message-ID: <20190806075054.GA15418@embeddedor>
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
X-Exim-ID: 1huuFC-000YPs-U1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:43460
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

drivers/i2c/busses/i2c-designware-master.c: In function ‘i2c_dw_init_recovery_info’:
drivers/i2c/busses/i2c-designware-master.c:658:6: warning: unused variable ‘r’ [-Wunused-variable]
  int r;
      ^

Fixes: 33eb09a02e8d ("i2c: designware: make use of devm_gpiod_get_optional")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 867787dade43..e8b328242256 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -655,7 +655,6 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
 	struct i2c_adapter *adap = &dev->adapter;
 	struct gpio_desc *gpio;
-	int r;
 
 	gpio = devm_gpiod_get_optional(dev->dev, "scl", GPIOD_OUT_HIGH);
 	if (IS_ERR_OR_NULL(gpio))
-- 
2.22.0

