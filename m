Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15AA20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Kt86HJCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfDVODH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:03:07 -0400
Received: from mail-eopbgr730066.outbound.protection.outlook.com ([40.107.73.66]:61952
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfDVODH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knVIJrlGGft75g/EsGWmyWuAzxfNdO2qsqfUogVbHiY=;
 b=Kt86HJCEmWWlScTcs9oWvMng3KY3QYA4uzjRFaGbeLuWe4S7enLIULL6rjlf0CkcW8hm4/rOJiovakcV4JiBNWbsfdZSD5Rk0hiqfKqdU9rz987JH+P4mqxxlv64+xfQBagJEgsZiLL14jTC4+qJlW6qYBaElp1IGDEAyfTbiWw=
Received: from MWHPR03CA0017.namprd03.prod.outlook.com (2603:10b6:300:117::27)
 by BY2PR03MB555.namprd03.prod.outlook.com (2a01:111:e400:2c37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.11; Mon, 22 Apr
 2019 14:03:01 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR03CA0017.outlook.office365.com
 (2603:10b6:300:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.12 via Frontend
 Transport; Mon, 22 Apr 2019 14:03:01 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 22 Apr 2019 14:03:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x3ME3069012105
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Apr 2019 07:03:00 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 22 Apr 2019
 10:03:00 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <namhyung@kernel.org>, <mingo@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2][V2] lib: add __sysfs_match_string_with_gaps() helper
Date:   Mon, 22 Apr 2019 17:02:51 +0300
Message-ID: <20190422140251.8960-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422083257.21805-1-alexandru.ardelean@analog.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(189003)(199004)(186003)(44832011)(5660300002)(336012)(446003)(26005)(77096007)(426003)(11346002)(486006)(7696005)(2616005)(476003)(126002)(2906002)(356004)(107886003)(8676002)(54906003)(76176011)(51416003)(86362001)(6666004)(70206006)(1076003)(8936002)(70586007)(4326008)(246002)(50226002)(48376002)(305945005)(50466002)(53416004)(7636002)(36756003)(47776003)(16586007)(316002)(110136005)(106002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB555;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f97b123-e087-4b70-6432-08d6c72b3b34
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BY2PR03MB555;
X-MS-TrafficTypeDiagnostic: BY2PR03MB555:
X-Microsoft-Antispam-PRVS: <BY2PR03MB555F9F82028F1C324588229F9220@BY2PR03MB555.namprd03.prod.outlook.com>
X-Forefront-PRVS: 00159D1518
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6DHKTiVoXA1TDRT0baxXZINfqjbZvVyRv813T6nB5RPE1rUOEINEoLxZOca9yW63cRUsNeRxORgBuDzdyY1/fVkxMOEX3ZvbkAARre356FN/RGUKXtZzj53Xe5ZAweWgtjN4lkEtIQLpR1Rgh/XpAh3sQ06xGsbvPilArcwJfIo18BISPJYaB33+MCyb5LyEK60hI9o98Nsbd7PjbQpCkSdB9gpDSRRUuKiiackBv5Wc1aCmgBRxLGJP0lSpPfJD4Rl7GQBh2OZivVu6CyB7J3v4ZagG8O4aGm8GHhddOZID/3S78qVYCD02kaxicwqG1ZytYeyIaKUuF/lU+LIo80N52OtqwIAODWwU2sWiPYuYZAhBgypw+rso5O2WaJHm5upJzxjJhh5v8qp37XC5wlTjObl+/0oFwvasR9d1i80=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2019 14:03:00.9343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f97b123-e087-4b70-6432-08d6c72b3b34
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB555
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
 include/linux/string.h |  2 ++
 lib/string.c           | 48 ++++++++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f80c..08e4a33b5f29 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -190,6 +190,8 @@ static inline int strtobool(const char *s, bool *res)
 
 int match_string(const char * const *array, size_t n, const char *string);
 int __sysfs_match_string(const char * const *array, size_t n, const char *s);
+int __sysfs_match_string_with_gaps(const char * const *array, size_t n,
+				   const char *str);
 
 /**
  * sysfs_match_string - matches given string in an array
diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..2ae3b7e5ff3d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -658,32 +658,58 @@ int match_string(const char * const *array, size_t n, const char *string)
 }
 EXPORT_SYMBOL(match_string);
 
-/**
- * __sysfs_match_string - matches given string in an array
- * @array: array of strings
- * @n: number of strings in the array or -1 for NULL terminated arrays
- * @str: string to match with
- *
- * Returns index of @str in the @array or -EINVAL, just like match_string().
- * Uses sysfs_streq instead of strcmp for matching.
- */
-int __sysfs_match_string(const char * const *array, size_t n, const char *str)
+static int __sysfs_match_string_common(const char * const *array, size_t n,
+				       const char *str, bool gaps)
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
+
+/**
+ * __sysfs_match_string - matches given string in an array
+ * @array: array of strings
+ * @n: number of strings in the array or -1 for NULL terminated arrays
+ * @str: string to match with
+ *
+ * Returns index of @str in the @array or -EINVAL, just like match_string().
+ * Uses sysfs_streq instead of strcmp for matching.
+ */
+int __sysfs_match_string(const char * const *array, size_t n, const char *str)
+{
+	return __sysfs_match_string_common(array, n, str, false);
+}
 EXPORT_SYMBOL(__sysfs_match_string);
 
+/**
+ * __sysfs_match_string_with_gaps - matches string in array ignoring NULLs
+ * @array: array of strings
+ * @n: number of strings in the array or -1 for NULL terminated arrays
+ * @str: string to match with
+ *
+ * Returns index of @str in the @array or -EINVAL, just like match_string().
+ * Uses sysfs_streq instead of strcmp for matching.
+ * Ignores NULL entries within the @array.
+ */
+int __sysfs_match_string_with_gaps(const char * const *array, size_t n,
+				   const char *str)
+{
+	return __sysfs_match_string_common(array, n, str, true);
+}
+EXPORT_SYMBOL(__sysfs_match_string_with_gaps);
+
 #ifndef __HAVE_ARCH_MEMSET
 /**
  * memset - Fill a region of memory with the given value
-- 
2.17.1

