Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D49C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C927620725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Ev4o/97+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLPIwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:52:07 -0500
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:5966
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbfLPIwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:52:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBadlTk2gqgmhS9+F0v2NDK382C813pebZsgngYR+u18s1bE6LC8hQpdmhHOuwLO3SNwdAzruGlQq/Go6GotUz86f/qB4ldmae56ZHF9dSbcKS1tzZkhHay2+B/UlNh/GP1K2GFyF6ZuAVkCokdLieaoDm29J8Mv+sg23uNWaH+ctcF+9H7zLx+hioR4p9TkKfTJBeFeoq93jToTnwcEYNBM4y+Kn6FHExTE65O/yN8aW60zstc9CifMMDp8PdfdQrVMDDaodtuQd6fWyQO33gstkpBcVXZPX42COnazR089l8nPA3OwhltYwEQiDHP33dSaiTEI/s5LWL99lScRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCzWi5HtwPTZi4DJz5Mk10lsec7d56j86AZ9hON9Zb8=;
 b=ULhIbnv5BFZpi7RLCsaSf13d4lHZ9p4uqSn7Dd1KMQ3oSdMfhVFMHbavtmf6odlZ8TH7ZOFYhqAoAyX6FM3oOvILD3BWZNpPkQzJbVkcy1FFuLjAHaSoKT29Y+TF1zL9RyaJGVTEwBPT7ReyJMubZ/E+Nx0m91lfMKeajVZqAQvE5lsqaw6aS85xDIyReaxaWwNCN8bs6RopN3UdE5zy/3dotRZK3a/m11LC6wGZVu8X/fFINAAkAoH3m5LhIpGFxMVcuJW09mR4psHJ0tQMXu/pYwZbK8nlU4VnV0VpEze8QPtBK2svrg6OquqRbIlcjBIhhOXJ8AN7ag7eckK3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCzWi5HtwPTZi4DJz5Mk10lsec7d56j86AZ9hON9Zb8=;
 b=Ev4o/97+9fsy0KM6sO85lFwIdVIcLqPDghK+zT8FSdvOfXa87MKNX7QgqjZ1HTw3ZxbV9GZuoitDUJADrh/V0nmIeQV7PetABR0iFB4kepNTDADvScdxIuLZn/nRaxUWbh1V4V4a31mu6XTYjPHM8+/e1NGDgw0dGVK9wZfA1HE=
