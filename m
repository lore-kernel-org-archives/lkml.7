Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C06DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D94321A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256238;
	bh=xql/hhdeWiiailQT00lRiApZb+d/wh6bNuxkWQcqQAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wkgudLItqjgwhDFmOkZ7VAH0+eMWdk6JheBi5ORIPNAqZnGhNaridV2DYt4d8ry42
	 gsX0HJGOQicnpCMCPS/y7mtkvV+2BgSz4hqvM78jiFw0MnHjjSMUX5VUWmdf6ZbFpr
	 pnzxxUe76i2v8WIQdJFXaEnzJsEhkO/WRYtUYDrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbfCVMD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388250AbfCVMDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:03:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3339F204FD;
        Fri, 22 Mar 2019 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256231;
        bh=xql/hhdeWiiailQT00lRiApZb+d/wh6bNuxkWQcqQAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCMJ+AJCAlBGwtyXuVBcWyNSo/xJHGqRQymQgR6E0y5IfE5Q9xkAFIvSLlypSZ6kY
         rGW4IOMU3JbrNEWz9qJHC/tume34gHPkJyYJqmcdp0hmB1o6SVEkZkKRh2leegD55T
         NY3ppqdYPD0/54ojvdnX+MvKbj+c7Anb9UWr7/W0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 148/280] spi: ti-qspi: Fix mmap read when more than one CS in use
Date:   Fri, 22 Mar 2019 12:15:01 +0100
Message-Id: <20190322111319.893848266@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>

commit 673c865efbdc5fec3cc525c46d71844d42c60072 upstream.

Commit 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support") has
has got order of parameter wrong when calling regmap_update_bits() to
select CS for mmap access. Mask and value arguments are interchanged.
Code will work on a system with single slave, but fails when more than
one CS is in use. Fix this by correcting the order of parameters when
calling regmap_update_bits().

Fixes: 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-ti-qspi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -490,8 +490,8 @@ static void ti_qspi_enable_memory_map(st
 	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base) {
 		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-				   MEM_CS_EN(spi->chip_select),
-				   MEM_CS_MASK);
+				   MEM_CS_MASK,
+				   MEM_CS_EN(spi->chip_select));
 	}
 	qspi->mmap_enabled = true;
 }
@@ -503,7 +503,7 @@ static void ti_qspi_disable_memory_map(s
 	ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base)
 		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-				   0, MEM_CS_MASK);
+				   MEM_CS_MASK, 0);
 	qspi->mmap_enabled = false;
 }
 


