Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5023F21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256885;
	bh=LL9vF//DPh36mv6QmBbUkNlhFZ7cX0H28wWuGhFwb24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ip/m5OdLzqWX4pQpotVHVGcYlZaM6bquqEMvkIVromiXTSS+9jRd6BBzYnUx/H07
	 ga4IXFbbujOSc8xnVLtEEYmBdNPe7mqSotzxIOFrs8ys5uSvmzDjFKC8d6LyyXvlnn
	 d9aYg2J35mck8wZf2cFXKApzPcwT0EFBFB0qB8aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389948AbfCVMOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389929AbfCVMOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D092083D;
        Fri, 22 Mar 2019 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256878;
        bh=LL9vF//DPh36mv6QmBbUkNlhFZ7cX0H28wWuGhFwb24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vvvYtNP2hrexbJ3iv0+wWOfZxUyJZB9k0eta9cgKLbTlFtw0EJPCMBeOmf/GsQtcv
         lSK7KQ3032Y9wE3fBjqQUKZB8CfAYqP5IpylAirYNUU73Ww/R3I/OlX0AScEdCknOD
         odDrQsRCsQLKP8D1ZYBGEJgJPgKBjgNThk22SJes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.0 065/238] spi: ti-qspi: Fix mmap read when more than one CS in use
Date:   Fri, 22 Mar 2019 12:14:44 +0100
Message-Id: <20190322111302.435078188@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
 


