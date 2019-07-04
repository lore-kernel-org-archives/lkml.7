Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F50C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936D72133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mbkFfmSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfGDGSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:18:01 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:30176
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPzfZbM8OzuukWXG8MI+OeDiGGOpEIbYpowB9n9Jlq4=;
 b=mbkFfmSHyFVvlf674eqXdl4AqTpNS0Y5HfqtPqQyGZe2WtsK9xnLNDikg8EVe6xEbGZ2h5vCb/4pzMepZyHul/o8kLXTtgyd47rW+NGWK9CtUUtfdZUJM1jJRxfemgxQvkmCPtovOLp/Sy8/nFeNb8duJd1qkr+k6KpNgr29wTo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 06:17:57 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:17:57 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 0/6] arm/komeda: Add side_by_side support
Thread-Topic: [PATCH 0/6] arm/komeda: Add side_by_side support
Thread-Index: AQHVMjA5MDII/vYZmUezDVlIyedfFw==
Date:   Thu, 4 Jul 2019 06:17:57 +0000
Message-ID: <20190704061717.6854-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9f02583-80b4-4f27-affc-08d700475b4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4637;
x-ms-traffictypediagnostic: VE1PR08MB4637:
x-microsoft-antispam-prvs: <VE1PR08MB463796A4283CFACE3D2AD538B3FA0@VE1PR08MB4637.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(99286004)(110136005)(14444005)(36756003)(68736007)(256004)(52116002)(102836004)(26005)(386003)(55236004)(3846002)(6116002)(6506007)(8676002)(5660300002)(103116003)(486006)(2906002)(54906003)(2501003)(186003)(6436002)(81156014)(81166006)(2201001)(476003)(71200400001)(86362001)(305945005)(7736002)(8936002)(478600001)(2616005)(6486002)(66476007)(64756008)(66066001)(66946007)(4326008)(53936002)(50226002)(66446008)(14454004)(316002)(73956011)(66556008)(71190400001)(6512007)(1076003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4637;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tO5faAHHfsRzx99LlbuSmjtDslv5QdMNGl/PjfYWcBS8qUL/qU5K6Cw66Ir9PeClFe4VIVNb+VW0Nt/+zIBkTWjj9hMbX1Nsi4t/YcWRCZqwYAt0zNlpBe2oVBgyFXHEVaU69cjj+Qhh2I0OO4HRbZjhBi2jtDHWuPzIH4vitSulK5nnBRT5s0ARsjCXZzUbAzl97Fz8xUW/YkL+KC3sf0O29hwLGEblXhyD22/1q4gK4Un2XxY75GONT+plKk6yOeDMU4syHtxTRFa1iBuU/cQEVHs9VXawwRrLQ7uWVvkhMcKsxSEsXxqc/lJmAStWWBVWdYjOtRlfsHI1+EZVYIk5VrI6CIMoV6SWzQkcLRXrU82Zwnztga2toIPe+cNDP3vtOELKqZfs0nwRIolAbMV1cErOng3k/aesFo6mZkE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f02583-80b4-4f27-affc-08d700475b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:17:57.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda HW can support side by side, which splits the internal display
processing to two single halves (LEFT/RIGHT) and handle them by two
pipelines separately.


James Qian Wang (Arm Technology China) (6):
  drm/komeda: Add side by side assembling
  drm/komeda: Add side by side plane_state split
  drm/komeda: Build side by side display output pipeline
  drm/komeda: Add side by side support for writeback
  drm/komeda: Update writeback signal for side_by_side
  drm/komeda: Expose side_by_side by sysfs/config_id

 .../drm/arm/display/include/malidp_product.h  |   3 +-
 .../arm/display/komeda/d71/d71_component.c    |   4 +
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  51 ++--
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |   4 +
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   9 +
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   8 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  50 +++-
 .../drm/arm/display/komeda/komeda_pipeline.h  |  39 ++-
 .../display/komeda/komeda_pipeline_state.c    | 277 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_plane.c |   7 +-
 .../arm/display/komeda/komeda_wb_connector.c  |  11 +-
 11 files changed, 417 insertions(+), 46 deletions(-)

--
2.20.1
