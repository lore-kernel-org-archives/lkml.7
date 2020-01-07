Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8398FC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462312081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgAGNo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:44:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:57008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgAGNo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:44:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C7DFADD7;
        Tue,  7 Jan 2020 13:44:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 57B1F1E0B47; Tue,  7 Jan 2020 14:44:25 +0100 (CET)
Date:   Tue, 7 Jan 2020 14:44:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: Update header files to UDF 2.60
Message-ID: <20200107134425.GE25547@quack2.suse.cz>
References: <20191226111923.9721-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226111923.9721-1-pali.rohar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-12-19 12:19:23, Pali Rohár wrote:
> This change synchronize header files ecma_167.h and osta_udf.h with
> udftools 2.2 project which already have definitions for UDF 2.60 revision.
> In most cases there are only changes in comments and added new definitions
> and done. There are no functional changes in code. Visible changes are:
> 
> 1. Removed duplicate definition of UDF_ID_COMPLIANT macro.
> 
> 2. Moved OSTA Identifier Suffix macros from ecma_167.h to osta_udf.h,
>    changed its naming and types (endianity fix) to match naming convention
>    with other UDF structures.
> 
> 3. Renamed EXT_NEXT_EXTENT_ALLOCDECS macro to EXT_NEXT_EXTENT_ALLOCDESCS as
>    "desc" abbrev (and not "dec") is used on all other places.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>

I like the changes. But can you please split them into several patches
doing one thing at a time? Like:

1) EXT_NEXT_EXTENT_ALLOCDECS spelling fixup
2) OSTA definitions move & rename
3) whatever is left.

Thanks!

								Honza

