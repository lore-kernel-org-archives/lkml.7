Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2127C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764FE2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IZUtc2kh";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IZUtc2kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfJKFnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:43:21 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:2370
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfJKFnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3exUIpO43eg+isG5bikJNfuF7PWKS/F5BOA9HkurNU=;
 b=IZUtc2khZ/YDHkOEW+lIEg7CQ7rvFd5l+9rs0fEmuU9669HxsDw9Bg2OzgBVfy+Rlsj+W8eHXl1QJm8OvxMUdVHId3Qz/uZQxPJxyhRQVowF2+egfSEWA7c/DC96Tz//PVEcpOMm8VsO3CE0uYtyplOBMgV74d+0JpfKdQxs1YI=
Received: from VI1PR0802CA0018.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::28) by VE1PR08MB4976.eurprd08.prod.outlook.com
 (2603:10a6:803:105::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 05:43:14 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by VI1PR0802CA0018.outlook.office365.com
 (2603:10a6:800:aa::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Fri, 11 Oct 2019 05:43:14 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT018.mail.protection.outlook.com (10.152.20.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:43:12 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 11 Oct 2019 05:43:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 20b2fe191d2f3947
X-CR-MTA-TID: 64aa7808
Received: from 5578faaff9c3.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0F2463F0-1604-4F40-9672-9614E8BEA0DE.1;
        Fri, 11 Oct 2019 05:43:04 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2054.outbound.protection.outlook.com [104.47.6.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5578faaff9c3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:43:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHqYLDqlplCkQ+bbQgCGG/wgpGEcx4hVUDVsndkOCXI0MJzDM3it4ZmjqAEQH8GO2ILdimckxzmBJWSyIeRcqx8B1kR0R+yJJzZDSr0x5PzLCy5s5Gxej/CCiyTCKGhJHJQvCfKYWYcRCoj7WWYRE0gRo2SoqNEd0FcvYMtbju1piReoP0t9FgUTqlaqYJ60AuqzApdP49uRx6VCRdyuuzAPW+mjopmoHFVHpLQTvVqS14TNNMTHyaZKzJLNpqaWnuhziUx4ZKyqM/200HHbgZuwNM5pW2/atW4fU1AzjhENPmkhh8n1ejuGiYVattgTxeLu/0bm/Rzqw9AVrktroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3exUIpO43eg+isG5bikJNfuF7PWKS/F5BOA9HkurNU=;
 b=OI+9YbQFEkyth4PYf6p4Mj5d2WBCdx420xH4a8pyTwSBVVqhAnh6M4Dgha6jkv7i65AnNoML72kCfvq/9DK56xrTGYmd6yBsOezyrc19sj2667ptyS65yjlHpvtIWGZcTHbLWHQ7QoXNICOHNzniAJUBSoHAnXhVkNwT6t0knBl1vWjURWk5OaCtgdZu6AtsX2onTbUYW13bJ2MjUWstifsizcqHaGjwcEUnRKXSVuOvZuH/uvO6qZW0YrNpBPwKtP0hFQWGhDkzu/cuVvL2sFhwXl9U70Xbe4SKKjiERIdoOeO4+vtfmAKZv7+jbFyt7C25Vtzrhej10mIOldNaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3exUIpO43eg+isG5bikJNfuF7PWKS/F5BOA9HkurNU=;
 b=IZUtc2khZ/YDHkOEW+lIEg7CQ7rvFd5l+9rs0fEmuU9669HxsDw9Bg2OzgBVfy+Rlsj+W8eHXl1QJm8OvxMUdVHId3Qz/uZQxPJxyhRQVowF2+egfSEWA7c/DC96Tz//PVEcpOMm8VsO3CE0uYtyplOBMgV74d+0JpfKdQxs1YI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5134.eurprd08.prod.outlook.com (10.255.158.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:43:02 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:43:02 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v2 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVf/a+U+eWgo62gEmtUPhfF5P9aw==
Date:   Fri, 11 Oct 2019 05:43:01 +0000
Message-ID: <20191011054240.17782-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1d4794ae-1a06-4cc1-11ba-08d74e0de7f4
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5134:|VE1PR08MB5134:|VE1PR08MB4976:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4976DB0A95C8965B8AC3BA6BB3970@VE1PR08MB4976.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(66066001)(486006)(386003)(6506007)(64756008)(99286004)(966005)(50226002)(52116002)(81156014)(6486002)(8936002)(81166006)(66946007)(102836004)(8676002)(305945005)(55236004)(26005)(66476007)(71200400001)(6116002)(3846002)(66556008)(6436002)(71190400001)(7736002)(36756003)(186003)(2906002)(256004)(476003)(6512007)(2616005)(14444005)(66446008)(6306002)(54906003)(25786009)(14454004)(2501003)(103116003)(110136005)(316002)(4326008)(5660300002)(86362001)(478600001)(2201001)(1076003)(2171002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5134;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Pv1KhBu9zJhx5wtxpaWCEaMYuUhyD3jUgPApX7kNpdyo8ETeui+LPxtsNdMokKTuHqGdjhPmBRGq0NYQEo8zwOUNLHmshgpX3JdkLuS6TTqjsA6V7OF3X31b3QWpVXQ8oiz3fL1KMuScoWG/722bmeQtKae8nqEB6WwH2THW5BHYYZHrnll0K96z37Smweqjm5qO/H6V9Qvq0+aVMaYzbGJLN6M40fX/j8HsHvuv9pXxHn3zGDfmKdL3B9UNKEJNad7AYfnHk9vNKiwIaNA+6ghpSZLknLxKlkHhQT3NoJn9cDkecLqkxmkwGFXbtXRvGb+pxJEErmVbaQN3bIsc9yQENhwpqad0OYeSM+GPrtPMzPtifxW7Juna6VvfdfnOIoGQO42HzmdxEN05PuqFCs8ZgIJ+D8nNiuBpV6q5IGZnOuy8dTFBrdEcI+PFi65GL5l6WKSI2MqmkN6I2iDfsA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5134
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(22756006)(476003)(126002)(2201001)(2501003)(5660300002)(6512007)(186003)(26005)(2616005)(86362001)(1076003)(8746002)(4326008)(2906002)(356004)(3846002)(2171002)(110136005)(6306002)(36756003)(6116002)(54906003)(6486002)(478600001)(50466002)(316002)(23756003)(81166006)(8676002)(26826003)(14454004)(8936002)(102836004)(7736002)(305945005)(6506007)(50226002)(386003)(99286004)(63350400001)(70586007)(70206006)(66066001)(47776003)(486006)(76130400001)(966005)(103116003)(25786009)(336012)(81156014)(14444005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4976;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d4b6b874-fdae-4051-b625-08d74e0de118
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOxYnXuSI9dqdEo9K2draaNVtRqcMatMR6Tq6BK7ETRPgvqJvJwFKEy41FjUiUZCgAKDJ4UxoxkLKKZWZthFBwJacsIf1uZInZigWh3R5gwgJuBHO1IMGASIkW4gaEzfeJM/PraOO+YrzLUGUGVpZg+DJ5oRgXbNaeZW9/LM9tPERpxjqlOmy8hfMhh0yuKSQR3aAK8g69kk5H2YA/YFOG4k0jjcn9AczTP3i2To3NVrqwJ9xvmKkM+qkQt49SmWkSecm1IfGxtJWzYX30TFg8xRj8aJ6+9nLaJR2j8JueBMs+oKfDOgOY4uXFip9jpX+FMNx/9rBtl9HC+c9HVm/6FI4XfLvnOkcZZLCkvaZ28q/5snWP5zbOItr5vf6s2kUrt6AwQpvqyYkiNOoIYtauCItvWlSWbDtdGudZLsIeeU3U+PcueBh3ZBDyWu12QGcwEDPikDYTx+GTrpoa9e/g==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:43:12.8807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4794ae-1a06-4cc1-11ba-08d74e0de7f4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4976
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enable CRTC color-mgmt for komeda driver, for current komeda HW
which only supports color conversion and forward gamma for CRTC.

This series actually are regrouped from:
- drm/komeda: Enable layer/plane color-mgmt:
  https://patchwork.freedesktop.org/series/60893/

- drm/komeda: Enable CRTC color-mgmt
  https://patchwork.freedesktop.org/series/61370/

For removing the dependence on:
- https://patchwork.freedesktop.org/series/30876/

Lowry Li (Arm Technology China) (1):
  drm/komeda: Adds gamma and color-transform support for DOU-IPS

james qian wang (Arm Technology China) (3):
  drm/komeda: Add a new helper drm_color_ctm_s31_32_to_qm_n()
  drm/komeda: Add drm_lut_to_fgamma_coeffs()
  drm/komeda: Add drm_ctm_to_coeffs()

v2:
  Move the fixpoint conversion function s31_32_to_q2_12() to drm core
  as a shared helper.

 .../arm/display/komeda/d71/d71_component.c    | 24 +++++++
 .../arm/display/komeda/komeda_color_mgmt.c    | 66 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    | 10 ++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    |  6 ++
 drivers/gpu/drm/drm_color_mgmt.c              | 23 +++++++
 include/drm/drm_color_mgmt.h                  |  2 +
 8 files changed, 135 insertions(+), 1 deletion(-)

--
2.20.1
