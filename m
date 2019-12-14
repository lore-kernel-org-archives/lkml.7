Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B102C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D381724656
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/WuMvEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfLNLte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 06:49:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37744 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNLte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:49:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so1507660wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 03:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c1S6tPhOfVYk5zUv59A7g70VnMPNHKzMxdwgAl5CeXs=;
        b=U/WuMvEC+SQYlZgMExaqFYv/1a9xCJMd3tlWGmKdWhdy/KSJ4AzVllDCOo3lIsRoDq
         NakT5we3D/ZtE/dw1Gd7WWSsPDZlyTZMg72RzE+gS0MR6p7MTxJj6wxcXjuhldN8+p3J
         YOMigzdMgtwHO7p/HfEaYMB31qSyxUA3lVTsVUg36ioOSDWjnz35YAhNwNtA1mH7jA98
         IPqfeNudMxsIYVTc1zqSMwthcFKLMjMKxp85GKRk1SxoRhCp/2veCWFFhIvD1inUWi6m
         8BoEP96cY5dysYn2JSJpkYJOb/a2EMdNqrMy41aTvoLUSMvBF4a0JghDRjpqD0Tpf3H5
         DOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c1S6tPhOfVYk5zUv59A7g70VnMPNHKzMxdwgAl5CeXs=;
        b=IkF2twnUWx3lt+XDF7XvHht+axGsf0Hfmspd/eLgjoPFTfnLEjbWoRhJkOlUkaUKiO
         SPPWLx6aa8iRHdvBasuws550rH1BuxWug68Eo1XfABOXqpTQX8I4K7+wrpuU305yq3tg
         kbraIR+o6MzFPXy620i34eYauXIkd6JPd5CrO/X/CqSALKelHeCfTL5whukSDhWjGv7D
         U9Vy2ogxQH2Wd22z2hYtCriQNlGxHbrfmrAH2oEx/s9aa3KFK9/AM1JV4nltTN/yJJAu
         m587gbgg1A0hP/BOHqxlgvObiMeke6P80y5vZdFue2q4GSDB2ySbB74W6ikEkV32moUQ
         oTvA==
X-Gm-Message-State: APjAAAVSqyNKVfw6MgwAb4au95rROkihcsL35N99jcgeLM92PXRtv8T9
        Dk7+B+7Zr6KV/hvkOoGF7SA=
X-Google-Smtp-Source: APXvYqzxvWYetjuMFaDL+se3Z5kqyNkyM/rGTPJQOyyCEziYrBqiGcUlZd9lzcc05qRw0lYaZtsG4A==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr18856162wml.103.1576324171980;
        Sat, 14 Dec 2019 03:49:31 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d9f:bc00:c423:bc8:7c43:bd71])
        by smtp.gmail.com with ESMTPSA id v3sm13407272wml.47.2019.12.14.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 03:49:31 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Cc:     Pat Riehecky <riehecky@fnal.gov>,
        Alessandro Rubini <rubini@gnudd.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] fmc: remove left-over ipmi-fru.h after fmc deletion
Date:   Sat, 14 Dec 2019 12:49:13 +0100
Message-Id: <20191214114913.8610-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a80b30086b8 ("fmc: Delete the FMC subsystem") from Linus Walleij
deleted the obsolete FMC subsystem, but missed the MAINTAINERS entry and
include/linux/ipmi-fru.h mentioned in the MAINTAINERS entry.

Later, commit d5d4aa1ec198 ("MAINTAINERS: Remove FMC subsystem") from
Denis Efremov cleaned up the MAINTAINERS entry, but actually also missed
that include/linux/ipmi-fru.h should also be deleted while deleting its
reference in MAINTAINERS.

So, deleting include/linux/ipmi-fru.h slipped through the previous
clean-ups.

As there is no further use for include/linux/ipmi-fru.h, finally delete
include/linux/ipmi-fru.h for good now.

Fixes: d5d4aa1ec198 ("MAINTAINERS: Remove FMC subsystem")
Fixes: 6a80b30086b8 ("fmc: Delete the FMC subsystem")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Linus, please pick this patch.
Federico, Denis, please ack.

 include/linux/ipmi-fru.h | 134 ---------------------------------------
 1 file changed, 134 deletions(-)
 delete mode 100644 include/linux/ipmi-fru.h

