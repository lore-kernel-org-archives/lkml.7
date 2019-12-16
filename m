Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40188C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124D7207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519673;
	bh=5a748kLGJg5Pdn84wMLWJVrxWQepfISWoeHI/WVEMYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iVG7eJylWIWyyYykcZCkYEJEmv+E8z4dPd+b3ayFOnRB0EJ3jr6XG/ODQkeKXq9qK
	 H3OmvWOASUU9uGunQR2pv1Fn369q0XNwuQ5/r8d/2wpBv9VtmU9SJMHjGnd3zS7Ff2
	 JlwTaM4khg1Wom1YE6epnNV/LLj7goKKiW1p5UcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfLPSHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbfLPSHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:07:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956A4206E0;
        Mon, 16 Dec 2019 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519667;
        bh=5a748kLGJg5Pdn84wMLWJVrxWQepfISWoeHI/WVEMYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQUOS4KJXfM79pSFjg2o1ExhT3drJ2/Qt5f72SCaGgntV7TXtlUl4ibRnvv0NIueM
         hp+qErzeMx9lTGqGz2vVNGe9Ro4uPMWxJNijc5d9cpDNl2MqcYvhdgn4bWAnfJhWpB
         wmtwBakrUPiL59QlfmuY9j8eDPPChVWKVazmuWos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 5.3 002/180] usb: gadget: pch_udc: fix use after free
Date:   Mon, 16 Dec 2019 18:47:22 +0100
Message-Id: <20191216174806.440411757@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 66d1b0c0580b7f1b1850ee4423f32ac42afa2e92 upstream.

Remove pointer dereference after free.

pci_pool_free doesn't care about contents of td.
It's just a void* for it

Addresses-Coverity-ID: 1091173 ("Use after free")
Cc: stable@vger.kernel.org
Acked-by: Michal Nazarewicz <mina86@mina86.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Link: https://lore.kernel.org/r/20191106202821.GA20347@embeddedor
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/pch_udc.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -1519,7 +1519,6 @@ static void pch_udc_free_dma_chain(struc
 		td = phys_to_virt(addr);
 		addr2 = (dma_addr_t)td->next;
 		dma_pool_free(dev->data_requests, td, addr);
-		td->next = 0x00;
 		addr = addr2;
 	}
 	req->chain_len = 1;


