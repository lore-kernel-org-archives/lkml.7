Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2578EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3422075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="BiIaz38L";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BypJ7OPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfDDIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:12:55 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:52060 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbfDDIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:12:55 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3488d13029049;
        Thu, 4 Apr 2019 01:12:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=/PHZH/ePTqv8nGbbYNpLtsvC4uLudQIIiHkLa5Nn6wo=;
 b=BiIaz38LnmxK1rrGshS5jaoFModRKusU2ZLSGLc5umSAepZxVrrI/8AKsghDLNYYj60l
 tSdPHp4dCppVr/235lh7TIs8NF2Qs3TWKDVurGNa9IMTgOrDqlcuACRa8l5wvgPWuHFC
 ZQ8QPw39/XciEOFfaPd2Xf06lw27WCgQ5l2qYUbtWQ1kMyxKBQjJg55j1tFI7iGccAdn
 QD9zABy56iNAfZTgpx44zlcdybfIsbOTmYpvmqCpmHgZmZflLfCBCxKBqw2eHhPrig4L
 3TxB1YKumDa3MLGiCNNe8jhBlHN/xWOFjQdTchh4yyOSwVFPmSDvsvgdpsxp+dwIEpzE uA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2051.outbound.protection.outlook.com [104.47.32.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2rncm08g9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Apr 2019 01:12:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PHZH/ePTqv8nGbbYNpLtsvC4uLudQIIiHkLa5Nn6wo=;
 b=BypJ7OPwmLiJXJG9E+L+rJh8/RMbQPDU1G4R061ch+OshF+lCsJiKUOCQBtZfe04ZqC6v1dA8CCQPbZeHR/8ZHqWmqIr5GMifXShR6sifdQ2mL8RN2mrdUeiRDeQat+dylU1MKcZt0nPLki5nlfBDDONiTmHLSYEtoUuDb4EU8I=
Received: from CO2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:100::33) by
 CY1PR07MB2300.namprd07.prod.outlook.com (2a01:111:e400:c5b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15; Thu, 4 Apr
 2019 08:12:42 +0000
Received: from DM3NAM05FT038.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by CO2PR07CA0065.outlook.office365.com
 (2603:10b6:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.13 via Frontend
 Transport; Thu, 4 Apr 2019 08:12:41 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT038.mail.protection.outlook.com (10.152.98.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.6 via Frontend Transport; Thu, 4 Apr 2019 08:12:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x348Cb0s026047
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 4 Apr 2019 01:12:39 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 4 Apr 2019 10:12:36 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Apr 2019 10:12:36 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x348Caoq000633;
        Thu, 4 Apr 2019 09:12:36 +0100
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x348CYFH000606;
        Thu, 4 Apr 2019 09:12:34 +0100
From:   Jan Kotas <jank@cadence.com>
To:     <vkoul@kernel.org>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jan Kotas <jank@cadence.com>
Subject: [PATCH] soundwire: cdns: Fix compilation error on arm64
Date:   Thu, 4 Apr 2019 09:12:21 +0100
Message-ID: <20190404081221.341-1-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(3190300001)(36092001)(189003)(199004)(126002)(106466001)(1076003)(50226002)(5660300002)(47776003)(486006)(16586007)(36756003)(26826003)(6666004)(2906002)(356004)(110136005)(2616005)(476003)(76130400001)(316002)(48376002)(42186006)(86362001)(426003)(478600001)(336012)(2201001)(4326008)(26005)(107886003)(54906003)(87636003)(186003)(4744005)(105596002)(50466002)(51416003)(246002)(7636002)(8676002)(305945005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2300;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73091c99-93f7-4c74-b9c0-08d6b8d54f23
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:CY1PR07MB2300;
X-MS-TrafficTypeDiagnostic: CY1PR07MB2300:
X-Microsoft-Antispam-PRVS: <CY1PR07MB230020C6C40C61961BED5B71D0500@CY1PR07MB2300.namprd07.prod.outlook.com>
X-Forefront-PRVS: 0997523C40
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Ccaxb5XMO7ri3d70O6xEnLArtaPUwJnaSfE7BH5pCIt+p4WIIDa5rGMVVR/rpixfcw/w/8KuWuNqGmv9S4Zk6WJbYpYjGhLy6Ay4PcK1p8s/QnPUlo2uMsHhHQQ0nI/TPjyqHQTsEvT/AybNAJ+5NLtVGk97e1GKOGsUNGM+GdeFjgluYuRhz1awuYwUukyriuPlqQiXKn9aqucOq1y3dpxq70jB5b+UEkgwyXNIUqATmKUx45Iq5Kh03x5PMcklSvdO9nf4Dem99fAbEz++SgwEdFBRWHstdnhIq7P+jgzKCCQW7DQ1JV3n/vx2ONrLYTV2Q+TXliGO8sm8w3c0qs9ImN9GB+bq85ZY5WxB3pY/gHTdYYRk8D0OOSposMBuUiTFf/rDdAMXfLQf5sexrjX3ek1ht5iY1YURoaW0Zo0=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2019 08:12:41.1467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73091c99-93f7-4c74-b9c0-08d6b8d54f23
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2300
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=673 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 the cadence_master.c file doesn't compile.

readl and writel are undefined.
This patch fixes that by including io.h.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/soundwire/cadence_master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index cb6a331f4..0b5bcc209 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/soundwire/sdw_registers.h>
-- 
2.15.0