diff --git a/include/linux/ipmi-fru.h b/include/linux/ipmi-fru.h
deleted file mode 100644
index 05c9422624c6..000000000000
--- a/include/linux/ipmi-fru.h
+++ /dev/null
@@ -1,134 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2012 CERN (www.cern.ch)
- * Author: Alessandro Rubini <rubini@gnudd.com>
- *
- * This work is part of the White Rabbit project, a research effort led
- * by CERN, the European Institute for Nuclear Research.
- */
-#ifndef __LINUX_IPMI_FRU_H__
-#define __LINUX_IPMI_FRU_H__
-#ifdef __KERNEL__
-#  include <linux/types.h>
-#  include <linux/string.h>
-#else
-#  include <stdint.h>
-#  include <string.h>
-#endif
-
-/*
- * These structures match the unaligned crap we have in FRU1011.pdf
- * (http://download.intel.com/design/servers/ipmi/FRU1011.pdf)
- */
-
-/* chapter 8, page 5 */
-struct fru_common_header {
-	uint8_t format;			/* 0x01 */
-	uint8_t internal_use_off;	/* multiple of 8 bytes */
-	uint8_t chassis_info_off;	/* multiple of 8 bytes */
-	uint8_t board_area_off;		/* multiple of 8 bytes */
-	uint8_t product_area_off;	/* multiple of 8 bytes */
-	uint8_t multirecord_off;	/* multiple of 8 bytes */
-	uint8_t pad;			/* must be 0 */
-	uint8_t checksum;		/* sum modulo 256 must be 0 */
-};
-
-/* chapter 9, page 5 -- internal_use: not used by us */
-
-/* chapter 10, page 6 -- chassis info: not used by us */
-
-/* chapter 13, page 9 -- used by board_info_area below */
-struct fru_type_length {
-	uint8_t type_length;
-	uint8_t data[0];
-};
-
-/* chapter 11, page 7 */
-struct fru_board_info_area {
-	uint8_t format;			/* 0x01 */
-	uint8_t area_len;		/* multiple of 8 bytes */
-	uint8_t language;		/* I hope it's 0 */
-	uint8_t mfg_date[3];		/* LSB, minutes since 1996-01-01 */
-	struct fru_type_length tl[0];	/* type-length stuff follows */
-
-	/*
-	 * the TL there are in order:
-	 * Board Manufacturer
-	 * Board Product Name
-	 * Board Serial Number
-	 * Board Part Number
-	 * FRU File ID (may be null)
-	 * more manufacturer-specific stuff
-	 * 0xc1 as a terminator
-	 * 0x00 pad to a multiple of 8 bytes - 1
-	 * checksum (sum of all stuff module 256 must be zero)
-	 */
-};
-
-enum fru_type {
-	FRU_TYPE_BINARY		= 0x00,
-	FRU_TYPE_BCDPLUS	= 0x40,
-	FRU_TYPE_ASCII6		= 0x80,
-	FRU_TYPE_ASCII		= 0xc0, /* not ascii: depends on language */
-};
-
-/*
- * some helpers
- */
-static inline struct fru_board_info_area *fru_get_board_area(
-	const struct fru_common_header *header)
-{
-	/* we know for sure that the header is 8 bytes in size */
-	return (struct fru_board_info_area *)(header + header->board_area_off);
-}
-
-static inline int fru_type(struct fru_type_length *tl)
-{
-	return tl->type_length & 0xc0;
-}
-
-static inline int fru_length(struct fru_type_length *tl)
-{
-	return (tl->type_length & 0x3f) + 1; /* len of whole record */
-}
-
-/* assume ascii-latin1 encoding */
-static inline int fru_strlen(struct fru_type_length *tl)
-{
-	return fru_length(tl) - 1;
-}
-
-static inline char *fru_strcpy(char *dest, struct fru_type_length *tl)
-{
-	int len = fru_strlen(tl);
-	memcpy(dest, tl->data, len);
-	dest[len] = '\0';
-	return dest;
-}
-
-static inline struct fru_type_length *fru_next_tl(struct fru_type_length *tl)
-{
-	return tl + fru_length(tl);
-}
-
-static inline int fru_is_eof(struct fru_type_length *tl)
-{
-	return tl->type_length == 0xc1;
-}
-
-/*
- * External functions defined in fru-parse.c.
- */
-extern int fru_header_cksum_ok(struct fru_common_header *header);
-extern int fru_bia_cksum_ok(struct fru_board_info_area *bia);
-
-/* All these 4 return allocated strings by calling fru_alloc() */
-extern char *fru_get_board_manufacturer(struct fru_common_header *header);
-extern char *fru_get_product_name(struct fru_common_header *header);
-extern char *fru_get_serial_number(struct fru_common_header *header);
-extern char *fru_get_part_number(struct fru_common_header *header);
-
-/* This must be defined by the caller of the above functions */
-extern void *fru_alloc(size_t size);
-
-#endif /* __LINUX_IMPI_FRU_H__ */
-- 
2.17.1

