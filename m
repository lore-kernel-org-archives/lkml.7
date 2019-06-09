Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F1AC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6F3205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100201;
	bh=2GIXIYzyc2bRJV1VoIiHwA6B1C2BcKL3dkvr9OdC9Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vXc/tG2TJyCuF+WVBYaeJuVS7fbfpBHZIFwFdphvCmrrmPBNSRgHeSTKSXTlTDGP5
	 ZBdbCM1u31iIMHZA+4bOifQOK6Yz/zKF+rBskF3ynl6Yb7IkByf0llO58OzjjBhnRx
	 NGvbUvEJKBtKQCLws20754sPSLRmypeKvAyxriG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbfFIRJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388413AbfFIRDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:03:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6998204EC;
        Sun,  9 Jun 2019 17:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099805;
        bh=2GIXIYzyc2bRJV1VoIiHwA6B1C2BcKL3dkvr9OdC9Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zIID524Wc3wfygNndNEIq6s+Y8wvG55piU7TIQC3nRFdtv7tX761M+6velq+PY/Xu
         nCBKOwcmtVS72/vVmPCUfzljxrVRqxFgZ3OI9c6P6pnNNxEnX0uKLepizvzTkSI/Lk
         Q3H93r8BobAHWDQRkgw5m6cyF1MwSJritWivh+s0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 171/241] scsi: qla4xxx: avoid freeing unallocated dma memory
Date:   Sun,  9 Jun 2019 18:41:53 +0200
Message-Id: <20190609164152.724720064@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 608f729c31d4caf52216ea00d20092a80959256d ]

Clang -Wuninitialized notices that on is_qla40XX we never allocate any DMA
memory in get_fw_boot_info() but attempt to free it anyway:

drivers/scsi/qla4xxx/ql4_os.c:5915:7: error: variable 'buf_dma' is used uninitialized whenever 'if' condition is false
      [-Werror,-Wsometimes-uninitialized]
                if (!(val & 0x07)) {
                    ^~~~~~~~~~~~~
drivers/scsi/qla4xxx/ql4_os.c:5985:47: note: uninitialized use occurs here
        dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
                                                     ^~~~~~~
drivers/scsi/qla4xxx/ql4_os.c:5915:3: note: remove the 'if' if its condition is always true
                if (!(val & 0x07)) {
                ^~~~~~~~~~~~~~~~~~~
drivers/scsi/qla4xxx/ql4_os.c:5885:20: note: initialize the variable 'buf_dma' to silence this warning
        dma_addr_t buf_dma;
                          ^
                           = 0

Skip the call to dma_free_coherent() here.

Fixes: 2a991c215978 ("[SCSI] qla4xxx: Boot from SAN support for open-iscsi")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index c158967b59d7b..d220b4f691c77 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -5939,7 +5939,7 @@ static int get_fw_boot_info(struct scsi_qla_host *ha, uint16_t ddb_index[])
 		val = rd_nvram_byte(ha, sec_addr);
 		if (val & BIT_7)
 			ddb_index[1] = (val & 0x7f);
-
+		goto exit_boot_info;
 	} else if (is_qla80XX(ha)) {
 		buf = dma_alloc_coherent(&ha->pdev->dev, size,
 					 &buf_dma, GFP_KERNEL);
-- 
2.20.1



