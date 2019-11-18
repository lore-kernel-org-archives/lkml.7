Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A856C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E282075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="p1uUUIAf";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vuTRZWWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKRHnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 02:43:45 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51384 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbfKRHno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:43:44 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI7d8GF027647;
        Sun, 17 Nov 2019 23:43:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=XUcdbqQgeAGTFE2ltQr7Xa7aN9Fmhxb+WddHaqu7DcE=;
 b=p1uUUIAfMfQXSYoo+8BINVkrK0Kktn36vLAzF2UrZEwQWFhM9ec4eyR6p3fvn8TBXrCN
 s8SWCi7W/duhJK4wuyphN++TCWMlzmW4lUTGV2vFwRHlINHI/8Z0GLw/HXdbO0Cm6giu
 7blhQh15U7Mv8aLQkvAYekwUEzvGMpIBtuVf+Azo8qHUTmUIeCAG3iwQ8xuxAYB1Qo0A
 4bUJvgzOvLKKxEhJx70OTnqTIEBIX5acrX8vfFcckmSymO4EZFAJgHD4nQN+PgZLbxaU
 /+hsCQ3Xr6t1yteZNaelxtnqMNnyK9wSkae6pDnWMsYBcsxNeas3LCw7NoMykkkQ/3xZ 0Q== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2056.outbound.protection.outlook.com [104.47.33.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wadjy5fuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Nov 2019 23:43:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b067fKS0oty+GM4yJkOxPz7wajYiQyDDTInCY0tlEu3XIukbvUDKtsWBxIBYmiJU6Xr47OTWoIej4Fy0EITwHZFVtkr96dMDLc5Slb+Af3lbjV1Xf95jmbr2g6S64AQjvwx9eXYuzHg2d8H7rwvDeu9oEANw6vKkF3EWMA5eord2blGCVTcXMufJ669BneD6phE5tyzVdoZeSAwQbEt7ggei0OlCqRCSdoPkPzRLVJM6/LJGr9Nx3EPGfMxOrWJlZBNNtXVGfHsQm+6JWpEXnysxSdclRxtf+3ouImivHS8+8xBdRzLqPH1C+vYwUcGNMKm2seXrsEaJcB8RFxkieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUcdbqQgeAGTFE2ltQr7Xa7aN9Fmhxb+WddHaqu7DcE=;
 b=H/BhmKKnx3yWlRfPUMN5yGqaopYc24RIbWxu5P97VyydpvJ7SEue7cz2BWvNa70BG1qhyAjjG9I1q706T8rAeLCIo2wzDxpVt1qstETWzougX5xIMW6d/hx1ebQNdWX4Fu0uwvsl2SoHeYGM1tUF1a0814xzfX63qJqMUMlU/8fpTR/tAstiIeuJXalQvZSUgyMwJ9ZhGGU/b9fZhe1NgzVgIzYWX/sPhZmHgeXweSGBqa2QJwIKu5TGYAfCwFbxbxBnpJS04ZFn+CKgswika7X0PRAWiqXEZ8jD3k6Zhyo9qzPe5/uXch6Uj9sjOrDLN2/EB8/W20fkC6xg9oHjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 199.43.4.28) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUcdbqQgeAGTFE2ltQr7Xa7aN9Fmhxb+WddHaqu7DcE=;
 b=vuTRZWWOZdFMWWu9gETKitu4dgoT41FvGSZuAxJfXamm5okwXyu/6CqwYv4qoO1twIgkSL8dXYtEbiv1uFOma61btRYMg5AwinTkoK58ChzhqIkwnQM873JX+ElYG3W0EF7FHocCOgMSMgvPYbbBxSubx3oSGdOQrBtA+pKSt1s=
