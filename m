Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881572133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vgxCeCEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfCSNhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:37:40 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:3201
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbfCSNhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQVhGWwQVSVIftKZVGzil12bT/7i66y7prDxroFYEV8=;
 b=vgxCeCEb90tYsEQegzAa6qi0XleAj8aiIFnxMhg1CYgo8WVmPaYbHsYITktgKzi7CzKlku+XVp0/BerjeaTJZsFGlFka9a6TzBnlsK2XDVBRjYtR6GDqoblpizh15D6ENiSMMZ7dVOHAwUQEGrHu4WFCXQa8xRDp5jlYWkpyGqc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6162.eurprd04.prod.outlook.com (20.179.36.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 13:37:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 13:37:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm: use memblocks_present
Thread-Topic: [PATCH] arm: use memblocks_present
Thread-Index: AQHUwgpk6mha5pabokK36jjcALV7pqXcbD0AgDamY4CAABSdgIAABjWQ
Date:   Tue, 19 Mar 2019 13:37:35 +0000
Message-ID: <AM0PR04MB44818056316525D4E66EC17988400@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190211131602.3294-1-peng.fan@nxp.com>
 <20190212172700.xwtomhb3qahyxugx@shell.armlinux.org.uk>
 <AM0PR04MB4481452226EC21AA7B90735288400@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAOMZO5BNZaQu8xXvVuxdFbCKPFypajq7qimf6Mk-KAYx-EHcHA@mail.gmail.com>
In-Reply-To: <CAOMZO5BNZaQu8xXvVuxdFbCKPFypajq7qimf6Mk-KAYx-EHcHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 229575b2-fbb9-49a8-6f5e-08d6ac700be5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6162;
x-ms-traffictypediagnostic: AM0PR04MB6162:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB6162C19DDE5AE9F9D9542A4888400@AM0PR04MB6162.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(13464003)(189003)(199004)(26005)(6306002)(71190400001)(478600001)(4326008)(55016002)(105586002)(9686003)(25786009)(186003)(66066001)(966005)(106356001)(86362001)(256004)(71200400001)(2906002)(74316002)(45080400002)(14454004)(305945005)(316002)(6436002)(5660300002)(53936002)(229853002)(33656002)(52536014)(44832011)(486006)(6506007)(81156014)(7736002)(8676002)(6246003)(68736007)(81166006)(11346002)(476003)(93886005)(102836004)(7696005)(53546011)(16799955002)(3846002)(97736004)(6116002)(7416002)(54906003)(446003)(99286004)(76176011)(8936002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6162;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wGIyk1a+z1mBk4otIoJABfPa0Qto5dRBj+4tXy5Vg3IOcldKLze9zOCQD6ac7tLCsfC3uCB/LV7Kug9wHSDvfXD1recDKo3I4+pZ2JThBafDSZTs+ZQq4My7p8i+93SZxc1bukOFmskB79SW0fmrDgCDYEJkp6W5VTaAifGkvXwIf0KVQF+czuoxeNAX8RLH6OdYfmM4I7FdC3CmDJFSxIC1fWOnlq+/JtFyiaQ6AxyEphqaewF52Q7VkuXyLndKbU3ZusIaRL+iHhshwTXygKK9i4GGWMX4ZxnrL+c4QFPEtu8vAqYyNLHnC7R5cgQFR/YhqiTcvucHu6DrejmLlnMBgy1gBZ3i4gRdS8vWJt7Lzm0QW1+ljladnvsi4DXpQPDbU8sOhoR7iD9MHhLdEah0ZxOOIx1SHqAmbS9848Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229575b2-fbb9-49a8-6f5e-08d6ac700be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 13:37:35.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBb
bWFpbHRvOmZlc3RldmFtQGdtYWlsLmNvbV0NCj4gU2VudDogMjAxOeW5tDPmnIgxOeaXpSAyMTox
NA0KPiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBSdXNzZWxsIEtpbmcg
LSBBUk0gTGludXggYWRtaW4gPGxpbnV4QGFybWxpbnV4Lm9yZy51az47DQo+IG5pY29sYXMucGl0
cmVAbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBtaG9ja29Ac3VzZS5jb207DQo+IGFybmRA
YXJuZGIuZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJvc3RlZHRAZ29vZG1pcy5v
cmc7DQo+IHJwcHRAbGludXgudm5ldC5pYm0uY29tOyB2YW4uZnJlZW5peEBnbWFpbC5jb207IGYu
ZmFpbmVsbGlAZ21haWwuY29tOw0KPiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJt
OiB1c2UgbWVtYmxvY2tzX3ByZXNlbnQNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBUdWUsIE1h
ciAxOSwgMjAxOSBhdCA5OjMxIEFNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToN
Cj4gDQo+ID4gPiBMb29rcyBnb29kLCBwbGVhc2UgcHV0IGl0IGluIHRoZSBwYXRjaCBzeXN0ZW0s
IHRoYW5rcy4gIERldGFpbHMgaW4NCj4gPiA+IG15IHNpZ25hdHVyZS4NCj4gPg0KPiA+IFdvdWxk
IHlvdSBhcHBseSB0aGlzIHBhdGNoPyBJIGRvIG5vdCBmaW5kIHRoaXMgcGF0Y2ggaW4geW91ciB0
cmVlLg0KPiANCj4gSGF2ZSB5b3UgcHV0IGl0IGluIFJ1c3NlbGwncyBwYXRjaCBzeXN0ZW0NCg0K
VGhhbmtzIGZvciByZW1pbmRpbmcgbWUsIGp1c3QgYWRkZWQNCmh0dHBzOi8vd3d3LmFybWxpbnV4
Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy92aWV3cGF0Y2gucGhwP2lkPTg4NTAvMQ0KDQpUaGFu
a3MsDQpQZW5nLg0KDQo+IChodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZ3d3cuDQo+IGFybWxpbnV4Lm9yZy51ayUyRmRldmVs
b3BlciUyRnBhdGNoZXMlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3BlbmcuDQo+IGZhbiU0MG54cC5j
b20lN0M0NDkxNTg1ZGQ4ZjQ0MmFlMGY4NTA4ZDZhYzZjZDMxMyU3QzY4NmVhMWQzYmMyDQo+IGI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODg1OTgwNzI5OTIwNjU3JmFtcDtzZGF0
YT0NCj4gU0glMkZDS2JxN3N3V1V5bjJEeGh4a1g1aHBGJTJGWVNEOE5mQzljNmJjJTJGTTZYTSUz
RCZhbXA7cg0KPiBlc2VydmVkPTApID8NCg==
