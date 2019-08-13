Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4FBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5B32067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnKedNmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfHMRhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:37:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38165 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfHMRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:37:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id r20so25825227ota.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=l4ZuASMx7dpU6pQrtKcOWqSMlMm+UO/jiuQYltNpOsE=;
        b=AnKedNmwsu/nQlIY+ff4Ywd2w4SLQVKGm8jZfZQHOrnPNQvHqugePXLSsX52dS+3le
         YKgCTdaAFfHV3lvQjUCqSBPD8G6YpW3xwlUmW5H5XHx+nZX/Kkl9prvwr/8eYPWmvLdA
         qXHaOfxjxtG+at9HLiUog3YMBKe9p/x4gvRHCNqiVRZ/0s2AX2r0V76GDe4ZFaOZrUOM
         Not978NrPGPOyW/2oguB75d9ORBHup6wQ35XEirKlB4KvHT55Gdv6gn8U1ewC1U8YUeH
         OqoY1q4TX7NNXFmrvSQFRSZtMCDmHoW+KDYPsjl7RSRgLw9WBfU3kqYUAHa+Gxb0/7Ke
         dH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=l4ZuASMx7dpU6pQrtKcOWqSMlMm+UO/jiuQYltNpOsE=;
        b=had0PYyBwthU5As7bn0Ku8HE36k9t5q6P3etPSssSwX+XTxV84shBb76NmayWYsdaQ
         yKxVmfJM6ZG7y7GkAvmt/lHSbr8U2WyrDpBK6qoBLxaZ/upQ772/COd/ouXRtf6xTBE4
         6juecJ588pajISIexm8gjiHfDWZbcFvEVp5KRp6XAC7f/IuXK34SAikqRMp7x82Wgy4t
         IaCYpNYfBgGe/SJROQ97JiD8L3/ulViXmJ7mt8ZuYfkifmNq641GNW8ioeZn4chSzM2j
         ZMphJmF8hY35s8RbDqgTPr99dZ3kvTql39z6fdltdRuOHcCYhW5fbA3WAkbYoQqPo3nL
         BPkA==
X-Gm-Message-State: APjAAAW8wm8/qM5+ezZv57b2iB9FuDJmQSRFs8SZ9o6/6nZsTBTtNi80
        N+zYOj2WWzzptY/yWEu67g==
X-Google-Smtp-Source: APXvYqx8Q4Kj1euqBHlhHnFOKRbHt3z4cb4B69xu2LnNGQtGtTMay/aJgWU0DksjnNVbrXdbXrP+eg==
X-Received: by 2002:a9d:5911:: with SMTP id t17mr32795306oth.159.1565717851898;
        Tue, 13 Aug 2019 10:37:31 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id n24sm33618961oie.19.2019.08.13.10.37.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:37:31 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 000811800D1;
        Tue, 13 Aug 2019 17:37:29 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 7B1FC302332; Tue, 13 Aug 2019 12:37:29 -0500 (CDT)
From:   minyard@acm.org
To:     linux-kernel@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pat Riehecky <riehecky@fnal.gov>,
        Alessandro Rubini <rubini@gnudd.com>
Subject: [PATCH] Remove include/linux/ipmi-fru.h and include/linux/sdb.h
Date:   Tue, 13 Aug 2019 12:37:21 -0500
Message-Id: <20190813173721.12411-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

These files were added as part of the FMC subsystem, but were not
removed when the FMC subsystem was removed in 6a80b30086 "fmc: Delete
the FMC subsystem".  They have no users, so remove them.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Pat Riehecky <riehecky@fnal.gov>
Cc: Alessandro Rubini <rubini@gnudd.com>
---

