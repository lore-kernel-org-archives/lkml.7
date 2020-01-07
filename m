Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB0CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDD22081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+nwQ8II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgAGV3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:29:23 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38033 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgAGV3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:29:21 -0500
Received: by mail-wm1-f41.google.com with SMTP id u2so368253wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yloz+AkEk95bHbhJcGPVMbjB18+crfNuwXlsDC0SHZY=;
        b=Q+nwQ8IIDRpXm6j5b6sTVih4krkKNQe8xKA1pZtinUmO6qLNmreSJUnzffVTs0bcd2
         2kdxFCapUq+mPmSPtmOJ9dwIOb+3HYjr1QYkDNOf09XDDYkZuIDiePyNRo/Iodfhwsm2
         XyQU3936rp+TpKNr0XvkcP0k2SQSy5we4OTdAKpll/Jwq67EyAiRm4sBedJTvRgU0zpb
         lWoMJsRzcrRgEUj1mhTr9My2CJQN0oeBF19zBcW7kAXVMlrVW+AKW4/r0z9i0CiwpJ+d
         xMPqIMaMBRXQlJ1kWN6JHExAZUShzIyroH9E9WcezUH13bZ61z7X2sl24UlXrFbBlkQH
         IiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yloz+AkEk95bHbhJcGPVMbjB18+crfNuwXlsDC0SHZY=;
        b=jGnViT8DDsCZNhkm9hgLed4rHg5VzUlBJPQi7qWjyas2IA9jw4xd0Q94Uw5GiLPh6N
         /jNowBrBx3TM/GWl2LdTM76B3UhxPDb4igLdNx/ZjBkZtBbf5mqeFQskiInJMg7Dc0uu
         Cc1yosvkcfe5G9rG96w9ILWS6li8bOks5Nd2AuMhnnsr+eufbLbR2/c5pqotNKiRrS0J
         7qhXllyP2SbLujDHdWtFCvWExV7MJhZr0+BOknFLixvfxgKYEBYlJAAETvc4AmvhKEiC
         WVNm6i54MZSzDbF5/RhKbZBPm1YUqwivjs7s+J2gpLejN+66Be5oF7T4f4tbLf9DQNOb
         kXcA==
X-Gm-Message-State: APjAAAU0KWI4/kXei6/K3tabzOQ0214uuSLkk3aMQH4u31OVZ30cmZ1D
        WeYiodytEZvTj4p1vSaGtLrxzFb6
X-Google-Smtp-Source: APXvYqxwrOQltubdMAYA2QHFztGWhA3iV8+2I+AJMqpC/JHk2LQUZcTng5heIhwbF4UvUokCLzXAUg==
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr328984wmm.61.1578432558022;
        Tue, 07 Jan 2020 13:29:18 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id f1sm1449144wru.6.2020.01.07.13.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:29:17 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: [PATCH 3/3] udf: Update header files to UDF 2.60
Date:   Tue,  7 Jan 2020 22:29:04 +0100
Message-Id: <20200107212904.30471-3-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107212904.30471-1-pali.rohar@gmail.com>
References: <20200107134425.GE25547@quack2.suse.cz>
 <20200107212904.30471-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change synchronizes header files ecma_167.h and osta_udf.h with
udftools 2.2 project which already has definitions for UDF 2.60 revision.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/udf/ecma_167.h | 26 ++++++++++++--
 fs/udf/osta_udf.h | 90 +++++++++++++++++++++++++++++++----------------
 2 files changed, 83 insertions(+), 33 deletions(-)

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index c98d5dc90..f9ee412fe 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -4,7 +4,8 @@
  * This file is based on ECMA-167 3rd edition (June 1997)
  * http://www.ecma.ch
  *
- * Copyright (c) 2001-2002  Ben Fennema <bfennema@falcon.csc.calpoly.edu>
+ * Copyright (c) 2001-2002  Ben Fennema
+ * Copyright (c) 2017-2019  Pali Rohár <pali.rohar@gmail.com>
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -32,11 +33,19 @@
  * SUCH DAMAGE.
  */
 
