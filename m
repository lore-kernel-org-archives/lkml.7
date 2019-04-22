Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F6C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9440220656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="cScyQXF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDVIdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:33:06 -0400
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:21745
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfDVIdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvvsQMCjsasU5tAUu8hT/EiBUDeUN01UFrU/q/KvUxU=;
 b=cScyQXF2Esfd8gSg3Gz9WAaI8ZkUwIEq9ivxM9pZYPx1rRJtK5Sf405GrO7BuVkWYwJTz4VvcTb3dtWqIraRRM+JP+zes+4f9/ZryLZP9gABpwsraZicf1ChslILNNFlthhWvw4moovWqo/VcSE0Ac4MIilY9laH6Ug52q3epLQ=
Received: from MWHPR03CA0032.namprd03.prod.outlook.com (2603:10b6:301:3b::21)
 by BL2PR03MB548.namprd03.prod.outlook.com (2a01:111:e400:c26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Mon, 22 Apr
 2019 08:33:02 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR03CA0032.outlook.office365.com
 (2603:10b6:301:3b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.11 via Frontend
 Transport; Mon, 22 Apr 2019 08:33:02 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 22 Apr 2019 08:33:01 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x3M8X1Zw020948
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Apr 2019 01:33:01 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 22 Apr 2019
 04:33:00 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <namhyung@kernel.org>, <mingo@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Date:   Mon, 22 Apr 2019 11:32:56 +0300
Message-ID: <20190422083257.21805-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(199004)(189003)(356004)(6666004)(48376002)(51416003)(7696005)(246002)(478600001)(305945005)(8676002)(70586007)(70206006)(50226002)(7636002)(107886003)(1076003)(16586007)(47776003)(316002)(50466002)(8936002)(110136005)(106002)(54906003)(186003)(36756003)(336012)(53416004)(126002)(476003)(77096007)(2616005)(426003)(26005)(86362001)(44832011)(5660300002)(2906002)(486006)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB548;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad51cb2-bc30-4e5a-fdf2-08d6c6fd21f1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR03MB548;
X-MS-TrafficTypeDiagnostic: BL2PR03MB548:
X-Microsoft-Antispam-PRVS: <BL2PR03MB54822C44E8B26400ECC311CF9220@BL2PR03MB548.namprd03.prod.outlook.com>
X-Forefront-PRVS: 00159D1518
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2Nt9MsowzA0qnSeNuvjNsQC0Gx1trYK547g8sG1ug5Bcwpd+nBLgoWBgJoyc0lvfvYExVp8XFSGcGv44Y3cijyFR2Fi2UGW8oQIxHNtxUy1L85x50l2TigwAU3iZzFlsO8KpfDOoic+nHIz8yImxzoFr0E+OxvCfQzpJ7fsH344Bdqd5SZ2wPdpsQ3ZmUPW5OAn6xth/aTE0/zvvhSES9QtSiEVFvO9iuwOviaEHJ0hb5L6HCzOUWJLEW79BD5giXMx6FxmfURjCOMSpjCz7t4EITeDjuh1vwZsHF4S/vJT7pj9hYickS0PNFUNiF54GiJ5Qnc6RT+B2ZZIVVKUVx4odfwn9xs2UhsBygx7pabTd7OR6Kp0c6gy56Q+aDsv6j2bnnZxhLaLuVcEQq5EcZliC2u5b5g4hERIucJiLeJo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2019 08:33:01.7035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad51cb2-bc30-4e5a-fdf2-08d6c6fd21f1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is similar to __sysfs_match_string() with the exception that it
ignores NULL elements within the array.
It takes an extra parameter (called `gaps`) which when true will ignore
the NULL elements. When false, this function behaves exactly like
`__sysfs_match_string()`.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/string.h |  9 ++++++++-
 lib/string.c           | 14 ++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f80c..30595ed483dc 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -189,7 +189,14 @@ static inline int strtobool(const char *s, bool *res)
 }
 
 int match_string(const char * const *array, size_t n, const char *string);
-int __sysfs_match_string(const char * const *array, size_t n, const char *s);
+int __sysfs_match_string_with_gaps(const char * const *array, size_t n,
+				   const char *str, bool gaps);
+
+static inline int __sysfs_match_string(const char * const *array, size_t n,
+				       const char *str)
+{
+	return __sysfs_match_string_with_gaps(array, n, str, false);
+}
 
 /**
  * sysfs_match_string - matches given string in an array
diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..8ddac3cd292a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -659,30 +659,36 @@ int match_string(const char * const *array, size_t n, const char *string)
 EXPORT_SYMBOL(match_string);
 
 /**
- * __sysfs_match_string - matches given string in an array
+ * __sysfs_match_string_with_gaps - matches string in array ignoring NULLs
  * @array: array of strings
  * @n: number of strings in the array or -1 for NULL terminated arrays
  * @str: string to match with
+ * @gaps: boolean to ignore NULL elements within the array
  *
  * Returns index of @str in the @array or -EINVAL, just like match_string().
  * Uses sysfs_streq instead of strcmp for matching.
+ * Ignores NULL pointers within the @array if @gaps is true.
  */
-int __sysfs_match_string(const char * const *array, size_t n, const char *str)
+int __sysfs_match_string_with_gaps(const char * const *array, size_t n,
+				   const char *str, bool gaps)
 {
 	const char *item;
 	int index;
 
 	for (index = 0; index < n; index++) {
 		item = array[index];
-		if (!item)
+		if (!item) {
+			if (gaps)
+				continue;
 			break;
+		}
 		if (sysfs_streq(item, str))
 			return index;
 	}
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(__sysfs_match_string);
+EXPORT_SYMBOL(__sysfs_match_string_with_gaps);
 
 #ifndef __HAVE_ARCH_MEMSET
 /**
-- 
2.17.1

