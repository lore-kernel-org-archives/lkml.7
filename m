Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB422CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lY+5BukH";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lY+5BukH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfH1LEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:04:11 -0400
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:39303
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfH1LEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOlgPkmjzFyevzxrBIfkaXakl8jz5d3ZNjqcOIW4hh8=;
 b=lY+5BukH3TKTbntpU8ZHhAyMKzc40KPXIqGu1rRPYV512dtgFbazKD60xo0pbsM6FFsC+0UabqGSya2gnNHCePjDJLPgmpoNPYX0T0LoYt0b8hTaqcmQfkwIURD7qswBELvEOwcrhjDJ1ceIM7YIM8GhapMnn/OqF3FlX/9ekv4=
Received: from DB7PR08CA0021.eurprd08.prod.outlook.com (2603:10a6:5:16::34) by
 AM5PR0801MB1842.eurprd08.prod.outlook.com (2603:10a6:203:3c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.19; Wed, 28 Aug
 2019 11:04:03 +0000
Received: from AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by DB7PR08CA0021.outlook.office365.com
 (2603:10a6:5:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.16 via Frontend
 Transport; Wed, 28 Aug 2019 11:04:03 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT040.mail.protection.outlook.com (10.152.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.13 via Frontend Transport; Wed, 28 Aug 2019 11:04:02 +0000
Received: ("Tessian outbound ea3fc1501f20:v27"); Wed, 28 Aug 2019 11:03:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 95ab108c4cead074
X-CR-MTA-TID: 64aa7808
Received: from ad4a491d3037.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C3EF50BF-B9CD-45EF-87E6-9FB4C93671FF.1;
        Wed, 28 Aug 2019 11:03:52 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2055.outbound.protection.outlook.com [104.47.4.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ad4a491d3037.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 28 Aug 2019 11:03:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO7RE4XEx70SkhmVvG2cDcjvc0AVfi1Pb4G4nk/5RrGYX/jxOUsl0athGK+zQ4G1/WcR2E3grR106vkN6q/pywvUOXVzs3U5+J859EbCI1ndaDZxA5zj9b5EA8ESY4s3ALDXTPI/S0jjh09RcXKBt9860XzUu2wGQJO1bGwwfXCoGlBG9aERq6wQ333akBh1TPXJurrNg0GFGMbUvF34vXa+mKi2qWNdICZ5ZT5nfn8GwpwQhZVnDJhq9/vOe3ZDRSa2ksqN7K5VMOZWuGFk9KgouiNzu2S+nPC86kBQjNYvRjcvy6vDaaRNvg+++K2Uvfi3Xcz9rEP3Bm9Q38BqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOlgPkmjzFyevzxrBIfkaXakl8jz5d3ZNjqcOIW4hh8=;
 b=kyypWOianWQ53P++kHj312qHyJjBZosiQpm5fRGKeaVng+GdwvXCgyPfYVAwk8C5gc+8aApLfaQmJJeZOeA8pTv1R3X0cM1QqMuRCgCup8cOYZqq1VMKs4hiGTbD7e+RW90TeuqyMT04s1W3JaWrbj4h/TjOdOFj4tuBtp64u8PatxFUHzYqRiarrGF3bFxqNwEpcPavUW8blme3YHOnBT/Rto356LUXaLrfSG5cvr5jilQrdRBcjJW5Gm6bCOEiW1uNc0lB3JAMCrSePa1SSiIN0Q+YXgzHUYWNlHFGe+KAYo+MZFfg9rrX+ybEaBvZbys/NAFrqbZXrVuRBCZ0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOlgPkmjzFyevzxrBIfkaXakl8jz5d3ZNjqcOIW4hh8=;
 b=lY+5BukH3TKTbntpU8ZHhAyMKzc40KPXIqGu1rRPYV512dtgFbazKD60xo0pbsM6FFsC+0UabqGSya2gnNHCePjDJLPgmpoNPYX0T0LoYt0b8hTaqcmQfkwIURD7qswBELvEOwcrhjDJ1ceIM7YIM8GhapMnn/OqF3FlX/9ekv4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4287.eurprd08.prod.outlook.com (20.179.25.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 11:03:50 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51%3]) with mapi id 15.20.2178.023; Wed, 28 Aug 2019
 11:03:50 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Add ACLK rate to sysfs
Thread-Topic: [PATCH] drm/komeda: Add ACLK rate to sysfs
Thread-Index: AQHVXZBFvBwgvZ1PNEmL4p2YP+CqdQ==
Date:   Wed, 28 Aug 2019 11:03:49 +0000
Message-ID: <20190828110342.45936-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::24) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.22.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c24075a0-d4e8-43e7-0700-08d72ba76f30
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4287;
X-MS-TrafficTypeDiagnostic: VI1PR08MB4287:|AM5PR0801MB1842:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1842A8CED017EE83B3B850798FA30@AM5PR0801MB1842.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:849;OLM:849;
x-forefront-prvs: 014304E855
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(199004)(189003)(102836004)(26005)(2616005)(476003)(25786009)(66476007)(3846002)(2906002)(109986005)(486006)(316002)(386003)(1671002)(256004)(44832011)(4326008)(99286004)(14454004)(305945005)(1076003)(54906003)(478600001)(66946007)(66556008)(8676002)(59246006)(50226002)(71200400001)(66066001)(71190400001)(6512007)(5660300002)(6436002)(81166006)(81156014)(86362001)(53936002)(7736002)(4744005)(52116002)(6506007)(6486002)(8936002)(66446008)(6116002)(36756003)(64756008)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4287;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 0e2/236Ag2xzCModA4uvg2Yxe4pI2KO0BzxV+TwHBTxIluMEtDbOHFcE1LcrvL6q4J9zyN6ZwJGEe2DQeBUecgQXR9aN3rRLQFxZQ9uoVbNgDzl/c6CaxVOF45IDCegn21c0lnp589wMEph+BSU2X0oUYZOcBZSUyKOo4CD/+z+atIg6GLBizV9J/rdjhCiyxPfktMgMKHbfaPWoOdrfLVsKOOuebVMuI/vMqURVJH5UbVcaj/9OsB+/R0Zf+SSCihbbXAsEZLiZiSn253EygRsWs5S5q0mxB7HHpaGhqysDcLEcj2fAnUR+12XMRrzdM3ALVRYQdQqhYsQYVVG3v4xEhqLXGqRGSsbJtw4vm83plooZmWCbQ5Gu8iVy2SZ3pVCdDmdNKsXAhFMqlO+zyA/ob+quKmFOmM4oLCy/UQE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4287
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(189003)(199004)(25786009)(23756003)(356004)(4326008)(5660300002)(26826003)(1671002)(14454004)(70206006)(70586007)(86362001)(4744005)(1076003)(478600001)(7736002)(99286004)(2906002)(316002)(3846002)(36906005)(81156014)(8936002)(50226002)(47776003)(6512007)(59246006)(66066001)(8746002)(76130400001)(109986005)(63350400001)(63370400001)(6116002)(186003)(26005)(22756006)(81166006)(336012)(2616005)(476003)(126002)(386003)(102836004)(6506007)(486006)(8676002)(54906003)(6486002)(50466002)(305945005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1842;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7c8b5516-8c15-4332-40ff-08d72ba767bf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM5PR0801MB1842;
NoDisclaimer: True
X-Forefront-PRVS: 014304E855
X-Microsoft-Antispam-Message-Info: uFDc0T+aBO/FG1pPWEK7NEOBiOxacrnsMq3+CHrBUKqTCFJBasMkLyRskecCaFcHf4P0mdOs8M56jQCfHqXpNJzwO8d+iOjlvheB86ptkw/VBLgml7Zckc2e5oHzcJmTkbl3PwXeu5ywc918io8GxRBCgIXfantyE0vmTCjfjU0pYNKdRmwkgQGsq1BaMAFzeJFkOXS7ZG37IDx0QvXCnjpgrg0bkaBifAY2y6G6w3lRwx0UA/tdOiVoNr/eTVBAZu5v1T0GBxBo53StF+P9mhss05p4AeMuS8FVXe3yaGMrxxr1IjXak3dNsViwe1bW4XgyRIyAh+tCFPzIpCTpC/cQdkQi6vJtzqjdM1AupPwrXkS/SHVYPxV4wHR/2HvX80J4QhwGKZpDsBqsBzlH9vY+WR2lkDYiXhgJK3cXrCA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2019 11:04:02.0365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c24075a0-d4e8-43e7-0700-08d72ba76f30
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1842
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose node with the name 'aclk_hz'

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 0142ee991957..e8d67395a3b9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -91,9 +91,19 @@ config_id_show(struct device *dev, struct device_attribu=
te *attr, char *buf)
 }
 static DEVICE_ATTR_RO(config_id);
=20
+static ssize_t
+aclk_hz_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct komeda_dev *mdev =3D dev_to_mdev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", clk_get_rate(mdev->aclk));
+}
+static DEVICE_ATTR_RO(aclk_hz);
+
 static struct attribute *komeda_sysfs_entries[] =3D {
 	&dev_attr_core_id.attr,
 	&dev_attr_config_id.attr,
+	&dev_attr_aclk_hz.attr,
 	NULL,
 };
=20
--=20
2.22.0

