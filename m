Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D49C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FF321E71
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTdwHlDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbfHGNbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:31:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbfHGNb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kretIwKkWxye/psg+87LaplK6rnUq+TvEVUnHaHn8vY=; b=tTdwHlDoYsf+gZct1YtEdRsV06
        wM6KafdPKrn9Ykk+qfbtyLl23lB6HCPCKtAVSEEAkMUmeYwHpiQ1hfXCwt0ymyf4a2WxJu0pubLDt
        MgYHtECpW3hNHfuIxZdlsF6SLz5tBEBKh3IjQS5NoACGHHU3k8lhZ8VaS0r2TQHIThGPDQq9RogTQ
        jqcpBYrbdWpum6GjncHmnKpCxYra/zx/nX5CSb65W/9uGMayq4dtikm0ZYZFk82qNssmcEj0zLhFC
        KsY5ul9nhPXlJKheLY+Gyls7qJxes4GlI6ByBc21WEubrbV5RA3U0cAYgmEpOZ59Te6oVjWdfJqqz
        4iCdXYpw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvM2J-00086w-3n; Wed, 07 Aug 2019 13:31:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/29] qla1280: remove SGI SN2 support
Date:   Wed,  7 Aug 2019 16:30:31 +0300
Message-Id: <20190807133049.20893-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807133049.20893-1-hch@lst.de>
References: <20190807133049.20893-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SGI SN2 support is about to be removed, so drops the bits
specific to it from this driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/qla1280.c | 37 -------------------------------------
 drivers/scsi/qla1280.h |  3 ---
 2 files changed, 40 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index e5760c4a27f0..832af4213046 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -357,10 +357,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
 
-#if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
-#include <asm/sn/io.h>
-#endif
-
 
 /*
  * Compile time Options:
@@ -380,11 +376,6 @@
 
 #define NVRAM_DELAY()			udelay(500)	/* 2 microseconds */
 
-#if defined(__ia64__) && !defined(ia64_platform_is)
-#define ia64_platform_is(foo)		(!strcmp(x, platform_name))
-#endif
-
-
 #define IS_ISP1040(ha) (ha->pdev->device == PCI_DEVICE_ID_QLOGIC_ISP1020)
 #define IS_ISP1x40(ha) (ha->pdev->device == PCI_DEVICE_ID_QLOGIC_ISP1020 || \
 			ha->pdev->device == PCI_DEVICE_ID_QLOGIC_ISP1240)
@@ -1427,15 +1418,6 @@ qla1280_initialize_adapter(struct scsi_qla_host *ha)
 	ha->flags.reset_active = 0;
 	ha->flags.abort_isp_active = 0;
 
-#if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
-	if (ia64_platform_is("sn2")) {
-		printk(KERN_INFO "scsi(%li): Enabling SN2 PCI DMA "
-		       "dual channel lockup workaround\n", ha->host_no);
-		ha->flags.use_pci_vchannel = 1;
-		driver_setup.no_nvram = 1;
-	}
-#endif
-
 	/* TODO: implement support for the 1040 nvram format */
 	if (IS_ISP1040(ha))
 		driver_setup.no_nvram = 1;
@@ -2251,13 +2233,6 @@ qla1280_nvram_config(struct scsi_qla_host *ha)
 	mb[1] = nv->firmware_feature.f.enable_fast_posting;
 	mb[1] |= nv->firmware_feature.f.report_lvd_bus_transition << 1;
 	mb[1] |= nv->firmware_feature.f.disable_synchronous_backoff << 5;
-#if defined(CONFIG_IA64_GENERIC) || defined (CONFIG_IA64_SGI_SN2)
-	if (ia64_platform_is("sn2")) {
-		printk(KERN_INFO "scsi(%li): Enabling SN2 PCI DMA "
-		       "workaround\n", ha->host_no);
-		mb[1] |= nv->firmware_feature.f.unused_9 << 9; /* XXX */
-	}
-#endif
 	status |= qla1280_mailbox_command(ha, BIT_1 | BIT_0, mb);
 
 	/* Retry count and delay. */
@@ -2888,12 +2863,6 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 				break;
 
 			dma_handle = sg_dma_address(s);
-#if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
-			if (ha->flags.use_pci_vchannel)
-				sn_pci_set_vchan(ha->pdev,
-						 (unsigned long *)&dma_handle,
-						 SCSI_BUS_32(cmd));
-#endif
 			*dword_ptr++ =
 				cpu_to_le32(lower_32_bits(dma_handle));
 			*dword_ptr++ =
@@ -2950,12 +2919,6 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 				if (cnt == 5)
 					break;
 				dma_handle = sg_dma_address(s);
-#if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
-				if (ha->flags.use_pci_vchannel)
-					sn_pci_set_vchan(ha->pdev,
-							 (unsigned long *)&dma_handle,
-							 SCSI_BUS_32(cmd));
-#endif
 				*dword_ptr++ =
 					cpu_to_le32(lower_32_bits(dma_handle));
 				*dword_ptr++ =
diff --git a/drivers/scsi/qla1280.h b/drivers/scsi/qla1280.h
index b496206362a9..a1a8aefc7cc3 100644
--- a/drivers/scsi/qla1280.h
+++ b/drivers/scsi/qla1280.h
@@ -1055,9 +1055,6 @@ struct scsi_qla_host {
 		uint32_t reset_active:1;		/* 3 */
 		uint32_t abort_isp_active:1;		/* 4 */
 		uint32_t disable_risc_code_load:1;	/* 5 */
-#ifdef __ia64__
-		uint32_t use_pci_vchannel:1;
-#endif
 	} flags;
 
 	struct nvram nvram;
-- 
2.20.1

