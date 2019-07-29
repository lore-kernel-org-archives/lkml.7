Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A199BC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0D92054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429466;
	bh=YigfFDnmjzRzlG0TXoyYJNv0M+tq3HrAyYwfziZy7w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1NGSYRUiBRWUjMEJoJ/oJcr8bMln8Yvn+XSTMwqFVfY/Ww9RNhaN/fnzP958tJ/Cj
	 8tv4V3HKIhL83k8+8JvhCzmv9wMP4+2F4lVU21FzXpeVg2GCv81wECMsOWuh4nq0it
	 ic6pc1BvYBZ84TZrz8KtAJjw3R9w0/xvNc2vqo5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbfG2ToZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389782AbfG2ToV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:44:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C742054F;
        Mon, 29 Jul 2019 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429460;
        bh=YigfFDnmjzRzlG0TXoyYJNv0M+tq3HrAyYwfziZy7w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DA25LkEQC+pqjb7Wh5TdxS63nH0ifhPszCi8rKXlB8YhstRYLZyG31A0yaKQh0Ml6
         kVNWdM+tkQ3CiEi8WSIKQuSnEmmK/wd9rsPLU7QuGD1DiTMoN6ZBu1zX6DtgySrAWv
         O1dk0WWG/gVHx8XVCaZhN5PbFK36bAiBks5vsrDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 4.19 104/113] fpga-manager: altera-ps-spi: Fix build error
Date:   Mon, 29 Jul 2019 21:23:11 +0200
Message-Id: <20190729190720.313071536@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
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
@@ -39,6 +39,7 @@ config ALTERA_PR_IP_CORE_PLAT
 config FPGA_MGR_ALTERA_PS_SPI
 	tristate "Altera FPGA Passive Serial over SPI"
 	depends on SPI
+	select BITREVERSE
 	help
 	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
 	  using the passive serial interface over SPI.


