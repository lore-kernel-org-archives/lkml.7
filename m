Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B0C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FA2216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="u6GVuBvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfFYQ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:56:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65008 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727763AbfFYQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:56:52 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PCxani006711;
        Tue, 25 Jun 2019 09:01:26 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2054.outbound.protection.outlook.com [104.47.34.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tbgangjrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 09:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdgasGIWIzLQXTxb3WrmCYTnTtqOzJJeUxXbhMpnQJU=;
 b=u6GVuBvWEghS7lzsEedSqdv4NUBZ8kIrRiGxILFZjvzs1yZiCS/vtxQP5LC7VqIJMzQ/R58rGzZMB3IFXrGERITP/WSheTdoPR03GTWiSfhMqKLh6JcmS78En/d5ilLYm1PyCEHPz3NOmFqp6f8w9CXtQ7GaIleJj4xMiHRNBUg=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 CO2PR03MB2261.namprd03.prod.outlook.com (2603:10b6:102:13::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 13:01:24 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 13:01:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 13:01:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5PD1Lk1002790
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 06:01:22 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 09:01:21 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <alexander.shishkin@linux.intel.com>, <akpm@linux-foundation.org>,
        <ndesaulniers@google.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][V4] lib: fix __sysfs_match_string() helper when n != -1
Date:   Tue, 25 Jun 2019 16:01:04 +0300
Message-ID: <20190625130104.29904-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508111913.7276-1-alexandru.ardelean@analog.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(189003)(199004)(54534003)(2870700001)(76176011)(77096007)(186003)(7696005)(4326008)(26005)(51416003)(36756003)(316002)(106002)(478600001)(2906002)(54906003)(47776003)(126002)(486006)(2351001)(70206006)(44832011)(14444005)(2616005)(48376002)(336012)(476003)(426003)(1076003)(7636002)(11346002)(5660300002)(446003)(50466002)(305945005)(107886003)(50226002)(356004)(6666004)(8676002)(246002)(6916009)(8936002)(86362001)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2261;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d287a192-c9e5-4ceb-e076-08d6f96d3a16
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CO2PR03MB2261;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2261:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2261818CADCFA507E3B296A6F9E30@CO2PR03MB2261.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: znFX76f2Bml2nbSt8FM6XEDsFodpr6ErrRMYinYG8kvAbsEF2Yj4PUWoqe+ZXjy5xMARZwRDyeCBeGG7+gMzFJRjQPOswMSf+WgYbbICsDre6Nsm46Xoss0TGnjk9urv9ukK62kARlKTK8U7avh5NDpq2pw4wAifWnegEdYHsomCbkfp6dEEw5f2hunGq8bHH8NXGVVvIaO3p3HZxKzJ0BuIAORA2TbtnaeXt2wvOXFIDymBTpeQH6un5dbAq2REqaufathPSRl0RxWyLv3/4IQWNi6KbXtb8i1wH/BKaurxfpV+h7/k1efSeFQsXkJZZ/aJ8izjH6V+Sg1/rdu03SmWJLiOZQerw0CIIGbJ0F8RXMczpqfmEdWoXVkHXZXroqvH+maV9OB9O18oVsR+DV8/tIknkH62XlNp2TBnuvg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 13:01:23.7070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d287a192-c9e5-4ceb-e076-08d6f96d3a16
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2261
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation the `__sysfs_match_string()` helper mentions that `n`
(the size of the given array) should be:
 * @n: number of strings in the array or -1 for NULL terminated arrays

The behavior of the function is different, in the sense that it exits on
the first NULL element in the array.

This patch changes the behavior, to exit the loop when a NULL element is
found, and the size of the array is provided as -1.

All current users of __sysfs_match_string() & sysfs_match_string() provide
contiguous arrays of strings, so this behavior change doesn't influence
anything (at this point in time).

This behavior change allows for an array of strings to have NULL elements
within the array, which will be ignored. This is particularly useful when
creating mapping of strings and integers (as bitfields or other HW
description).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v3 -> v4:
* split this patch away from series; there are some unsolved discussions
  that will probably need resolving per sub-system

 lib/string.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 3ab861c1a857..5bea3f98478a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -674,8 +674,11 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *str)
 
 	for (index = 0; index < n; index++) {
 		item = array[index];
-		if (!item)
+		if (!item) {
+			if (n != (size_t)-1)
+				continue;
 			break;
+		}
 		if (sysfs_streq(item, str))
 			return index;
 	}
-- 
2.20.1

