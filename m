Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3326206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429115;
	bh=O7vXi/mvoHLNCihrvF/geScUTRzpb0BoakrTcm462t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EXlQtTSQ70c4Dz99uXCmGffT1xhYxPwJryrbI69XQK2cSDdhfphivbEFDZ6cRh69A
	 wBtfE9HC1pEFiQIREdriTVG198QD37QrCWfCllKMCrndOYfpjMpGpV1tnXpjkoGddc
	 LpC6mIHkl06Odty2RRDzdI7pfNLRJ33PH2q59Hqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbfG2Tid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388867AbfG2Tia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:38:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D868206DD;
        Mon, 29 Jul 2019 19:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429109;
        bh=O7vXi/mvoHLNCihrvF/geScUTRzpb0BoakrTcm462t4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssIDsi9jsVQd11bVM67hlIaG5RpC/z99QXLBXl5sodNUb5v2h9d7xvJwuL0GnmVFo
         M7GCxb8tMzmDCJkmRjPdzAq4F0k+gQtrWA3KMP4iUb3gcaFLoxZirxukd4mB/LN+Sv
         S9A+PwfoHTNFL2YtEbE0ClmCSuo0qaUnJnrey81c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 4.14 287/293] fpga-manager: altera-ps-spi: Fix build error
Date:   Mon, 29 Jul 2019 21:22:58 +0200
Message-Id: <20190729190846.243225910@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 3d139703d397f6281368047ba7ad1c8bf95aa8ab upstream.

If BITREVERSE is m and FPGA_MGR_ALTERA_PS_SPI is y,
build fails:

drivers/fpga/altera-ps-spi.o: In function `altera_ps_write':
altera-ps-spi.c:(.text+0x4ec): undefined reference to `byte_rev_table'

Select BITREVERSE to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: fcfe18f885f6 ("fpga-manager: altera-ps-spi: use bitrev8x4")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
Link: https://lore.kernel.org/r/20190708071356.50928-1-yuehaibing@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/fpga/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -34,6 +34,7 @@ config FPGA_MGR_ALTERA_CVP
 config FPGA_MGR_ALTERA_PS_SPI
 	tristate "Altera FPGA Passive Serial over SPI"
 	depends on SPI
+	select BITREVERSE
 	help
 	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
 	  using the passive serial interface over SPI.


