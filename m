Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88539C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532C520715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XVPIK/+v";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Mcjfz12d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLWPQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:15 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:61954 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbfLWPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFDgoJ032656;
        Mon, 23 Dec 2019 07:15:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=vLzV39YegzU7URVY4Zp1rmFRwkD7KaTmIvIwkXDVh4g=;
 b=XVPIK/+v77W5g3lCHC+M1QWQ7DAt/JI+mWNubw+uIUONQ7KB7kvDV4F3yayR4H+lTruT
 8pn8vVww6BRAHsP3X1DbFghl3/Nt/AVxuLCOH2MZqRuAQeCKO9Wk1UpmhH2zfef5qW/J
 11oIW1r5fhNEJC4hJLvnjcd7BbCWYlZyf3pYu09ewOjMcM3fE8WWgiqdg3AbP9I/68pg
 GBvsUKgVHGMD5ClF4x/sNFId5lxAa9yMt6I1r8xxFyQv3FuWYFHWuxEUjULc1kDG2THN
 g/hT8rP/aTS1s9/ofVnBwqBNKS4EfVZfY+xDXA2lqVCCgmQRWexLnxV5BUIMLzSJQPwe Ww== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4waq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:15:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz0Y/g9Jzz+mmw6JxPlPIsTNAHSWSM7tiuwMmbiO6gCffPPd0pTYnLxTf5YZ9RDpOCuVIzhrVe7i1Wn490JzEymzU7DijuMGaHs7TCWcA2cruwIoFHGKGDF9zDisOD6UuFmfRB7UI43iQwsPOW59UEP3E6/ZNrQS1ViIOwEb0PWMnBemehP+y1PVI77VOYb7h/2sgGajEnoN/bOTvuZXm6xNv4ldC/fPZf+Rho/xR+mYvAV6C7KOz9ySLu1OQgsxu/W2RAaHeHvuLThbtLypjwhmXosZGdtAt4NfT9gKtjcuOS9GdiJBpDjtnzIqFxZBrC60klu2W4WtKoYe6GuCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLzV39YegzU7URVY4Zp1rmFRwkD7KaTmIvIwkXDVh4g=;
 b=JOV1awDSITVxSJ4XenPjGLeVOIPTJdVt+D/gYTqY7ouB3Y+Vra6cQyIzD/c9GZFaWuCop6TUqFIII10v8YxJvSOI/X7W5Gw4rlcmxabFez7hA9MyAExetpSQ0Ur68serObkKJLazPIXb+9lnLh/KU1XkunDwVlJ17zgWx8VPHEOzcnOM6n+dwAyVjEB7TIgyxoBmhXfKDC/ltLcicrqNTcfjSdwUQKgMAInfDyVi9TVp2mCT32oOEmI+g8r+KFutrZtw1KiOB3EfOmmxa1MoyF+1lql93URh+YPvSAnTF3b7SF8sZ9Nuu9tM/SRtYLz8dm0S+HANahmms8MF6k/+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLzV39YegzU7URVY4Zp1rmFRwkD7KaTmIvIwkXDVh4g=;
 b=Mcjfz12dTTfSK63tUJV/7n72ttUZltncerCCZcNaMtTKjbpJQ9JhEg3Dh82SXKY+hM3OptEg78TYEg1c3h1LXnwjSIq6ilfNsgBhkHMPjpQnom7h8KEBZEPv2AF+S6lrUuQI41fRj3764KpM+AYJHWJ4oxbVdhwggDMO7adE33E=
Received: from DM6PR07CA0070.namprd07.prod.outlook.com (2603:10b6:5:74::47) by
 SN2PR07MB2495.namprd07.prod.outlook.com (2603:10b6:804:12::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Mon, 23 Dec 2019 15:15:54 +0000
Received: from MW2NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::200) by DM6PR07CA0070.outlook.office365.com
 (2603:10b6:5:74::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:53 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT064.mail.protection.outlook.com (10.13.181.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVe093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:51 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:46 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:46 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFjBI015239;
        Mon, 23 Dec 2019 16:15:45 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFj5t015238;
        Mon, 23 Dec 2019 16:15:45 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 13/14] dt-bindings: phy: phy-cadence-torrent: Add platform dependent compatible string
Date:   Mon, 23 Dec 2019 16:15:38 +0100
Message-ID: <1577114139-14984-14-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(36092001)(189003)(199004)(70586007)(70206006)(4326008)(2616005)(107886003)(478600001)(86362001)(36756003)(110136005)(4744005)(186003)(2906002)(26005)(81166006)(6666004)(81156014)(36906005)(356004)(5660300002)(8936002)(426003)(316002)(8676002)(336012)(42186006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2495;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d264ba-8a10-4117-d042-08d787bafff9
X-MS-TrafficTypeDiagnostic: SN2PR07MB2495:
X-Microsoft-Antispam-PRVS: <SN2PR07MB2495960878113E84C3720EDFD22E0@SN2PR07MB2495.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ak+EqjFKbA9z+AzlmJ7/0Tf7abyIghIOQq85wQABuBB+RROLv2oIR37c1OnlgmGPzpq88wxEONxGq4bwLNQ52JAhkZpja1tdr2TmTJFO/KbcnIn4HlrnhkzNOm1I3olyu2/HxLx5EyBPbNfXS+4VeQGxLQM0hUvNXV1PR7q+44HyCIRJDDY/eyrE/HtqcDLL6MqIcDVwBzpCz/j6+z9lHQ7KI8rS+iclPBlVsF+yght6q+xKLeeoobQIn/AHhPDEWe1Z2/9bi4o3qaXf3YeaYwGuORXqSo0XjFzFo0y9aySrSTlGyZ4V7gjkVoT/4gxJIayj9Be7UA9y9GySmXA/fExJ5YQCCCPRrMczcLlicycVMASXJJIzufbS6+MG9yNjZOlj1yvYqZ+/YYNvBAAZ8I/h0qCd7LBqk8kF7+nHtwWZE4GZisbFEyTychoZKzHDi942/Q49i+BR4EsGM+2MZtaaepUdwEbnEFS5AZ9yYc+Depjx36p2lzjQeAnShYTl
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:52.3892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d264ba-8a10-4117-d042-08d787bafff9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2495
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=929
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912230129
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
index 907b627..76ce04a 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -15,7 +15,9 @@ maintainers:
 
 properties:
   compatible:
-    const: cdns,torrent-phy
+    enum:
+      - cdns,torrent-phy
+      - ti,j721e-serdes-10g
 
   clocks:
     maxItems: 1
-- 
2.7.4

