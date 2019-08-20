Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0150CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A94A216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="s3DlH9q5";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="s3DlH9q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfHTPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:17:18 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:42703
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfHTPRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzEqZ7CC9OoVY5Ey3yEm1NH7WJvxczad09nO/5ZPgi0=;
 b=s3DlH9q5uwjw0KdoIRo5/vBLN1DE0fVvaxLWRdyqg/KG6ZClB5dEerBzfeXwFo/vY56dTtk93UVvns0/YI8yaDFu+iZHrgnnM5XbDMSpJ7I3x0SFzyEZeXCLYsUNX5XowYs7TkZfLMpDDRVALBQ9ZV90iI9c/Wsar9B1LNaT3sc=
Received: from VI1PR08CA0256.eurprd08.prod.outlook.com (2603:10a6:803:dc::29)
 by AM5PR0802MB2595.eurprd08.prod.outlook.com (2603:10a6:203:a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18; Tue, 20 Aug
 2019 15:17:12 +0000
Received: from DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VI1PR08CA0256.outlook.office365.com
 (2603:10a6:803:dc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Tue, 20 Aug 2019 15:17:12 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT057.mail.protection.outlook.com (10.152.20.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Tue, 20 Aug 2019 15:17:11 +0000
Received: ("Tessian outbound cc8a947d4660:v26"); Tue, 20 Aug 2019 15:17:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 16b669ec263041b4
X-CR-MTA-TID: 64aa7808
Received: from 96d95517a1a1.2 (cr-mta-lb-1.cr-mta-net [104.47.5.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E43D436E-4F98-4309-9A8F-E1AB5297BC29.1;
        Tue, 20 Aug 2019 15:17:00 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 96d95517a1a1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 20 Aug 2019 15:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3ceUuh0xU513PtpLtJ2DKNAGkEgo8/zep/q42Wh0iYaVmTiiOzBS+Mgx/GmE9HWrJKptIP4B4s1tmyozD/SiudXTdspUw/5dxxBuQY61ma+vveqNPhIcI2s5rPdqrrJhB1qQJkpBkW6tYUPljkB8rbkbyJmNsAUvc/EEltMXnTDO2loZxxMH+Jv+aeSm/rFjtnlzRbGpnLC7zMXTxXnn4o4NusV8TV5aiXTvfDGSXwlFEQpY4CC4bIsgWa/joJALghqF0JjzF3Gx3S2TRQuQV4/bCFTUBSJnRV6zMug3xzorG48LmdpnnZmKVNTUZhJ75ykVl/U3ZlcIdh9i+mTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzEqZ7CC9OoVY5Ey3yEm1NH7WJvxczad09nO/5ZPgi0=;
 b=O58Usro5a/PUA4WhU0KoQLcodhF7LSgTcKblMu5m8NFZKtuXsRDRix1gaQkX08MjFfD18i5k7ijoUhno+85AVQgQDN1BH5lrcyJ/LybYEvGaz0qN8Fv20N1gUMTcRcOXBZbJztaSN9kvugONW8xlgAHLDrycQPsqGiPcxZvh+UP556cT9axMjvytmwWPskFMJ+jmr+nOY5K9vVffagFNdSV5H5jTn8c0snDChysx3VFp0fLjPpLF2t0M2pYj3d/3AR9y2re1ZJkykkfi72KCpQL2FfSGu0sTo8kBf922wt+lOk5As4SubtmzmfRiF01uQ7d/q5djxu3Qk1DoMpGALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzEqZ7CC9OoVY5Ey3yEm1NH7WJvxczad09nO/5ZPgi0=;
 b=s3DlH9q5uwjw0KdoIRo5/vBLN1DE0fVvaxLWRdyqg/KG6ZClB5dEerBzfeXwFo/vY56dTtk93UVvns0/YI8yaDFu+iZHrgnnM5XbDMSpJ7I3x0SFzyEZeXCLYsUNX5XowYs7TkZfLMpDDRVALBQ9ZV90iI9c/Wsar9B1LNaT3sc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4477.eurprd08.prod.outlook.com (20.179.26.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 15:16:58 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 15:16:58 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Add missing of_node_get() call
Thread-Topic: [PATCH] drm/komeda: Add missing of_node_get() call
Thread-Index: AQHVV2pPVPebZtWZiUahUiy3IZo+Pg==
Date:   Tue, 20 Aug 2019 15:16:58 +0000
Message-ID: <20190820151357.22324-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.22.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 72a22954-36dd-4be7-0b99-08d72581796a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4477;
X-MS-TrafficTypeDiagnostic: VI1PR08MB4477:|AM5PR0802MB2595:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB259522A6FBC57FEA2A4578568FAB0@AM5PR0802MB2595.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:30;OLM:30;
x-forefront-prvs: 013568035E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(6116002)(256004)(1671002)(2906002)(6506007)(14444005)(186003)(54906003)(478600001)(4744005)(26005)(102836004)(66446008)(7736002)(71200400001)(305945005)(66066001)(25786009)(66946007)(64756008)(6486002)(53936002)(66476007)(71190400001)(109986005)(66556008)(36756003)(50226002)(6436002)(81166006)(3846002)(6512007)(5660300002)(81156014)(8676002)(4326008)(386003)(14454004)(44832011)(52116002)(2616005)(476003)(316002)(86362001)(8936002)(486006)(99286004)(59246006)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4477;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: xdXJ73KPUk7mNIXgI6RrSpGccvOTiyyKcUWYTixMmj2AQrngfuJt7NPiucaC+N6oIsu1aNIlidb/SeZxNuxL4SdI1iCtOdxt/XZFc8txJK5HQ/MPZFF4ZiA8+ttc+sDEyy/eWQXnNKhizhsf8te0ig57jjsXEVSd721m/gIih42XXVs/N3w9/3S/CHpXPptVtyfFFyY8vprzZXLSu3IzCZemh8JOZjaQh0FUEhsd0HKNpetLO6ylgO3XINIZ4RZoAO07NVuaV6JdH8P9N40c9aNyRNltHhyAM4ixMfFXup8oMMJC0VEprUNFX7dSn6psDHnELoOBhz9chcdPTWt3i18ITy4Ty8S2B5kAM2QsleND8WJC4YlrIxf76T6FRR0sND6e3q1p9Hbx1PysXwtArehHuAHJRrjGnEvYIz+6y08=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4477
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(199004)(189003)(25786009)(63350400001)(126002)(63370400001)(8746002)(70206006)(70586007)(14444005)(2616005)(476003)(6512007)(6116002)(23756003)(4326008)(186003)(3846002)(99286004)(6486002)(356004)(86362001)(102836004)(66066001)(1671002)(26005)(336012)(54906003)(50226002)(8676002)(8936002)(81156014)(81166006)(47776003)(316002)(50466002)(14454004)(2906002)(26826003)(36756003)(22756006)(486006)(1076003)(6506007)(386003)(4744005)(5660300002)(305945005)(109986005)(7736002)(76130400001)(478600001)(59246006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2595;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8b57ba38-c0eb-484f-0e7b-08d72581716d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0802MB2595;
NoDisclaimer: True
X-Forefront-PRVS: 013568035E
X-Microsoft-Antispam-Message-Info: X4Pa2vdDlo8sWq1aRlhlMgGUGcxwor6E9R+74IxKdgat7lG/exH/wvbNeSVSQH2sk3s5/xWLW/Oww8/CJR/8l/Ei4BsOWEanYF/J6RxFKTXdgPxS5huFyGWRgZYweRcdwpiyBksOX7vGaiENF1828jTOxEy+YteJaRUum+m6D1Wo+ACKz3IbOdj4VyPKCCAzIviyZFhTlKJv75ix4sRFZcZUJTMozjaxslwNl0sFcZT7OgxEofBA3NZucy2ezjENgwdgf0a8Ba5iICvs5Kn3CdJa4MZiA59hQfRzvexB8ki1ppl9kXwFk37YspWLUH26kcAhKEOfvMQ4PJ7wc4T4sWVVvwTB2tF16AvS/LwJ/DM1Qyn1ZkddiI0ezGkM6f7SNAnb/P9gGRmiRsGf8NdB+sGd412qw7tAIw9KkllyMk0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2019 15:17:11.3665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a22954-36dd-4be7-0b99-08d72581796a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2595
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

komeda_pipeline_destroy has the matching of_node_put().

Fixes: 29e56aec911dd ("drm/komeda: Add DT parsing")
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 0142ee991957..ca64a129c594 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -130,7 +130,7 @@ static int komeda_parse_pipe_dt(struct komeda_dev *mdev=
, struct device_node *np)
 		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
=20
 	pipe->dual_link =3D pipe->of_output_links[0] && pipe->of_output_links[1];
-	pipe->of_node =3D np;
+	pipe->of_node =3D of_node_get(np);
=20
 	return 0;
 }
--=20
2.22.0

