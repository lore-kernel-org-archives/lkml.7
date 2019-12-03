Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6544AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA402053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413976;
	bh=7His517HIkpxcCkY+lqk1TQkXuKS/1654XySQ2ACWI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhaLZa8VnEPYJ174/NM+S3dCfqlVW9y7gQT9l+FdjNC+1tVf3NJfcl3X8K1p9/Y/l
	 XgibpCxSPcTehwDvI0Y+Zl/Xz6Wc8czCm35ximdeYTIUEtspTx5DqHK/3rpHdjSAlJ
	 2W6rx1stjKYhwU4Ak/wo/5aTQbXQsUnHVRbwuY74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfLCW7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730742AbfLCW7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:59:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C1520656;
        Tue,  3 Dec 2019 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413945;
        bh=7His517HIkpxcCkY+lqk1TQkXuKS/1654XySQ2ACWI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERxvnvP/Q2vj2CVI+Z4G/Ax39ORLEdn0lBQdC7QnFBtT7+p6ie6Q7rKD5rt6rMASI
         nndBkFdtktZLRDPsqjczSpIIp6e16JDaMF3V0RqsUvW46ddpQKQMrXVsH6wwv3YoL8
         +X9UJ6nIUMm9GiHxvwn3t/x1pnh67oYE8ocSLFrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "huijin.park" <huijin.park@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 300/321] mtd: spi-nor: cast to u64 to avoid uint overflows
Date:   Tue,  3 Dec 2019 23:36:06 +0100
Message-Id: <20191203223442.757758877@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huijin.park <huijin.park@samsung.com>

commit 84a1c2109d23df3543d96231c4fee1757299bb1a upstream.

The "params->size" is defined as "u64".
And "info->sector_size" and "info->n_sectors" are defined as
unsigned int and u16.
Thus, u64 data might have strange data(loss data) if the result
overflows an unsigned int.
This patch casts "info->sector_size" to an u64.

Signed-off-by: huijin.park <huijin.park@samsung.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/spi-nor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct sp
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
-	params->size = info->sector_size * info->n_sectors;
+	params->size = (u64)info->sector_size * info->n_sectors;
 	params->page_size = info->page_size;
 
 	/* (Fast) Read settings. */