Received: from BN8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:ac::16)
 by DM6PR07MB6809.namprd07.prod.outlook.com (2603:10b6:5:17c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26; Mon, 18 Nov
 2019 07:43:35 +0000
Received: from MW2NAM12FT009.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::208) by BN8PR07CA0003.outlook.office365.com
 (2603:10b6:408:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Mon, 18 Nov 2019 07:43:34 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 MW2NAM12FT009.mail.protection.outlook.com (10.13.180.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Mon, 18 Nov 2019 07:43:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xAI7hUXY001611
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 18 Nov 2019 02:43:32 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 18 Nov 2019 08:43:30 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Nov 2019 08:43:30 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xAI7hUuL006242;
        Mon, 18 Nov 2019 08:43:30 +0100
Received: (from aniljoy@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xAI7hS7U006159;
        Mon, 18 Nov 2019 08:43:28 +0100
From:   Anil Joy Varughese <aniljoy@cadence.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <aniljoy@cadence.com>, <mparab@cadence.com>, <rafalc@cadence.com>
Subject: [PATCH] bindings:phy Mark phy_clk binding as deprecated in Cadence Sierra Phy.
Date:   Mon, 18 Nov 2019 08:43:08 +0100
Message-ID: <1574062988-4751-1-git-send-email-aniljoy@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39850400004)(346002)(136003)(396003)(36092001)(199004)(189003)(8936002)(16586007)(36756003)(486006)(336012)(76130400001)(26826003)(81156014)(81166006)(54906003)(476003)(87636003)(5660300002)(8676002)(316002)(42186006)(110136005)(478600001)(2616005)(4744005)(2201001)(70206006)(70586007)(50226002)(50466002)(2906002)(305945005)(86362001)(126002)(426003)(51416003)(356004)(6666004)(47776003)(4326008)(26005)(186003)(107886003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6809;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b628247a-d3d5-40cf-540a-08d76bfb03e8
X-MS-TrafficTypeDiagnostic: DM6PR07MB6809:
X-Microsoft-Antispam-PRVS: <DM6PR07MB68093B6B79F08A37E3C3A9A5A84D0@DM6PR07MB6809.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWGUxV8UeQ0edfHWqr4Y0ZZV71sEoBZ47Z6HDkA9ymICSfZDRTCInYUlIqvUFYO9THuhp2ZgA1VEBEwH5254eet+V5aPI5755nOy3CdHrxnc20sXhw4Aeild/l8VPSJ8ivFGnUqmyoMMimvvqgCbxSCZRE9cViHDAE+uFWValGbgQWP1ycHY+xBoOexqiyKP4/F6yppdgZau+PAFtamqEP5S2hc9eZcnbxNm3YsTaEwRhLgM6VZRGCIefbDTh/VUO5DnkKU0ahJc4w4OTen/g/uGfpWZd/493yexuY/5wnMMPKhqWQj1xxtGTmsQGNyGNFHsaWpsyOn1nVjR+QB7AvVrDQ3VCt9e5JKqc4X/zrJdeKG7fURTjzUUa30ikJvl0sKA1Uce/+9gvoqs9MpyPw0ZtZfWLVXD2cEXFrv0XDDGrZIJorbi78DhMqHj9R/9H3YedW7orQL4cJRWWRmbbg==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 07:43:34.1291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b628247a-d3d5-40cf-540a-08d76bfb03e8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6809
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911180067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the Sierra Phy binding doc to mark phy_clk as deprecated.

Signed-off-by: Anil Joy Varughese <aniljoy@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-sierra.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
index 6e1b47b..9a42b46 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
@@ -5,7 +5,7 @@ Required properties:
 - compatible:	cdns,sierra-phy-t0
 - clocks:	Must contain an entry in clock-names.
 		See ../clocks/clock-bindings.txt for details.
-- clock-names:	Must be "phy_clk"
+- clock-names:	Must be "phy_clk". This is deprecated and should not be used with newer bindings.
 - resets:	Must contain an entry for each in reset-names.
 		See ../reset/reset.txt for details.
 - reset-names:	Must include "sierra_reset" and "sierra_apb".
-- 
1.7.1

