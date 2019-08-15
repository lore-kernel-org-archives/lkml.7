Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A985C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CFC2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Pcrmix+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbfHONwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:52:49 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com ([40.107.8.99]:59367
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732426AbfHONws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:52:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3SkoDGA1Ktd8ncXrtseXEmUdEm/S/6wgRRQBJhziWMvT9P7rdyDAu6pc+RvTqILQSj+aSUopzMMOM18FL4PxAm5rLUzNPPTiUasghMFR6C+gMTp+sJ2yEMCFCSwVc2OmMQ0BliLh8IzykCeqKnMHPw1Mh90jKj7fTbKkMSdKt2gXyjITFXNkMIft2LtXcPntncbCnO1+1oQGPzWQxLZD9e5bp0NC35wdP6yH9bcGwOHdqLWLCpAAPBMb3XckxGV0q+dFnL5BByEEPQTOpjAvXetEdnULiU86vOQNHEOWUiS31LQHi6hAX10+ePX9tcPTyIQdDGYAij9W208t94X0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jk4FEZGe+Q2hT8CFyKS9KtkL3oLSaZD2Zp300vOZUw=;
 b=Tr8qcv3hP+72OiqFdENrCW5tRyvnt2aHrjQWmxsSHcbmCKVgwlUGYEXZj5Di4zNlfGgTvu6C4YIkMT6vF8t0eJAPDPkErev2H46MI/41GdeaKcBOGiE8kKHIPUhjf5syKA6+zTQsoJdyY50+gjWI3DrbAQUIo9MRW9LXNk3wSwE5TXsNJNKTybvA2/GNLZIsYzgKrGAGEQHmZzNOYs2vXbzrN2undRlDX/41BaP7KzYCpFeLqOTyj1kiqpGiqNsoViBvB5Lb/zkN0IZJDuT6m1GYaOyZjWPjVjO+YRWejMx3fJR7gMgui6Fb4+TaV3DO/3sED2Y3xxCpwnHfJ8N8Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jk4FEZGe+Q2hT8CFyKS9KtkL3oLSaZD2Zp300vOZUw=;
 b=Pcrmix+HkAR+Trc3Fjpzc8qTktkMEMjvpv+Etl3K8aw9pWxGT1O7XfTBU2OondanwJh2dtEL2EudoN2lUCFD+NRT3hNI1DrXFIttx7hHCgmyfeEC2TUKasXVjUS1pYnpkZAQCSGvpR5gdUpQ5+TngAq1tYO/Glw5n6EgJ7I53Cw=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB4637.eurprd05.prod.outlook.com (20.176.3.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 15 Aug 2019 13:52:39 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 13:52:39 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 02/21] ARM: dts: imx7-colibri: disable HS400
Thread-Topic: [PATCH v4 02/21] ARM: dts: imx7-colibri: disable HS400
Thread-Index: AQHVU2+2jR4mtUCFk0i0EfTWj0jIPA==
Date:   Thu, 15 Aug 2019 13:52:39 +0000
Message-ID: <CAGgjyvFXYeGJrhT8zKoM8ACuniZUQBNqyuwimSB2UoRGo3Cj4A@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-3-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-3-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0149.eurprd05.prod.outlook.com
 (2603:10a6:207:3::27) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAVfFlLXKuLnSLVa3O3zu4X1hYN5JZdJxywYoIm9OrXsIglnsDSn
        Upq+JWQm0GcFAgJHWnlZvi6iIm4H6gAeO2su5Jw=
x-google-smtp-source: APXvYqyH8JXFA6YmjfqOFMKLi+82GmkxXPNFYFtDOXqCbDxK05KwL1GeBN9RPoSrSlqvcAhjp+AquyHpqlq/OQ0qXAs=
x-received: by 2002:a17:907:423d:: with SMTP id
 oi21mr4484888ejb.184.1565876745810; Thu, 15 Aug 2019 06:45:45 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvFXYeGJrhT8zKoM8ACuniZUQBNqyuwimSB2UoRGo3Cj4A@mail.gmail.com>
x-originating-ip: [209.85.208.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e08bcdee-5b7e-447d-6ef2-08d72187d5f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4637;
x-ms-traffictypediagnostic: VI1PR05MB4637:
x-microsoft-antispam-prvs: <VI1PR05MB4637DEAD1413FB09EFA553DAF9AC0@VI1PR05MB4637.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(66066001)(66476007)(14444005)(6246003)(478600001)(53936002)(8936002)(66556008)(3846002)(66446008)(6116002)(256004)(66946007)(81166006)(81156014)(107886003)(450100002)(6862004)(25786009)(54906003)(61726006)(61266001)(99286004)(95326003)(316002)(8676002)(4326008)(64756008)(11346002)(386003)(55446002)(6506007)(76176011)(44832011)(102836004)(53546011)(26005)(71190400001)(186003)(7736002)(86362001)(52116002)(446003)(14454004)(229853002)(2906002)(5660300002)(476003)(305945005)(6512007)(6486002)(6636002)(498394004)(6436002)(71200400001)(486006)(9686003)(54206008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4637;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e/kG7qyHj3fM9hH4tWdMYuvapvq0MOFUlnGfsTA2/K93fmriuS3YFVRv1ulild73K9LY3mtC2NPNOXy25TizqtPdvTZ/uQBGXz91Z54ODJy2HgtckS/dD0HobsqvcXLghosr0MPejnm027Hyh5w7mlj8o91MIRsSX8QyyO5troJ1WMZ9wa7mREaMyUa2vEwOyloEFQpP1qA/WpQOWAZXud+27gPPNomWzPZonQe2Ahc+J82QQJRQuxAqH3dxuSIb14tjDH3JmCOOz7dVKMRKDLFtFVlWb+VGrVrPrkywTa3/Tvgzcm3m9ZmsGUSU+YHHtGJA0sW4oPqvuZHt8uYlPaaWiPqOXwyET0j/ZTZ4dFfUgSG0XrZ1VdiCoV+VrMrdBNptnc08uJVxv7CMVRLFxGKQ0wzis/ard7ik1hT/nA8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDE53BC54221E04BACBC650A9843DA77@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08bcdee-5b7e-447d-6ef2-08d72187d5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 13:52:39.1822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqW7SxiUGgUVvt/wJWeUi9zJpMb112tyokEpJ96+gcYl4iHBrMEkzK5qciA3XhsX4d1a7cS7fc3hRPMIClST6gJkRWtjTlOT3Rge9XZLjO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyMyBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gRnJvbTogU3RlZmFuIEFnbmVy
IDxzdGVmYW4uYWduZXJAdG9yYWRleC5jb20+DQo+DQo+IEZvcmNlIEhTMjAwIGJ5IG1hc2tpbmcg
Yml0IDYzIG9mIHRoZSBTREhDSSBjYXBhYmlsaXR5IHJlZ2lzdGVyLg0KPiBUaGUgaS5NWCBFU0RI
QyBkcml2ZXIgdXNlcyBTREhDSV9RVUlSSzJfQ0FQU19CSVQ2M19GT1JfSFM0MDAuIFdpdGgNCj4g
dGhhdCB0aGUgc3RhY2sgY2hlY2tzIGJpdCA2MyB0byBkZXNjaWRlIHdoZXRoZXIgSFM0MDAgaXMg
YXZhaWxhYmxlLg0KPiBVc2luZyBzZGhjaS1jYXBzLW1hc2sgYWxsb3dzIHRvIG1hc2sgYml0IDYz
LiBUaGUgc3RhY2sgdGhlbiBzZWxlY3RzDQo+IEhTMjAwIGFzIG9wZXJhdGluZyBtb2RlLg0KPg0K
PiBUaGlzIHByZXZlbnRzIHJhcmUgY29tbXVuaWNhdGlvbiBlcnJvcnMgd2l0aCBtaW5pbWFsIGVm
ZmVjdCBvbg0KPiBwZXJmb3JtYW5jZToNCj4gICAgICAgICBzZGhjaS1lc2RoYy1pbXggMzBiNjAw
MDAudXNkaGM6IHdhcm5pbmchIEhTNDAwIHN0cm9iZSBETEwNCj4gICAgICAgICAgICAgICAgIHN0
YXR1cyBSRUYgbm90IGxvY2shDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBBZ25lciA8c3Rl
ZmFuLmFnbmVyQHRvcmFkZXguY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtl
ciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoNClJldmlld2VkLWJ5OiBPbGVrc2Fu
ZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+DQo+
IENoYW5nZXMgaW4gdjQ6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MzogTm9uZQ0KPiBDaGFuZ2VzIGlu
IHYyOiBOb25lDQo+DQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaSB8IDEg
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDctY29saWJyaS5kdHNpDQo+IGluZGV4IGYxYzE5NzFmMjE2MC4uZjdjOWNlNWJlZDQ3IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiArKysgYi9h
cmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiBAQCAtMzI1LDYgKzMyNSw3IEBA
DQo+ICAgICAgICAgdm1tYy1zdXBwbHkgPSA8JnJlZ19tb2R1bGVfM3YzPjsNCj4gICAgICAgICB2
cW1tYy1zdXBwbHkgPSA8JnJlZ19EQ0RDMz47DQo+ICAgICAgICAgbm9uLXJlbW92YWJsZTsNCj4g
KyAgICAgICBzZGhjaS1jYXBzLW1hc2sgPSA8MHg4MDAwMDAwMCAweDA+Ow0KPiAgfTsNCj4NCj4g
ICZpb211eGMgew0KPiAtLQ0KPiAyLjIyLjANCj4NCg0KDQotLSANCkJlc3QgcmVnYXJkcw0KT2xl
a3NhbmRyIFN1dm9yb3YNCg0KVG9yYWRleCBBRw0KQWx0c2FnZW5zdHJhc3NlIDUgfCA2MDQ4IEhv
cncvTHV6ZXJuIHwgU3dpdHplcmxhbmQgfCBUOiArNDEgNDEgNTAwDQo0ODAwIChtYWluIGxpbmUp
DQo=
