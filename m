Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DBDC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B6521850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cxk323EE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGDGau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:30:50 -0400
Received: from mail-eopbgr50040.outbound.protection.outlook.com ([40.107.5.40]:41974
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA9r2LAEqNmQCjJFLocOWL30qRGVdGyGxVj95VNJ/Do=;
 b=cxk323EEEgaQyZDv+l8kjfGFaRUTSelx8ZjegVIBm0ZlLNEl9nEb/Z1WuvLaoScVwntx9ouZRoNtcPu77t6Z3ELzdoUQQr09e2/92yFOnLtAIgm8ZBJe+BuqwJjqIVLbzOToPD75uMY8IZQpcqP4xCf/tRR9EfGcqoAT/GiBlo8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5229.eurprd08.prod.outlook.com (10.255.27.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 06:30:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:30:46 +0000
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
Thread-Index: AQHVMjIDC/ZcHd3edEanzROZCyvHmQ==
Date:   Thu, 4 Jul 2019 06:30:46 +0000
Message-ID: <20190704063011.7431-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:2e::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a969773-981a-4a5b-f69d-08d70049258d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5229;
x-ms-traffictypediagnostic: VE1PR08MB5229:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1PR08MB5229AC11A06FF7475B7A2F5EB3FA0@VE1PR08MB5229.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(6506007)(66066001)(110136005)(386003)(54906003)(103116003)(2906002)(316002)(186003)(86362001)(2201001)(52116002)(55236004)(99286004)(26005)(102836004)(6486002)(50226002)(25786009)(478600001)(71200400001)(71190400001)(6512007)(6436002)(6306002)(4326008)(68736007)(53936002)(14454004)(2616005)(966005)(476003)(486006)(36756003)(81166006)(8676002)(256004)(14444005)(81156014)(8936002)(305945005)(7736002)(66946007)(6116002)(73956011)(66476007)(66556008)(64756008)(66446008)(3846002)(2501003)(5660300002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5229;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fWMASs9OPmis2MdD3Y/pkkNKMlfFX4fXI9Nh4wl7x/y1gvkYO7iPghoFQgRAjHKS20dDr5hvztpeGpMAoGDrNYuop2AzaC7wVBIfhJMyxCVKg90T0f/f26Eafsn88mUJl2yPl/DuWAw22LhII+dVjShi2AwSgw4xna2Vd8UJaPF8OnwEzwDNq121dBu0+TcgkR6ZYttMJt/mqTNevCgQiUINLr9bff0anAbZ2MLVgUQbvZmGXPyQSJu03TZF2onlMBdaTswM31LyIWL8OJXKXeFZPXHcjueM7DVJX2YJqQeYwDE+ocUuIweH+AXEDJdoPGX+2sXHkMZ9utvEdY8Y1PaTiHaVSAw+m1PG98JH0icQhyKJiFuvhkIIR5iVWWu1F8EImWaRJaBk0nWj/bS96110KBL4U0ht7HXHh7tbB24=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a969773-981a-4a5b-f69d-08d70049258d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:30:46.2036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda HW can support side by side, which splits the internal display
processing to two single halves (LEFT/RIGHT) and handle them by two
pipelines separately and simultaneously.
And since a sinple pipeline only handles half the pixel processor, the
main engine clock requirement can be halved.

The data flow of side_by_side as blow:

 slave.layer0 ->\                  /-> slave.wb_layer -> mem.fb.right_part
     ...         -> slave.compiz ->
 slave.layer3 ->/                  \-> slave.improcessor->
                                                          \   /-> output-li=
nk0
 master.layer0 ->\                   /-> master.improcessor ->\-> output-li=
nk1
     ...          -> master.compiz ->
 master.layer3 ->/                   \-> master.wb_layer -> mem.fb.left_par=
t

Depends on:
- https://patchwork.freedesktop.org/series/62280/

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
