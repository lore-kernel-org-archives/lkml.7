Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF56C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822EA20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="S/BF7Ajf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfCEXol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:44:41 -0500
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:37012
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728317AbfCEXok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Tr+AKGj1Uk/U/XQb9nmtxA+wXvqnv0yREdAOJU5/Kk=;
 b=S/BF7Ajf4RcFLkDfD2PCUER6SohlGBmlBHpM3SmrshXFXyN71KUM7hGTWV76IST+koTtim48re+U6YSaCYjcI38ZkmiENslT3PSJeKPYLfYy9yZXs9SlL+jpRfdVotlXXbYllO9EoDiQklG24Q3mAFES4FdQMB0oOcRLfO3kIp4=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2688.eurprd05.prod.outlook.com (10.172.15.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 23:44:33 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 23:44:33 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Topic: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Index: AQHUz/D0zHEkReNVsEa2RSWOI/Q4NKX3M+0AgAOlj4CAAW4QgIABFdqggABLTwCAAAI9cIAADqcQ
Date:   Tue, 5 Mar 2019 23:44:33 +0000
Message-ID: <VI1PR0501MB2271A1E091538621F00B2433D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <20190301120358.7970f0ad@cakuba.netronome.com>
 <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304173529.59aef2b3@cakuba.netronome.com>
 <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <54d846bc-cfa5-6665-efcb-a6c85e87763b@nvidia.com>
 <VI1PR0501MB2271962A3044DD29CE0E4C0CD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR0501MB2271962A3044DD29CE0E4C0CD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51ca6ac5-5633-4aee-dd9b-08d6a1c484c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2688;
x-ms-traffictypediagnostic: VI1PR0501MB2688:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjI2ODg7MjM6UVpkbkhnK3BwWlhMaVUzWng4eVpFQWJi?=
 =?utf-8?B?RkYzY1Q4ZUhTZGl3NTExd3lhMWxveVduYWxwTE40MUFRUUkxOVZCRHpZUVJn?=
 =?utf-8?B?akNLU3lYUzhEbENvd21TREtzN0lUdno0QnNHMGNlVStQclpPdHhISmhOMndQ?=
 =?utf-8?B?V0tneE4wZDQ5ekVMdmdyU2dXaEQxSTdhWVN6WTdqTTZabVVBUHhjSmQwRnlR?=
 =?utf-8?B?Z21QRE1RSmppdkczR2lGcVAzdXo1UDZsRVBiR3pXTU9sMXdLRjUwTUtnNkNi?=
 =?utf-8?B?WkZUMzlmbXJ5bDhqK1JJREpRczhoSm9OdVBCS1p5cEtkOHg2Mm5YTUxCdzcx?=
 =?utf-8?B?R0I0VEtKS3FoWlB2MFlOcWd6UHdZeTNVU3NIT1pkUVpvUWkvUGU0WjAzOXBn?=
 =?utf-8?B?ZitPZGs0Z1l0Z0s1RFhqWVJtcnl1MEVLU3hrRDh1ejFBdlpFeWprOC9zRjM2?=
 =?utf-8?B?K1ZYd2gwRzlJTmRLN0hIKzJIK3NaZmgwUXcyQm1YQjVuS1dGc0dpdHJGTXp1?=
 =?utf-8?B?ZmJGNmJpQy9IbG53TzdVeHBiL1dEK2h4S0F0ZmlJOUtITG5LOHpaQ0FkamxT?=
 =?utf-8?B?THhudHFzZ01nbUhYVk52R1EyMnNMVjBqNHZmUUZPcXJYVXZYU3c4RjJoQnN0?=
 =?utf-8?B?WVUrMVVZeEwxUEtjbTVGYnNPUzZWa2o0aXc3NnhQWTRXWENEWm1lRWQ0clpk?=
 =?utf-8?B?MmlyUU82ajFCTjJBNHpKdVBVQ2MwNncxTE1RYXMvNW8rZW5VTzJLRHlOR3dq?=
 =?utf-8?B?eWtRMlRoN1Z5Z1Z4UzZGMDdaaVVrMldJSlhhMlZMNnM2Q3F5TkxHZDFmUTdQ?=
 =?utf-8?B?LzRIczNuajdJZmp0cHEzV2JHdDl0N25kUCtBNFhKRDY0M3VVSE1vTnNKWlpC?=
 =?utf-8?B?VVgzcFpDbit0eHJmWU1FQSsyeitUSlFnMkhTa25lWW1LSXBxelY0N1dTNU1s?=
 =?utf-8?B?S3NlUUx6MEUvZVFlQmp0aFQ1M2swNnZtb0QxMHQ5VytFbnFkQzFubnE5bkRX?=
 =?utf-8?B?ZVE2RWwvTGJFeDFCRVR0aTFSTkJwWnVHdWxLMG1jcWZmUlYrVlVzMi9ZNzl5?=
 =?utf-8?B?cWhYbXhmNStxSTZLWjNybi90azNDRzJmVXJkN0dwcE1acHBYYzRXeFFnNzAy?=
 =?utf-8?B?N25kc21QaEEwSFllVTVwMjloMkxsaFVZN0dUUHZWeFRTNjZ1dFk0ZDdqdVJr?=
 =?utf-8?B?TmExcGNXV0RObkpzakl4Rkd1SzEveWRIZm5EWlAreWY5dHFnUnhsVnc3R21R?=
 =?utf-8?B?SVduK08zVmpyYUczT1hKMHJmY1hyWlJYeE9HSExZV0VRUWtqMTB5Y1Jjc05G?=
 =?utf-8?B?MWZBV1R5U3Z0MERHRUM0WTEvSkR6Tm01ZGFtNlB5Mkg1RWt1SkNDd2MrWThD?=
 =?utf-8?B?RHl3TVF4NUF2Y2N1ZThreHlxS2czd2tOMkZUd0U2VmRuMkxjTFdOcVJZRGwz?=
 =?utf-8?B?Mjd1V3hkamF5OTgzbE1ORXBtU0pTQzZONWk1bkJ3SFM4Y09XVHRGclVpZXQ3?=
 =?utf-8?B?b0NucDEyaDU3SVYxMFFWenFWaFpobHpFWEZNRG9ldXZoa1dEc1k3MWZ5SHNu?=
 =?utf-8?B?aVZYZjJDS3V0d1ZSdDBScEhGdXJzQUtxUlJlbjhzYU1aTlkrbzhTRC9DeUxw?=
 =?utf-8?B?eTk0YnZmQWQxdmsrQmFycisyVGN0S0ZXZXV3M0h2ZzlYdGJzNjlqWkdZYjIr?=
 =?utf-8?B?d3c4bmZESjJVa1JHbTl5REdlMUFjemgvYXI4bDU5RGFVUkQzRUtuTkE4Zm9a?=
 =?utf-8?B?SU5ObkJzaFBtME9RMDNiblZ2QUloV0pMaUJZRkpBbGZUb2ttMDhQZzRsTFRF?=
 =?utf-8?B?eHczZ1ZmYTViSUFxK3BMbWJ5V0pUenVhN3ZJeTRvSWIvQmlCbFVUUHV6TUVI?=
 =?utf-8?B?TTR5eUs4b0ZrWGFBMjJJSEQvZnlmYVgybGtNVlV4cmt3WnFOaVE5UzlQMkNE?=
 =?utf-8?B?TThPMFFNUjZYOHc9PQ==?=
x-microsoft-antispam-prvs: <VI1PR0501MB2688B60A453914CD25DF2A66D1720@VI1PR0501MB2688.eurprd05.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(13464003)(86362001)(26005)(305945005)(93886005)(74316002)(6506007)(7736002)(2940100002)(5660300002)(97736004)(52536013)(8936002)(81166006)(8676002)(186003)(486006)(81156014)(11346002)(66066001)(446003)(53936002)(476003)(107886003)(6246003)(14444005)(229853002)(6436002)(54906003)(33656002)(105586002)(316002)(25786009)(256004)(55016002)(7696005)(93156006)(68736007)(71190400001)(99286004)(71200400001)(6346003)(3846002)(6306002)(2906002)(9686003)(14454004)(4326008)(966005)(76176011)(102836004)(6116002)(478600001)(53546011)(106356001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2688;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o15n5erRXGSnuvWCktZjwAzvC8Rrl3Nh0A3aFO2Vpx7YdjwL0DVoVcvrJLqNBvMlRmARUK56Epwg3iA+UZnH0el4tVPI+X5/E6ZpfOUHkFn/DlYqHa8AUIB7180CxIUM1J+r+o9q7ZPnKFXvtTCjFrxK/yMH2IZukq68PUwY0G8Q0N3VbpoNrH83dnqPx/+becieBSPm/1DqyO84BsoKKmYZ1nzr1o1TE3BbBe/Pc53ROUkmUq5BKJau3MKNqNmN6AidKpLVWlTJvIqREfGI1Hw3NDPNRPo+dk4Qbkcy9c5mb7z1PltisMp/ueZv4HgcjTIaMvGCDN5D7Fk5LCt9KCiovBAcluErLeac3SA29jgno1mztJzNYq7HQPFNNEHhaXHw4IFaA6vZZIR5I8O+8dmX8yeAYnQW0D3IPAV88Nc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ca6ac5-5633-4aee-dd9b-08d6a1c484c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 23:44:33.1404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBQYXJhdiBQYW5kaXQNCj4gU2VudDogVHVlc2RheSwgTWFyY2ggNSwg
MjAxOSA1OjE3IFBNDQo+IFRvOiBLaXJ0aSBXYW5raGVkZSA8a3dhbmtoZWRlQG52aWRpYS5jb20+
OyBKYWt1YiBLaWNpbnNraQ0KPiA8amFrdWIua2ljaW5za2lAbmV0cm9ub21lLmNvbT4NCj4gQ2M6
IE9yIEdlcmxpdHogPGdlcmxpdHoub3JAZ21haWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1pY2hhbC5sa21sQG1hcmtvdmku
bmV0OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsg
SmlyaSBQaXJrbyA8amlyaUBtZWxsYW5veC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUkZDIG5ldC1u
ZXh0IDAvOF0gSW50cm9kdWNpbmcgc3ViZGV2IGJ1cyBhbmQgZGV2bGluayBleHRlbnNpb24NCj4g
DQo+IEhpIEtpcnRpLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IEtpcnRpIFdhbmtoZWRlIDxrd2Fua2hlZGVAbnZpZGlhLmNvbT4NCj4gPiBTZW50OiBUdWVz
ZGF5LCBNYXJjaCA1LCAyMDE5IDQ6NDAgUE0NCj4gPiBUbzogUGFyYXYgUGFuZGl0IDxwYXJhdkBt
ZWxsYW5veC5jb20+OyBKYWt1YiBLaWNpbnNraQ0KPiA+IDxqYWt1Yi5raWNpbnNraUBuZXRyb25v
bWUuY29tPg0KPiA+IENjOiBPciBHZXJsaXR6IDxnZXJsaXR6Lm9yQGdtYWlsLmNvbT47IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1p
Y2hhbC5sa21sQG1hcmtvdmkubmV0OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiA+IGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnOyBKaXJpIFBpcmtvIDxqaXJpQG1lbGxhbm94LmNvbT4NCj4gPiBT
dWJqZWN0OiBSZTogW1JGQyBuZXQtbmV4dCAwLzhdIEludHJvZHVjaW5nIHN1YmRldiBidXMgYW5k
IGRldmxpbmsNCj4gPiBleHRlbnNpb24NCj4gPg0KPiA+DQo+ID4NCj4gPiA+IEkgYW0gbm92aWNl
IGF0IG1kZXYgbGV2ZWwgdG9vLiBtZGV2IG9yIHZmaW8gbWRldi4NCj4gPiA+IEN1cnJlbnRseSBi
eSBkZWZhdWx0IHdlIGJpbmQgdG8gc2FtZSB2ZW5kb3IgZHJpdmVyLCBidXQgd2hlbiBpdCB3YXMN
Cj4gPiBjcmVhdGVkIGFzIHBhc3N0aHJvdWdoIGRldmljZSwgdmVuZG9yIGRyaXZlciB3b24ndCBj
cmVhdGUgbmV0ZGV2aWNlIG9yDQo+ID4gcmRtYSBkZXZpY2UgZm9yIGl0Lg0KPiA+ID4gQW5kIHZm
aW8vbWRldiBvciB3aGF0ZXZlciBtYXR1cmUgYXZhaWxhYmxlIGRyaXZlciB3b3VsZCBiaW5kIGF0
IHRoYXQNCj4gPiBwb2ludC4NCj4gPiA+DQo+ID4NCj4gPiBVc2luZyBtZGV2IGZyYW1ld29yaywg
aWYgeW91IHdhbnQgdG8gcGFydGl0aW9uIGEgcGh5c2ljYWwgZGV2aWNlIGludG8NCj4gPiBtdWx0
aXBsZSBsb2dpYyBkZXZpY2VzLCB5b3UgY2FuIGJpbmQgdGhvc2UgZGV2aWNlcyB0byBzYW1lIHZl
bmRvcg0KPiA+IGRyaXZlciB0aHJvdWdoIHZmaW8tbWRldiwgd2hlcmUgYXMgaWYgeW91IHdhbnQg
dG8gcGFzc3Rocm91Z2ggdGhlDQo+ID4gZGV2aWNlIGJpbmQgaXQgdG8gdmZpby1wY2kuIElmIEkg
dW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoYXQgaXMgd2hhdCB5b3UgYXJlDQo+IGxvb2tpbmcgZm9y
Lg0KPiA+DQo+ID4NCj4gV2UgY2Fubm90IGJpbmQgYSB3aG9sZSBQQ0kgZGV2aWNlIHRvIHZmaW8t
cGNpLCByZWFzb24gaXMsIEEgZ2l2ZW4gUENJIGRldmljZQ0KPiBoYXMgZXhpc3RpbmcgcHJvdG9j
b2wgZGV2aWNlcyBvbiBpdCBzdWNoIGFzIG5ldGRldnMgYW5kIHJkbWEgZGV2Lg0KPiBUaGlzIGRl
dmljZSBpcyBwYXJ0aXRpb25lZCB3aGlsZSB0aG9zZSBwcm90b2NvbCBkZXZpY2VzIGV4aXN0IGFu
ZCBtbHg1X2NvcmUsDQo+IG1seDVfaWIgZHJpdmVycyBhcmUgbG9hZGVkIG9uIGl0Lg0KPiBBbmQg
d2UgYWxzbyBuZWVkIHRvIGNvbm5lY3QgdGhlc2Ugb2JqZWN0cyByaWdodGx5IHRvIGVzd2l0Y2gg
ZXhwb3NlZCBieQ0KPiBkZXZsaW5rIGludGVyZmFjZSAobmV0L2NvcmUvZGV2bGluay5jKSB0aGF0
IHN1cHBvcnRzIGVzd2l0Y2ggYmluZGluZywgaGVhbHRoLA0KPiByZWdpc3RlcnMsIHBhcmFtZXRl
cnMsIHBvcnRzIHN1cHBvcnQuDQo+IEl0IGFsc28gc3VwcG9ydHMgZXhpc3RpbmcgUENJIFZGcy4N
Cj4gDQo+IEkgZG9u4oCZdCB0aGluayB3ZSB3YW50IHRvIHJlcGxpY2F0ZSBhbGwgb2YgdGhpcyBh
Z2FpbiBpbiBtZGV2IHN1YnN5c3RlbSBbMV0uDQo+IA0KPiBbMV0gaHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9kb2MvRG9jdW1lbnRhdGlvbi92ZmlvLW1lZGlhdGVkLWRldmljZS50eHQNCj4gDQo+IFNv
IGRldmxpbmsgaW50ZXJmYWNlIHRvIG1pZ3JhdGUgdXNlcnMgZnJvbSBtYW5hZ2luZyBWRnMgdG8g
bm9uX1ZGIHN1Yg0KPiBkZXZpY2UgaXMgbmF0dXJhbCBwcm9ncmVzc2lvbi4NCj4gDQo+IEhvd2V2
ZXIsIGluIGZ1dHVyZSwgSSBiZWxpZXZlIHdlIHdvdWxkIGJlIGNyZWF0aW5nIG1lZGlhdGVkIGRl
dmljZXMgb24gdXNlcg0KPiByZXF1ZXN0LCB0byB1c2UgbWRldiBtb2R1bGVzIGFuZCBtYXAgdGhl
bSB0byBWTS4NCj4gDQo+IEFsc28gJ21kZXZfYnVzJyBpcyBjcmVhdGVkIGFzIGEgY2xhc3MgYW5k
IG5vdCBhcyBhIGJ1cy4gVGhpcyBsaW1pdHMgdG8gbm90IHVzZQ0KPiBkZXZsaW5rIGludGVyZmFj
ZSB3aG9zZSBoYW5kbGUgaXMgYnVzK2RldmljZSBuYW1lLg0KPiANCj4gU28gb25lIG9wdGlvbiBp
cyB0byBjaGFuZ2UgbWRldiBmcm9tIGNsYXNzIHRvIGJ1cy4NCj4gZGV2bGluayB3aWxsIGNyZWF0
ZSBtZGV2cyBvbiB0aGUgYnVzLCBtZGV2IGRyaXZlciBjYW4gcHJvYmUgdGhlc2UgZGV2aWNlcw0K
PiBvbiBob3N0IHN5c3RlbSBieSBkZWZhdWx0Lg0KPiBBbmQgaWYgdG9sZCB0byBkbyBwYXNzdGhy
b3VnaCwgYSBkaWZmZXJlbnQgZHJpdmVyIGV4cG9zZXMgdGhlbSB0byBWTS4NCj4gSG93IGZlYXNp
YmxlIGlzIHRoaXM/DQo+IA0KV2FpdCwgSSBkbyBzZWUgYSBtZGV2IGJ1cyBhbmQgbWRldnMgYXJl
IGNyZWF0ZWQgb24gdGhpcyBidXMgdXNpbmcgbWRldl9kZXZpY2VfY3JlYXRlKCkuDQpTbyBob3cg
YWJvdXQgd2UgY3JlYXRlIG1kZXZzIG9uIHRoaXMgYnVzIHVzaW5nIGRldmxpbmssIGluc3RlYWQg
b2Ygc3lzZnM/DQpBbmQgZHJpdmVyIHNpZGUgb24gaG9zdCBnZXRzIHRoZSBtZGV2X3JlZ2lzdGVy
X2RyaXZlcigpLT5wcm9iZSgpPw0KDQoNCg==