Received: from HE1PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:7:16::25) by
 AM0PR06MB3987.eurprd06.prod.outlook.com (2603:10a6:208:b1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Mon, 16 Dec 2019 08:52:00 +0000
Received: from VE1EUR02FT018.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::206) by HE1PR06CA0138.outlook.office365.com
 (2603:10a6:7:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17 via Frontend
 Transport; Mon, 16 Dec 2019 08:51:59 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT018.mail.protection.outlook.com (10.152.12.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2538.14 via Frontend Transport; Mon, 16 Dec 2019 08:51:59 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 16 Dec
 2019 09:51:58 +0100
Received: from cwe-513-vol689.cern.ch (2001:1458:d00:7::100:1c8) by
 smtp.cern.ch (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 16 Dec 2019 09:51:57 +0100
Date:   Mon, 16 Dec 2019 09:51:56 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Denis Efremov <efremov@linux.com>,
        <linux-kernel@vger.kernel.org>, Pat Riehecky <riehecky@fnal.gov>,
        Alessandro Rubini <rubini@gnudd.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Sebastian Duda <sebastian.duda@fau.de>
Subject: Re: [PATCH] fmc: remove left-over ipmi-fru.h after fmc deletion
Message-ID: <20191216085156.rkvy3n7slblhnclc@cwe-513-vol689.cern.ch>
References: <20191214114913.8610-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20191214114913.8610-1-lukas.bulwahn@gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [2001:1458:d00:7::100:1c8]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(40224003)(2906002)(4326008)(246002)(1076003)(86362001)(70586007)(55016002)(7636002)(356004)(26005)(7696005)(70206006)(16526019)(186003)(8936002)(478600001)(316002)(54906003)(5660300002)(6916009)(336012)(426003)(44832011)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR06MB3987;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f0f579f-f7ff-4304-1fc7-08d782053677
X-MS-TrafficTypeDiagnostic: AM0PR06MB3987:
X-Microsoft-Antispam-PRVS: <AM0PR06MB398703DCF906A7A1EC96DA55EF510@AM0PR06MB3987.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02530BD3AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0NnCXVOuQ5K5Zt4TtIounHEPt4EJm7Aj8Am9azyTsio8gzHuR8vYeIAbwy8bCGUnSnDt9TESFHwzQjtqWa1cHj08TdUt3N0c7xqcLkfRhDkkOA5xcN6d06IbWYrZ3AOW8grt+9u27GIjiKX496FCVdJHVT7J92hnReI3EzHdVCpGKLEZQJxzqrmLVzfGD0Wl9mNPhiyY6DFn5IJq4a4qanROXglzhx5lrtHwWTlrBZcN9cKLLUrHUGzRXJk+OdrRtpsKe0b6+TwaIwU552rIugSG2CXv9ScjPhDd+Q6I6nos5FX3fBvvkrS0Z/JMMPSOtHyaH8QuB744HndnEaJhGJxvzM/YeSUXl2QY22KAktmznSvZb/i4+hFgiHyzWE2uyCQM829s+6oUm2m9hXif0jrMd7SVNEv6fqcDygMYktejhyPQRnfI7DBVrJZPcnB66HBBY0RLlxbwi6ULNbpsoVAsz31qZgW2wDfHQebCizvAqh8JT1FYOTsAFLKoBlY0ucqGr0do6y5ZQnhg+U2PWUi9/cMxf7GQrWxaltLqLE=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 08:51:59.3736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0f579f-f7ff-4304-1fc7-08d782053677
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB3987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Federico Vaga <federico.vaga@cern.ch>

On Sat, Dec 14, 2019 at 12:49:13PM +0100, Lukas Bulwahn wrote:
>Commit 6a80b30086b8 ("fmc: Delete the FMC subsystem") from Linus Walleij
>deleted the obsolete FMC subsystem, but missed the MAINTAINERS entry and
>include/linux/ipmi-fru.h mentioned in the MAINTAINERS entry.
>
>Later, commit d5d4aa1ec198 ("MAINTAINERS: Remove FMC subsystem") from
>Denis Efremov cleaned up the MAINTAINERS entry, but actually also missed
>that include/linux/ipmi-fru.h should also be deleted while deleting its
>reference in MAINTAINERS.
>
>So, deleting include/linux/ipmi-fru.h slipped through the previous
>clean-ups.
>
>As there is no further use for include/linux/ipmi-fru.h, finally delete
>include/linux/ipmi-fru.h for good now.
>
>Fixes: d5d4aa1ec198 ("MAINTAINERS: Remove FMC subsystem")
>Fixes: 6a80b30086b8 ("fmc: Delete the FMC subsystem")
>Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>---
>Linus, please pick this patch.
>Federico, Denis, please ack.
>
> include/linux/ipmi-fru.h | 134 ---------------------------------------
> 1 file changed, 134 deletions(-)
> delete mode 100644 include/linux/ipmi-fru.h
>
>diff --git a/include/linux/ipmi-fru.h b/include/linux/ipmi-fru.h
>deleted file mode 100644
>index 05c9422624c6..000000000000
>--- a/include/linux/ipmi-fru.h
>+++ /dev/null
>@@ -1,134 +0,0 @@
>-/* SPDX-License-Identifier: GPL-2.0+ */
>-/*
>- * Copyright (C) 2012 CERN (www.cern.ch)
>- * Author: Alessandro Rubini <rubini@gnudd.com>
>- *
>- * This work is part of the White Rabbit project, a research effort led
>- * by CERN, the European Institute for Nuclear Research.
>- */
>-#ifndef __LINUX_IPMI_FRU_H__
>-#define __LINUX_IPMI_FRU_H__
>-#ifdef __KERNEL__
>-#  include <linux/types.h>
>-#  include <linux/string.h>
>-#else
>-#  include <stdint.h>
>-#  include <string.h>
>-#endif
>-
>-/*
>- * These structures match the unaligned crap we have in FRU1011.pdf
>- * (http://download.intel.com/design/servers/ipmi/FRU1011.pdf)
>- */
>-
>-/* chapter 8, page 5 */
>-struct fru_common_header {
>-	uint8_t format;			/* 0x01 */
>-	uint8_t internal_use_off;	/* multiple of 8 bytes */
>-	uint8_t chassis_info_off;	/* multiple of 8 bytes */
>-	uint8_t board_area_off;		/* multiple of 8 bytes */
>-	uint8_t product_area_off;	/* multiple of 8 bytes */
>-	uint8_t multirecord_off;	/* multiple of 8 bytes */
>-	uint8_t pad;			/* must be 0 */
>-	uint8_t checksum;		/* sum modulo 256 must be 0 */
>-};
>-
>-/* chapter 9, page 5 -- internal_use: not used by us */
>-
>-/* chapter 10, page 6 -- chassis info: not used by us */
>-
>-/* chapter 13, page 9 -- used by board_info_area below */
>-struct fru_type_length {
>-	uint8_t type_length;
>-	uint8_t data[0];
>-};
>-
>-/* chapter 11, page 7 */
>-struct fru_board_info_area {
>-	uint8_t format;			/* 0x01 */
>-	uint8_t area_len;		/* multiple of 8 bytes */
>-	uint8_t language;		/* I hope it's 0 */
>-	uint8_t mfg_date[3];		/* LSB, minutes since 1996-01-01 */
>-	struct fru_type_length tl[0];	/* type-length stuff follows */
>-
>-	/*
>-	 * the TL there are in order:
>-	 * Board Manufacturer
>-	 * Board Product Name
>-	 * Board Serial Number
>-	 * Board Part Number
>-	 * FRU File ID (may be null)
>-	 * more manufacturer-specific stuff
>-	 * 0xc1 as a terminator
>-	 * 0x00 pad to a multiple of 8 bytes - 1
>-	 * checksum (sum of all stuff module 256 must be zero)
>-	 */
>-};
>-
>-enum fru_type {
>-	FRU_TYPE_BINARY		= 0x00,
>-	FRU_TYPE_BCDPLUS	= 0x40,
>-	FRU_TYPE_ASCII6		= 0x80,
>-	FRU_TYPE_ASCII		= 0xc0, /* not ascii: depends on language */
>-};
>-
>-/*
>- * some helpers
>- */
>-static inline struct fru_board_info_area *fru_get_board_area(
>-	const struct fru_common_header *header)
>-{
>-	/* we know for sure that the header is 8 bytes in size */
>-	return (struct fru_board_info_area *)(header + header->board_area_off);
>-}
>-
>-static inline int fru_type(struct fru_type_length *tl)
>-{
>-	return tl->type_length & 0xc0;
>-}
>-
>-static inline int fru_length(struct fru_type_length *tl)
>-{
>-	return (tl->type_length & 0x3f) + 1; /* len of whole record */
>-}
>-
>-/* assume ascii-latin1 encoding */
>-static inline int fru_strlen(struct fru_type_length *tl)
>-{
>-	return fru_length(tl) - 1;
>-}
>-
>-static inline char *fru_strcpy(char *dest, struct fru_type_length *tl)
>-{
>-	int len = fru_strlen(tl);
>-	memcpy(dest, tl->data, len);
>-	dest[len] = '\0';
>-	return dest;
>-}
>-
>-static inline struct fru_type_length *fru_next_tl(struct fru_type_length *tl)
>-{
>-	return tl + fru_length(tl);
>-}
>-
>-static inline int fru_is_eof(struct fru_type_length *tl)
>-{
>-	return tl->type_length == 0xc1;
>-}
>-
>-/*
>- * External functions defined in fru-parse.c.
>- */
>-extern int fru_header_cksum_ok(struct fru_common_header *header);
>-extern int fru_bia_cksum_ok(struct fru_board_info_area *bia);
>-
>-/* All these 4 return allocated strings by calling fru_alloc() */
>-extern char *fru_get_board_manufacturer(struct fru_common_header *header);
>-extern char *fru_get_product_name(struct fru_common_header *header);
>-extern char *fru_get_serial_number(struct fru_common_header *header);
>-extern char *fru_get_part_number(struct fru_common_header *header);
>-
>-/* This must be defined by the caller of the above functions */
>-extern void *fru_alloc(size_t size);
>-
>-#endif /* __LINUX_IMPI_FRU_H__ */
>-- 
>2.17.1
>
