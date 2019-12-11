Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A37FC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D920836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="O5bklWIg";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LmBb8sY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfLKNJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:09:59 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:56376 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729493AbfLKNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:48 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD7a3f010249;
        Wed, 11 Dec 2019 05:09:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=wtxG/1ecGpMmIbGX3CZbbd+hcaqBj7cQ2+w0RIeoPdA=;
 b=O5bklWIg5JkjR+D0jZ6Y+Mnq4JMO2aNoqv77YMn6x23JCQ3T/ZulzFNSjpjZBi2U+SF1
 JUHfJgWC2Ij0Wtn4KPKJosGL7J9KeL2oJAd+a0F0YaBNX1tyq4LNWp1d1pJpcXZiq/aB
 i0IXnqzrXClsEIDultYyE8FrwQg/2zGt8fq3iBftYPbWxbAmzab7iHloyQiTJmJOPEwg
 XSMrNkJfIhbkF1UOzkyS5XY04KrrfZSDpLOxZYqVzT/q1BDYv3HsrSsE+CY9+esWTdUK
 P//y/sj7bIoqQQxuV8OETg2EsCqiibyKnK0ef+9zcx9CPgHuiuGKG2q18p3Q+NqZXpHl 9Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2wra70e3wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB/FCu3oH4I5OWYcl57II3rA3ojYoTRZ9R/rRysFutVeaSKthSKhyVXruKSUzV7YhrihoRxuHR7E9iLmOblZdp1RuuuV/ZYu18anwOlxT5bSeWHIipEys2RoWDviXKo6xW/l6klhqi/LzjFv1UIbqexM5vMvK5MlY5rOTTlTq6nxsVxZ6GIviQ6aQKX1pYUdLwJe666rCt4KV6odK7tkpgC/lI3BDCrFEB116lmQZ+e6KafHAaQtD2P/xmNcYGfFKJtiezBOR5dTyUa7tG7azc+CnR88LmoOCe7tndKqvSfwQ2EtbdILYahertJprBpmAWUTcPAUh0uFckAykdrpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtxG/1ecGpMmIbGX3CZbbd+hcaqBj7cQ2+w0RIeoPdA=;
 b=LrPMFV1ttBEkhZ2IPoclKGxQiyZIJN5N7WO1ELcg4o295tNsjdiwYsWcoRgEcSv1VS8yKLij6C6qRlf34dDsYUoIMQyecMckLadZhc7cId9BBxZvktBjNhT8gAktfYqJwHNEDMbDog07S23s+BvwMcc7pDISl5zoIiFapEvURUwF49e6eVFXKZTaQzx5SHiKs8oThO0Gg6CkCqMKX8h0xtz9IgQLd5ppZ8Q5LE2Z7fDtBS1fRug9LG8sMgdTfgXhWSe+0PzG0eP6sYgNyEZyxVzDG9RHIgLNtH2JeU8d3qnuqTXu3kY/0lTw+hKVJuAMudiH0VoExFfs8ixasfkdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtxG/1ecGpMmIbGX3CZbbd+hcaqBj7cQ2+w0RIeoPdA=;
 b=LmBb8sY+6db1CEt+Muc/vFhgOUkwgtO9tTplpSbVBsmCXQ+WVggQRPnEf4ErASPWbih7oHJZARWOP3xtOnuY3e1h83ilcQLmuBAfzWVtHK2zwsga3RTOWB1vAup4gy63Op76B1/zdjyEzydhlhZVWsbO2mCKXGPGdbVfAAXwSyc=
Received: from BYAPR07CA0064.namprd07.prod.outlook.com (2603:10b6:a03:60::41)
 by DM6PR07MB5114.namprd07.prod.outlook.com (2603:10b6:5:47::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 11 Dec
 2019 13:09:34 +0000
Received: from DM6NAM12FT027.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::203) by BYAPR07CA0064.outlook.office365.com
 (2603:10b6:a03:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:34 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT027.mail.protection.outlook.com (10.13.178.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5h006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:31 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:23 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:23 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9Noo011688;
        Wed, 11 Dec 2019 14:09:23 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9NaM011687;
        Wed, 11 Dec 2019 14:09:23 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 08/15] dt-bindings: phy: phy-cadence-torrent: Add clock bindings
Date:   Wed, 11 Dec 2019 14:09:13 +0100
Message-ID: <1576069760-11473-9-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(36092001)(76130400001)(186003)(426003)(356004)(2906002)(26005)(2616005)(6666004)(336012)(86362001)(70586007)(54906003)(81166006)(478600001)(107886003)(81156014)(8676002)(5660300002)(42186006)(316002)(26826003)(8936002)(110136005)(4326008)(70206006)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5114;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cc82a6e-6078-4a8a-7dbe-08d77e3b5db5
X-MS-TrafficTypeDiagnostic: DM6PR07MB5114:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5114549F714043CA687217F9D25A0@DM6PR07MB5114.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ms36KRVNNkDsLbzTfXHAopnYr0HqoetDpuLXDdodlMEA5yTpgVJ7k4Vzo9HSktnP0jOOx31VjAexUVC1mK9cd2foJ/K/yCzk3c6pUNFT65YhkGvaczd6veL52U5s3SU+i8dSdm3C5SMyg5XXZTZpEAFkPP/Dvj42u1k95zBcSMRn28LoruasOm4ZGU9fJo1vDNR/KhPwfKNg0RFXSaYqgw+idbJVBM+5MfkyJ2LfTgOrOd5bJLYz+Sjvcz9c5pLIXduLnmiOYo2Heu+eP9KaqdOtGKh1SwU0GnNgHyxoHdqXCRG/CuEUKi9ND6n1E/okdOhtRHpk1ncFUZ+RQsiwp7J1p3oCmRBvIpziZYazUX4Gbbtv4zsqkZJ4XlJpbbY0dmxemYBK8P7IaZ3Amin0bq3hCw49nzEq66TkRl+fRrF2BSm+5o2Sf8pCc0ubRt1urFBVGN5fq8mLosV/YkMeacbTBF61NVA8xggM8MNIQ55LEn2CWNXQi59wlLTZsQHK
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:33.5889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc82a6e-6078-4a8a-7dbe-08d77e3b5db5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5114
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Torrent PHY reference clock bindings.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 4fa9d0a..8069498 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -17,6 +17,14 @@ properties:
   compatible:
     const: cdns,torrent-phy
 
+  clocks:
+    maxItems: 1
+    description:
+      PHY reference clock. Must contain an entry in clock-names.
+
+  clock-names:
+    const: "refclk"
+
   reg:
     items:
       - description: Offset of the DPTX PHY configuration registers.
@@ -41,6 +49,8 @@ properties:
 
 required:
   - compatible
+  - clocks
+  - clock-names
   - reg
   - "#phy-cells"
 
@@ -53,5 +63,7 @@ examples:
           num_lanes = <4>;
           max_bit_rate = <8100>;
           #phy-cells = <0>;
+          clocks = <&ref_clk>;
+          clock-names = "refclk";
     };
 ...
-- 
2.7.4

