Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4546C48BDD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 08:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD3220645
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 08:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3UMHfPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGGI5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 04:57:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42171 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfGGI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 04:57:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so6133214pgb.9;
        Sun, 07 Jul 2019 01:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=D1c54hA/MhrwT1zO0mQGNBhy7LcvgkYJFum1qndfWlU=;
        b=T3UMHfPGAFhuSDUvffwzP2nvUlhdDzzRq28R8D91rlu9bnuWwvw0G1S2mAbkaLvVge
         38I5MAE53ZY8Q7h5iCHFQCuhPmUk9SeJZdukXs3mAkj4DWzywfnkZKKUQ71rBzkARVej
         GmwAg0m/RokMlRrU40ADvAKjY5J5YwSdYpfTGtcy9cV0S3BYbUAxDZrhdkFXEkacpBIE
         cXqShGisGBamA0o1F06zTu9+6LwZYDR/wMspKWKTPegZWTF/3L/RaFFnbQNDjx2GQlGV
         uLVf0AOcqDPaXIGxjA2HuWRCmeSm4CJWSMKAam6+u95FuUynSbdAwglxtJ5ZOuUnmEru
         MABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=D1c54hA/MhrwT1zO0mQGNBhy7LcvgkYJFum1qndfWlU=;
        b=Z0/Jrd1oRgomS5AmbnuIVZhagOyhG+kaEgXYRDVnWqxw2+zq6U3fjNJ58wD5Hz0A1B
         Y4sovnXrnbHJ4Y6VPCGWw1adOBP9XibFRRZ4POHGciZCKG0QCkHDgzbE8m6XAxYI5QyC
         611e9Q9XcbztttZvB8Elei4UOkLtoS4q09AR5Ewjp6OCSkfq+Cu1MMrH2vtdUNQVkQCp
         SQKBGLeKlApYdShrDmdtRnZ0Kb7o6ZnJhwI1pVH2TDVKWTXUPNJfUk5OoaioQFaiety8
         7w516eIotdElt9DbDrKxIcsoHs59l6Zypn4hqeeYlDeV2B3ztXlCn48yLdcQo//hayjX
         HXEg==
X-Gm-Message-State: APjAAAXs+Q2tgiqrJ48CXMiP+o+UaDckTbOKCDDEhp6cTl7uH/JsrhBs
        Svd6G90DEt1n2X51pCMVymg=
X-Google-Smtp-Source: APXvYqyy8FWLuck2dpAEb/uadlMdkv+VVm+nU2OciatIlQTjvqTz9wtTtYqqDSEzwMjHyIktkTDUrw==
X-Received: by 2002:a17:90a:3ac2:: with SMTP id b60mr16398960pjc.74.1562489854516;
        Sun, 07 Jul 2019 01:57:34 -0700 (PDT)
Received: from arch ([103.238.105.141])
        by smtp.gmail.com with ESMTPSA id z68sm13017254pgz.88.2019.07.07.01.57.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 01:57:33 -0700 (PDT)
Date:   Sun, 7 Jul 2019 14:27:29 +0530
From:   Amol Surati <suratiamol@gmail.com>
To:     davem@davemloft.net, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        suratiamol@gmail.com
Subject: [PATCH] ide: use BIT() macro for defining bit-flags
Message-ID: <20190707085729.GA22964@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BIT() macro is available for defining the required bit-flags.

Since it operates on an unsigned value and expands to an unsigned result,
using it, instead of an expression like (1 << x), also fixes the problem
of shifting a signed 32-bit value by 31 bits (e.g. 1 << 31).

