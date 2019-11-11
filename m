Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C5C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC75206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RzvavtsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKAzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:55:10 -0500
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:60907
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbfKKAzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 19:55:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaF3SIqI89nwfDYcJ0gJ4q33deveIDKWBROshoUrCAnB+kbcDnUQ7YDqdQRqeTkhr+yWff/suLaz1QFfKY57lwD926ZHNNoFIhA8CQxaSrkcAoWLEb3C4xHTzZJfGUdhyK0aS/fNdvrXecFePuerxOVr0FPde+ulkPmoJeDqPShKqzxNYDh0j4PDcRy4SLIQNE0lBSHVPyBEGfHEGZIXpQE5qWjTfEWR34BdL6OakxGd1kkJsIoQ9io4ncBK1v2H14KiEUCOPpCGB8Ju9L7pK/BfZuQ21+vJDbnbWD61ergmtHxjVLvVJkWz4zvzzW4zNh8sdRr46Cg2aFN1C5feRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOW3sIz5zgrPDXyA+fA9+c0yjKPHzUqVOc1kjDWei/U=;
 b=iXaM+tBv8N3IR72XpYC2zZFp8ehqPXdwvILSBHmV4+h7J0ospM2UGE6LcehcLcRQJ1dfuT7KJT9LzEcDjj9Kpqj3Mjx94iD7fkLVpBeewtKAAlAsEuwW5DhCEPQow0WDQNuBmk0rVrJ0xa4nUWPyT7Qo+aZ7vN/93v43fDvH+PEFQr00vLzW3JH21RnSvVWfnoz/Mw1edOco+9DlZi30iNfwovBYydYR6eHTX5AAx0AegLLuURJzibMJ8CBnTKxzq4q70p3UyBZUl11pWiydEGlmSQyidRN3uJdIWH8yFozpK561HI2RITJWR/qN4d9HVbAIpi3YwQRFtZi30Dvs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOW3sIz5zgrPDXyA+fA9+c0yjKPHzUqVOc1kjDWei/U=;
 b=RzvavtsZfqQn52x7qakjMFIoR7WKDQdKnQfo0ghdPRSyQhVrVg4nKhnb/NVljDVfW4ncfM36kOXBFzFvfEmF0QWteqD9AKi4Z2h5ZuvnldXZn8CW4DCqv2xOIntbvzibmjPuPJGY8ZlP6ApF6e+xWUViQNiHOaS8/IPOZ0KPl90=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 00:55:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 00:55:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?utf-8?B?U8OpYmFzdGllbiBTenltYW5za2k=?= 
        <sebastien.szymanski@armadeus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/4] ARM: dts: imx6sll: Update usdhc fallback
 compatible to support HS400 mode
Thread-Topic: [PATCH V2 1/4] ARM: dts: imx6sll: Update usdhc fallback
 compatible to support HS400 mode
Thread-Index: AQHVlRA1L7s8cMO6lkuva14Mm0YPYad/2TYAgAVRwyA=
Date:   Mon, 11 Nov 2019 00:55:05 +0000
Message-ID: <DB3PR0402MB39160A87354A68AAC2AF72DEF5740@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1573092393-26885-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CiR7-YmAUggdt9rdZpNYKzQTFY5zGGGQ2k06Qc7pkg_Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CiR7-YmAUggdt9rdZpNYKzQTFY5zGGGQ2k06Qc7pkg_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 307f14ff-eeb0-4cb3-66f4-08d76641cade
x-ms-traffictypediagnostic: DB3PR0402MB3738:|DB3PR0402MB3738:|DB3PR0402MB3738:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3738C07934B5CC0AEB54D699F5740@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(2906002)(7736002)(7416002)(14454004)(76176011)(305945005)(1411001)(74316002)(25786009)(81166006)(81156014)(44832011)(8676002)(86362001)(229853002)(7696005)(476003)(486006)(11346002)(446003)(33656002)(8936002)(9686003)(6506007)(316002)(4326008)(53546011)(54906003)(26005)(66446008)(99286004)(64756008)(66556008)(66476007)(66946007)(55016002)(6246003)(71190400001)(71200400001)(66066001)(6436002)(6116002)(3846002)(6916009)(478600001)(14444005)(186003)(15650500001)(52536014)(4744005)(5660300002)(256004)(102836004)(76116006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: veFvtGsuWUhXKmT4hEBycOdTotlCENRbXSuFaytGDACfzorQ/Eg7ENVOyixHtr39aRd6rY6Xulc0Xo4Wq5iLClcOUxSJAKawrAVhT5JTUDfqSTf9FWGZQYeskyn8KVvMKzwHAK3aOt9eyBhZI2f7+a6QwQ+g74XTlNgytIayhtLrIKjed7BSMbPKUHDT2tgBJAylbjRX7YWkZJ2Dlt+pB1MvatLNPJL4cm0hNr48K1v8tBCkXPDAeaj/OJQVpaxsEZsJjOTk/mgZN0TQjiRNUhmPSscYIc+/g2zy4aLNSQWKN16Ut2CvmeyPDV0h2+5gxvmv3pMNG620lvSaeGErDtQ6izmxgvZPcEqWO/U0O/QA6dXu3T7m2u4MPRIoXpLTX9VRAiNqNwrFMYc5aKgh/va/C3YALdVF71TU4AXIUTiZQRFK62HN/pT2ilC3VMWB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307f14ff-eeb0-4cb3-66f4-08d76641cade
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 00:55:05.5906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilCNa3JHut4z1A+xMrKSCCuRVS0Y3Xp+jUs8lEQG+nGqM6/OpcYXMZcoO0uElAu3iY3RBccXTanUfoHe7KUo2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCj4gSGkgQW5zb24sDQo+IA0KPiBPbiBXZWQsIE5vdiA2LCAyMDE5IGF0IDEx
OjA4IFBNIEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IFRoZSBsYXRlc3QgaS5NWDZTTEwgRVZLIGJvYXJkIHN1cHBvcnRzIEhTNDAwIG1vZGUsIHVw
ZGF0ZSB1c2RoYydzDQo+IA0KPiBTaW5jZSB0aGlzIGlzIGEgZHRzaSBwYXRjaCwgaXQgaXMgYmV0
dGVyIG5vdCB0byBtZW50aW9uIGEgc3BlY2lmaWMgYm9hcmQgaGVyZSBpbg0KPiB0aGUgY29tbWl0
IGxvZy4NCj4gDQo+IEl0IHdvdWxkIGJlIGJldHRlciB0byBzYXkgdGhhdCB1bmxpa2UgaS5NWDZT
TCwgdGhlIGkuTVg2U0xMIFNvQyBjYW4gc3VwcG9ydA0KPiBIUzQwMCBtb2RlLCBoZW5jZSBmc2ws
aW14N2QtdXNkaGMgc2hvdWxkIGJlIHVzZWQgYXMgY29tcGF0aWJsZSBzdHJpbmcuDQoNCk1ha2Ug
c2Vuc2UsIHRoYW5rcyBmb3IgYWR2aWNlLCB3aWxsIGltcHJvdmUgaXQgaW4gVjIuDQoNCkFuc29u
Lg0K
