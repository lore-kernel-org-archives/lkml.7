Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C8C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2315207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="HlgcVhy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbfISKsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:48:47 -0400
Received: from mail-eopbgr740121.outbound.protection.outlook.com ([40.107.74.121]:27920
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387520AbfISKsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:48:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQTouy6eUKRRUktgATnJBZPemHH9vhzSatA6L4xVJl1ZoZxZBODxPzAiFjik0XJUwSG04DO+YrTYdwgwl2IwuEXcMKZhCW7fRFZC7fLx0hKHR19sCCnl0LLlBnbbQrn+7huLXxky26KMnS5hT5J2yLNj8hSxvTiqPv/EC1asVNAotkG7SIG2klo5ySzW1mr6NdGJT8E0DZWJlsDgxNU6qEEB6xADkiiBMV8cAjrC7/9c253GxYx0hSeo4hfI5Ove5EbGUP9tGtJ3E4egmQlVoTZPwChAc3kf2j3o4XB9Ps1eyqap2EK5dtJPNaiG2VvgioxhuEaS4cq60YVIJvREPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnviiPQztF2wMhw8UUZtUuwkxVKisF9/Tz/Lv4RZuOA=;
 b=VGOhGNxj9rQz6SLMybVPyZjlDHJMBwZHpQ//NWCSAyUYQXbmr9M9OyQcK0EYTQTj+g0W6fHD+7TEkDp1CHZL6mK30UGVKYbL3OLyxKbN7f5qxpuWsi4codcFrOPgejfoVS9xAa7ENVD3Af4RZNEhwyePN0lhjy+TEIAJBGOO7nQH5+MnMsNqOBa6TfbhwIN27X9CYNRTD0aHaM6a96HLtJ5huvn1flHK92t2RuO3R2XNOvs7fHcF9hJWflirld/1HCvimw078Ji/RGvtxIjKXUhVyoeJg4ncnrTNozXKTrcrwDitnzF+tzoFaZ3P8+mXL/fUWjnw9ZpIUgLaCA9XPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnviiPQztF2wMhw8UUZtUuwkxVKisF9/Tz/Lv4RZuOA=;
 b=HlgcVhy2o9lGl9AHUSheXsCIPlx2VfbOn9hxIi6cSOqXOiB2Yr1998JjCdzQiv4dIUt2aIr9hWL9QfnVPewhJRaX4echgpnZf39Rki5FRAkA9aigJMnHJAXkU4fIbfBrgavCNK4mWVgcQNYGZSvEQfjI27/OCU6yY7JZNNX03Pg=
Received: from MN2PR04MB5886.namprd04.prod.outlook.com (20.179.22.213) by
 MN2PR04MB6861.namprd04.prod.outlook.com (10.186.145.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 10:48:42 +0000
Received: from MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::8520:f80f:ae9:63cd]) by MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::8520:f80f:ae9:63cd%6]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 10:48:42 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v1 0/2] Add initial support for slimport anx7625
Thread-Topic: [PATCH v1 0/2] Add initial support for slimport anx7625
Thread-Index: AQHVbrX5ZBWm7ngGmkilFiHXsbIhDacykSyAgABA+IA=
Date:   Thu, 19 Sep 2019 10:48:42 +0000
Message-ID: <20190919104833.GA30631@xin-VirtualBox>
References: <cover.1568858880.git.xji@analogixsemi.com>
 <8bb69c72-50bf-c499-ff92-9e3662b4fe87@baylibre.com>
In-Reply-To: <8bb69c72-50bf-c499-ff92-9e3662b4fe87@baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0011.apcprd03.prod.outlook.com
 (2603:1096:202::21) To MN2PR04MB5886.namprd04.prod.outlook.com
 (2603:10b6:208:a3::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40cdd32b-6061-4148-ddb4-08d73ceef006
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6861;
x-ms-traffictypediagnostic: MN2PR04MB6861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6861296ED3913D699C4D3F81C7890@MN2PR04MB6861.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(366004)(39850400004)(396003)(346002)(53754006)(199004)(189003)(7736002)(6916009)(1076003)(486006)(6512007)(3846002)(186003)(6436002)(14454004)(6116002)(6246003)(229853002)(11346002)(5660300002)(386003)(54906003)(53546011)(476003)(2906002)(8936002)(102836004)(107886003)(305945005)(26005)(14444005)(6506007)(446003)(66066001)(7416002)(86362001)(6486002)(256004)(81156014)(478600001)(316002)(66446008)(9686003)(71200400001)(33716001)(76176011)(71190400001)(4326008)(99286004)(8676002)(25786009)(81166006)(66556008)(64756008)(66946007)(66476007)(52116002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6861;H:MN2PR04MB5886.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dymHbQKjO4hSuVaR6UkRsts+cUlPgc1YaM6SLeKjCJuyl4vFdP0bQY1ev2/QuyhPpGYGLcfXukYEDGQ8I8G20KLvvUsqq9hF6eU5k2oU7TPJ7pUciGywHmNkhP+XGFgWQoS/ib6Eb8KExATQruOsE+6FfNYZeLafTQsSSDzqgyStqWhWYS4u6lEXUuVh9fxmAtMc5d/DJ6IxdatPEomweG3saMpFZS9yfTsmB7Y3jn6eU1mAc9RtPnK2ac/my7ThigPHFQrFSMJ5mdY6qmyAG1Cudt9/lADPDCfI3KSoxz2/EQQ6L+V2yp5UulaDWRYX4ol+WuotSYKfcUBG2W5O2LAai7jv/YQo/QD4iyIqKt5/EdvcV8GFyLtxxy9BlYmK/uDHBFFmu9TH8mLJKSTCBcmkU4WBADdQtUDJEDxOuz8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96D1184EF9664145ACC2E445F4D00A84@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cdd32b-6061-4148-ddb4-08d73ceef006
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 10:48:42.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJywVg77r63RDyezTwIqUYBbrQP7vRY9YJKEIfj1NIfV2Y2RuNTluwbAHPsvMlzP3+2UCZkHf+lNNg7MT5gOug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 08:56:01AM +0200, Neil Armstrong wrote:
> Hi,
>=20
> Please Cc dri-devel@lists.freedesktop.org
>=20
> Thanks,
> Neil

OK, thanks.
Xin
>=20
> On 19/09/2019 08:51, Xin Ji wrote:
> > Hi all,
> >=20
> > The following series add initial support for the Slimport ANX7625 trans=
mitter, a
> > ultra-low power Full-HD 4K MIPI to DP transmitter designed for portable=
 device.
> >=20
> > This is the first version upload, any mistakes, please let me know, I w=
ill fix
> > it in the next series.
> >=20
> > Thanks,
> > Xin
> >=20
> >=20
> > Xin Ji (2):
> >   dt-bindings: drm/bridge: anx7625: MIPI to DP transmitter binding
> >   drm/bridge: anx7625: Add anx7625 MIPI to DP bridge driver
> >=20
> >  .../devicetree/bindings/display/bridge/anx7625.txt |   42 +
> >  drivers/gpu/drm/bridge/Makefile                    |    2 +-
> >  drivers/gpu/drm/bridge/analogix/Kconfig            |    6 +
> >  drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
> >  drivers/gpu/drm/bridge/analogix/anx7625.c          | 2086 ++++++++++++=
++++++++
> >  drivers/gpu/drm/bridge/analogix/anx7625.h          |  397 ++++
> >  6 files changed, 2533 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/an=
x7625.txt
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
> >=20
