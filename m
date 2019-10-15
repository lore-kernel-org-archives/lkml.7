Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F1ECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F392067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="Pewc8SIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfJOHcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:32:47 -0400
Received: from mail-eopbgr750134.outbound.protection.outlook.com ([40.107.75.134]:37350
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbfJOHcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:32:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKZI31/XJ9M5v+c87rUBp28EOLpoX0pu3JxPZx6k9WyUnIQfhVDyR4WO6QCTqVX8NaL36h9xygIYoHFUXWDQXSPk2gO0pK7F5hbfTdo6RTKo6r1axgCwz2d7lUwTKbBZt/zDGGManssgiATZbClB2/F8Varx6c1xecAxPaxH6O1lOXPJvPqxHj97Mh7f5fYcG90VhSAQNnUeH1/Kl2Tk0WnP/urjSY9S41j3x6KtfbBY9ttM6fsvMNro93F/t6+C2kuFeo233jzbeeKdZxgP6Cu7PzQWDXvYOI67GxJvARdmNv9eOz1/Pu1rdXLEf9Nw1CYiBjsMiJRneridKT0fCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxM2xBzOznogq816Fd/DkVmgewkRZ4skTxXgmRS2uR4=;
 b=iJ2nCxHcJddvwXuijgBn/kGU1RmzGO0LDQpLDYJsD5D4CRxY4+NaRdDQRIpKpr5dOiKVe1ZjZOzmOBsso5P5vOd9tq+EN0V3pxRm16VaHDuSklP86o539IlXYlj0NI0fbswxqWyzTSsn76A8Oh+1OIaXOevmDZPR3WHKTxUlsq73maNc8l2NL/YkpS9ikrqbKV5oh1F7a7whys0Zu8VoiPmgvWgJLJ5M0qLzeUp7qYSEdlS06ZDzOYwEZwiU7986G1BpNpRAAkWUx5uN4PiwW87NC/3O8HJTVOZ+sKTsPEmpiiz+GXo3NX88NSX3RYx52P88oyNBGrnFLgdSDsq3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxM2xBzOznogq816Fd/DkVmgewkRZ4skTxXgmRS2uR4=;
 b=Pewc8SIHuXmI4TGIToutH4cRiw8COzsOygfxyoxNTP9qwPlrNzMYlMNFCuDE5KbYrjgQk311ZsmtfF2KYsMLyVrL5ebo3SH28knQS7ErAF6WU3n7dM/MRDXkwbtUJ9IJ/K+sxUYiw9ArQUmxoHthyYwlV0VGbOSSwxwHJMR8L5s=
Received: from SN6PR04MB4543.namprd04.prod.outlook.com (52.135.120.29) by
 SN6PR04MB4254.namprd04.prod.outlook.com (52.135.71.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 07:32:42 +0000
Received: from SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87]) by SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::c55e:6c70:adbb:cf87%5]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 07:32:42 +0000
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
Thread-Index: AQHVgyq7frv1r7c2/EClw9etHxQ/Sw==
Date:   Tue, 15 Oct 2019 07:32:42 +0000
Message-ID: <cover.1571124579.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::14) To SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a8::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e40d96ec-6b7b-4518-8f9c-08d75141dd66
x-ms-traffictypediagnostic: SN6PR04MB4254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB42547F7C2DE2D71669BE9238C7930@SN6PR04MB4254.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(346002)(136003)(376002)(366004)(199004)(189003)(53754006)(14444005)(305945005)(256004)(316002)(71200400001)(186003)(107886003)(36756003)(71190400001)(110136005)(81156014)(81166006)(54906003)(6506007)(7416002)(99286004)(86362001)(386003)(66446008)(66946007)(64756008)(14454004)(66476007)(52116002)(8676002)(8936002)(7736002)(66556008)(6116002)(6436002)(3846002)(66066001)(5660300002)(4744005)(4326008)(2501003)(2906002)(102836004)(478600001)(6486002)(26005)(486006)(6512007)(2616005)(25786009)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4254;H:SN6PR04MB4543.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8F5DORq26JuHfoP5xmq1knnzq2otPap3WjRGUxMwjDUFYuakl5H6NWXRuS/rrLNuLQg3mIAKJUq3rFzplNRdDDqicKOXIudED3cdeAIq/ZTbtkUL87/5My8GoqnRrnMkcApp5/pVqlyMTavPUZdNUmgYc3pOEOBD7SvY+wpzf6if0JJicf5YOVaw1/D/jNkHj2C+vqL0Tvk8xZooLlQR+fMHBFhFO6jTum/Q1Pe8vH1H9DR4pbZH0aZjDxAJiTAenEqMK3XFapYhKepXzW0WjKivMLlklyJSFloFT4/aKh7L+AhRleXeIyRusAq4ox1YUsrMYoNFQ8wBT4HICe8tqdgSPrzmoioYlF7TUqJamG1W7je4dVL+9w3B0OHU6VX6xf+osueKnzsUAAvUBQdokbMZEt8mvQn30SniS56/r7M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1F5EEFE5996F7449BAD78692D4F440A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d96ec-6b7b-4518-8f9c-08d75141dd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 07:32:42.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jMh7SJavo0CqVCxDkt0q9QNH1cJkRLlTWTkYuCOcjOQy7Gi3h5zyN6QFInVBY30pZlg6PX31iwo70nHafrwiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4254
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
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 2159 ++++++++++++++++=
++++
 drivers/gpu/drm/bridge/analogix/anx7625.h          |  406 ++++
 6 files changed, 2664 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx762=
5.yaml
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h

--=20
2.7.4

