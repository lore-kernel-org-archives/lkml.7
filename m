Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED96DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7BB21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="n1dk4uIy";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VHmwpuIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfLKNKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:05 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:19124 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729469AbfLKNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:51 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD48fh020456;
        Wed, 11 Dec 2019 05:09:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=f+4ngTfOWQVngV4fPgeencMm5sxLBn9XFDyI9iKkn18=;
 b=n1dk4uIyD9N/lFZLGI/yVC++0ZW+IoonzS2ABrFCsVDCk74S6H/skRDNF7UbyFa8HstA
 MORGysMArDs9lgCS74McND12osO9ptISNS/aROzIuj+1H+KPgqWX/uvcLKr/6zQJbV00
 ahjukGT0D50iv8czqg9i4CWuH9WQmo9aVBzL3hRrc6WdjUoKbdbv9nlIzhoZFltk2+cO
 hju35Zok6NoECOyv/B1PZBtrlKaiwijo4ANPpgmR7uTFue0FAZtKSqMQcqZ80472Pxpk
 aD2haK9YGSztn4berOvxow6NhtRy8sKhohNIHsE9rkRElb/8I2sWhJAr3VSr1yBMq7fp Qg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp68x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2FPJBzruLUzbk0mgp5KYMnYLPcQNaTNwKe+CniOfbdpnBdAlkrA5U6BDJ1N/s3JGfKzh0dAHg3YJSXfFrgKvPatT46AiQzyCSlaBpqeBKJgNVXxdJbICcGMsOD46pfO5CM4tynygrtIWwhKaW2fWbvwX0r0Wx7IxLQxAuVKQcNtrHC+RW3DO8MWdfTYoT800y/oBPNF0lBdFKh776Pte7rYFxk2gAc6WJpBnVVT8TNkiY55cCxL2Rxq9Z7bf4KRj7X4+LJAIelH3y0ndFJa4BZwipoFYu+OI+9kOTEQbYC0n89yyRP1Sexw7ScT0bZWkDmCGiVMu5JvQubgY3mZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+4ngTfOWQVngV4fPgeencMm5sxLBn9XFDyI9iKkn18=;
 b=c3pGsryNLlZ/8/BPwN/4gHDV6cTDuXdNw2gzovBiNyVHajd0ilJaqVH4cyt5aMi4hwgGRWbwSa2wd1ir5F3ATqucYmhLJBAve3H9RD+TxmfNtK0QeapeUk/LSp4b2ZehhhoHDxFSCnRZX5kstGdkkBFDFI/GIR8OfQxahR1WOvxfl9kbwlx6S4fk2haQQ9APb4jffi2JIBdkMf3EfH1+7y9/OzEpiuSieCbOJDa2lkczNrQomo5UYCxYN+8GBhU3l6d1vYPRaeKNQUQ0fets/c+mvf1TdFW6tCs5qT/ePC5FCEMOvz7m0PDGt//yTgnQtV8izziJGow6CYYUSwg6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+4ngTfOWQVngV4fPgeencMm5sxLBn9XFDyI9iKkn18=;
 b=VHmwpuIU9F7UCPdZ2e4T0YDnuDFSNGyhLlyQG08Ti1hCOPFky7FLlPucYRc8/BDN4wy73ar4ml4UwdOxuPSuu6z9sA8iaQlFMA6yT+bmyiTWMwQGJQMNMAzUa0gwuWtx2K/rYKrwNftMtcachzojbM81GPlzQMiSSlcUcIPPFDI=
Received: from BYAPR07CA0078.namprd07.prod.outlook.com (2603:10b6:a03:12b::19)
 by BYAPR07MB6216.namprd07.prod.outlook.com (2603:10b6:a03:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.18; Wed, 11 Dec
 2019 13:09:43 +0000
Received: from MW2NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::205) by BYAPR07CA0078.outlook.office365.com
 (2603:10b6:a03:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:43 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 MW2NAM12FT011.mail.protection.outlook.com (10.13.180.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5n006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:38 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:24 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:24 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9Omc011713;
        Wed, 11 Dec 2019 14:09:24 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9OdA011712;
        Wed, 11 Dec 2019 14:09:24 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 14/15] dt-bindings: phy: phy-cadence-torrent: Add platform dependent compatible string
Date:   Wed, 11 Dec 2019 14:09:19 +0100
Message-ID: <1576069760-11473-15-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(36092001)(86362001)(4326008)(70206006)(426003)(8676002)(186003)(70586007)(81156014)(26005)(8936002)(2906002)(81166006)(26826003)(336012)(2616005)(76130400001)(107886003)(36756003)(42186006)(6666004)(5660300002)(478600001)(316002)(110136005)(54906003)(4744005)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6216;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79bf5fac-87de-4de1-7ec1-08d77e3b6207
X-MS-TrafficTypeDiagnostic: BYAPR07MB6216:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6216097922BF737FDEFC7DBED25A0@BYAPR07MB6216.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nn+//aMy2l+Ht9hDZf3tJ9KP/fq3cBPFTfHY5AoBz4BEuU3rNfZWBih+3kOH9PvvIArJ03oKJOeSKqSqGJ5rwaIOvEJBoQ0692/8jTz+ebfJ/LJQP+G4d3TOb44t3PhrAcjJWNnntN2Vp40IEEBn15a1T5UrakWHtPYEKd0/v6G/7yeL5OYrhdPe8lAEuvbO8PaDmXvrYq6OSlL5eCUUxWxCMgtpENYkmK4flJYtcNuYuCd6IfA3wMaL7d5PjiVqufNxhy418JGQbk4xGU/LiLMZjnK7AhbXsZ0BvTehKTVWWmthvab0F/aOAjezBxMKtvbemAHALcBjDSh7j5fI/2X3aFhMp+jA+rTGsNbS96bnRK3x997XyKkDE+rTOb79uJqyJxDDlccv7Ugm49waGnqfK/2Y9g30/9aIGJH4+rQNq/BQCVSfaZZuYNo/J9w79jJfdLv8ZM+zGyr1pnKwGBvuofrE+V/NyEzV97AdDuG3jjNuTKZHqyCjU91T6XyT
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:40.7572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bf5fac-87de-4de1-7ec1-08d77e3b6207
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6216
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=894
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string used for TI SoCs using Torrent PHY.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 8069498..60e024b 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -15,7 +15,9 @@ maintainers:
 
 properties:
   compatible:
-    const: cdns,torrent-phy
+    anyOf:
+      - const: cdns,torrent-phy
+      - const: ti,j721e-serdes-10g
 
   clocks:
     maxItems: 1
-- 
2.7.4

