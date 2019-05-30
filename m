Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4535DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188D925117
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oR8V5EBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfE3Icq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:32:46 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:60480
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfE3Icp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi54/Wsb2EELtCPVtGgRW8DWCkW3wAB0JnotLKVG+Gs=;
 b=oR8V5EBDtL7fbUySSjtUo+BZWIhQsw1Yjy1MPQf3Qip+d6FWtvSBNKbabIu5eFkb5S1vegNq8zbX51dTnIDICwbH7u78KDT42e9SUm9w4jJZTi9AmN72+H6qF6AmdarXe8E7FEAS5fo0lCvU0ZE1aFCrjCNr+OY2U1FWs3THJUo=
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com (20.177.51.203) by
 VI1PR04MB3085.eurprd04.prod.outlook.com (10.170.228.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 30 May 2019 08:32:41 +0000
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::5141:a777:e2ca:f736]) by VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::5141:a777:e2ca:f736%3]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 08:32:41 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/3] Add mclk0 clock source for SAI
Thread-Topic: [PATCH 0/3] Add mclk0 clock source for SAI
Thread-Index: AQHVFVgpjX4j9HD02UiVNkRH/YGV5aaCuuaAgACe54A=
Date:   Thu, 30 May 2019 08:32:41 +0000
Message-ID: <fe755bc76ac7226790a7db6ab025db04fcd6d8d5.camel@nxp.com>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
         <20190529230357.GB17556@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190529230357.GB17556@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b68ef5d0-529e-4384-ffe3-08d6e4d961d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3085;
x-ms-traffictypediagnostic: VI1PR04MB3085:
x-microsoft-antispam-prvs: <VI1PR04MB30851DECD84980EA92A83E5BF9180@VI1PR04MB3085.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(66066001)(71190400001)(6246003)(6506007)(118296001)(71200400001)(76176011)(25786009)(66946007)(256004)(6916009)(76116006)(102836004)(66476007)(1361003)(316002)(6512007)(99286004)(229853002)(73956011)(44832011)(1411001)(2351001)(68736007)(4744005)(53936002)(186003)(14454004)(2501003)(478600001)(54906003)(6436002)(6486002)(4326008)(2906002)(486006)(2616005)(476003)(36756003)(446003)(11346002)(66446008)(7736002)(1730700003)(5640700003)(66556008)(8676002)(3846002)(6116002)(86362001)(5660300002)(64756008)(81156014)(26005)(305945005)(81166006)(8936002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3085;H:VI1PR04MB5214.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aeMVxTvOmwFeMyJ8V5lJolWb9AmL4hwvVn6eE+NdffmxoDeDcBnsNyvdIvy3HBitSifmbkDCV5hnTSLmikTY9F4hmcoWcsaztbNjk4oEEtw9hWqNDoFVznaDHDmp/qbMpIB0J0DlIbqXDrlsFgftuKx+qi9DrA1lLqt4tYDvbtrGkQROODGnYqUChp2WLk6mt64ROZteqJ+fNQ0zcxiCPrS1iIvCKNtP1819FbLJt3NE2a975tZlzTL/iRcDyQ6eG8wy22OGPCS1ZPN3fEsLbVyUIGj13a0SWqxZrB+U/4wh//e9RN6u3i7VP2Njmo+R81CZRPESkRMLkOH6oRzxgvFH5VVh39umhB9Zrh/QxQ8XFpOXPbbkKzVj05tkb2s+j5H5KtikwrxUeeBK+cG5N3G43hGbMUvKv0s1coWborA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F4BDF9EB712444AB8F6F83A9950F048@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68ef5d0-529e-4384-ffe3-08d6e4d961d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 08:32:41.8687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daniel.baluta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDE2OjAzIC0wNzAwLCBOaWNvbGluIENoZW4gd3JvdGU6DQo+
IE9uIFR1ZSwgTWF5IDI4LCAyMDE5IGF0IDAxOjIwOjQ2UE0gKzAwMDAsIERhbmllbCBCYWx1dGEg
d3JvdGU6DQo+IA0KPiA+IDEpIFNBSSBjbG9jayBzb3VyY2Ugc2VsZWN0IE1VWCBpcyByZWFsbHkg
cGFydCBvZiB0aGUgaGFyZHdhcmUNCj4gPiAyKSBmbGV4aWJpbGl0eSEgV2UgbGV0IERUIHRlbGwg
dXMgd2hpY2ggaXMgdGhlIG9wdGlvbiBmb3IgTVVYDQo+ID4gb3B0aW9uIDAuDQo+IA0KPiBJIHRo
aW5rIHRoZSAiTVVYIiBpcyBwbGF1c2libGUgY29tcGFyaW5nIHRvIHlvdXIgcHJldmlvdXMgdmVy
c2lvbi4NCj4gQXMgbG9uZyBhcyBEVCBtYWludGFpbmVycyBhY2sgdGhlIERUIGJpbmRpbmcgZG9j
LCBJIHdvdWxkIGJlIG9rYXkNCj4gdG8gYWNrIHRvby4gSnVzdCBvbmUgY29tbWVudHMgYXQgdGhl
IGR0cy9kdHNpIGNoYW5nZXMsIEkga25vdyB0aGUNCj4gZHJpdmVyIHdvdWxkIGp1c3Qgd2FybiBv
bGQgRFRzLCBidXQgaXQgZG9lcyBjaGFuZ2UgdGhlIGJlaGF2aW9yIGF0DQo+IHRoZSBtY2xrX2Ns
a1swXSBmcm9tIHByZXZpb3VzbHkgYnVzX2NsayB0byBOVUxMIGFmdGVyIHRoaXMgc2VyaWVzLg0K
DQpUaGFua3MgZm9yIHJldmlldywgd2lsbCBmaXggaW4gdjIuDQo=
