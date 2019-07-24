Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6A2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ED822ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997333;
	bh=Zui+Y95a8U24rYFho+CbP5JtAUkVNJtHI9RDcy+HTvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vOf+RdcOKMO8readbHCF3QVKF5oDJouUb9fXqctjb0SssEcK5y/NrwvtWumEwU7T3
	 DfukWBH3CEOUD6NRju3PkUFDLBMCxNkuiW7+Q7dhSlPYt4dlfMDx2R+ByaCaARa20P
	 bi99j2mhlMFNdnCAs5TPtBVatyYOKneykrcI9VJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbfGXTmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfGXTmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:42:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E518022AEC;
        Wed, 24 Jul 2019 19:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997324;
        bh=Zui+Y95a8U24rYFho+CbP5JtAUkVNJtHI9RDcy+HTvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZZ2d+IqEh15/UKYJfYdqUr33DW0HrgFfzYDhq0afSxWDS7ia7c9fEmfsx3slxnXv
         ImiF5kQ1BTE9WzHagLPfmsboqpTZKIgVS9rd86tMbYNfBGuR5UeWO0DO4Mr0ZnQxQW
         EhHH+8Fwr+OM0r0VE3s2DC/bWo+uC5Y8uvdAY4q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Weixiong Liao <liaoweixiong@allwinnertech.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.2 398/413] mtd: spinand: read returns badly if the last page has bitflips
Date:   Wed, 24 Jul 2019 21:21:29 +0200
Message-Id: <20190724191803.377727180@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liaoweixiong <liaoweixiong@allwinnertech.com>

commit b83408b580eccf8d2797cd6cb9ae42c2a28656a7 upstream.

In case of the last page containing bitflips (ret > 0),
spinand_mtd_read() will return that number of bitflips for the last
page while it should instead return max_bitflips like it does when the
last page read returns with 0.

Signed-off-by: Weixiong Liao <liaoweixiong@allwinnertech.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: stable@vger.kernel.org
Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/spi/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -511,12 +511,12 @@ static int spinand_mtd_read(struct mtd_i
 		if (ret == -EBADMSG) {
 			ecc_failed = true;
 			mtd->ecc_stats.failed++;
-			ret = 0;
 		} else {
 			mtd->ecc_stats.corrected += ret;
 			max_bitflips = max_t(unsigned int, max_bitflips, ret);
 		}
 
+		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
 	}


