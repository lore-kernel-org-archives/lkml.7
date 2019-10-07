Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B57C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA9121479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 00:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3Jq/RGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfJGApz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 20:45:55 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:41128
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfJGApy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:45:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2ApjYd/c5z0TxyBOocS2eRCJP56ZLGOHHksdmvHGh+11Xm2F2CuTIqokmtKXe0X5OJpe6XDG9egqxvjkpYOITqBnaQzrCZL8hP/vPJKZw6PI7Ufj8zzTsv6C/vdIUVvGJfC5ETAseYmQOiwXko7gzTe2IrvIuVsL8M5nhtsva/YCk9FTFqRiBrC5LVdYdT/4ADM9AY/GxqnsUnvVHX7IYkGMz1a01tWFAsj9H5v+iOAnHACMZnoVA7/ZWWAR36Iut+zq03m/057RRyzqoXFRGPD36jHwkLQ/8iYYX/J03UkcRi/3qxq8JcTRhhzPd1pHwe9NswdjJtA3M5TVn53/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhhHQH6uVALXlP+dDGAM+lgnZ6issBrGnrxW7CsOvAM=;
 b=ZVhXNh6B88JMOlEQd4Pa+qp3EYqLHEMYctf/yrNRtu6ZplOQW4X00OFtJqaO5bhsePb+sU1AU5IwZi8p8Hu3Xyn6d2RY7wBrY3Rgz4vZpq1Z8Y48YuB4PRq4tF5R1IANGR85+gmJpNaGsBcmQXkOU6fUC0kieKLS2POfVmqhuREpQbG/zUorA+HlPNhHQ+UPDebmwXTtOE7ZkCNcB/a22c2S21SeZN/Dr1U11r2yZZGINm/fM8RXjC1ekFDQIsWyxGZr8/P9z84bxKGHMrECc16+4mGnkyVwi/zpJb0Zuu4nyzvRJ2T2bBc/G8ekJRA1mkKNem3ZeKrekcMY/4vIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhhHQH6uVALXlP+dDGAM+lgnZ6issBrGnrxW7CsOvAM=;
 b=k3Jq/RGSjtmLogpSmHsYNuDMklIlWGsXXZ5xP1QvJw6PEF4Yt0Wa2cptT0l+mcwx4nf9RioRn5PAFKMzB35jny2z09URa1F9+hyMy0aB2Ypy3Rn2tQYIJYaL3RcJK7AI37tdzvnkbN/DHmNhUXDWwLOPncNGWOj1wxgyYsJoENk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 7 Oct 2019 00:45:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 00:45:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx7s: Correct GPT's ipg clock source
Thread-Topic: [PATCH] ARM: dts: imx7s: Correct GPT's ipg clock source
Thread-Index: AQHVbGj9OePM1LgLKkuaNPfAjuopxKdNaGOAgAENZYA=
Date:   Mon, 7 Oct 2019 00:45:50 +0000
Message-ID: <DB3PR0402MB3916B8450581E6D3F9F8D566F59B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1568622549-15819-1-git-send-email-Anson.Huang@nxp.com>
 <20191006083233.GB7150@dragon>
In-Reply-To: <20191006083233.GB7150@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a33d0f-ec11-499e-01c3-08d74abfb3a5
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3931:|DB3PR0402MB3931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB39318FB968382E4C8C4B5802F59B0@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(3846002)(54906003)(99286004)(229853002)(5660300002)(76176011)(2906002)(7696005)(14454004)(52536014)(6916009)(102836004)(4744005)(86362001)(6116002)(6436002)(25786009)(71190400001)(44832011)(55016002)(9686003)(71200400001)(11346002)(33656002)(486006)(446003)(26005)(186003)(7736002)(6506007)(476003)(66946007)(66476007)(8676002)(81166006)(81156014)(478600001)(4326008)(66066001)(66446008)(64756008)(66556008)(8936002)(76116006)(74316002)(256004)(6246003)(316002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObNtBWuE6qnZTTP7UXMHKQWBSEDm5Lx2Jh4zmdQgire5vaVEYb1hiaT5fHfiXlnNiKdpGcVhmGPeFCpl/1Psy0mNLr4nqRznkgnPqLXICTqTcSUnVGRfR/U/9XoTk9KQVheiyObXXtuf3Qklhmtaejvaau22hmtNSb8T1mRCUVldg6Wcb8Y5KnjjBZIyqTGZsobpf0lTGvF0NBDcm0s5P7k6rJTN/rUJlz1uWiymoRx9CG+g16G45609wUuMXA7f0MRuzQAfs4tapIT+4occE3cBvSb///kDVBGm4oM8cgjeF4V5yPwPLWvMJlHomLnn1VAqLLO5FwA5vjHb9FzIf1eBDED67dfddPvYtk+lkSjF9CTkoGOpH+Rx0laPf1dvAn9No7Ct0uQWPOC0VnVJ/ohEk5GlBGWSRUYO1qxwzlQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a33d0f-ec11-499e-01c3-08d74abfb3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 00:45:50.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtsIV4961zoFrYhELmo1rpFsExkIhjCmwc0DJYmWdSv9eyxvxNjiBdbcnPe5RHjjOFMN8v1UNQ4GbaGMBOUq9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gT24gTW9uLCBTZXAgMTYsIDIwMTkgYXQgMDQ6Mjk6MDlQTSArMDgwMCwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gaS5NWDdTL0QncyBHUFQgaXBnIGNsb2NrIHNob3VsZCBi
ZSBmcm9tIEdQVCBjbG9jayByb290IGFuZCBjb250cm9sbGVkDQo+ID4gYnkgQ0NNJ3MgR1BUIEND
R1IsIHVzaW5nIGNvcnJlY3QgY2xvY2sgc291cmNlIGZvciBHUFQgaXBnIGNsb2NrDQo+ID4gaW5z
dGVhZCBvZiBJTVg3RF9DTEtfRFVNTVkuDQo+IA0KPiBTbyBib3RoICdpcGcnIGFuZCAncGVyJyBj
bG9jayBhcmUgY29taW5nIGZyb20gR1BUIHJvb3QgY2xvY2s/DQoNClllcy4NCg0KPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IEl0
IGxvb2tzIGxpa2UgYSBmaXgsIHNvIGRvIHdlIG5lZWQgYSBGaXhlcyB0YWcgaGVyZT8NCg0KU3Vy
ZSwgd2lsbCBhZGQgYSBmaXhlcyB0YWcgaW4gVjIuDQoNClRoYW5rcywNCkFuc29uLg0K