I noticed this when doing something else.  If this is ok, I can take
this into the IPMI tree since, well, one of the files as "ipmi" in
the name.  Just for convenience, really.

 include/linux/ipmi-fru.h | 134 --------------------------------
 include/linux/sdb.h      | 160 ---------------------------------------
 2 files changed, 294 deletions(-)
 delete mode 100644 include/linux/ipmi-fru.h
 delete mode 100644 include/linux/sdb.h

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
diff --git a/include/linux/sdb.h b/include/linux/sdb.h
deleted file mode 100644
index a2404a2bbd10..000000000000
--- a/include/linux/sdb.h
+++ /dev/null
@@ -1,160 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is the official version 1.1 of sdb.h
- */
-#ifndef __SDB_H__
-#define __SDB_H__
-#ifdef __KERNEL__
-#include <linux/types.h>
-#else
-#include <stdint.h>
-#endif
-
-/*
- * All structures are 64 bytes long and are expected
- * to live in an array, one for each interconnect.
- * Most fields of the structures are shared among the
- * various types, and most-specific fields are at the
- * beginning (for alignment reasons, and to keep the
- * magic number at the head of the interconnect record
- */
-
-/* Product, 40 bytes at offset 24, 8-byte aligned
- *
- * device_id is vendor-assigned; version is device-specific,
- * date is hex (e.g 0x20120501), name is UTF-8, blank-filled
- * and not terminated with a 0 byte.
- */
-struct sdb_product {
-	uint64_t		vendor_id;	/* 0x18..0x1f */
-	uint32_t		device_id;	/* 0x20..0x23 */
-	uint32_t		version;	/* 0x24..0x27 */
-	uint32_t		date;		/* 0x28..0x2b */
-	uint8_t			name[19];	/* 0x2c..0x3e */
-	uint8_t			record_type;	/* 0x3f */
-};
-
-/*
- * Component, 56 bytes at offset 8, 8-byte aligned
- *
- * The address range is first to last, inclusive
- * (for example 0x100000 - 0x10ffff)
- */
-struct sdb_component {
-	uint64_t		addr_first;	/* 0x08..0x0f */
-	uint64_t		addr_last;	/* 0x10..0x17 */
-	struct sdb_product	product;	/* 0x18..0x3f */
-};
-
-/* Type of the SDB record */
-enum sdb_record_type {
-	sdb_type_interconnect	= 0x00,
-	sdb_type_device		= 0x01,
-	sdb_type_bridge		= 0x02,
-	sdb_type_integration	= 0x80,
-	sdb_type_repo_url	= 0x81,
-	sdb_type_synthesis	= 0x82,
-	sdb_type_empty		= 0xFF,
-};
-
-/* Type 0: interconnect (first of the array)
- *
- * sdb_records is the length of the table including this first
- * record, version is 1. The bus type is enumerated later.
- */
-#define				SDB_MAGIC	0x5344422d /* "SDB-" */
-struct sdb_interconnect {
-	uint32_t		sdb_magic;	/* 0x00-0x03 */
-	uint16_t		sdb_records;	/* 0x04-0x05 */
-	uint8_t			sdb_version;	/* 0x06 */
-	uint8_t			sdb_bus_type;	/* 0x07 */
-	struct sdb_component	sdb_component;	/* 0x08-0x3f */
-};
-
-/* Type 1: device
- *
- * class is 0 for "custom device", other values are
- * to be standardized; ABI version is for the driver,
- * bus-specific bits are defined by each bus (see below)
- */
-struct sdb_device {
-	uint16_t		abi_class;	/* 0x00-0x01 */
-	uint8_t			abi_ver_major;	/* 0x02 */
-	uint8_t			abi_ver_minor;	/* 0x03 */
-	uint32_t		bus_specific;	/* 0x04-0x07 */
-	struct sdb_component	sdb_component;	/* 0x08-0x3f */
-};
-
-/* Type 2: bridge
- *
- * child is the address of the nested SDB table
- */
-struct sdb_bridge {
-	uint64_t		sdb_child;	/* 0x00-0x07 */
-	struct sdb_component	sdb_component;	/* 0x08-0x3f */
-};
-
-/* Type 0x80: integration
- *
- * all types with bit 7 set are meta-information, so
- * software can ignore the types it doesn't know. Here we
- * just provide product information for an aggregate device
- */
-struct sdb_integration {
-	uint8_t			reserved[24];	/* 0x00-0x17 */
-	struct sdb_product	product;	/* 0x08-0x3f */
-};
-
-/* Type 0x81: Top module repository url
- *
- * again, an informative field that software can ignore
- */
-struct sdb_repo_url {
-	uint8_t			repo_url[63];	/* 0x00-0x3e */
-	uint8_t			record_type;	/* 0x3f */
-};
-
-/* Type 0x82: Synthesis tool information
- *
- * this informative record
- */
-struct sdb_synthesis {
-	uint8_t			syn_name[16];	/* 0x00-0x0f */
-	uint8_t			commit_id[16];	/* 0x10-0x1f */
-	uint8_t			tool_name[8];	/* 0x20-0x27 */
-	uint32_t		tool_version;	/* 0x28-0x2b */
-	uint32_t		date;		/* 0x2c-0x2f */
-	uint8_t			user_name[15];	/* 0x30-0x3e */
-	uint8_t			record_type;	/* 0x3f */
-};
-
-/* Type 0xff: empty
- *
- * this allows keeping empty slots during development,
- * so they can be filled later with minimal efforts and
- * no misleading description is ever shipped -- hopefully.
- * It can also be used to pad a table to a desired length.
- */
-struct sdb_empty {
-	uint8_t			reserved[63];	/* 0x00-0x3e */
-	uint8_t			record_type;	/* 0x3f */
-};
-
-/* The type of bus, for bus-specific flags */
-enum sdb_bus_type {
-	sdb_wishbone = 0x00,
-	sdb_data     = 0x01,
-};
-
-#define SDB_WB_WIDTH_MASK	0x0f
-#define SDB_WB_ACCESS8			0x01
-#define SDB_WB_ACCESS16			0x02
-#define SDB_WB_ACCESS32			0x04
-#define SDB_WB_ACCESS64			0x08
-#define SDB_WB_LITTLE_ENDIAN	0x80
-
-#define SDB_DATA_READ		0x04
-#define SDB_DATA_WRITE		0x02
-#define SDB_DATA_EXEC		0x01
-
-#endif /* __SDB_H__ */
-- 
2.17.1

