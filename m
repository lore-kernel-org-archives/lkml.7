Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E5AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89881218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="rukj2oPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfJJJbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:31:55 -0400
Received: from mail-eopbgr770104.outbound.protection.outlook.com ([40.107.77.104]:20961
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbfJJJby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+fjN8W0MF40MyMgExkDwXM5lg3OdWpYf37L8hswIqQfuWsN0ZZtAIeU6WpSOwXEIvTPKn7Q7mOywifU8gpDqUwEWjHaJ1jhE44VQXT/2Vxi52NqVcX4GJtuf7vjombfEbiXp+01JKNEQNvHH1tjbyUy4nJUiD5TPykbxeNElasgK44yz2sX3B4OxTIgYwqqQ1oy4jR4ndA6RAvvBWGzKJWmYZuouYkzpFRttUfIA5DGdvvusQRw5zxY0jiQhrjk151SUW8H1G5W4ULMNQXVFfH1p3RgBjMrraa7x3gHXO54XmbpOZ8/xmzZ/qehExF+vwfOeA2tEMEI7y5VchsdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMPvfG55FZUqtBg6uq+Nf2D/eTESknfNUSOnWMpsW5Q=;
 b=cKebEemjgleE1w6gd1wV4BstUQME1xUl69WR4k90PtpEvcTs3KjjPfxMGlG+AC5zkVlgHG4wrmuezkvJ5xXN1UqfeTPt+HEVBpOAho7i6sohw/8GDH5wX/mDpru8e0zCWo8aVm1Cgk8qOKunriPq0HZZdT340PmeRRPqQQLNe+zcpJKYEWgIT0qosaQAHxeS0HVrd2B5NvUJfyhnXX+kHe3llo4b7FXPQ00TMLtlP2WNC0/gEhJaUzLAaEMPLlh5ImEk8loBLU2zIIuyQ0NEtmeR9N96fdqFLiJYanYL8JDA6bOyEWNpP+i404dk/SFXXWtOsa63OaplDy+DuAlobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMPvfG55FZUqtBg6uq+Nf2D/eTESknfNUSOnWMpsW5Q=;
 b=rukj2oPXM+SC/zcECLFaZhCtKf+I9PeJdBeIDOACb8kRGPs8VXyAYjqAP1K22+gpvxKURvboudwxfB4AfycjaO4vsC+UM9IHIslz0mbVjTc7fsNjmDozmMCDYl0sQmSD3JMzsUG6JX3RPqbCEWzAQ3T6IP0U+ier/fOeikQVkTE=
Received: from SN6PR04MB4543.namprd04.prod.outlook.com (52.135.120.29) by
 SN6PR04MB5374.namprd04.prod.outlook.com (20.178.6.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 10 Oct 2019 09:31:51 +0000
Received: from SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87]) by SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87%5]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 09:31:51 +0000
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
Subject: [PATCH v2 0/2] Add initial support for slimport anx7625
Thread-Topic: [PATCH v2 0/2] Add initial support for slimport anx7625
Thread-Index: AQHVf02Lgtx0676fOUSsX2pXrX7r4g==
Date:   Thu, 10 Oct 2019 09:31:51 +0000
Message-ID: <cover.1570699576.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:203:52::30) To SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a8::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 593adf43-d261-42f0-e6ad-08d74d64ae1a
x-ms-traffictypediagnostic: SN6PR04MB5374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB53741CBB8E2E59BB3BF90C22C7940@SN6PR04MB5374.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39840400004)(136003)(346002)(376002)(199004)(53754006)(189003)(99286004)(4326008)(71200400001)(71190400001)(6506007)(14444005)(256004)(52116002)(386003)(316002)(305945005)(2906002)(7736002)(186003)(102836004)(478600001)(25786009)(26005)(14454004)(66066001)(8676002)(86362001)(6436002)(5660300002)(8936002)(2501003)(81166006)(81156014)(4744005)(6512007)(486006)(54906003)(110136005)(7416002)(6116002)(3846002)(2616005)(6486002)(476003)(66556008)(66946007)(66476007)(107886003)(64756008)(66446008)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5374;H:SN6PR04MB4543.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lu9lPA8AdBRq+fzdpGE0KCtNyxe8Bs886wV+6yHDQuCrGyO6pCpRx+7LYDTVzeE1agMH+G99cvqK1Usv98T1/3z8kIkyF2SfZvPDZMRpkDar2k1OPLC4xXA0ZA2dd8BmCZXGzoj2aolujot1QXkTF6LoXbvVDpcVFmgz/Q09pVS4FPTvuz9i+BPAmv9otDixiuLb2WmY/KfvlYjbrkF98mIF7/zSGcSHOmeBQUihm53r1CvfrutCuY2HJ2fEm8fBsD018Ao+DrY3rEtitlXGVm9RPz2jHDmLnlMq63JkbZAAmiWDPOl58JrNWol4QnU/qeYPpfDAGlAPr8IDrf3Kx09R0R51pPIOkvHVbwJo/8xBmgVLzO9CDnrdoHQY2DCgon1NOBIsZEDI+ikjoStq8SaQnRDl+cYjQQMTmjolZaA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0B40718F7C5ED4A8177B42D35AC70E0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593adf43-d261-42f0-e6ad-08d74d64ae1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 09:31:51.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkcuvLzHXpJSZDQdjv1oAB78qcudGcsNPEN1Rm4gjVK+jddTuE0OCUcEBq4rnLi4Zg+OxKF1wGf9S3YUJdr7+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5374
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

 .../bindings/display/bridge/anx7625.yaml           |   96 +
 drivers/gpu/drm/bridge/Makefile                    |    2 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |    6 +
 drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 2155 ++++++++++++++++=
++++
 drivers/gpu/drm/bridge/analogix/anx7625.h          |  406 ++++
 6 files changed, 2665 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx762=
5.yaml
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h

--=20
2.7.4