+/**
+ * @file
+ * ECMA-167r3 defines and structure definitions
+ */
+
 #include <linux/types.h>
 
 #ifndef _ECMA_167_H
 #define _ECMA_167_H 1
 
+/* Character sets and coding - d-characters (ECMA 167r3 1/7.2) */
+typedef uint8_t		dchars;
+
 /* Character set specification (ECMA 167r3 1/7.2.1) */
 struct charspec {
 	uint8_t		charSetType;
@@ -54,6 +63,7 @@ struct charspec {
 #define CHARSPEC_TYPE_CS7		0x07	/* (1/7.2.9) */
 #define CHARSPEC_TYPE_CS8		0x08	/* (1/7.2.10) */
 
+/* Fixed-length character fields - d-string (EMCA 167r3 1/7.2.12) */
 typedef uint8_t		dstring;
 
 /* Timestamp (ECMA 167r3 1/7.3) */
@@ -188,6 +198,13 @@ struct NSRDesc {
 	uint8_t		structData[2040];
 } __packed;
 
+/* Generic Descriptor */
+struct genericDesc {
+	struct tag	descTag;
+	__le32		volDescSeqNum;
+	uint8_t		reserved[492];
+} __packed;
+
 /* Primary Volume Descriptor (ECMA 167r3 3/10.1) */
 struct primaryVolDesc {
 	struct tag		descTag;
@@ -302,7 +319,7 @@ struct genericPartitionMap {
 
 /* Partition Map Type (ECMA 167r3 3/10.7.1.1) */
 #define GP_PARTITION_MAP_TYPE_UNDEF	0x00
-#define GP_PARTIITON_MAP_TYPE_1		0x01
+#define GP_PARTITION_MAP_TYPE_1		0x01
 #define GP_PARTITION_MAP_TYPE_2		0x02
 
 /* Type 1 Partition Map (ECMA 167r3 3/10.7.2) */
@@ -709,6 +726,7 @@ struct appUseExtAttr {
 #define EXTATTR_DEV_SPEC		12
 #define EXTATTR_IMP_USE			2048
 #define EXTATTR_APP_USE			65536
+#define EXTATTR_SUBTYPE			1
 
 /* Unallocated Space Entry (ECMA 167r3 4/14.11) */
 struct unallocSpaceEntry {
@@ -740,6 +758,8 @@ struct partitionIntegrityEntry {
 /* Short Allocation Descriptor (ECMA 167r3 4/14.14.1) */
 
 /* Extent Length (ECMA 167r3 4/14.14.1.1) */
+#define EXT_LENGTH_MASK			0x3FFFFFFF
+#define EXT_TYPE_MASK			0xC0000000
 #define EXT_RECORDED_ALLOCATED		0x00000000
 #define EXT_NOT_RECORDED_ALLOCATED	0x40000000
 #define EXT_NOT_RECORDED_NOT_ALLOCATED	0x80000000
@@ -760,7 +780,7 @@ struct pathComponent {
 	uint8_t		componentType;
 	uint8_t		lengthComponentIdent;
 	__le16		componentFileVersionNum;
-	dstring		componentIdent[0];
+	dchars		componentIdent[0];
 } __packed;
 
 /* File Entry (ECMA 167r3 4/14.17) */
diff --git a/fs/udf/osta_udf.h b/fs/udf/osta_udf.h
index c9117eb41..35e61b2ca 100644
--- a/fs/udf/osta_udf.h
+++ b/fs/udf/osta_udf.h
@@ -1,10 +1,11 @@
 /*
  * osta_udf.h
  *
- * This file is based on OSTA UDF(tm) 2.50 (April 30, 2003)
+ * This file is based on OSTA UDF(tm) 2.60 (March 1, 2005)
  * http://www.osta.org
  *
- * Copyright (c) 2001-2004  Ben Fennema <bfennema@falcon.csc.calpoly.edu>
+ * Copyright (c) 2001-2004  Ben Fennema
+ * Copyright (c) 2017-2019  Pali Rohár <pali.rohar@gmail.com>
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -32,36 +33,49 @@
  * SUCH DAMAGE.
  */
 
+/**
+ * @file
+ * OSTA-UDF defines and structure definitions
+ */
+
 #include "ecma_167.h"
 
 #ifndef _OSTA_UDF_H
 #define _OSTA_UDF_H 1
 
-/* OSTA CS0 Charspec (UDF 2.50 2.1.2) */
+/* OSTA CS0 Charspec (UDF 2.60 2.1.2) */
 #define UDF_CHAR_SET_TYPE		0
 #define UDF_CHAR_SET_INFO		"OSTA Compressed Unicode"
 
-/* Entity Identifier (UDF 2.50 2.1.5) */
-/* Identifiers (UDF 2.50 2.1.5.2) */
+/* Entity Identifier (UDF 2.60 2.1.5) */
+/* Identifiers (UDF 2.60 2.1.5.2) */
+/* Implementation Use Extended Attribute (UDF 2.60 3.3.4.5) */
+/* Virtual Allocation Table (UDF 1.50 2.2.10) */
+/* Logical Volume Extended Information (UDF 1.50 Errata, DCN 5003, 3.3.4.5.1.3) */
+/* OS2EA (UDF 1.50 3.3.4.5.3.1) */
+/* MacUniqueIDTable (UDF 1.50 3.3.4.5.4.3) */
+/* MacResourceFork (UDF 1.50 3.3.4.5.4.4) */
 #define UDF_ID_DEVELOPER		"*Linux UDFFS"
 #define	UDF_ID_COMPLIANT		"*OSTA UDF Compliant"
 #define UDF_ID_LV_INFO			"*UDF LV Info"
 #define UDF_ID_FREE_EA			"*UDF FreeEASpace"
 #define UDF_ID_FREE_APP_EA		"*UDF FreeAppEASpace"
 #define UDF_ID_DVD_CGMS			"*UDF DVD CGMS Info"
+#define UDF_ID_VAT_LVEXTENSION		"*UDF VAT LVExtension"
 #define UDF_ID_OS2_EA			"*UDF OS/2 EA"
 #define UDF_ID_OS2_EA_LENGTH		"*UDF OS/2 EALength"
 #define UDF_ID_MAC_VOLUME		"*UDF Mac VolumeInfo"
 #define UDF_ID_MAC_FINDER		"*UDF Mac FinderInfo"
 #define UDF_ID_MAC_UNIQUE		"*UDF Mac UniqueIDTable"
 #define UDF_ID_MAC_RESOURCE		"*UDF Mac ResourceFork"
+#define UDF_ID_OS400_DIRINFO		"*UDF OS/400 DirInfo"
 #define UDF_ID_VIRTUAL			"*UDF Virtual Partition"
 #define UDF_ID_SPARABLE			"*UDF Sparable Partition"
 #define UDF_ID_ALLOC			"*UDF Virtual Alloc Tbl"
 #define UDF_ID_SPARING			"*UDF Sparing Table"
 #define UDF_ID_METADATA			"*UDF Metadata Partition"
 
-/* Identifier Suffix (UDF 2.50 2.1.5.3) */
+/* Identifier Suffix (UDF 2.60 2.1.5.3) */
 #define DOMAIN_FLAGS_HARD_WRITE_PROTECT	0x01
 #define DOMAIN_FLAGS_SOFT_WRITE_PROTECT	0x02
 
@@ -81,15 +95,15 @@ struct UDFIdentSuffix {
 struct impIdentSuffix {
 	uint8_t		OSClass;
 	uint8_t		OSIdentifier;
-	uint8_t		reserved[6];
+	uint8_t		impUse[6];
 } __packed;
 
 struct appIdentSuffix {
 	uint8_t		impUse[8];
 } __packed;
 
-/* Logical Volume Integrity Descriptor (UDF 2.50 2.2.6) */
-/* Implementation Use (UDF 2.50 2.2.6.4) */
+/* Logical Volume Integrity Descriptor (UDF 2.60 2.2.6) */
+/* Implementation Use (UDF 2.60 2.2.6.4) */
 struct logicalVolIntegrityDescImpUse {
 	struct regid	impIdent;
 	__le32		numFiles;
@@ -100,8 +114,8 @@ struct logicalVolIntegrityDescImpUse {
 	uint8_t		impUse[0];
 } __packed;
 
-/* Implementation Use Volume Descriptor (UDF 2.50 2.2.7) */
-/* Implementation Use (UDF 2.50 2.2.7.2) */
+/* Implementation Use Volume Descriptor (UDF 2.60 2.2.7) */
+/* Implementation Use (UDF 2.60 2.2.7.2) */
 struct impUseVolDescImpUse {
 	struct charspec	LVICharset;
 	dstring		logicalVolIdent[128];
@@ -121,7 +135,7 @@ struct udfPartitionMap2 {
 	__le16		partitionNum;
 } __packed;
 
-/* Virtual Partition Map (UDF 2.50 2.2.8) */
+/* Virtual Partition Map (UDF 2.60 2.2.8) */
 struct virtualPartitionMap {
 	uint8_t		partitionMapType;
 	uint8_t		partitionMapLength;
@@ -132,7 +146,7 @@ struct virtualPartitionMap {
 	uint8_t		reserved2[24];
 } __packed;
 
-/* Sparable Partition Map (UDF 2.50 2.2.9) */
+/* Sparable Partition Map (UDF 2.60 2.2.9) */
 struct sparablePartitionMap {
 	uint8_t partitionMapType;
 	uint8_t partitionMapLength;
@@ -147,7 +161,7 @@ struct sparablePartitionMap {
 	__le32 locSparingTable[4];
 } __packed;
 
-/* Metadata Partition Map (UDF 2.4.0 2.2.10) */
+/* Metadata Partition Map (UDF 2.60 2.2.10) */
 struct metadataPartitionMap {
 	uint8_t		partitionMapType;
 	uint8_t		partitionMapLength;
@@ -166,14 +180,14 @@ struct metadataPartitionMap {
 
 /* Virtual Allocation Table (UDF 1.5 2.2.10) */
 struct virtualAllocationTable15 {
-	__le32		VirtualSector[0];
+	__le32		vatEntry[0];
 	struct regid	vatIdent;
 	__le32		previousVATICBLoc;
 } __packed;
 
 #define ICBTAG_FILE_TYPE_VAT15		0x00U
 
-/* Virtual Allocation Table (UDF 2.50 2.2.11) */
+/* Virtual Allocation Table (UDF 2.60 2.2.11) */
 struct virtualAllocationTable20 {
 	__le16		lengthHeader;
 	__le16		lengthImpUse;
@@ -181,9 +195,9 @@ struct virtualAllocationTable20 {
 	__le32		previousVATICBLoc;
 	__le32		numFiles;
 	__le32		numDirs;
-	__le16		minReadRevision;
-	__le16		minWriteRevision;
-	__le16		maxWriteRevision;
+	__le16		minUDFReadRev;
+	__le16		minUDFWriteRev;
+	__le16		maxUDFWriteRev;
 	__le16		reserved;
 	uint8_t		impUse[0];
 	__le32		vatEntry[0];
@@ -191,7 +205,7 @@ struct virtualAllocationTable20 {
 
 #define ICBTAG_FILE_TYPE_VAT20		0xF8U
 
-/* Sparing Table (UDF 2.50 2.2.12) */
+/* Sparing Table (UDF 2.60 2.2.12) */
 struct sparingEntry {
 	__le32		origLocation;
 	__le32		mappedLocation;
@@ -207,12 +221,12 @@ struct sparingTable {
 			mapEntry[0];
 } __packed;
 
-/* Metadata File (and Metadata Mirror File) (UDF 2.50 2.2.13.1) */
+/* Metadata File (and Metadata Mirror File) (UDF 2.60 2.2.13.1) */
 #define ICBTAG_FILE_TYPE_MAIN		0xFA
 #define ICBTAG_FILE_TYPE_MIRROR		0xFB
 #define ICBTAG_FILE_TYPE_BITMAP		0xFC
 
-/* struct struct long_ad ICB - ADImpUse (UDF 2.50 2.2.4.3) */
+/* struct struct long_ad ICB - ADImpUse (UDF 2.60 2.2.4.3) */
 struct allocDescImpUse {
 	__le16		flags;
 	uint8_t		impUse[4];
@@ -220,17 +234,17 @@ struct allocDescImpUse {
 
 #define AD_IU_EXT_ERASED		0x0001
 
-/* Real-Time Files (UDF 2.50 6.11) */
+/* Real-Time Files (UDF 2.60 6.11) */
 #define ICBTAG_FILE_TYPE_REALTIME	0xF9U
 
-/* Implementation Use Extended Attribute (UDF 2.50 3.3.4.5) */
-/* FreeEASpace (UDF 2.50 3.3.4.5.1.1) */
+/* Implementation Use Extended Attribute (UDF 2.60 3.3.4.5) */
+/* FreeEASpace (UDF 2.60 3.3.4.5.1.1) */
 struct freeEaSpace {
 	__le16		headerChecksum;
 	uint8_t		freeEASpace[0];
 } __packed;
 
-/* DVD Copyright Management Information (UDF 2.50 3.3.4.5.1.2) */
+/* DVD Copyright Management Information (UDF 2.60 3.3.4.5.1.2) */
 struct DVDCopyrightImpUse {
 	__le16		headerChecksum;
 	uint8_t		CGMSInfo;
@@ -238,20 +252,35 @@ struct DVDCopyrightImpUse {
 	uint8_t		protectionSystemInfo[4];
 } __packed;
 
-/* Application Use Extended Attribute (UDF 2.50 3.3.4.6) */
-/* FreeAppEASpace (UDF 2.50 3.3.4.6.1) */
+/* Logical Volume Extended Information (UDF 1.50 Errata, DCN 5003, 3.3.4.5.1.3) */
+struct LVExtensionEA {
+	__le16		headerChecksum;
+	__le64		verificationID;
+	__le32		numFiles;
+	__le32		numDirs;
+	dstring		logicalVolIdent[128];
+} __packed;
+
+/* Application Use Extended Attribute (UDF 2.60 3.3.4.6) */
+/* FreeAppEASpace (UDF 2.60 3.3.4.6.1) */
 struct freeAppEASpace {
 	__le16		headerChecksum;
 	uint8_t		freeEASpace[0];
 } __packed;
 
-/* UDF Defined System Stream (UDF 2.50 3.3.7) */
+/* UDF Defined System Stream (UDF 2.60 3.3.7) */
 #define UDF_ID_UNIQUE_ID		"*UDF Unique ID Mapping Data"
 #define UDF_ID_NON_ALLOC		"*UDF Non-Allocatable Space"
 #define UDF_ID_POWER_CAL		"*UDF Power Cal Table"
 #define UDF_ID_BACKUP			"*UDF Backup"
 
-/* Operating System Identifiers (UDF 2.50 6.3) */
+/* UDF Defined Non-System Streams (UDF 2.60 3.3.8) */
+#define UDF_ID_MAC_RESOURCE_FORK_STREAM	"*UDF Macintosh Resource Fork"
+/* #define UDF_ID_OS2_EA		"*UDF OS/2 EA" */
+#define UDF_ID_NT_ACL			"*UDF NT ACL"
+#define UDF_ID_UNIX_ACL			"*UDF UNIX ACL"
+
+/* Operating System Identifiers (UDF 2.60 6.3) */
 #define UDF_OS_CLASS_UNDEF		0x00U
 #define UDF_OS_CLASS_DOS		0x01U
 #define UDF_OS_CLASS_OS2		0x02U
@@ -276,6 +305,7 @@ struct freeAppEASpace {
 #define UDF_OS_ID_LINUX			0x05U
 #define UDF_OS_ID_MKLINUX		0x06U
 #define UDF_OS_ID_FREEBSD		0x07U
+#define UDF_OS_ID_NETBSD		0x08U
 #define UDF_OS_ID_WIN9X			0x00U
 #define UDF_OS_ID_WINNT			0x00U
 #define UDF_OS_ID_OS400			0x00U
-- 
2.20.1

