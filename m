Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B0AECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1733120659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="2vj5XJDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfJOJtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:49:41 -0400
Received: from mail-eopbgr750120.outbound.protection.outlook.com ([40.107.75.120]:35041
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbfJOJtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXsaXeq1pnSkldjoD6f0uh7WPyTG0oN0pjxNhnUyFklLu1A76n6f7lpggsf4H3vFelUTMmF2sBg6blMf7hDi6u0Ewdt4IDfJxsU9cWhLTYTLSrXD7uv3/vxbcerklG3l/K/IbSoSjLy7V1P855mS/E8dcVIRmAM7RDDR0GQRa11uTO9zdQWsLA2MSw7xB8xO2HaEZWxVFCdQh8RwNIpy+dDee6JTaWaeebSuP6A4re5yQCHbP/znJn8+NaBvXZz2YA7D5Mas7rkdmn1SFQKbID/AwbzP3Jgs529cmBGyW87+k6dr9tEDZZVk80Rdt/qIh55sgdceJg5r601r+ENYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJmmb3/kA02j2b/YZsJKMMSbVVYCPaCWWFTYRzx8AwM=;
 b=Qa1a4rDz+aQIf4/Th2e6v+A32YhwXZrwv5E5eXHpP62UpVdg+GG9c0D+vGm02wr6CqxXqiLZFNekUR+tIB2epEWrNGpaS+yB3UXyzqCJJ64w7yqBeL5RRSB5V3Ufa/yScOG0q29x4B1XADzi6Tscue376KhLBCrSl6NHMOPPWawO/D6Kjb1rBTqE3ub5Pv+wgQz3jfm2r7UAOJh8UT7BIma5r+0UXA03kXACrEni/0aBjYIgsjrU3fqZUht/PUicvEbUiPMEtjj8jo2ViDubeP+FAaWLtqZxb+TpMsovtvN2VW9rD1H+mA8tK0PsPYtpyaWswQl7664P1Gw3XNO1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJmmb3/kA02j2b/YZsJKMMSbVVYCPaCWWFTYRzx8AwM=;
 b=2vj5XJDst3icMCEqZJq8DnVT3nfH+wzjtwzakmkUoA1O2ObQxZ2FSVGNeqJGYE8yu0CuJmA07nGh1emjiCgNSTbJSdf0IGLNFYOFrHOTCv8+y91aKFASWSVKBMaTgfaP04zB6HVZO1RTBys+5aTX5gsYQIBogeKJeOzbLWUC1Pg=
Received: from SN6PR04MB4543.namprd04.prod.outlook.com (52.135.120.29) by
 SN6PR04MB5295.namprd04.prod.outlook.com (20.177.254.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Tue, 15 Oct 2019 09:46:58 +0000
Received: from SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87]) by SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87%5]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 09:46:58 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v3 0/2] Add initial support for slimport anx7625
Thread-Topic: [PATCH v3 0/2] Add initial support for slimport anx7625
Thread-Index: AQHVgz18ii85ZkKQDUisjYsNOX82Bg==
Date:   Tue, 15 Oct 2019 09:46:57 +0000
Message-ID: <cover.1571132350.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::46) To SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a8::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d55dbdd8-6057-407c-060c-08d751549ea5
x-ms-traffictypediagnostic: SN6PR04MB5295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB529525E21321DA5E180F2AF8C7930@SN6PR04MB5295.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(53754006)(66066001)(6486002)(6436002)(107886003)(2906002)(4326008)(5660300002)(66946007)(66476007)(66556008)(64756008)(66446008)(6512007)(4744005)(2501003)(14454004)(7736002)(86362001)(110136005)(54906003)(498600001)(8676002)(8936002)(81156014)(81166006)(36756003)(7416002)(305945005)(99286004)(25786009)(71190400001)(71200400001)(3846002)(26005)(102836004)(2616005)(486006)(6116002)(186003)(52116002)(476003)(14444005)(256004)(6506007)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5295;H:SN6PR04MB4543.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIEwDS5kS6zsy/N6iTndnPlxXnN5CbhUNxjKxNI0iSP8pUZ9D3wd8lwjjcdzfsk4MrMWahppdH3oNE9Hm9/TIPr6wVr3zODxDHkq0SxhSfdzXMzjyDq9WAhNeN8KOyMKoUopOD3lA7T/HeB8ZyV7ZNDPj1aNmlF6nNmc9BY8z3E5q3UNPo7Xv/qymjkSRsQC4vgitj+yBRJVDgQbQy3GeEtdIyZMJLNSbU+8kVY8Rjhe/nT6XBNofIJ50ryrQLLNepvy4ZrR2Xnth88UR32/bNZBu6Q9GJZiUVSV5hCGUUzogEo50STuLeImsU0FNzRP+xU7575gdZtWwHbG3xD8xjvDoXTMFR9yVfe1BvpT6J6ipotoqb9ThY3sFsYfs08G9YgxYxJ96wO6FyJttFrvBw2OAb636x4Ug+IdBDztpoc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <193F035F439A9A419DFB4141B728922D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55dbdd8-6057-407c-060c-08d751549ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 09:46:57.9360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9Z4mjMpe/jcVqtvCuFWNXvq/R8gb2bcx+j7c9BZ0sm/2t/F0Rc/FUSWjHWi/+i21tjvoHv/AqQ/oJpy4h83mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following series add initial support for the Slimport ANX7625 transmitt=
er, a
ultra-low power Full-HD 4K MIPI to DP transmitter designed for portable dev=
ice.

This is the initial version, any mistakes, please let me know, I will fix i=
t in
the next series.

Thanks,
Xin

Xin Ji (2):
  dt-bindings: drm/bridge: anx7625: MIPI to DP transmitter binding
  drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP bridge driver

 .../bindings/display/bridge/anx7625.yaml           |   91 +
 drivers/gpu/drm/bridge/Makefile                    |    2 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |    6 +
 drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 2043 ++++++++++++++++=
++++
 drivers/gpu/drm/bridge/analogix/anx7625.h          |  406 ++++
 6 files changed, 2548 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx762=
5.yaml
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h

--=20
2.7.4

