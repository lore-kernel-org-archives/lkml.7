Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B33CC2D0D5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2184020709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cKHnqZdg";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="X4s4u5Ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfLWPQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:08 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48740 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfLWPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:05 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFDfRM032649;
        Mon, 23 Dec 2019 07:15:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=jMwYk7Vbk+GcfyXCnGEzljsLjF9Ya23s2syjQo+6bT8=;
 b=cKHnqZdgBxqR7rdp00U4ZBUTgPKCZFSwAcKvD50lxXg8hOd534JLBaEerxhsyTUR3g8/
 a51oxmgsr4PehlT6ccXsbuvIxDTJbRy3ZtUD2w0y4couSeKxBsAJ5YWpWc04DSzCnN+N
 gxGx5brFVs13DW/f6ez4xLxE/PlFnH2M+C9mW9chBPDsQVyuDXt0gsB8PRiu4NU4xtCu
 2ZfTp78ZyXMEyGlOI9oSqwCS5m04Z6kdOk70mgPqE8QmQvExAHt19tmRvMSwX/njRcqg
 mgVh4N+uZEhuCcBY4mWIx5F+M7ahNdXTG0/y7BJtNB08j9MLRoK5vlHqDIB0EujDrk8B 4w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4wapr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:15:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcnmj7dcEWI1YSym8wy5BzQTSpnKbjNkuB7KjfqV2jtc0W/Wlt1NcIVszL+iadeTiUeRCClytmDkiHTmwqEz8Rv563Gmp/VWW3RPcmBuFuZ9+9l9bJO5X+sow35kXKdwneXbj0lfefqFIiWST1b7y1mYu6MJ6uX28S1KAcqDppm8fj9AFAjGFswdmzrLhkZZ00eBjowa1H+wEPq9F4qhvmr99IjwXjAJZcpro0pTLlkA4RufllHwMWIGpzSdmq2cjTf2ZwZgkRnRPJ/8p9h1qEObnbPbl77wmScU77+coCb6PlYrQKb9qapil/pkWmSlQTTIvFym4pOt5dwQDYMzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMwYk7Vbk+GcfyXCnGEzljsLjF9Ya23s2syjQo+6bT8=;
 b=L+PH3qMlmbuoeEI9wiaYPkAV4yVAL7YvsaL8DiBeRGRAo/aeTQaqJeuPaVaP2YnZUu3SWXDddWWfDMpyp32YG/e+RUUWbgIZ6hrZzA1j3xIa16QZMwxjaD6+ND/hGUx2PGON8QeJbkncr+yNn6NGi9pYKHu+YuNSMfu2FaZSI2wVDM0zAlxXLORDl8ANtteMIX6IT4rkTSKiJ+PJcupI6ZM9lsJq2zXn6d5bvrElTLdd+sNz8VGBYUrSbz1wu1XUCfoxaJkcp05a82oow/9BsYuBT6S6RluWra0Q3SvDU5j8iv6MbNnrfBtZp7OhjlsUfsR4JLi1j0UYTxouCHVwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMwYk7Vbk+GcfyXCnGEzljsLjF9Ya23s2syjQo+6bT8=;
 b=X4s4u5FtQ0UxH7EVMA1c07DzqtaOWBZpx66/OzoxUsUExlT2viN7YOAK5Ymme3HCNxWAGvUL4Ect0972gEFPJAQlxoCJe569RIO6FWUIP4OHztDNLFduSrD6Itme01R0eRZVQuCbXVeiPr54jWlmQZDun8Dn3t1dzGSrG56kbIg=
Received: from MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33)
 by BL0PR07MB5651.namprd07.prod.outlook.com (2603:10b6:208:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Mon, 23 Dec
 2019 15:15:53 +0000
Received: from MW2NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::207) by MN2PR07CA0023.outlook.office365.com
 (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.19 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT038.mail.protection.outlook.com (10.13.180.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVf093771
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFk1t015247;
        Mon, 23 Dec 2019 16:15:46 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFkmm015246;
        Mon, 23 Dec 2019 16:15:46 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 14/14] phy: cadence-torrent: Add platform dependent initialization structure
Date:   Mon, 23 Dec 2019 16:15:39 +0100
Message-ID: <1577114139-14984-15-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(36092001)(199004)(189003)(26005)(36756003)(6666004)(336012)(426003)(70586007)(186003)(356004)(70206006)(110136005)(81156014)(54906003)(81166006)(5660300002)(316002)(42186006)(2616005)(478600001)(107886003)(8936002)(4744005)(4326008)(8676002)(2906002)(86362001)(36906005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB5651;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b717837-008d-42b2-3c34-08d787bb0019
X-MS-TrafficTypeDiagnostic: BL0PR07MB5651:
X-Microsoft-Antispam-PRVS: <BL0PR07MB565154970035EFB70AC4AA1CD22E0@BL0PR07MB5651.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GEa07B0BcOlWCZ34pLlW5SAuKwCUsgykCBUpX/WYrhZnGd74ShtcEgaKAA30eShYuMMS98BM7mNP7V58dvF7o/ZkQLp98FcH8Jo2+Xs8b8fBltDbgVscURazgCHPmhF/ZgcP2A5FPE68Cer+mlU2S64b9DwFV+UJBLPhlDfkkLnu8dQxI6y6+Z/loAB1J9mlsZ8wbarW8dnXfsO95S3ad1pbrsCkkbuAAs9JueO58oxwmd/Hq8OvB5hgi4D/LwlwI+mVs0cKtpkmk4MWrH/z/NU9Enii/YZaBmAcpHcQnzGIyTlxArOwAQ3/fOL4Rh3cDxvJk12dzzERE4NA/JcQxoMKFXYKn8/uISYeLpMGiXb+JiFS0OlVlb2p5fcFsyXKcoeMtY3U0bCyIJ4hck/1ANk2sb8WPohqerbLVSHyMA6J8wFKC8F54Jx/lOasHj6Nkqaiy5kis4d4YpNqVnuYjroAAhREwobJi5HNJWlNLV959cLn8G3DbRrwhHdICq1
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:52.5932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b717837-008d-42b2-3c34-08d787bb0019
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5651
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912230129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform dependent initialization data for Torrent PHY used in TI's
J721E SoC.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a64ed4b..29e125b 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1792,11 +1792,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.reg_offset_shift = 0x2,
 };
 
+static const struct cdns_torrent_data ti_j721e_map_torrent = {
+	.block_offset_shift = 0x0,
+	.reg_offset_shift = 0x1,
+};
+
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
 		.compatible = "cdns,torrent-phy",
 		.data = &cdns_map_torrent,
 	},
+	{
+		.compatible = "ti,j721e-serdes-10g",
+		.data = &ti_j721e_map_torrent,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
-- 
2.7.4

