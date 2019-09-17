Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02621C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B221020640
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zk30GWfq";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zk30GWfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfIQL0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:26:06 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:47998
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbfIQL0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPCfEYioEfsWHrPR84jJQb343tIWOQ3Hl3nMGQNyF3M=;
 b=Zk30GWfq09LmpfdfmWiDUuE8TW+mRV28WzPBHUSMqD/PBK8h7aFGweK/fxBUX9OkRTTwPFXqAy3WIDpmjSiuhyrb6lt0kPLfn6CdX5H8k0pC81ERM50uyr7XcTqvJwLBPymN+96UdnkqqHQoGR0GI/wcU6HmTwKTSBJT0lW8CwA=
Received: from VI1PR0801CA0081.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::25) by AM0PR08MB4052.eurprd08.prod.outlook.com
 (2603:10a6:208:12d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.20; Tue, 17 Sep
 2019 11:25:58 +0000
Received: from DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR0801CA0081.outlook.office365.com
 (2603:10a6:800:7d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Tue, 17 Sep 2019 11:25:58 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT026.mail.protection.outlook.com (10.152.20.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14 via Frontend Transport; Tue, 17 Sep 2019 11:25:56 +0000
Received: ("Tessian outbound 96594883d423:v31"); Tue, 17 Sep 2019 11:25:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c31b3dd893088c5f
X-CR-MTA-TID: 64aa7808
Received: from ed96af2a6d6b.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7EE5C799-2460-4FA4-B5CE-1DF4F8ED5121.1;
        Tue, 17 Sep 2019 11:25:47 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ed96af2a6d6b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 17 Sep 2019 11:25:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/6jK6H7SQnYtiEa4GsOpnaZaAeOWygx32BtNnuTjn4NbiRvcprxPoG3z7OiuDdz0BEZCCrvHyHvbLCbufC/o22uk08G3gelqBo7sX7T+nfxjfEq+aQ1jTz1L4uhRGSmBM5trWrPOWblK0qJJ0nzTOwTkjSozO96MN3n/da8yImdebbDFf1Lxivs9kA/SbY0uY2eRnSokWEGPcnR7Eh8nSFDvGc5JeiSY3zc6M/lfSJU6seqYtJb58nOBnsqTbUGEpwt3hpP0KFh42Vgah9SQVo6TBKl5syte2R8RYM/PGsiTtJRbAT+TjZ0ficMnvrDsdyJ/MIdTNKEyoH7LHcj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPCfEYioEfsWHrPR84jJQb343tIWOQ3Hl3nMGQNyF3M=;
 b=OUMHhJjc/f1LFInNKrZr4X4/SEo6pI+zvfjIwhceE3VsZXEpKeZ20kzmzO771sdiIZljjXz/NHt6UWKZEei8O4pw/3Xp1tLJhP++Ya6zZ/DwAvdtP95zMWe3bmnRwpVNVe6KnCjGmDD9Hota/E7yV4RA7+kg2EA/tOIAVZdng12PGsri042dtg5jlzt5mtQfw3KuOvNDBBWG+MO5P9HS5tkZCKmgJfX4VJjeHMaLKVfMBwM1N/QSca0fiv/T5Kb6pDyoRlZrFK+XATtA/y13TWg0bKrVf282jNFoVkbaZg7pJKD5iszGXsPVXYxi5sis5ySiM72xQUKaXNkEZTQWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPCfEYioEfsWHrPR84jJQb343tIWOQ3Hl3nMGQNyF3M=;
 b=Zk30GWfq09LmpfdfmWiDUuE8TW+mRV28WzPBHUSMqD/PBK8h7aFGweK/fxBUX9OkRTTwPFXqAy3WIDpmjSiuhyrb6lt0kPLfn6CdX5H8k0pC81ERM50uyr7XcTqvJwLBPymN+96UdnkqqHQoGR0GI/wcU6HmTwKTSBJT0lW8CwA=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Tue, 17 Sep 2019 11:25:44 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 11:25:44 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH] drm/komeda: Adds register dump support for gcu, lup and dou
Thread-Topic: [PATCH] drm/komeda: Adds register dump support for gcu, lup and
 dou
Thread-Index: AQHVbUqkK0KWtTUlrECe2oyL7O6Z7w==
Date:   Tue, 17 Sep 2019 11:25:44 +0000
Message-ID: <20190917112525.25490-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:203:36::17) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b71dbbfb-03d2-4662-77af-08d73b61cecd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB5488;
X-MS-TrafficTypeDiagnostic: VI1PR08MB5488:|VI1PR08MB5488:|AM0PR08MB4052:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4052E20C34591504C461D9809F8F0@AM0PR08MB4052.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1417;OLM:1332;
x-forefront-prvs: 01630974C0
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(476003)(486006)(102836004)(186003)(1076003)(2616005)(2501003)(6506007)(478600001)(26005)(66446008)(64756008)(66556008)(81166006)(66946007)(52116002)(8936002)(8676002)(66476007)(14454004)(305945005)(50226002)(66066001)(7736002)(71190400001)(71200400001)(6636002)(99286004)(5660300002)(86362001)(36756003)(256004)(55236004)(81156014)(386003)(54906003)(2201001)(110136005)(6512007)(25786009)(3846002)(6486002)(6116002)(6436002)(4326008)(2906002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5488;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 1Qu8p/oPEGzUsq8FUfVM1WNMZAemhp1ITpa8Dgy8QHW7d0m5g8bZD0tJ4XREWBKOpBujguRi15nY4XtecKasffrF9UrxDPe0cf/mJRzosAu6PvRsqn+GIQMnVPuJF4O4cgeXDVOphX3tcPtx98oEpQ3LNGWnUmOfJmUbGoCmkwbCfPDWdGHQLjOWmPQLC/TpCiLBKdWkpRMNUanYHF6IanTzgCZohPLbNOdx2gniC6Psu2JeV8s43fbQiPn2SVBMQ1gQLXcX7toO6xrSAgMEWi37qbtwRZPfNmZ90c/5xXO7hBgIfM0qKx1/8pz7DXX/d2UICa3LbOwff0VXj4Geo4UgRHkCpbGSHkIfAlkV35TEi4vksK1mz1NV+igdSB0Zgfa6e1F7XcJrDRm/3VpVt2bzHqyoBnpEtwIJu1mOd7k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5488
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(336012)(110136005)(6636002)(102836004)(70206006)(86362001)(70586007)(486006)(7736002)(50466002)(478600001)(76130400001)(2201001)(25786009)(126002)(47776003)(5660300002)(23756003)(2501003)(316002)(6506007)(22756006)(4326008)(386003)(356004)(6116002)(8676002)(1076003)(8936002)(8746002)(50226002)(3846002)(26005)(81156014)(26826003)(14454004)(476003)(2616005)(36756003)(54906003)(63350400001)(186003)(6486002)(99286004)(81166006)(6512007)(2906002)(305945005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4052;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4ebe53ff-1fc0-496b-f72d-08d73b61c73f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR08MB4052;
NoDisclaimer: True
X-Forefront-PRVS: 01630974C0
X-Microsoft-Antispam-Message-Info: /yq5O8H78nkxwsoUJjyWrliXllpBWyS9cWQ4z+LiM6L+LEGuKJqTI7nhPFrBazIrNrVZSslW+JN9Q5lOz9aYZ9p3++HRjCYfZCxC5tQXjDFtZycaWcbF5NChVlEt3W468LIgMfD68iigiIo9mAQrwV7AO4JTRIEpKFC1UI+g4FwBd4r5/8lyP9A7E/nQX/PoS+7OOZ2HzdybPl3zbVs22Pa8wx1VSCocVKen6sZZaM+DcAGk7E+xUpwWcPI95340ngPxAVbEcFSxRRhp9xWg7kQJRhZK86VQrP2+PyKG4Q0+ClcOaGfoiQVA58pEZ4rI1WBT0+n6NLK17M9rQrvgz2euQT1nWo5mnf1aAF7aiTexXFsPEuyZPnETePxOeRBv2Z8zUbXA+w1LGG+8da5BW87mwqh9WiCc6gxw2t6A1SQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2019 11:25:56.3122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71dbbfb-03d2-4662-77af-08d73b61cecd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Adds to support register dump on lpu and dou of pipeline and gcu on D71

Changes since v1:
- For a constant format without additional arguments, use seq_puts()
instead of seq_printf().

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 86 ++++++++++++++++++-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 23 ++---
 .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |  2 +
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  2 +
 4 files changed, 101 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 4073a452e24a..7ba3c135142c 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1206,6 +1206,90 @@ int d71_probe_block(struct d71_dev *d71,
 	return err;
 }
=20
+static void d71_gcu_dump(struct d71_dev *d71, struct seq_file *sf)
+{
+	u32 v[5];
+
+	seq_puts(sf, "\n------ GCU ------\n");
+
+	get_values_from_reg(d71->gcu_addr, 0, 3, v);
+	seq_printf(sf, "GLB_ARCH_ID:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "GLB_CORE_ID:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "GLB_CORE_INFO:\t\t0x%X\n", v[2]);
+
+	get_values_from_reg(d71->gcu_addr, 0x10, 1, v);
+	seq_printf(sf, "GLB_IRQ_STATUS:\t\t0x%X\n", v[0]);
+
+	get_values_from_reg(d71->gcu_addr, 0xA0, 5, v);
+	seq_printf(sf, "GCU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
+	seq_printf(sf, "GCU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "GCU_IRQ_MASK:\t\t0x%X\n", v[2]);
+	seq_printf(sf, "GCU_IRQ_STATUS:\t\t0x%X\n", v[3]);
+	seq_printf(sf, "GCU_STATUS:\t\t0x%X\n", v[4]);
+
+	get_values_from_reg(d71->gcu_addr, 0xD0, 3, v);
+	seq_printf(sf, "GCU_CONTROL:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "GCU_CONFIG_VALID0:\t0x%X\n", v[1]);
+	seq_printf(sf, "GCU_CONFIG_VALID1:\t0x%X\n", v[2]);
+}
+
+static void d71_lpu_dump(struct d71_pipeline *pipe, struct seq_file *sf)
+{
+	u32 v[6];
+
+	seq_printf(sf, "\n------ LPU%d ------\n", pipe->base.id);
+
+	dump_block_header(sf, pipe->lpu_addr);
+
+	get_values_from_reg(pipe->lpu_addr, 0xA0, 6, v);
+	seq_printf(sf, "LPU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
+	seq_printf(sf, "LPU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "LPU_IRQ_MASK:\t\t0x%X\n", v[2]);
+	seq_printf(sf, "LPU_IRQ_STATUS:\t\t0x%X\n", v[3]);
+	seq_printf(sf, "LPU_STATUS:\t\t0x%X\n", v[4]);
+	seq_printf(sf, "LPU_TBU_STATUS:\t\t0x%X\n", v[5]);
+
+	get_values_from_reg(pipe->lpu_addr, 0xC0, 1, v);
+	seq_printf(sf, "LPU_INFO:\t\t0x%X\n", v[0]);
+
+	get_values_from_reg(pipe->lpu_addr, 0xD0, 3, v);
+	seq_printf(sf, "LPU_RAXI_CONTROL:\t0x%X\n", v[0]);
+	seq_printf(sf, "LPU_WAXI_CONTROL:\t0x%X\n", v[1]);
+	seq_printf(sf, "LPU_TBU_CONTROL:\t0x%X\n", v[2]);
+}
+
+static void d71_dou_dump(struct d71_pipeline *pipe, struct seq_file *sf)
+{
+	u32 v[5];
+
+	seq_printf(sf, "\n------ DOU%d ------\n", pipe->base.id);
+
+	dump_block_header(sf, pipe->dou_addr);
+
+	get_values_from_reg(pipe->dou_addr, 0xA0, 5, v);
+	seq_printf(sf, "DOU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
+	seq_printf(sf, "DOU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "DOU_IRQ_MASK:\t\t0x%X\n", v[2]);
+	seq_printf(sf, "DOU_IRQ_STATUS:\t\t0x%X\n", v[3]);
+	seq_printf(sf, "DOU_STATUS:\t\t0x%X\n", v[4]);
+}
+
+static void d71_pipeline_dump(struct komeda_pipeline *pipe, struct seq_fil=
e *sf)
+{
+	struct d71_pipeline *d71_pipe =3D to_d71_pipeline(pipe);
+
+	d71_lpu_dump(d71_pipe, sf);
+	d71_dou_dump(d71_pipe, sf);
+}
+
 const struct komeda_pipeline_funcs d71_pipeline_funcs =3D {
-	.downscaling_clk_check =3D d71_downscaling_clk_check,
+	.downscaling_clk_check	=3D d71_downscaling_clk_check,
+	.dump_register		=3D d71_pipeline_dump,
 };
+
+void d71_dump(struct komeda_dev *mdev, struct seq_file *sf)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+
+	d71_gcu_dump(d71, sf);
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index d567ab7ed314..0b763ea543ac 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -561,17 +561,18 @@ static int d71_disconnect_iommu(struct komeda_dev *md=
ev)
 }
=20
 static const struct komeda_dev_funcs d71_chip_funcs =3D {
-	.init_format_table =3D d71_init_fmt_tbl,
-	.enum_resources	=3D d71_enum_resources,
-	.cleanup	=3D d71_cleanup,
-	.irq_handler	=3D d71_irq_handler,
-	.enable_irq	=3D d71_enable_irq,
-	.disable_irq	=3D d71_disable_irq,
-	.on_off_vblank	=3D d71_on_off_vblank,
-	.change_opmode	=3D d71_change_opmode,
-	.flush		=3D d71_flush,
-	.connect_iommu	=3D d71_connect_iommu,
-	.disconnect_iommu =3D d71_disconnect_iommu,
+	.init_format_table	=3D d71_init_fmt_tbl,
+	.enum_resources		=3D d71_enum_resources,
+	.cleanup		=3D d71_cleanup,
+	.irq_handler		=3D d71_irq_handler,
+	.enable_irq		=3D d71_enable_irq,
+	.disable_irq		=3D d71_disable_irq,
+	.on_off_vblank		=3D d71_on_off_vblank,
+	.change_opmode		=3D d71_change_opmode,
+	.flush			=3D d71_flush,
+	.connect_iommu		=3D d71_connect_iommu,
+	.disconnect_iommu	=3D d71_disconnect_iommu,
+	.dump_register		=3D d71_dump,
 };
=20
 const struct komeda_dev_funcs *
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.h
index 84f1878b647d..c7357c2b9e62 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
@@ -49,4 +49,6 @@ int d71_probe_block(struct d71_dev *d71,
 		    struct block_header *blk, u32 __iomem *reg);
 void d71_read_block_header(u32 __iomem *reg, struct block_header *blk);
=20
+void d71_dump(struct komeda_dev *mdev, struct seq_file *sf);
+
 #endif /* !_D71_DEV_H_ */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 9d4d5075cc64..4aa324d46409 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -25,6 +25,8 @@ static int komeda_register_show(struct seq_file *sf, void=
 *x)
 	struct komeda_dev *mdev =3D sf->private;
 	int i;
=20
+	seq_puts(sf, "\n=3D=3D=3D=3D=3D=3D Komeda register dump =3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
+
 	if (mdev->funcs->dump_register)
 		mdev->funcs->dump_register(mdev, sf);
=20
--=20
2.17.1

