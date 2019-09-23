Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B8D21670
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="DNKcqyHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfIWJGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:06:14 -0400
Received: from mail-eopbgr780101.outbound.protection.outlook.com ([40.107.78.101]:4320
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfIWJGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7OiEdVAj/Ah2hnl1WBRI1LXuTYa4CiK9l+deS8mzVd1Pi+8PjOutsEUgQjmCRVBa1jktLjj4VsuBiewpkUMjT8ob5U8EcD7j/SMVVvQt7WBJ4WAK52I9CgdEnN+DFgXWvUBSSykKBPDKpGIzq+ZLbsbQWaAHopTYI6B/9LpjadFqOpP/MIMohqL9UPxr6M4E84hXnvZsfCqEZJvhtFDNxT27SwRzZbEvUiYdBUch2dw8DBg8rgh2OZRZFn5xiU/5k0p47okRt3mYmJ1ZNkdgjhL945mVY0wI842RJdSeeha5ERujt41V4zL7M1tRSDNPR+SA+xLlAs6qzrBC29VfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV0ml3WFUXu0uS2X/imI1vPjeOu2HMIMPSA8SnDvzjg=;
 b=Pm1Iv/Wh5EHOhNk7JI9Sq8lfVmmFqc/Vpw6Uh8c/txKVWXvg+Gi7xrTBZ5oQGRBErxObhWlzhi9gpKlgcT0uwbv+1iiaU1pTD/0+kOjNRSIdNMZGfYLYpy+WJWrxefqkQO8m4TUQbOnVDv0AmMFiFJLPwiuiNqMiYZc2i7iqRFJWQBV+by5ArFUYg8yoI22FNFc2+LvjpIXgdSXAZGI3VjaVVbxFQfa0LOnCaCSuxmZQyDGHZUAeuBfgskpAIffr3Puhi9rsoWW7B97bJzNHP1bOswtJ19G/g/GKLj612Smhr6rzzTxQin94vDcviBl3XC/PaIjQyRIz0SchYEdcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV0ml3WFUXu0uS2X/imI1vPjeOu2HMIMPSA8SnDvzjg=;
 b=DNKcqyHY/LqJrK4+KsylpWTCM8/rp69AOTIzrQ/MZZMg6pBMjxePHz3IZe4FuZtw0aNdluUOaT8yt1btyjxtfRXSVCJmOSgupgbQfIkySfQyw16hrH7wmG6sibK6X/c7xJPQqVZHDPuItffBEPsvgPZZczl32HcTycv0i6sDEqk=
Received: from MN2PR04MB5886.namprd04.prod.outlook.com (20.179.22.213) by
 MN2PR04MB6079.namprd04.prod.outlook.com (20.178.247.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Mon, 23 Sep 2019 09:06:09 +0000
Received: from MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::8520:f80f:ae9:63cd]) by MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::8520:f80f:ae9:63cd%6]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 09:06:09 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v1 0/2] Add initial support for slimport anx7625
Thread-Topic: [PATCH v1 0/2] Add initial support for slimport anx7625
Thread-Index: AQHVce4jZalL2j3UqU21V4teaUNI/A==
Date:   Mon, 23 Sep 2019 09:06:08 +0000
Message-ID: <cover.1569229197.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To MN2PR04MB5886.namprd04.prod.outlook.com
 (2603:10b6:208:a3::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5ccc297-ef6c-4c4a-a2a6-08d7400545e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6079;
x-ms-traffictypediagnostic: MN2PR04MB6079:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB607980494501E8A5ABE1C4DFC7850@MN2PR04MB6079.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(53754006)(478600001)(66066001)(52116002)(26005)(6506007)(486006)(386003)(476003)(2616005)(71200400001)(2906002)(186003)(71190400001)(102836004)(256004)(14444005)(6116002)(86362001)(4744005)(316002)(2501003)(99286004)(14454004)(5660300002)(7416002)(6436002)(107886003)(66476007)(7736002)(305945005)(54906003)(3846002)(66556008)(64756008)(66446008)(8676002)(25786009)(81166006)(110136005)(36756003)(6512007)(66946007)(8936002)(81156014)(4326008)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6079;H:MN2PR04MB5886.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /bnwyN9I4U0LrmdCh75NG3lFHiorpsQeinkCtlr85NpbRvNSsMfjGVL7Ia3WOqb8KqPUPOxtNJNuGNKy1Y/+fN2ZVTbDAEvaqIU3N2nRiY6bVZ0CWH0Uzl1GvoegkoDBKF9ecwY6Ma4p33CDX4pnTC2beKD5bPiO0YBcsBf+bdbmZBaxKs3RIbhRv5VIwJr+esZYhuSofJXsmDE5LMbMrMlpgT182bHMrq6b4jEiI6sSEXPukK1Hp8nU3KQ6FXvR06jbmMguFDZ94bV7bQ88sSLBDqICwG/WsaevOxNewBJx/06pAhRvy1gzirz3kHkDaJcw1UZlF3T07RXPpjJaWU4ww4yeJkw/DT8SGt85qAHRLB2vw/ttceyzbii8eHiE3/H6DDIolu9TMkMnF25LxctlZQKloUVtTtyp6lR6po4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0035C45673DBC429FCFC9688CFF8FB5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ccc297-ef6c-4c4a-a2a6-08d7400545e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 09:06:08.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFOw84XfZGbt4MdTjkXhjN4TI/3PcQlk0KpadEg19+sRaqihnftJIGv+b1hKpE/2N3CWF5vXeSZGM8DO0eORug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following series add initial support for the Slimport ANX7625 transmitt=
er, a
ultra-low power Full-HD 4K MIPI to DP transmitter designed for portable dev=
ice.

This is the first version upload, any mistakes, please let me know, I will =
fix
it in the next series.

Thanks,
Xin


Xin Ji (2):
  dt-bindings: drm/bridge: anx7625: MIPI to DP transmitter binding
  drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP bridge driver

 .../bindings/display/bridge/anx7625.yaml           |   84 +
 drivers/gpu/drm/bridge/Makefile                    |    2 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |    6 +
 drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 2110 ++++++++++++++++=
++++
 drivers/gpu/drm/bridge/analogix/anx7625.h          |  405 ++++
 6 files changed, 2607 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx762=
5.yaml
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h

--=20
2.7.4

