Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D81C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0775121850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="h/49uBHa";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="igZf+qUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfDEH1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:27:38 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33254 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbfDEH1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:27:38 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x357MLcp027063;
        Fri, 5 Apr 2019 00:27:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=4E0AMx/2ORRdYQzqbmE9kCMENMMKePZIDyWpctIh5to=;
 b=h/49uBHaNFuBoTHbl6lT6AtW+FzwEgc939w+Xc8aIhAc5KiozDTKeyIVlyoO4+YUJqbK
 qyVEBgvja+MkONjFelyjW1ohCr5Shc+pTxK5lsmRxNZSDdEu5gAE06OnSkEAxIjGGWYs
 S+uOj66SulJcYJl6bn4qzCvbngFJ8hwInh6wo2FRD2Q7RFYu4JvcJKRxJHGKApQkh/N1
 uOmZtQt/k1GX8HyjNpTviE4M/fjNh/pX9DJn486EB/95TermDM2ud6Z42Q2cVk33LMSi
 SB9O85Bq5xspHPL1cMGO15UnuNfAaifdzxxowdUIoJAha5WL6kD9mqSJ847sBSgml55d Ew== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2056.outbound.protection.outlook.com [104.47.41.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rnkm1urkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Apr 2019 00:27:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E0AMx/2ORRdYQzqbmE9kCMENMMKePZIDyWpctIh5to=;
 b=igZf+qUXuZM6fYMh1Nm1eEUe6Zu1/IvqlO3oJDoOIMySfY/cI6P5d3LtXdWVve04XQNvCP8x5Oac6mCmUSctewYrr6PEt/fSmUSgiFALno/jB9ZTQp2TYxlINLmjQ1/A9JtmEANMguJFQmZGvj1GlTFjLw9+rM/8cviY57Wmud4=
Received: from DM6PR07CA0007.namprd07.prod.outlook.com (2603:10b6:5:94::20) by
 DM6PR07MB4716.namprd07.prod.outlook.com (2603:10b6:5:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Fri, 5 Apr 2019 07:27:22 +0000
Received: from CO1NAM05FT037.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by DM6PR07CA0007.outlook.office365.com
 (2603:10b6:5:94::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Fri, 5 Apr 2019 07:27:22 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT037.mail.protection.outlook.com (10.152.96.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.6 via Frontend Transport; Fri, 5 Apr 2019 07:27:21 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x357RJs0028838
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 5 Apr 2019 00:27:21 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 5 Apr 2019 09:27:18 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Apr 2019 09:27:18 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x357RIku026460;
        Fri, 5 Apr 2019 08:27:18 +0100
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x357RFTV026441;
        Fri, 5 Apr 2019 08:27:15 +0100
From:   Jan Kotas <jank@cadence.com>
To:     <vkoul@kernel.org>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jan Kotas <jank@cadence.com>
Subject: [PATCH] soundwire: fix pm_runtime_get_sync return code checks
Date:   Fri, 5 Apr 2019 08:26:55 +0100
Message-ID: <20190405072655.25995-1-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(3190300001)(189003)(199004)(36092001)(50226002)(4326008)(42186006)(2201001)(186003)(5660300002)(14444005)(86362001)(8936002)(2906002)(316002)(48376002)(16586007)(107886003)(50466002)(426003)(54906003)(110136005)(478600001)(1076003)(36756003)(51416003)(87636003)(6666004)(336012)(356004)(105596002)(26005)(26826003)(126002)(486006)(7636002)(8676002)(2616005)(47776003)(305945005)(476003)(246002)(106466001)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4716;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2a47ae1-cc81-4a11-b58e-08d6b99824b2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328);SRVR:DM6PR07MB4716;
X-MS-TrafficTypeDiagnostic: DM6PR07MB4716:
X-Microsoft-Antispam-PRVS: <DM6PR07MB4716D905BD4CBE76E9CF8BCCD0510@DM6PR07MB4716.namprd07.prod.outlook.com>
X-Forefront-PRVS: 0998671D02
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xQjupB5jNgew6sgdNImkwy90sjulRrUfBwoNTtKwaaYTwLmsMK3VXS6dv5FU7XJ2OGp1dDjKbwGT47mJStRb3dc3h29CUzPvgsCciOaYlBsLVBZoWIBmBrS8OTWrJHUY0HSHCef0JgiQzAC9FA/ASVNV6b2PdPJFuFSc9nyAPbQEH9CGhaHdnQ95ZQnd0C/NGdJjzafkDCuifuGcAgsV6HlY02/dZ8IzHXC7kXWleuLm1CAlU6T0BNU6qyNCgCiQuqCTky+qW7pcy/eCSbAb68rFu07hcXOUisHgTSDt5Zu2oVXj8HdJIGCzz5IKLd3yhJ174yPp4st7dgYB2XRqPqJp4CrAbwcpWI/zpFchSeAJcU3jrQp+B3VYzQEWYLMBgw2ZTvQ9TlDNcFQ5Diqom74pN9Fbr//0ygZm16jykYI=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2019 07:27:21.9331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a47ae1-cc81-4a11-b58e-08d6b99824b2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4716
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PM is disabled it returns -EACCES, which is currently
threated as an error, and prevents accessing the slave's
registers.

This patch ignores the -EACCES return value from
pm_runtime_get_sync() to let the SoundWire work in systems
without runtime PM.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/soundwire/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1cbfedfc2..6567ff439 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -328,7 +328,7 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 		return ret;
 
 	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -EACCES)
 		return ret;
 
 	ret = sdw_transfer(slave->bus, &msg);
@@ -356,7 +356,7 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 		return ret;
 
 	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -EACCES)
 		return ret;
 
 	ret = sdw_transfer(slave->bus, &msg);
-- 
2.15.0