Signed-off-by: Amol Surati <suratiamol@gmail.com>
---
 include/linux/ide.h | 272 ++++++++++++++++++++++----------------------
 1 file changed, 136 insertions(+), 136 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index 971cf76a78a0..46b771d6999e 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -253,9 +253,9 @@ static inline void ide_std_init_ports(struct ide_hw *hw,
  * Special Driver Flags
  */
 enum {
-	IDE_SFLAG_SET_GEOMETRY		= (1 << 0),
-	IDE_SFLAG_RECALIBRATE		= (1 << 1),
-	IDE_SFLAG_SET_MULTMODE		= (1 << 2),
+	IDE_SFLAG_SET_GEOMETRY		= BIT(0),
+	IDE_SFLAG_RECALIBRATE		= BIT(1),
+	IDE_SFLAG_SET_MULTMODE		= BIT(2),
 };
 
 /*
@@ -267,13 +267,13 @@ typedef enum {
 } ide_startstop_t;
 
 enum {
-	IDE_VALID_ERROR 		= (1 << 1),
+	IDE_VALID_ERROR 		= BIT(1),
 	IDE_VALID_FEATURE		= IDE_VALID_ERROR,
-	IDE_VALID_NSECT 		= (1 << 2),
-	IDE_VALID_LBAL			= (1 << 3),
-	IDE_VALID_LBAM			= (1 << 4),
-	IDE_VALID_LBAH			= (1 << 5),
-	IDE_VALID_DEVICE		= (1 << 6),
+	IDE_VALID_NSECT 		= BIT(2),
+	IDE_VALID_LBAL			= BIT(3),
+	IDE_VALID_LBAM			= BIT(4),
+	IDE_VALID_LBAH			= BIT(5),
+	IDE_VALID_DEVICE		= BIT(6),
 	IDE_VALID_LBA			= IDE_VALID_LBAL |
 					  IDE_VALID_LBAM |
 					  IDE_VALID_LBAH,
@@ -289,24 +289,24 @@ enum {
 };
 
 enum {
-	IDE_TFLAG_LBA48			= (1 << 0),
-	IDE_TFLAG_WRITE			= (1 << 1),
-	IDE_TFLAG_CUSTOM_HANDLER	= (1 << 2),
-	IDE_TFLAG_DMA_PIO_FALLBACK	= (1 << 3),
+	IDE_TFLAG_LBA48			= BIT(0),
+	IDE_TFLAG_WRITE			= BIT(1),
+	IDE_TFLAG_CUSTOM_HANDLER	= BIT(2),
+	IDE_TFLAG_DMA_PIO_FALLBACK	= BIT(3),
 	/* force 16-bit I/O operations */
-	IDE_TFLAG_IO_16BIT		= (1 << 4),
+	IDE_TFLAG_IO_16BIT		= BIT(4),
 	/* struct ide_cmd was allocated using kmalloc() */
-	IDE_TFLAG_DYN			= (1 << 5),
-	IDE_TFLAG_FS			= (1 << 6),
-	IDE_TFLAG_MULTI_PIO		= (1 << 7),
-	IDE_TFLAG_SET_XFER		= (1 << 8),
+	IDE_TFLAG_DYN			= BIT(5),
+	IDE_TFLAG_FS			= BIT(6),
+	IDE_TFLAG_MULTI_PIO		= BIT(7),
+	IDE_TFLAG_SET_XFER		= BIT(8),
 };
 
 enum {
-	IDE_FTFLAG_FLAGGED		= (1 << 0),
-	IDE_FTFLAG_SET_IN_FLAGS		= (1 << 1),
-	IDE_FTFLAG_OUT_DATA		= (1 << 2),
-	IDE_FTFLAG_IN_DATA		= (1 << 3),
+	IDE_FTFLAG_FLAGGED		= BIT(0),
+	IDE_FTFLAG_SET_IN_FLAGS		= BIT(1),
+	IDE_FTFLAG_OUT_DATA		= BIT(2),
+	IDE_FTFLAG_IN_DATA		= BIT(3),
 };
 
 struct ide_taskfile {
@@ -357,13 +357,13 @@ struct ide_cmd {
 /* ATAPI packet command flags */
 enum {
 	/* set when an error is considered normal - no retry (ide-tape) */
-	PC_FLAG_ABORT			= (1 << 0),
-	PC_FLAG_SUPPRESS_ERROR		= (1 << 1),
-	PC_FLAG_WAIT_FOR_DSC		= (1 << 2),
-	PC_FLAG_DMA_OK			= (1 << 3),
-	PC_FLAG_DMA_IN_PROGRESS		= (1 << 4),
-	PC_FLAG_DMA_ERROR		= (1 << 5),
-	PC_FLAG_WRITING			= (1 << 6),
+	PC_FLAG_ABORT			= BIT(0),
+	PC_FLAG_SUPPRESS_ERROR		= BIT(1),
+	PC_FLAG_WAIT_FOR_DSC		= BIT(2),
+	PC_FLAG_DMA_OK			= BIT(3),
+	PC_FLAG_DMA_IN_PROGRESS		= BIT(4),
+	PC_FLAG_DMA_ERROR		= BIT(5),
+	PC_FLAG_WRITING			= BIT(6),
 };
 
 #define ATAPI_WAIT_PC		(60 * HZ)
@@ -417,111 +417,111 @@ struct ide_disk_ops {
 
 /* ATAPI device flags */
 enum {
-	IDE_AFLAG_DRQ_INTERRUPT		= (1 << 0),
+	IDE_AFLAG_DRQ_INTERRUPT		= BIT(0),
 
 	/* ide-cd */
 	/* Drive cannot eject the disc. */
-	IDE_AFLAG_NO_EJECT		= (1 << 1),
+	IDE_AFLAG_NO_EJECT		= BIT(1),
 	/* Drive is a pre ATAPI 1.2 drive. */
-	IDE_AFLAG_PRE_ATAPI12		= (1 << 2),
+	IDE_AFLAG_PRE_ATAPI12		= BIT(2),
 	/* TOC addresses are in BCD. */
-	IDE_AFLAG_TOCADDR_AS_BCD	= (1 << 3),
+	IDE_AFLAG_TOCADDR_AS_BCD	= BIT(3),
 	/* TOC track numbers are in BCD. */
-	IDE_AFLAG_TOCTRACKS_AS_BCD	= (1 << 4),
+	IDE_AFLAG_TOCTRACKS_AS_BCD	= BIT(4),
 	/* Saved TOC information is current. */
-	IDE_AFLAG_TOC_VALID		= (1 << 6),
+	IDE_AFLAG_TOC_VALID		= BIT(6),
 	/* We think that the drive door is locked. */
-	IDE_AFLAG_DOOR_LOCKED		= (1 << 7),
+	IDE_AFLAG_DOOR_LOCKED		= BIT(7),
 	/* SET_CD_SPEED command is unsupported. */
-	IDE_AFLAG_NO_SPEED_SELECT	= (1 << 8),
-	IDE_AFLAG_VERTOS_300_SSD	= (1 << 9),
-	IDE_AFLAG_VERTOS_600_ESD	= (1 << 10),
-	IDE_AFLAG_SANYO_3CD		= (1 << 11),
-	IDE_AFLAG_FULL_CAPS_PAGE	= (1 << 12),
-	IDE_AFLAG_PLAY_AUDIO_OK		= (1 << 13),
-	IDE_AFLAG_LE_SPEED_FIELDS	= (1 << 14),
+	IDE_AFLAG_NO_SPEED_SELECT	= BIT(8),
+	IDE_AFLAG_VERTOS_300_SSD	= BIT(9),
+	IDE_AFLAG_VERTOS_600_ESD	= BIT(10),
+	IDE_AFLAG_SANYO_3CD		= BIT(11),
+	IDE_AFLAG_FULL_CAPS_PAGE	= BIT(12),
+	IDE_AFLAG_PLAY_AUDIO_OK		= BIT(13),
+	IDE_AFLAG_LE_SPEED_FIELDS	= BIT(14),
 
 	/* ide-floppy */
 	/* Avoid commands not supported in Clik drive */
-	IDE_AFLAG_CLIK_DRIVE		= (1 << 15),
+	IDE_AFLAG_CLIK_DRIVE		= BIT(15),
 	/* Requires BH algorithm for packets */
-	IDE_AFLAG_ZIP_DRIVE		= (1 << 16),
+	IDE_AFLAG_ZIP_DRIVE		= BIT(16),
 	/* Supports format progress report */
-	IDE_AFLAG_SRFP			= (1 << 17),
+	IDE_AFLAG_SRFP			= BIT(17),
 
 	/* ide-tape */
-	IDE_AFLAG_IGNORE_DSC		= (1 << 18),
+	IDE_AFLAG_IGNORE_DSC		= BIT(18),
 	/* 0 When the tape position is unknown */
-	IDE_AFLAG_ADDRESS_VALID		= (1 <<	19),
+	IDE_AFLAG_ADDRESS_VALID		= BIT(19),
 	/* Device already opened */
-	IDE_AFLAG_BUSY			= (1 << 20),
+	IDE_AFLAG_BUSY			= BIT(20),
 	/* Attempt to auto-detect the current user block size */
-	IDE_AFLAG_DETECT_BS		= (1 << 21),
+	IDE_AFLAG_DETECT_BS		= BIT(21),
 	/* Currently on a filemark */
-	IDE_AFLAG_FILEMARK		= (1 << 22),
+	IDE_AFLAG_FILEMARK		= BIT(22),
 	/* 0 = no tape is loaded, so we don't rewind after ejecting */
-	IDE_AFLAG_MEDIUM_PRESENT	= (1 << 23),
+	IDE_AFLAG_MEDIUM_PRESENT	= BIT(23),
 
-	IDE_AFLAG_NO_AUTOCLOSE		= (1 << 24),
+	IDE_AFLAG_NO_AUTOCLOSE		= BIT(24),
 };
 
 /* device flags */
 enum {
 	/* restore settings after device reset */
-	IDE_DFLAG_KEEP_SETTINGS		= (1 << 0),
+	IDE_DFLAG_KEEP_SETTINGS		= BIT(0),
 	/* device is using DMA for read/write */
-	IDE_DFLAG_USING_DMA		= (1 << 1),
+	IDE_DFLAG_USING_DMA		= BIT(1),
 	/* okay to unmask other IRQs */
-	IDE_DFLAG_UNMASK		= (1 << 2),
+	IDE_DFLAG_UNMASK		= BIT(2),
 	/* don't attempt flushes */
-	IDE_DFLAG_NOFLUSH		= (1 << 3),
+	IDE_DFLAG_NOFLUSH		= BIT(3),
 	/* DSC overlap */
-	IDE_DFLAG_DSC_OVERLAP		= (1 << 4),
+	IDE_DFLAG_DSC_OVERLAP		= BIT(4),
 	/* give potential excess bandwidth */
-	IDE_DFLAG_NICE1			= (1 << 5),
+	IDE_DFLAG_NICE1			= BIT(5),
 	/* device is physically present */
-	IDE_DFLAG_PRESENT		= (1 << 6),
+	IDE_DFLAG_PRESENT		= BIT(6),
 	/* disable Host Protected Area */
-	IDE_DFLAG_NOHPA			= (1 << 7),
+	IDE_DFLAG_NOHPA			= BIT(7),
 	/* id read from device (synthetic if not set) */
-	IDE_DFLAG_ID_READ		= (1 << 8),
-	IDE_DFLAG_NOPROBE		= (1 << 9),
+	IDE_DFLAG_ID_READ		= BIT(8),
+	IDE_DFLAG_NOPROBE		= BIT(9),
 	/* need to do check_media_change() */
-	IDE_DFLAG_REMOVABLE		= (1 << 10),
+	IDE_DFLAG_REMOVABLE		= BIT(10),
 	/* needed for removable devices */
-	IDE_DFLAG_ATTACH		= (1 << 11),
-	IDE_DFLAG_FORCED_GEOM		= (1 << 12),
+	IDE_DFLAG_ATTACH		= BIT(11),
+	IDE_DFLAG_FORCED_GEOM		= BIT(12),
 	/* disallow setting unmask bit */
-	IDE_DFLAG_NO_UNMASK		= (1 << 13),
+	IDE_DFLAG_NO_UNMASK		= BIT(13),
 	/* disallow enabling 32-bit I/O */
-	IDE_DFLAG_NO_IO_32BIT		= (1 << 14),
+	IDE_DFLAG_NO_IO_32BIT		= BIT(14),
 	/* for removable only: door lock/unlock works */
-	IDE_DFLAG_DOORLOCKING		= (1 << 15),
+	IDE_DFLAG_DOORLOCKING		= BIT(15),
 	/* disallow DMA */
-	IDE_DFLAG_NODMA			= (1 << 16),
+	IDE_DFLAG_NODMA			= BIT(16),
 	/* powermanagement told us not to do anything, so sleep nicely */
-	IDE_DFLAG_BLOCKED		= (1 << 17),
+	IDE_DFLAG_BLOCKED		= BIT(17),
 	/* sleeping & sleep field valid */
-	IDE_DFLAG_SLEEPING		= (1 << 18),
-	IDE_DFLAG_POST_RESET		= (1 << 19),
-	IDE_DFLAG_UDMA33_WARNED		= (1 << 20),
-	IDE_DFLAG_LBA48			= (1 << 21),
+	IDE_DFLAG_SLEEPING		= BIT(18),
+	IDE_DFLAG_POST_RESET		= BIT(19),
+	IDE_DFLAG_UDMA33_WARNED		= BIT(20),
+	IDE_DFLAG_LBA48			= BIT(21),
 	/* status of write cache */
-	IDE_DFLAG_WCACHE		= (1 << 22),
+	IDE_DFLAG_WCACHE		= BIT(22),
 	/* used for ignoring ATA_DF */
-	IDE_DFLAG_NOWERR		= (1 << 23),
+	IDE_DFLAG_NOWERR		= BIT(23),
 	/* retrying in PIO */
-	IDE_DFLAG_DMA_PIO_RETRY		= (1 << 24),
-	IDE_DFLAG_LBA			= (1 << 25),
+	IDE_DFLAG_DMA_PIO_RETRY		= BIT(24),
+	IDE_DFLAG_LBA			= BIT(25),
 	/* don't unload heads */
-	IDE_DFLAG_NO_UNLOAD		= (1 << 26),
+	IDE_DFLAG_NO_UNLOAD		= BIT(26),
 	/* heads unloaded, please don't reset port */
-	IDE_DFLAG_PARKED		= (1 << 27),
-	IDE_DFLAG_MEDIA_CHANGED		= (1 << 28),
+	IDE_DFLAG_PARKED		= BIT(27),
+	IDE_DFLAG_MEDIA_CHANGED		= BIT(28),
 	/* write protect */
-	IDE_DFLAG_WP			= (1 << 29),
-	IDE_DFLAG_FORMAT_IN_PROGRESS	= (1 << 30),
-	IDE_DFLAG_NIEN_QUIRK		= (1 << 31),
+	IDE_DFLAG_WP			= BIT(29),
+	IDE_DFLAG_FORMAT_IN_PROGRESS	= BIT(30),
+	IDE_DFLAG_NIEN_QUIRK		= BIT(31),
 };
 
 struct ide_drive_s {
@@ -709,7 +709,7 @@ struct ide_dma_ops {
 };
 
 enum {
-	IDE_PFLAG_PROBING		= (1 << 0),
+	IDE_PFLAG_PROBING		= BIT(0),
 };
 
 struct ide_host;
@@ -862,7 +862,7 @@ extern struct mutex ide_setting_mtx;
  * configurable drive settings
  */
 
-#define DS_SYNC	(1 << 0)
+#define DS_SYNC	BIT(0)
 
 struct ide_devset {
 	int		(*get)(ide_drive_t *);
@@ -1000,15 +1000,15 @@ static inline void ide_proc_unregister_driver(ide_drive_t *drive,
 
 enum {
 	/* enter/exit functions */
-	IDE_DBG_FUNC =			(1 << 0),
+	IDE_DBG_FUNC =			BIT(0),
 	/* sense key/asc handling */
-	IDE_DBG_SENSE =			(1 << 1),
+	IDE_DBG_SENSE =			BIT(1),
 	/* packet commands handling */
-	IDE_DBG_PC =			(1 << 2),
+	IDE_DBG_PC =			BIT(2),
 	/* request handling */
-	IDE_DBG_RQ =			(1 << 3),
+	IDE_DBG_RQ =			BIT(3),
 	/* driver probing/setup */
-	IDE_DBG_PROBE =			(1 << 4),
+	IDE_DBG_PROBE =			BIT(4),
 };
 
 /* DRV_NAME has to be defined in the driver before using the macro below */
@@ -1171,10 +1171,10 @@ ssize_t ide_park_store(struct device *dev, struct device_attribute *attr,
  * the tail of our block device request queue and wait for their completion.
  */
 enum {
-	REQ_IDETAPE_PC1		= (1 << 0), /* packet command (first stage) */
-	REQ_IDETAPE_PC2		= (1 << 1), /* packet command (second stage) */
-	REQ_IDETAPE_READ	= (1 << 2),
-	REQ_IDETAPE_WRITE	= (1 << 3),
+	REQ_IDETAPE_PC1		= BIT(0), /* packet command (first stage) */
+	REQ_IDETAPE_PC2		= BIT(1), /* packet command (second stage) */
+	REQ_IDETAPE_READ	= BIT(2),
+	REQ_IDETAPE_WRITE	= BIT(3),
 };
 
 int ide_queue_pc_tail(ide_drive_t *, struct gendisk *, struct ide_atapi_pc *,
@@ -1264,71 +1264,71 @@ struct ide_pci_enablebit {
 
 enum {
 	/* Uses ISA control ports not PCI ones. */
-	IDE_HFLAG_ISA_PORTS		= (1 << 0),
+	IDE_HFLAG_ISA_PORTS		= BIT(0),
 	/* single port device */
-	IDE_HFLAG_SINGLE		= (1 << 1),
+	IDE_HFLAG_SINGLE		= BIT(1),
 	/* don't use legacy PIO blacklist */
-	IDE_HFLAG_PIO_NO_BLACKLIST	= (1 << 2),
+	IDE_HFLAG_PIO_NO_BLACKLIST	= BIT(2),
 	/* set for the second port of QD65xx */
-	IDE_HFLAG_QD_2ND_PORT		= (1 << 3),
+	IDE_HFLAG_QD_2ND_PORT		= BIT(3),
 	/* use PIO8/9 for prefetch off/on */
-	IDE_HFLAG_ABUSE_PREFETCH	= (1 << 4),
+	IDE_HFLAG_ABUSE_PREFETCH	= BIT(4),
 	/* use PIO6/7 for fast-devsel off/on */
-	IDE_HFLAG_ABUSE_FAST_DEVSEL	= (1 << 5),
+	IDE_HFLAG_ABUSE_FAST_DEVSEL	= BIT(5),
 	/* use 100-102 and 200-202 PIO values to set DMA modes */
-	IDE_HFLAG_ABUSE_DMA_MODES	= (1 << 6),
+	IDE_HFLAG_ABUSE_DMA_MODES	= BIT(6),
 	/*
 	 * keep DMA setting when programming PIO mode, may be used only
 	 * for hosts which have separate PIO and DMA timings (ie. PMAC)
 	 */
-	IDE_HFLAG_SET_PIO_MODE_KEEP_DMA	= (1 << 7),
+	IDE_HFLAG_SET_PIO_MODE_KEEP_DMA	= BIT(7),
 	/* program host for the transfer mode after programming device */
-	IDE_HFLAG_POST_SET_MODE		= (1 << 8),
+	IDE_HFLAG_POST_SET_MODE		= BIT(8),
 	/* don't program host/device for the transfer mode ("smart" hosts) */
-	IDE_HFLAG_NO_SET_MODE		= (1 << 9),
+	IDE_HFLAG_NO_SET_MODE		= BIT(9),
 	/* trust BIOS for programming chipset/device for DMA */
-	IDE_HFLAG_TRUST_BIOS_FOR_DMA	= (1 << 10),
+	IDE_HFLAG_TRUST_BIOS_FOR_DMA	= BIT(10),
 	/* host is CS5510/CS5520 */
-	IDE_HFLAG_CS5520		= (1 << 11),
+	IDE_HFLAG_CS5520		= BIT(11),
 	/* ATAPI DMA is unsupported */
-	IDE_HFLAG_NO_ATAPI_DMA		= (1 << 12),
+	IDE_HFLAG_NO_ATAPI_DMA		= BIT(12),
 	/* set if host is a "non-bootable" controller */
-	IDE_HFLAG_NON_BOOTABLE		= (1 << 13),
+	IDE_HFLAG_NON_BOOTABLE		= BIT(13),
 	/* host doesn't support DMA */
-	IDE_HFLAG_NO_DMA		= (1 << 14),
+	IDE_HFLAG_NO_DMA		= BIT(14),
 	/* check if host is PCI IDE device before allowing DMA */
-	IDE_HFLAG_NO_AUTODMA		= (1 << 15),
+	IDE_HFLAG_NO_AUTODMA		= BIT(15),
 	/* host uses MMIO */
-	IDE_HFLAG_MMIO			= (1 << 16),
+	IDE_HFLAG_MMIO			= BIT(16),
 	/* no LBA48 */
-	IDE_HFLAG_NO_LBA48		= (1 << 17),
+	IDE_HFLAG_NO_LBA48		= BIT(17),
 	/* no LBA48 DMA */
-	IDE_HFLAG_NO_LBA48_DMA		= (1 << 18),
+	IDE_HFLAG_NO_LBA48_DMA		= BIT(18),
 	/* data FIFO is cleared by an error */
-	IDE_HFLAG_ERROR_STOPS_FIFO	= (1 << 19),
+	IDE_HFLAG_ERROR_STOPS_FIFO	= BIT(19),
 	/* serialize ports */
-	IDE_HFLAG_SERIALIZE		= (1 << 20),
+	IDE_HFLAG_SERIALIZE		= BIT(20),
 	/* host is DTC2278 */
-	IDE_HFLAG_DTC2278		= (1 << 21),
+	IDE_HFLAG_DTC2278		= BIT(21),
 	/* 4 devices on a single set of I/O ports */
-	IDE_HFLAG_4DRIVES		= (1 << 22),
+	IDE_HFLAG_4DRIVES		= BIT(22),
 	/* host is TRM290 */
-	IDE_HFLAG_TRM290		= (1 << 23),
+	IDE_HFLAG_TRM290		= BIT(23),
 	/* use 32-bit I/O ops */
-	IDE_HFLAG_IO_32BIT		= (1 << 24),
+	IDE_HFLAG_IO_32BIT		= BIT(24),
 	/* unmask IRQs */
-	IDE_HFLAG_UNMASK_IRQS		= (1 << 25),
-	IDE_HFLAG_BROKEN_ALTSTATUS	= (1 << 26),
+	IDE_HFLAG_UNMASK_IRQS		= BIT(25),
+	IDE_HFLAG_BROKEN_ALTSTATUS	= BIT(26),
 	/* serialize ports if DMA is possible (for sl82c105) */
-	IDE_HFLAG_SERIALIZE_DMA		= (1 << 27),
+	IDE_HFLAG_SERIALIZE_DMA		= BIT(27),
 	/* force host out of "simplex" mode */
-	IDE_HFLAG_CLEAR_SIMPLEX		= (1 << 28),
+	IDE_HFLAG_CLEAR_SIMPLEX		= BIT(28),
 	/* DSC overlap is unsupported */
-	IDE_HFLAG_NO_DSC		= (1 << 29),
+	IDE_HFLAG_NO_DSC		= BIT(29),
 	/* never use 32-bit I/O ops */
-	IDE_HFLAG_NO_IO_32BIT		= (1 << 30),
+	IDE_HFLAG_NO_IO_32BIT		= BIT(30),
 	/* never unmask IRQs */
-	IDE_HFLAG_NO_UNMASK_IRQS	= (1 << 31),
+	IDE_HFLAG_NO_UNMASK_IRQS	= BIT(31),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
@@ -1536,16 +1536,16 @@ struct ide_timing {
 };
 
 enum {
-	IDE_TIMING_SETUP	= (1 << 0),
-	IDE_TIMING_ACT8B	= (1 << 1),
-	IDE_TIMING_REC8B	= (1 << 2),
-	IDE_TIMING_CYC8B	= (1 << 3),
+	IDE_TIMING_SETUP	= BIT(0),
+	IDE_TIMING_ACT8B	= BIT(1),
+	IDE_TIMING_REC8B	= BIT(2),
+	IDE_TIMING_CYC8B	= BIT(3),
 	IDE_TIMING_8BIT		= IDE_TIMING_ACT8B | IDE_TIMING_REC8B |
 				  IDE_TIMING_CYC8B,
-	IDE_TIMING_ACTIVE	= (1 << 4),
-	IDE_TIMING_RECOVER	= (1 << 5),
-	IDE_TIMING_CYCLE	= (1 << 6),
-	IDE_TIMING_UDMA		= (1 << 7),
+	IDE_TIMING_ACTIVE	= BIT(4),
+	IDE_TIMING_RECOVER	= BIT(5),
+	IDE_TIMING_CYCLE	= BIT(6),
+	IDE_TIMING_UDMA		= BIT(7),
 	IDE_TIMING_ALL		= IDE_TIMING_SETUP | IDE_TIMING_8BIT |
 				  IDE_TIMING_ACTIVE | IDE_TIMING_RECOVER |
 				  IDE_TIMING_CYCLE | IDE_TIMING_UDMA,
-- 
2.22.0

