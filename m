Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10460C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A73204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430242;
	bh=hM3Cw06sG+uY9q8n7DVamsw6wKd9UJaB/2X3M9tvu20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gfAGYohjXv/Y93905g+yFoaAnB6+OkRlj+++DsNDkmB1W11odT3uenjByN5kAJNCJ
	 Pur2SQCRWGPlckNYZkieu9VVWtgB7q+Ukj2sh4KxkAeyva1E0bDQkHVK0VMKQCMpVN
	 ly+xRXjwObNP6FPhhxnawiKosKa1MmMnRPVDhYOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbfG2T5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404060AbfG2Tyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:54:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD832054F;
        Mon, 29 Jul 2019 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564430070;
        bh=hM3Cw06sG+uY9q8n7DVamsw6wKd9UJaB/2X3M9tvu20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QstDM+oPVmkYE+ltiX84k6DTKUVlvSWalygPy6zLR+Eh2waE/nJC+fTxOxZI8dYEj
         jD0eFgXNO/Nyfe6LE3Psol4XSP+roFiRraqIlq0hXkFPRcLHH/QusL4qmWo2nWZq2i
         cfKE8Y0coph4v7EFtn/8lTAJWvx97K4fzvmx/O84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 5.2 186/215] fpga-manager: altera-ps-spi: Fix build error
Date:   Mon, 29 Jul 2019 21:23:02 +0200
Message-Id: <20190729190812.422865445@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
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
@@ -40,6 +40,7 @@ config ALTERA_PR_IP_CORE_PLAT
 config FPGA_MGR_ALTERA_PS_SPI
 	tristate "Altera FPGA Passive Serial over SPI"
 	depends on SPI
+	select BITREVERSE
 	help
 	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
 	  using the passive serial interface over SPI.


