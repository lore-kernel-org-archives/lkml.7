Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A7FC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEB62087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Pq6eXOZS";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="OvoKcsda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfC0Op6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:45:58 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43236 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728633AbfC0Opz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:45:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2REfY27028014;
        Wed, 27 Mar 2019 07:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=myOgtt+Hq5AXTcLhIftDctjAs/nNl9s+lHLeX/d1Wyk=;
 b=Pq6eXOZStwM1uXpKWlDIrrPs+Tx/WOUkzIzrUrS12jojhEeT7NzWNBnqW/K3kqx8p1WG
 NzG4KiAL/yK14FV0U9DNPYxkQiO3J61/Wzl27dtpgSldCWxXoH8lhDsJOae1qdxEjIn4
 a5nGFOIaMTJNlUe1D4hM6K+dNv4J4W/zn92EURBWlRVkyu7EVFMdEWnkjkRpwyd69m0b
 ajDg8DE+bM31DBsQFwXjoDvMLqwNvhUKH94PRdlVm+kfsXPj5qBmASNAa0Osaqeaiovc
 EUQ3mJKEsz20Ag+TmkGsxuEPzo5P6K62GNm8tA8zvlShvnwtnaFh5SH7J+eCy+vX78OK +A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2057.outbound.protection.outlook.com [104.47.50.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rg8pv0ms0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Mar 2019 07:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myOgtt+Hq5AXTcLhIftDctjAs/nNl9s+lHLeX/d1Wyk=;
 b=OvoKcsdaKemBiVOisrTuLhDT44aflNyHOpcS3584NgHOguNiPGxIO+S77WPT6R5SsGjwqdDyyWWCCs/D4K4492Np8pZ/nbQETsi854SvnClGzjX7RlD14YT2Z4vKIMDMUEGuxkovqYNGRN+omtlLVfBHpAUOnGEK526F86lS3DA=
Received: from CO2PR07CA0076.namprd07.prod.outlook.com (2603:10b6:100::44) by
 BN8PR07MB5908.namprd07.prod.outlook.com (2603:10b6:408:6c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 14:45:32 +0000
Received: from BY2NAM05FT046.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by CO2PR07CA0076.outlook.office365.com
 (2603:10b6:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.16 via Frontend
 Transport; Wed, 27 Mar 2019 14:45:31 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT046.mail.protection.outlook.com (10.152.100.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.4 via Frontend Transport; Wed, 27 Mar 2019 14:45:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x2REjQWv002613
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Mar 2019 07:45:31 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 27 Mar 2019 15:45:25 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Mar 2019 15:45:25 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x2REjPts007091;
        Wed, 27 Mar 2019 14:45:25 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x2REjLn3007031;
        Wed, 27 Mar 2019 14:45:21 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH 0/2] scsi: ufs-cdns: Add M31 PHY init
Date:   Wed, 27 Mar 2019 14:44:03 +0000
Message-ID: <20190327144405.5716-1-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(36092001)(189003)(199004)(426003)(486006)(105596002)(50226002)(107886003)(336012)(126002)(8676002)(14444005)(8936002)(54906003)(4326008)(2616005)(110136005)(36756003)(106466001)(2906002)(476003)(51416003)(86362001)(1076003)(356004)(246002)(5660300002)(316002)(47776003)(16586007)(4744005)(305945005)(186003)(48376002)(6666004)(478600001)(2201001)(26826003)(87636003)(50466002)(7416002)(7636002)(26005)(42186006)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR07MB5908;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efb762f-aa35-4c1e-89a9-08d6b2c2dcd7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN8PR07MB5908;
X-MS-TrafficTypeDiagnostic: BN8PR07MB5908:
X-Microsoft-Antispam-PRVS: <BN8PR07MB59080FC09EE733148E75EA3DD0580@BN8PR07MB5908.namprd07.prod.outlook.com>
X-Forefront-PRVS: 0989A7979C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7QgTNKr31HsCw0vMe4N92MYik4Uz7dgUcCMNVQlY1JNOcajQtfFhMFgQPs9EqV+MlwaRJqRLBh7lwbIjUZf4IIaLHM+0oNMfFQ4TdYmfA4agfKZ7jw8O9I4o7Cv1ChUeh/VQZDJEKWGOOmSGueir9B8IBEh1lkuNYIcdjYqk770xNeUKNyWs7gjSc4pwpk9PsIRQSPkRUf7lHC85iYQeKXZHTkMM53yg4mlaP/cbgu4ZhrGnFJA19TDg9w+ovqI3VEIG2Rs8C5B1LjEXQbVPQH986UmsPT5EVUCTXcvrwfR/ZisNwFUgHK04GlFpRV9a+kOx6FJ8ISgiMnLHGUvl0+FrAARqhn1rjQqU9hSBplCO4qNMJDL4q2zz5ZnQDJV+4QOIe8I1xpastyE9EdK+FGrVrzoP2LSfMd6rgk6wvJg=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2019 14:45:31.7315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efb762f-aa35-4c1e-89a9-08d6b2c2dcd7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB5908
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=681 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds additional initialization required by
M31 PHY when used with Cadence UFS Host Controller.

Jan Kotas (2):
  dt-bindings: scsi: ufs-cdns: Update Cadence UFS compatibility list
  scsi: ufs-cdns: Add support for UFSHCI with M31 PHY

 .../devicetree/bindings/ufs/cdns,ufshc.txt         |  5 +-
 drivers/scsi/ufs/cdns-pltfrm.c                     | 77 +++++++++++++++++++---
 2 files changed, 70 insertions(+), 12 deletions(-)

-- 
2.15.0

