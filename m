Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C709FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97238218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfCVOZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:25:50 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39509 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfCVOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:25:49 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MiIhU-1gT2oE0K5G-00fRHK; Fri, 22 Mar 2019 15:25:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Manish Rangankar <mrangankar@marvell.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla4xxx: avoid freeing unallocated dma memory
Date:   Fri, 22 Mar 2019 15:25:03 +0100
Message-Id: <20190322142530.904080-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ld3F0hrJatNfmdt2OFIuffWFZjGGDCNGuU01maFhBtmKx1JSAzs
 82c5XuRHym71YmZa7ql7llyTlp8QOnW+1mNalywMdDJxRBXOffWVuLPI7Ggp0K7u4+XQrHS
 4aXr/T9WVT8XdX669vcM2IAK5So35aKlRrtjkvibtd0AXLOZrsqTqZtG4JF6RKP/7GdMy1g
 kiZEJgOvUKaGpUQUOguMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CaVxR7jP4bQ=:3jhgTJyc6Qjfc/fcy/+yRp
 5sw95f6gxXneMgCqtiXwQAskl+Oy610fVWXOYJYoBHE7bxPicUxwRgSROCjjLhTbZeMIMDn9N
 kOhyyXkV2yWy7Cmyu9kI79Sv5hRTyRR/79Juy7j7ys2r5nGkz50I/PSAoP72V+GF8x70OmRio
 Yl6FF0P1cAg3lT+XvMMT/W7elMf3t/rFWctV/s6XcrqxoUSJMyPn9jwyd7B+grir0vyZrDQnY
 B8YPGIrwCOYDX2uv+YDzSb/cO4BvbFoEwZnuigqAJcM8zMMni6eqYh8p7Zgq1zC+p4kq2AlIf
 BT5MjVgNN1XlG25x7EI3Pf3ub9ghXQaIpdVOVK76zKZaCffkV7KeLceAT1cKS0JhdmQrkJG0I
 9ivg6VFrhyf8iEC40y2VJj2o2QjqhejmSaFCdvlTYYOpwLsHS6xch0RqyiSLecyzZ7N1jLEfu
 e335MZF+uFs47x+ogqw1lsmcMdyae79wtlx5iUvkYYQ2KV+zwt0zpa6cHBL7GeXQb3HP4NFr6
 z4eixQlPK1dA3uWo2pMV1PX6QF5eB1eeK2KyhiD7ynIW368Rvntuc/IhUMeub6/6VROA6Wu3i
 MoVNyGVI97tSmmCK63haWobnVb+cv9sGqxA+Emd4xySQ75MDdmATRjEkspdut2y41GxM7meRb
 O7lk+94zDhpFj/2SVDbkp78DHaebr8dUS+lG/I5+32d+sJEOI3aCFJf35FQhy84nsD1K0mtwH
 hmmykpOsu6CZjv/mUdcUsuv9NGTft/NqvpJvMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang -Wuninitialized notices that on is_qla40XX we never allocate
any DMA memory in get_fw_boot_info() but attempt to free it anyway:

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
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 16a18d5d856f..daa884fa43f4 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -5928,7 +5928,7 @@ static int get_fw_boot_info(struct scsi_qla_host *ha, uint16_t ddb_index[])
 		val = rd_nvram_byte(ha, sec_addr);
 		if (val & BIT_7)
 			ddb_index[1] = (val & 0x7f);
-
+		goto exit_boot_info;
 	} else if (is_qla80XX(ha)) {
 		buf = dma_alloc_coherent(&ha->pdev->dev, size,
 					 &buf_dma, GFP_KERNEL);
-- 
2.20.0

