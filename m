Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4222146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="S91D/u/J";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LtP34aUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfC0Opw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:45:52 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43220 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726743AbfC0Opv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:45:51 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2REfY25028014;
        Wed, 27 Mar 2019 07:45:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=V8UOuQlWuF50Lse1FrWUp71J83+WWG3gFJSYICf+DQE=;
 b=S91D/u/JyALj78N1Dgi9dnIbV/CkML9lW60dsEdmsBP0G/dItWbo9y9T9NAR4lDJf+Vg
 WbstBS55TJVCnuxMqrFiuWvgOu9HV0BY9QCq8Plk/qYpa9C2ZKwU2LNXWsx5IpVajE0J
 /h0FiCIivQXPWkzOEdvK3ghsDSV3VLECYP0GRhG8WVmHMSgJPC7o/4YLz3TeZ7J0aSAy
 XX5dWPV/w1IxJtWACKBgLOLIcOTQ9eIFpPSPEP4YO8c5ENYUJVlSLAIvhb/+XWhRUQdH
 cPL4M5LaR/cmcOT8WeEOGu3JAsWjBHG/wYrC1W8RAWEHsFBPb9ogKUum7i6cZWLNUiTY bQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2058.outbound.protection.outlook.com [104.47.42.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rg8pv0mrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Mar 2019 07:45:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8UOuQlWuF50Lse1FrWUp71J83+WWG3gFJSYICf+DQE=;
 b=LtP34aUpWCevBU6Ev/K51X+/tltjZyEBk1xzY934bc1vZU61rdbgsdmLroPUg4gvwOQFgs/dziz1UtDdiYvdlsNi7Yc73z8H2It9QiX40VSEQpvtwFmuiS1pAuF+MplxEGmp+W3E+CyK//pu2Tp/Q6mIrxgrJRu5b06sLVTXwLE=
Received: from CY1PR07CA0033.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::43) by BL2PR07MB2291.namprd07.prod.outlook.com
 (2a01:111:e400:c752::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.18; Wed, 27 Mar
 2019 14:45:32 +0000
Received: from CO1NAM05FT037.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by CY1PR07CA0033.outlook.office365.com
 (2a01:111:e400:c60a::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15 via Frontend
 Transport; Wed, 27 Mar 2019 14:45:32 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT037.mail.protection.outlook.com (10.152.96.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.4 via Frontend Transport; Wed, 27 Mar 2019 14:45:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x2REjQWu002613
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Mar 2019 07:45:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 27 Mar 2019 15:45:25 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Mar 2019 15:45:25 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x2REjP6q007095;
        Wed, 27 Mar 2019 14:45:25 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x2REjPXQ007094;
        Wed, 27 Mar 2019 14:45:25 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH 1/2] dt-bindings: scsi: ufs-cdns: Update Cadence UFS compatibility list
Date:   Wed, 27 Mar 2019 14:44:04 +0000
Message-ID: <20190327144405.5716-2-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190327144405.5716-1-jank@cadence.com>
References: <20190327144405.5716-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(189003)(199004)(36092001)(2906002)(76176011)(6666004)(316002)(8936002)(11346002)(106466001)(2616005)(446003)(5660300002)(105596002)(356004)(42186006)(54906003)(16586007)(110136005)(336012)(36756003)(246002)(87636003)(8676002)(478600001)(7636002)(305945005)(7416002)(51416003)(26005)(26826003)(50226002)(186003)(2201001)(4326008)(1076003)(48376002)(426003)(50466002)(4744005)(486006)(126002)(107886003)(86362001)(476003)(47776003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2291;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfb0dd56-1983-4b46-67a5-08d6b2c2dcfe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL2PR07MB2291;
X-MS-TrafficTypeDiagnostic: BL2PR07MB2291:
X-Microsoft-Antispam-PRVS: <BL2PR07MB2291E047D48F9BC1C98BAB65D0580@BL2PR07MB2291.namprd07.prod.outlook.com>
X-Forefront-PRVS: 0989A7979C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cGsO43Hd33tY6p4mrrfpdL5k/lSsjFfsjnfunmaDEZ0kztYBY2yebseie3URbtWaNtmrSpPTrjI7LPwJiGDD8HM2xj2qwFqduWyoXleM0XortBZGPASb5PhdlLi1QwHHeGvDZLCqqnJilXvhm7br6/LbzogMZwqgAWcRnhzXmO//snOvdto+zq6ke4dL/cUesEX20g2gtTTDMP17Qp+/Z6l5j+Pks+h7I5TM5bsjvwV2+vaI/xAxW69EQkw3EhDE3+bnRNs/sQ6/DVGnKK52R9BbAP2/MTmOQEoKMkmqkH+OMKQYsS8dJWQNfWrRypYJ3uiLmu9n4tq38xOnh4DGXxnNp5P88q482Gwzw74X4eBr9Joh7Unx4fpAcuQ3deRN5OcxWoK4A5G0ZUNKXHbYgYPaAMxshCH/YkbGMvdOviY=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2019 14:45:31.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb0dd56-1983-4b46-67a5-08d6b2c2dcfe
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2291
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new compatible string description for
CDNS UFS HCD + M31 16nm PHY.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
index a04a4989e..02347b017 100644
--- a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
+++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
@@ -5,8 +5,9 @@ Each UFS controller instance should have its own node.
 Please see the ufshcd-pltfrm.txt for a list of all available properties.
 
 Required properties:
-- compatible	: Compatible list, contains the following controller:
-			"cdns,ufshc"
+- compatible	: Compatible list, contains one of the following controllers:
+			"cdns,ufshc" - Generic CDNS HCI,
+			"cdns,ufshc-m31-16nm" - CDNS UFS HC + M31 16nm PHY
 		  complemented with the JEDEC version:
 			"jedec,ufs-2.0"
 
-- 
2.15.0

