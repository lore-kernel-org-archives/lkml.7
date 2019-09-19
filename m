Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B3B21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SWZhd7j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbfISKCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:02:01 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:2286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388966AbfISKCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uum/bUwjIjrkIqrAEskZ0F1pK8d3ZB5x00BpYreNs3xXHuafkBS4dEBew+z7JmYY0p96fgPoj381UQHafbPsePKkxVzqMQbD7Ce2eTEN9qkM9If4wdK4hB+AeXO759LSh1bY9y/dHPiNfpOnsXMeE3aK6rt18TLL4gX71NWObyGNmmmTz54u96KMM6BfZPYtSslSmOzT1l0GO2fJcZFOaikDAJN4mVVVzlsbPkL40VltUSVkzhMK364H+/0d+wghkXFpk1Y9inEARSHG6A8LD9WcGYDF/jMJsSGh6Alw8MPV78gLpTnpXmPsRb5PJgheZI3qlixWZutVKUallNcDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC/ip0vaqmRjLlxfup04aMPvWEi804Vf624fec5JaZs=;
 b=Wd8HAU3+LIlAnC+55znTarrZu30v5viRqy1beVHxzT8rFp3CgqATaBOX6FAj7wBr5B7sd4naa3+5C3tJPOBmUEDUxDW885VyY5h1ITLz5ETRHH5nPdb74AoELWYxClXq0x4d4fTcQfvdq8u8AYmiUd0IATXU/ghGdQyKUIJPj15kfrqZAu3FBErEvyUy0dHeY+DwF9+1DzjzY7FJ6+GPzWkoD+tYvqsp1fTs3jYa1/+g3B9RxsNVTjmyHTu/rtUn3OKziHofNV965FGgbgJrpUz7z+YfMXFOrDba0/qLOxwP+yOiHRucEtFeMZ56toU6UUugKM70E1RLLI+hsUtlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC/ip0vaqmRjLlxfup04aMPvWEi804Vf624fec5JaZs=;
 b=SWZhd7j6ca2HdyPzxbFcR3213DKKiWPBVNkYgZXhL4CVh66c39gJmIc7CGJGgOIlkM7UVLoqbIUW/FdpUxaAAxfkxrbpLNFkSiopdjSWK7prLFJPwLoEMw+wTYY7zms/gJSZofp+6GwfprpZwWk7fApAremuetxX+n2yyZ3INqA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 10:01:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 10:01:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: Missing 'assigned-clocks' in usdhc node of i.MX8MQ/MM/MN dtsi?
Thread-Topic: Missing 'assigned-clocks' in usdhc node of i.MX8MQ/MM/MN dtsi?
Thread-Index: AQHVbtCPIpmeLD1Wgkq8yfUNmKVWtacyxFuA
Date:   Thu, 19 Sep 2019 10:01:57 +0000
Message-ID: <DB3PR0402MB39167149796B0DD51442FD07F5890@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <e6ce599e-597a-6f67-d5d1-5487f50c7d0d@kontron.de>
In-Reply-To: <e6ce599e-597a-6f67-d5d1-5487f50c7d0d@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8acf25c6-e1d6-42e7-3535-08d73ce86851
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:|DB3PR0402MB3705:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3705CCBEB870B481BDFDD3A4F5890@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(189003)(81166006)(81156014)(2201001)(2501003)(33656002)(76176011)(14454004)(14444005)(316002)(7696005)(256004)(52536014)(9686003)(7416002)(55016002)(5660300002)(110136005)(99286004)(6246003)(6436002)(6506007)(86362001)(66476007)(6636002)(71190400001)(66556008)(66066001)(66446008)(74316002)(64756008)(4744005)(76116006)(229853002)(71200400001)(305945005)(66946007)(2906002)(7736002)(26005)(44832011)(11346002)(102836004)(186003)(6116002)(8676002)(8936002)(446003)(3846002)(486006)(478600001)(476003)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ar7+9Vqt7zsfVtXKe6+7oVKOPf70oxJ6sGvNNwjhjuZTFT9Tg2eu0xKzlb8p03FM1j5DeeVijccpTR7jAwgaHJn0hV8TDKMVPzztEhWhmHDPL0CJQIsc4zoylVXZHkeAJR6kurfAaPMDBCBNfJGYa4Wbw+g+L6Ch4Erkfu+jTWOb+xEUvfFOD6dXX8ig+pAtiI2RzzlyaBCTUD2cuyYzqPBX3E2e46fS5OlF7dlRlZoBn4PyDdMk1WHU/tniMAr8r2ImXdAjQKLfqFSOu0+P0HUIn8SWqdB6/XXUOHS956/qaUPSPncx8NOqgerg/WQ3nQnvOtcDm9UXEifS7qwni7zb9GwQEGJ7H/JfD6ET73DRB8IXJLfljQu/ldpx4eLO+huBex8z2Vj1ADMO2oMw9MRKM4BmJJECQvJjCD2w4bE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acf25c6-e1d6-42e7-3535-08d73ce86851
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 10:01:57.4577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxUGQUYdVZFihaoGkoEiJuSPPoKqKIPcavs/qrZsRMYyoESQzg3pp8GeXwah6OytvGdiQfV/9BPbUEp8lNjrGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNjaHJlbXBmDQoNCj4gSGksDQo+IA0KPiBJIHdvbmRlciB3aHkgaW14OG1xLmR0c2ksIGlt
eDhtbS5kdHNpIGFuZCBpbXg4bW4uZHRzaSBoYXZlICdhc3NpZ25lZC0NCj4gY2xvY2tzJyBhbmQg
J2Fzc2lnbmVkLWNsb2NrLXJhdGVzJyBzZXQgZm9yIGFsbCB1c2RoYyBub2RlcywgZXhjZXB0IGZv
ciB1c2RoYzIuDQo+IA0KPiBJcyB0aGlzIG9uIHB1cnBvc2U/IElzIGl0IGEgZmxhdz8NCg0KSSBk
b24ndCB0aGluayBpdCBpcyBvbiBwdXJwb3NlLCBpdCBzaG91bGQgYmUgYSBmbGF3LCBJIHdpbGwg
ZG91YmxlIGNoZWNrIHdpdGggb3VyIHVzZGhjIG93bmVyLA0KaWYgaXQgaXMgaW5kZWVkIGEgZmxh
dywgd2Ugd2lsbCBzdW1taXQgYSBwYXRjaCB0byBmaXggaXQsIHRoYW5rcyBmb3IgcmVtaW5kZXIu
DQoNClRoYW5rcywNCkFuc29uDQoNCg==