> ---
>  fs/udf/ecma_167.h |  42 +++++++++++++----------
>  fs/udf/inode.c    |   6 ++--
>  fs/udf/osta_udf.h | 100 +++++++++++++++++++++++++++++++++++++-----------------
>  fs/udf/super.c    |   8 ++---
>  fs/udf/truncate.c |   2 +-
>  5 files changed, 100 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index fb7f2c7be..f9ee412fe 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -4,7 +4,8 @@
>   * This file is based on ECMA-167 3rd edition (June 1997)
>   * http://www.ecma.ch
>   *
> - * Copyright (c) 2001-2002  Ben Fennema <bfennema@falcon.csc.calpoly.edu>
> + * Copyright (c) 2001-2002  Ben Fennema
> + * Copyright (c) 2017-2019  Pali Rohár <pali.rohar@gmail.com>
>   * All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
> @@ -32,11 +33,19 @@
>   * SUCH DAMAGE.
>   */
>  
> +/**
> + * @file
> + * ECMA-167r3 defines and structure definitions
> + */
> +
>  #include <linux/types.h>
>  
>  #ifndef _ECMA_167_H
>  #define _ECMA_167_H 1
>  
> +/* Character sets and coding - d-characters (ECMA 167r3 1/7.2) */
> +typedef uint8_t		dchars;
> +
>  /* Character set specification (ECMA 167r3 1/7.2.1) */
>  struct charspec {
>  	uint8_t		charSetType;
> @@ -54,6 +63,7 @@ struct charspec {
>  #define CHARSPEC_TYPE_CS7		0x07	/* (1/7.2.9) */
>  #define CHARSPEC_TYPE_CS8		0x08	/* (1/7.2.10) */
>  
> +/* Fixed-length character fields - d-string (EMCA 167r3 1/7.2.12) */
>  typedef uint8_t		dstring;
>  
>  /* Timestamp (ECMA 167r3 1/7.3) */
> @@ -88,20 +98,6 @@ struct regid {
>  #define ENTITYID_FLAGS_DIRTY		0x00
>  #define ENTITYID_FLAGS_PROTECTED	0x01
>  
> -/* OSTA UDF 2.1.5.2 */
> -#define UDF_ID_COMPLIANT "*OSTA UDF Compliant"
> -
> -/* OSTA UDF 2.1.5.3 */
> -struct domainEntityIDSuffix {
> -	uint16_t	revision;
> -	uint8_t		flags;
> -	uint8_t		reserved[5];
> -};
> -
> -/* OSTA UDF 2.1.5.3 */
> -#define ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT 0
> -#define ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT 1
> -
>  /* Volume Structure Descriptor (ECMA 167r3 2/9.1) */
>  #define VSD_STD_ID_LEN			5
>  struct volStructDesc {
> @@ -202,6 +198,13 @@ struct NSRDesc {
>  	uint8_t		structData[2040];
>  } __packed;
>  
> +/* Generic Descriptor */
> +struct genericDesc {
> +	struct tag	descTag;
> +	__le32		volDescSeqNum;
> +	uint8_t		reserved[492];
> +} __packed;
> +
>  /* Primary Volume Descriptor (ECMA 167r3 3/10.1) */
>  struct primaryVolDesc {
>  	struct tag		descTag;
> @@ -316,7 +319,7 @@ struct genericPartitionMap {
>  
>  /* Partition Map Type (ECMA 167r3 3/10.7.1.1) */
>  #define GP_PARTITION_MAP_TYPE_UNDEF	0x00
> -#define GP_PARTIITON_MAP_TYPE_1		0x01
> +#define GP_PARTITION_MAP_TYPE_1		0x01
>  #define GP_PARTITION_MAP_TYPE_2		0x02
>  
>  /* Type 1 Partition Map (ECMA 167r3 3/10.7.2) */
> @@ -723,6 +726,7 @@ struct appUseExtAttr {
>  #define EXTATTR_DEV_SPEC		12
>  #define EXTATTR_IMP_USE			2048
>  #define EXTATTR_APP_USE			65536
> +#define EXTATTR_SUBTYPE			1
>  
>  /* Unallocated Space Entry (ECMA 167r3 4/14.11) */
>  struct unallocSpaceEntry {
> @@ -754,10 +758,12 @@ struct partitionIntegrityEntry {
>  /* Short Allocation Descriptor (ECMA 167r3 4/14.14.1) */
>  
>  /* Extent Length (ECMA 167r3 4/14.14.1.1) */
> +#define EXT_LENGTH_MASK			0x3FFFFFFF
> +#define EXT_TYPE_MASK			0xC0000000
>  #define EXT_RECORDED_ALLOCATED		0x00000000
>  #define EXT_NOT_RECORDED_ALLOCATED	0x40000000
>  #define EXT_NOT_RECORDED_NOT_ALLOCATED	0x80000000
> -#define EXT_NEXT_EXTENT_ALLOCDECS	0xC0000000
> +#define EXT_NEXT_EXTENT_ALLOCDESCS	0xC0000000
>  
>  /* Long Allocation Descriptor (ECMA 167r3 4/14.14.2) */
>  
> @@ -774,7 +780,7 @@ struct pathComponent {
>  	uint8_t		componentType;
>  	uint8_t		lengthComponentIdent;
>  	__le16		componentFileVersionNum;
> -	dstring		componentIdent[0];
> +	dchars		componentIdent[0];
>  } __packed;
>  
>  /* File Entry (ECMA 167r3 4/14.17) */
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index ea80036d7..e875bc566 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1981,10 +1981,10 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
>  
>  		__udf_add_aext(inode, &nepos, &cp_loc, cp_len, 1);
>  		udf_write_aext(inode, epos, &nepos.block,
> -			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDECS, 0);
> +			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDESCS, 0);
>  	} else {
>  		__udf_add_aext(inode, epos, &nepos.block,
> -			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDECS, 0);
> +			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDESCS, 0);
>  	}
>  
>  	brelse(epos->bh);
> @@ -2143,7 +2143,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
>  	unsigned int indirections = 0;
>  
>  	while ((etype = udf_current_aext(inode, epos, eloc, elen, inc)) ==
> -	       (EXT_NEXT_EXTENT_ALLOCDECS >> 30)) {
> +	       (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
>  		udf_pblk_t block;
>  
>  		if (++indirections > UDF_MAX_INDIR_EXTS) {
> diff --git a/fs/udf/osta_udf.h b/fs/udf/osta_udf.h
> index a4da59e38..838f853b2 100644
> --- a/fs/udf/osta_udf.h
> +++ b/fs/udf/osta_udf.h
> @@ -1,10 +1,11 @@
>  /*
>   * osta_udf.h
>   *
> - * This file is based on OSTA UDF(tm) 2.50 (April 30, 2003)
> + * This file is based on OSTA UDF(tm) 2.60 (March 1, 2005)
>   * http://www.osta.org
>   *
> - * Copyright (c) 2001-2004  Ben Fennema <bfennema@falcon.csc.calpoly.edu>
> + * Copyright (c) 2001-2004  Ben Fennema
> + * Copyright (c) 2017-2019  Pali Rohár <pali.rohar@gmail.com>
>   * All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
> @@ -32,38 +33,57 @@
>   * SUCH DAMAGE.
>   */
>  
> +/**
> + * @file
> + * OSTA-UDF defines and structure definitions
> + */
> +
>  #include "ecma_167.h"
>  
>  #ifndef _OSTA_UDF_H
>  #define _OSTA_UDF_H 1
>  
> -/* OSTA CS0 Charspec (UDF 2.50 2.1.2) */
> +/* OSTA CS0 Charspec (UDF 2.60 2.1.2) */
>  #define UDF_CHAR_SET_TYPE		0
>  #define UDF_CHAR_SET_INFO		"OSTA Compressed Unicode"
>  
> -/* Entity Identifier (UDF 2.50 2.1.5) */
> -/* Identifiers (UDF 2.50 2.1.5.2) */
> +/* Entity Identifier (UDF 2.60 2.1.5) */
> +/* Identifiers (UDF 2.60 2.1.5.2) */
> +/* Implementation Use Extended Attribute (UDF 2.60 3.3.4.5) */
> +/* Virtual Allocation Table (UDF 1.50 2.2.10) */
> +/* Logical Volume Extended Information (UDF 1.50 Errata, DCN 5003, 3.3.4.5.1.3) */
> +/* OS2EA (UDF 1.50 3.3.4.5.3.1) */
> +/* MacUniqueIDTable (UDF 1.50 3.3.4.5.4.3) */
> +/* MacResourceFork (UDF 1.50 3.3.4.5.4.4) */
>  #define UDF_ID_DEVELOPER		"*Linux UDFFS"
>  #define	UDF_ID_COMPLIANT		"*OSTA UDF Compliant"
>  #define UDF_ID_LV_INFO			"*UDF LV Info"
>  #define UDF_ID_FREE_EA			"*UDF FreeEASpace"
>  #define UDF_ID_FREE_APP_EA		"*UDF FreeAppEASpace"
>  #define UDF_ID_DVD_CGMS			"*UDF DVD CGMS Info"
> +#define UDF_ID_VAT_LVEXTENSION		"*UDF VAT LVExtension"
>  #define UDF_ID_OS2_EA			"*UDF OS/2 EA"
>  #define UDF_ID_OS2_EA_LENGTH		"*UDF OS/2 EALength"
>  #define UDF_ID_MAC_VOLUME		"*UDF Mac VolumeInfo"
>  #define UDF_ID_MAC_FINDER		"*UDF Mac FinderInfo"
>  #define UDF_ID_MAC_UNIQUE		"*UDF Mac UniqueIDTable"
>  #define UDF_ID_MAC_RESOURCE		"*UDF Mac ResourceFork"
> +#define UDF_ID_OS400_DIRINFO		"*UDF OS/400 DirInfo"
>  #define UDF_ID_VIRTUAL			"*UDF Virtual Partition"
>  #define UDF_ID_SPARABLE			"*UDF Sparable Partition"
>  #define UDF_ID_ALLOC			"*UDF Virtual Alloc Tbl"
>  #define UDF_ID_SPARING			"*UDF Sparing Table"
>  #define UDF_ID_METADATA			"*UDF Metadata Partition"
>  
> -/* Identifier Suffix (UDF 2.50 2.1.5.3) */
> -#define IS_DF_HARD_WRITE_PROTECT	0x01
> -#define IS_DF_SOFT_WRITE_PROTECT	0x02
> +/* Identifier Suffix (UDF 2.60 2.1.5.3) */
> +#define DOMAIN_FLAGS_HARD_WRITE_PROTECT	0x01
> +#define DOMAIN_FLAGS_SOFT_WRITE_PROTECT	0x02
> +
> +struct domainIdentSuffix {
> +	__le16		UDFRevision;
> +	uint8_t		domainFlags;
> +	uint8_t		reserved[5];
> +} __packed;
>  
>  struct UDFIdentSuffix {
>  	__le16		UDFRevision;
> @@ -75,15 +95,15 @@ struct UDFIdentSuffix {
>  struct impIdentSuffix {
>  	uint8_t		OSClass;
>  	uint8_t		OSIdentifier;
> -	uint8_t		reserved[6];
> +	uint8_t		impUse[6];
>  } __packed;
>  
>  struct appIdentSuffix {
>  	uint8_t		impUse[8];
>  } __packed;
>  
> -/* Logical Volume Integrity Descriptor (UDF 2.50 2.2.6) */
> -/* Implementation Use (UDF 2.50 2.2.6.4) */
> +/* Logical Volume Integrity Descriptor (UDF 2.60 2.2.6) */
> +/* Implementation Use (UDF 2.60 2.2.6.4) */
>  struct logicalVolIntegrityDescImpUse {
>  	struct regid	impIdent;
>  	__le32		numFiles;
> @@ -94,8 +114,8 @@ struct logicalVolIntegrityDescImpUse {
>  	uint8_t		impUse[0];
>  } __packed;
>  
> -/* Implementation Use Volume Descriptor (UDF 2.50 2.2.7) */
> -/* Implementation Use (UDF 2.50 2.2.7.2) */
> +/* Implementation Use Volume Descriptor (UDF 2.60 2.2.7) */
> +/* Implementation Use (UDF 2.60 2.2.7.2) */
>  struct impUseVolDescImpUse {
>  	struct charspec	LVICharset;
>  	dstring		logicalVolIdent[128];
> @@ -115,7 +135,7 @@ struct udfPartitionMap2 {
>  	__le16		partitionNum;
>  } __packed;
>  
> -/* Virtual Partition Map (UDF 2.50 2.2.8) */
> +/* Virtual Partition Map (UDF 2.60 2.2.8) */
>  struct virtualPartitionMap {
>  	uint8_t		partitionMapType;
>  	uint8_t		partitionMapLength;
> @@ -126,7 +146,7 @@ struct virtualPartitionMap {
>  	uint8_t		reserved2[24];
>  } __packed;
>  
> -/* Sparable Partition Map (UDF 2.50 2.2.9) */
> +/* Sparable Partition Map (UDF 2.60 2.2.9) */
>  struct sparablePartitionMap {
>  	uint8_t partitionMapType;
>  	uint8_t partitionMapLength;
> @@ -141,7 +161,7 @@ struct sparablePartitionMap {
>  	__le32 locSparingTable[4];
>  } __packed;
>  
> -/* Metadata Partition Map (UDF 2.4.0 2.2.10) */
> +/* Metadata Partition Map (UDF 2.60 2.2.10) */
>  struct metadataPartitionMap {
>  	uint8_t		partitionMapType;
>  	uint8_t		partitionMapLength;
> @@ -160,14 +180,14 @@ struct metadataPartitionMap {
>  
>  /* Virtual Allocation Table (UDF 1.5 2.2.10) */
>  struct virtualAllocationTable15 {
> -	__le32		VirtualSector[0];
> +	__le32		vatEntry[0];
>  	struct regid	vatIdent;
>  	__le32		previousVATICBLoc;
>  } __packed;
>  
>  #define ICBTAG_FILE_TYPE_VAT15		0x00U
>  
> -/* Virtual Allocation Table (UDF 2.50 2.2.11) */
> +/* Virtual Allocation Table (UDF 2.60 2.2.11) */
>  struct virtualAllocationTable20 {
>  	__le16		lengthHeader;
>  	__le16		lengthImpUse;
> @@ -175,9 +195,9 @@ struct virtualAllocationTable20 {
>  	__le32		previousVATICBLoc;
>  	__le32		numFiles;
>  	__le32		numDirs;
> -	__le16		minReadRevision;
> -	__le16		minWriteRevision;
> -	__le16		maxWriteRevision;
> +	__le16		minUDFReadRev;
> +	__le16		minUDFWriteRev;
> +	__le16		maxUDFWriteRev;
>  	__le16		reserved;
>  	uint8_t		impUse[0];
>  	__le32		vatEntry[0];
> @@ -185,7 +205,7 @@ struct virtualAllocationTable20 {
>  
>  #define ICBTAG_FILE_TYPE_VAT20		0xF8U
>  
> -/* Sparing Table (UDF 2.50 2.2.12) */
> +/* Sparing Table (UDF 2.60 2.2.12) */
>  struct sparingEntry {
>  	__le32		origLocation;
>  	__le32		mappedLocation;
> @@ -201,12 +221,12 @@ struct sparingTable {
>  			mapEntry[0];
>  } __packed;
>  
> -/* Metadata File (and Metadata Mirror File) (UDF 2.50 2.2.13.1) */
> +/* Metadata File (and Metadata Mirror File) (UDF 2.60 2.2.13.1) */
>  #define ICBTAG_FILE_TYPE_MAIN		0xFA
>  #define ICBTAG_FILE_TYPE_MIRROR		0xFB
>  #define ICBTAG_FILE_TYPE_BITMAP		0xFC
>  
> -/* struct struct long_ad ICB - ADImpUse (UDF 2.50 2.2.4.3) */
> +/* struct struct long_ad ICB - ADImpUse (UDF 2.60 2.2.4.3) */
>  struct allocDescImpUse {
>  	__le16		flags;
>  	uint8_t		impUse[4];
> @@ -214,17 +234,17 @@ struct allocDescImpUse {
>  
>  #define AD_IU_EXT_ERASED		0x0001
>  
> -/* Real-Time Files (UDF 2.50 6.11) */
> +/* Real-Time Files (UDF 2.60 6.11) */
>  #define ICBTAG_FILE_TYPE_REALTIME	0xF9U
>  
> -/* Implementation Use Extended Attribute (UDF 2.50 3.3.4.5) */
> -/* FreeEASpace (UDF 2.50 3.3.4.5.1.1) */
> +/* Implementation Use Extended Attribute (UDF 2.60 3.3.4.5) */
> +/* FreeEASpace (UDF 2.60 3.3.4.5.1.1) */
>  struct freeEaSpace {
>  	__le16		headerChecksum;
>  	uint8_t		freeEASpace[0];
>  } __packed;
>  
> -/* DVD Copyright Management Information (UDF 2.50 3.3.4.5.1.2) */
> +/* DVD Copyright Management Information (UDF 2.60 3.3.4.5.1.2) */
>  struct DVDCopyrightImpUse {
>  	__le16		headerChecksum;
>  	uint8_t		CGMSInfo;
> @@ -232,20 +252,35 @@ struct DVDCopyrightImpUse {
>  	uint8_t		protectionSystemInfo[4];
>  } __packed;
>  
> -/* Application Use Extended Attribute (UDF 2.50 3.3.4.6) */
> -/* FreeAppEASpace (UDF 2.50 3.3.4.6.1) */
> +/* Logical Volume Extended Information (UDF 1.50 Errata, DCN 5003, 3.3.4.5.1.3) */
> +struct LVExtensionEA {
> +	__le16		headerChecksum;
> +	__le64		verificationID;
> +	__le32		numFiles;
> +	__le32		numDirs;
> +	dstring		logicalVolIdent[128];
> +} __packed;
> +
> +/* Application Use Extended Attribute (UDF 2.60 3.3.4.6) */
> +/* FreeAppEASpace (UDF 2.60 3.3.4.6.1) */
>  struct freeAppEASpace {
>  	__le16		headerChecksum;
>  	uint8_t		freeEASpace[0];
>  } __packed;
>  
> -/* UDF Defined System Stream (UDF 2.50 3.3.7) */
> +/* UDF Defined System Stream (UDF 2.60 3.3.7) */
>  #define UDF_ID_UNIQUE_ID		"*UDF Unique ID Mapping Data"
>  #define UDF_ID_NON_ALLOC		"*UDF Non-Allocatable Space"
>  #define UDF_ID_POWER_CAL		"*UDF Power Cal Table"
>  #define UDF_ID_BACKUP			"*UDF Backup"
>  
> -/* Operating System Identifiers (UDF 2.50 6.3) */
> +/* UDF Defined Non-System Streams (UDF 2.60 3.3.8) */
> +#define UDF_ID_MAC_RESOURCE_FORK_STREAM	"*UDF Macintosh Resource Fork"
> +/* #define UDF_ID_OS2_EA		"*UDF OS/2 EA" */
> +#define UDF_ID_NT_ACTL			"*UDF NT ACL"
> +#define UDF_ID_UNIX_ACTL		"*UDF UNIX ACL"
> +
> +/* Operating System Identifiers (UDF 2.60 6.3) */
>  #define UDF_OS_CLASS_UNDEF		0x00U
>  #define UDF_OS_CLASS_DOS		0x01U
>  #define UDF_OS_CLASS_OS2		0x02U
> @@ -270,6 +305,7 @@ struct freeAppEASpace {
>  #define UDF_OS_ID_LINUX			0x05U
>  #define UDF_OS_ID_MKLINUX		0x06U
>  #define UDF_OS_ID_FREEBSD		0x07U
> +#define UDF_OS_ID_NETBSD		0x08U
>  #define UDF_OS_ID_WIN9X			0x00U
>  #define UDF_OS_ID_WINNT			0x00U
>  #define UDF_OS_ID_OS400			0x00U
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 8c28e93e9..2d0b90800 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -767,7 +767,7 @@ static int udf_check_vsd(struct super_block *sb)
>  static int udf_verify_domain_identifier(struct super_block *sb,
>  					struct regid *ident, char *dname)
>  {
> -	struct domainEntityIDSuffix *suffix;
> +	struct domainIdentSuffix *suffix;
>  
>  	if (memcmp(ident->ident, UDF_ID_COMPLIANT, strlen(UDF_ID_COMPLIANT))) {
>  		udf_warn(sb, "Not OSTA UDF compliant %s descriptor.\n", dname);
> @@ -778,9 +778,9 @@ static int udf_verify_domain_identifier(struct super_block *sb,
>  			 dname);
>  		goto force_ro;
>  	}
> -	suffix = (struct domainEntityIDSuffix *)ident->identSuffix;
> -	if (suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT) ||
> -	    suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT)) {
> +	suffix = (struct domainIdentSuffix *)ident->identSuffix;
> +	if ((suffix->domainFlags & DOMAIN_FLAGS_HARD_WRITE_PROTECT) ||
> +	    (suffix->domainFlags & DOMAIN_FLAGS_SOFT_WRITE_PROTECT)) {
>  		if (!sb_rdonly(sb)) {
>  			udf_warn(sb, "Descriptor for %s marked write protected."
>  				 " Forcing read only mount.\n", dname);
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index 63a47f1e1..532cda996 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -241,7 +241,7 @@ int udf_truncate_extents(struct inode *inode)
>  
>  	while ((etype = udf_current_aext(inode, &epos, &eloc,
>  					 &elen, 0)) != -1) {
> -		if (etype == (EXT_NEXT_EXTENT_ALLOCDECS >> 30)) {
> +		if (etype == (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
>  			udf_write_aext(inode, &epos, &neloc, nelen, 0);
>  			if (indirect_ext_len) {
>  				/* We managed to free all extents in the
> -- 
> 2.11.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
