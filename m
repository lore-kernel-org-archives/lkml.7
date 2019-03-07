Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF35AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BE720675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YVjzXHRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCGVWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:22:02 -0500
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:6119
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfCGVWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXYrkwwW14XZTG4HHKBnlN32CgtYY5ZtyqchADo7zz8=;
 b=YVjzXHRuirk25kbBuuix7NDK8yZ7CJEvHb4j2zO0JrRfi3OHXNsfOzGYi14wXu/HzI9vkS+lR2ZsCezQY2oFasaSiWqLN8FgjDgZ2EpXmENdMjJNpq6yhqpXgFXhmpNHkE+3j0wsczwuV/BbdxyL+btwbb+Xm3ZpDP9HMUQIA/g=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB3598.eurprd05.prod.outlook.com (10.166.198.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 21:21:52 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 21:21:52 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Topic: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Index: AQHUz/D0zHEkReNVsEa2RSWOI/Q4NKX3M+0AgAOlj4CAAW4QgIABFdqggABLTwCAAAI9cIAADqcQgAAOtWCAADeQgIAAGIjAgAJ44YCAABQVAIAACmcAgAAAnZCAAANVgIAAAebA
Date:   Thu, 7 Mar 2019 21:21:52 +0000
Message-ID: <VI1PR0501MB2271020E5B8C2345AFFBF968D14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304173529.59aef2b3@cakuba.netronome.com>
 <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <54d846bc-cfa5-6665-efcb-a6c85e87763b@nvidia.com>
 <VI1PR0501MB2271962A3044DD29CE0E4C0CD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB2271A1E091538621F00B2433D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB227137E2040C23E255DAC4F3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <97d63e18-b151-8b35-6687-1dcf5216f08a@nvidia.com>
 <VI1PR0501MB22711C5925D09B9822382AC3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <9dbc644f-4e4c-7119-8f99-99850fc67b73@nvidia.com>
 <VI1PR0501MB227181D2B27A29BCD8F5342FD14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <9e9b3e39-a649-a9cd-83cc-dab74cf77ac7@nvidia.com>
 <VI1PR0501MB22715BECE805956776809A1FD14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <965ae0c8-5e6d-20ac-4baa-22b7e8dab5e3@nvidia.com>
In-Reply-To: <965ae0c8-5e6d-20ac-4baa-22b7e8dab5e3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e47dfb2-e123-4209-7ac1-08d6a342eb2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB3598;
x-ms-traffictypediagnostic: VI1PR0501MB3598:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjM1OTg7MjM6czVpakJoV1BidVBKbHpKOW11VlFhUEVM?=
 =?utf-8?B?UlM4NEVZSnBkMkgrVE11L2JlcGg1Wnk2M0pNOFpYa09JbWtBUUJ1UThBZWQ3?=
 =?utf-8?B?em9Xak9BUyswOXI1WVd0QUJSRjgzQ2JFM2Uyczk5RW5mYjhpV3pvNE5UM1RU?=
 =?utf-8?B?aFcrRWlEZ0xLWkdsZThPSkRhTDMreU56TUtzL3JqQUpKYUMycVhqeGFETTFz?=
 =?utf-8?B?VDBCbW1VSEdaNlVEZzJOaW15Ty8rSjFrRWJ3TTlzb0dGeHFaL3Y2WFBFaWZC?=
 =?utf-8?B?cHlaaFRLalY1Q0ZVRWtSODRQNWNLRkZKS2pCS08rU3JocytmdG9UcWZwdzNt?=
 =?utf-8?B?TmtIVDlzREVOZ21tRXYvZnBOdGUvTEtuY0lkbzVIT3JBYVBLZjFjbm83ejZP?=
 =?utf-8?B?YVh3S2dIdHVQZVJWYXRnN0g3UWhiWjVaT0VNUDd1UnNjb2tCN2ZqeVlkNzIw?=
 =?utf-8?B?Qk9nMDh2S0Evc3hlL1I0amh6ekppUnBLczRqMFpnSnVNdXJvSTN4dXdPVVN1?=
 =?utf-8?B?Y01jNmwvTTJ6Q2VqZ1R4STFtUWVMQUxvRmdybzV3NDVtcVBPNDd5SUdCT21u?=
 =?utf-8?B?VnhGSVp6WjhaYkptbDl6L2NNWHErMEM5aXdPc240WlVad1lxcFMzck05dnl4?=
 =?utf-8?B?L25wNWFPUm1uQ1FIWEdObWx0OENLdTZJcUxGcldhTm5SamJRMnZ3Y3pFb2h4?=
 =?utf-8?B?eFc2bFJsWjhNTVYxTERNMm9oTWVzZ2FJemgzaEprMlN0b2o2aVNGcXhUQ0pK?=
 =?utf-8?B?MDZJeTJJODhLeUdlbVFFbnFJdmRuVXRDRFQ0QzVOQ1UrT1FPa1dHSlVPWE55?=
 =?utf-8?B?aXZSSWhFU0xjN0JPdmh1V1RlSnVjV2FaUzA0cGxZejRwbkVLYkMvNXA1K0l0?=
 =?utf-8?B?ZzlDU2w4WFo5QlBVSTJ6M2ZSOGVxTGNUU1pubjYvRTNrOGZRWXBpZHhIUkMw?=
 =?utf-8?B?enlpT0QvZlpOcFVjMDkybGRpTThNazM0RE5vN21jaElVRmw1cnJkR1djTG1t?=
 =?utf-8?B?aWxxMUdBUmhMT2JlMkp2UWM4dlhZUGJObEVyaFB1K2ZpdXVKcWd2amJNNDhk?=
 =?utf-8?B?QnFpcEtadGtGSXNjT2swbDE4M0xlK3Z5bXhGekk4bStkaThJVXJ5M3h2ZTJZ?=
 =?utf-8?B?aUhWQ0wxbkwreVMyNFNHRHlkd012NUU0eXJhYjM4Mk5yTFB6djhnWEZ6Y1Zs?=
 =?utf-8?B?YU9nTGJMU1d1Z2w4dnNCNkhNaFV4SnRaejNwLzVQdTN0cGZQUFdacFBYM2Jt?=
 =?utf-8?B?dkQyamVQMm9lQzQrNEh2RlNjVDd5ZktsOTJBVmtDY0hxZmRZa25jNVlGcTJ0?=
 =?utf-8?B?UkZuSFFKQlFrWmJlZE5VQ2p3dSt2eXF3Nm82UGRSMnZiK2QzSXhqUEFSQ3dp?=
 =?utf-8?B?M2RkSGU5KzhnbjNPWGVzOHN6bjZkNHZrNDFHY1Q4b3lUOVhjNUJET1psZnc3?=
 =?utf-8?B?L0UxY2s1M3cwSTJVUUtEUXlrcjBGZDZ0SUtrRmNjK3BpQURpV243L01WZ3BL?=
 =?utf-8?B?NUViMlloeDBueEtqaER5eis3RnNNSUhBdDlNQ3VpM29Pb2hMOGlBcXJQb05U?=
 =?utf-8?B?ejZzRTZEVU9ldlEzOUpqWTNHTkNwVkVsckt4S3k0OG1Lc0UvdGRwZ3BZL0Ey?=
 =?utf-8?B?MXRCNldDbUw5WklwTW1DblQzczFudWJzZ09mdHVobFJ1Q2pWZm9VOXRIdUUz?=
 =?utf-8?B?dDlSNHg5R1E5dEhtaFZVZ0JaZnhjS1ZtNmlzSm9YTVd5M2tlUitodWN3Z24z?=
 =?utf-8?B?YWZDZTV4aDFqWHhnY01XaGpBPT0=?=
x-microsoft-antispam-prvs: <VI1PR0501MB359869CF6987E9D8DD4AEAB8D14C0@VI1PR0501MB3598.eurprd05.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(13464003)(99286004)(53936002)(53546011)(97736004)(6436002)(8676002)(478600001)(52536013)(5660300002)(229853002)(71200400001)(71190400001)(9686003)(81166006)(106356001)(6506007)(7696005)(305945005)(105586002)(81156014)(55016002)(6246003)(76176011)(7736002)(6116002)(3846002)(86362001)(102836004)(486006)(54906003)(74316002)(2906002)(4326008)(110136005)(33656002)(93886005)(26005)(446003)(11346002)(476003)(66066001)(186003)(8936002)(316002)(25786009)(14454004)(68736007)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB3598;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h0n5/HFre/s/B+zEQl3okMLfMBiZ5FVMnkGkcli5Fv4ezRo/eIRsjTJfyFszFRUVbH+vcTJ/uX7b7T6daVKKH6Dx5g0dbBugJy4ZWWDvlJMvLP3cDEjHHP/zu+Uk/RL/6dywyySTaQ4E+RYM4QmfleB+J1rwZ8VSIsVVZrBE6lCfy593BY3Y+XqX6DqiHCl6fh3ohKAhH16zlZkW2FV3wxOGVsUDhzWQYCiYikHgp05xwtF5YmfAY3C0ubgKORF/+Z4G8x3lpI508oyF+DPKlI+x13+MCFEH1K1PnKyovdcOZHqt1UC5XWWmvWIR25jCbFWkaRuHqhJx/2h6luVTPFx+Wm5CWEZvE1M8Kb0grhX34GCejBzDSGkMUej/XH+b2FPai2fgfaNS1OamIoYIR81HlhXzW71rnCJ65lC1Mvk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e47dfb2-e123-4209-7ac1-08d6a342eb2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 21:21:52.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB3598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2lydGkgV2Fua2hlZGUg
PGt3YW5raGVkZUBudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggNywgMjAxOSAz
OjA4IFBNDQo+IFRvOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT47IEpha3ViIEtp
Y2luc2tpDQo+IDxqYWt1Yi5raWNpbnNraUBuZXRyb25vbWUuY29tPg0KPiBDYzogT3IgR2VybGl0
eiA8Z2VybGl0ei5vckBnbWFpbC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWljaGFsLmxrbWxAbWFya292aS5uZXQ7IGRhdmVt
QGRhdmVtbG9mdC5uZXQ7DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBKaXJpIFBpcmtv
IDxqaXJpQG1lbGxhbm94LmNvbT47IEFsZXgNCj4gV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29u
QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIG5ldC1uZXh0IDAvOF0gSW50cm9kdWNp
bmcgc3ViZGV2IGJ1cyBhbmQgZGV2bGluayBleHRlbnNpb24NCj4gDQo+IA0KPiANCj4gT24gMy84
LzIwMTkgMjozMiBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS2lydGkgV2Fua2hlZGUgPGt3YW5raGVk
ZUBudmlkaWEuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTWFyY2ggNywgMjAxOSAyOjU0IFBN
DQo+ID4+IFRvOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT47IEpha3ViIEtpY2lu
c2tpDQo+ID4+IDxqYWt1Yi5raWNpbnNraUBuZXRyb25vbWUuY29tPg0KPiA+PiBDYzogT3IgR2Vy
bGl0eiA8Z2VybGl0ei5vckBnbWFpbC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4gPj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWljaGFsLmxrbWxAbWFya292aS5uZXQ7
DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+ID4+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
OyBKaXJpIFBpcmtvIDxqaXJpQG1lbGxhbm94LmNvbT47IEFsZXgNCj4gPj4gV2lsbGlhbXNvbiA8
YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZDIG5ldC1u
ZXh0IDAvOF0gSW50cm9kdWNpbmcgc3ViZGV2IGJ1cyBhbmQgZGV2bGluaw0KPiA+PiBleHRlbnNp
b24NCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gPHNuaXA+DQo+ID4+DQo+ID4+Pj4+DQo+ID4+Pj4+
IFllcy4gSSBnb3QgbXkgcGF0Y2hlcyB0byBhZGFwdCB0byBtZGV2IHdheS4gV2lsbCBiZSBwb3N0
aW5nIFJGQyB2Mg0KPiBzb29uLg0KPiA+Pj4+PiBXaWxsIHdhaXQgZm9yIGEgZGF5IHRvIHJlY2Vp
dmUgbW9yZSBjb21tZW50cy92aWV3cyBmcm9tIEdyZWcgYW5kDQo+ID4+IG90aGVycy4NCj4gPj4+
Pj4NCj4gPj4+Pj4gQXMgSSBleHBsYWluZWQgaW4gdGhpcyBjb3Zlci1sZXR0ZXIgYW5kIGRpc2N1
c3Npb24sIEZpcnN0IHVzZSBjYXNlDQo+ID4+Pj4+IGlzIHRvIGNyZWF0ZSBhbmQgdXNlIG1kZXZz
IGluIHRoZSBob3N0IChhbmQgbm90IGluIFZNKS4NCj4gPj4+Pj4gTGF0ZXIgb24sIEkgYW0gc3Vy
ZSBvbmNlIHdlIGhhdmUgbWRldnMgYXZhaWxhYmxlLCBWTSB1c2VycyB3aWxsDQo+ID4+Pj4+IGxp
a2VseSB1c2UNCj4gPj4+PiBpdC4NCj4gPj4+Pj4NCj4gPj4+Pj4gU28sIG1seDVfY29yZSBkcml2
ZXIgd2lsbCBoYXZlIHR3byBjb21wb25lbnRzIGFzIHN0YXJ0aW5nIHBvaW50Lg0KPiA+Pj4+Pg0K
PiA+Pj4+PiAxLiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbWRldi9t
ZGV2LmMNCj4gPj4+Pj4gVGhpcyBpcyBtZGV2IGRldmljZSBsaWZlIGN5Y2xlIGRyaXZlciB3aGlj
aCB3aWxsIGRvLA0KPiA+Pj4+PiBtZGV2X3JlZ2lzdGVyX2RldmljZSgpDQo+ID4+Pj4gYW5kIGlt
cGxlbWVudHMgbWx4NV9tZGV2X29wcy4NCj4gPj4+Pj4NCj4gPj4+PiBPay4gSSB3b3VsZCBzdWdn
ZXN0IG5vdCB1c2UgbWRldi5jIGZpbGUgbmFtZSwgbWF5IGJlIGFkZCBkZXZpY2UNCj4gPj4+PiBu
YW1lLCBzb21ldGhpbmcgbGlrZSBtbHhfbWRldi5jIG9yIHZmaW9fbWx4LmMNCj4gPj4+Pg0KPiA+
Pj4gbWx4NS9jb3JlIGlzIGNvZGluZyBjb252ZW50aW9uIGlzIG5vdCBmb2xsb3dpbmcgdG8gcHJl
Zml4IG1seCB0byBpdHMNCj4gPj4+IDQwKw0KPiA+PiBmaWxlcy4NCj4gPj4+DQo+ID4+PiBpdCB1
c2VzIGFjdHVhbCBzdWJzeXN0ZW0gb3IgZnVuY3Rpb25hbGl0eSBuYW1lLCBzdWNoIGFzLCBzcmlv
di5jDQo+ID4+PiBlc3dpdGNoLmMgZncuYyBlbl90Yy5jIChlbiBmb3IgRXRoZXJuZXQpIGxhZy5j
IHNvLCBtZGV2LmMgYWxpZ25zIHRvDQo+ID4+PiByZXN0IG9mIHRoZSA0MCsgZmlsZXMuDQo+ID4+
Pg0KPiA+Pj4NCj4gPj4+Pj4gMi4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9j
b3JlL21kZXYvbWRldl9kcml2ZXIuYw0KPiA+Pj4+PiBUaGlzIGlzIG1kZXYgZGV2aWNlIGRyaXZl
ciB3aGljaCBkb2VzIG1kZXZfcmVnaXN0ZXJfZHJpdmVyKCkgYW5kDQo+ID4+Pj4+IHByb2JlKCkg
Y3JlYXRlcyBuZXRkZXYgYnkgaGVhdmlseSByZXVzaW5nIGV4aXN0aW5nIGNvZGUgb2YgdGhlIFBG
DQo+IGRldmljZS4NCj4gPj4+Pj4gVGhlc2UgZHJpdmVycyB3aWxsIG5vdCBiZSBwbGFjZWQgdW5k
ZXIgZHJpdmVycy92ZmlvL21kZXYsIGJlY2F1c2UNCj4gPj4+Pj4gdGhpcyBpcw0KPiA+Pj4+IG5v
dCBhIHZmaW8gZHJpdmVyLg0KPiA+Pj4+PiBUaGlzIGlzIGZpbmUsIHJpZ2h0Pw0KPiA+Pj4+Pg0K
PiA+Pj4+DQo+ID4+Pj4gSSdtIG5vdCB0b28gZmFtaWxpYXIgd2l0aCBuZXRkZXYsIGJ1dCBjYW4g
eW91IGNyZWF0ZSBuZXRkZXYgb24NCj4gPj4+PiBvcGVuKCkgY2FsbCBvbiBtbHggbWRldiBkZXZp
Y2U/IFRoZW4geW91IGRvbid0IGhhdmUgdG8gd3JpdGUgbWRldg0KPiA+Pj4+IGRldmljZQ0KPiA+
PiBkcml2ZXIuDQo+ID4+Pj4NCj4gPj4+IFdobyBpbnZva2VzIG9wZW4oKSBhbmQgcmVsZWFzZSgp
Pw0KPiA+Pj4gSSBiZWxpZXZlIGl0IGlzIHRoZSBxZW11IHdvdWxkIGRvIG9wZW4oKSwgcmVsZWFz
ZSwgcmVhZC93cml0ZS9tbWFwPw0KPiA+Pj4NCj4gPj4+IEFzc3VtaW5nIHRoYXQgaXMgdGhlIGNh
c2UsDQo+ID4+PiBJIHRoaW5rIGl0cyBpbmNvcnJlY3QgdG8gY3JlYXRlIG5ldGRldiBpbiBvcGVu
Lg0KPiA+Pj4gQmVjYXVzZSB3aGVuIHdlIHdhbnQgdG8gbWFwIHRoZSBtZGV2IHRvIFZNIHVzaW5n
IGFib3ZlIG1kZXYgY2FsbHMsDQo+ID4+PiB3ZQ0KPiA+PiBhY3R1YWxseSB3b250IGJlIGNyZWF0
aW5nIG5ldGRldiBpbiBob3N0Lg0KPiA+Pj4gSW5zdGVhZCwgc29tZSBxdWV1ZXMgZXRjIHdpbGwg
YmUgc2V0dXAgYXMgcGFydCBvZiB0aGVzZSBjYWxscy4NCj4gPj4+DQo+ID4+PiBCeSBkZWZhdWx0
IHRoaXMgY3JlYXRlZCBtZGV2IGlzIGJvdW5kIHRvIHZmaW9fbWRldi4NCj4gPj4+IEFuZCBvbmNl
IHdlIHVuYmluZCB0aGUgZGV2aWNlIGZyb20gdGhpcyBkcml2ZXIsIHdlIG5lZWQgdG8gYmluZCB0
bw0KPiA+Pj4gbWx4NQ0KPiA+PiBkcml2ZXIgc28gdGhhdCBkcml2ZXIgY2FuIGNyZWF0ZSB0aGUg
bmV0ZGV2IGV0Yy4NCj4gPj4+DQo+ID4+PiBPciBkaWQgSSBnZXQgb3BlbigpIGFuZCBmcmllbmRz
IGNhbGwgd3Jvbmc/DQo+ID4+Pg0KPiA+Pg0KPiA+PiBJbiAnc3RydWN0IG1kZXZfcGFyZW50X29w
cycgdGhlcmUgYXJlIGNyZWF0ZSgpIGFuZCByZW1vdmUoKS4gV2hlbg0KPiA+PiB1c2VyIGNyZWF0
ZXMgbWRldiBkZXZpY2UgYnkgd3JpdGluZyBVVUlEIHRvIGNyZWF0ZSBzeXNmcywgdmVuZG9yDQo+
ID4+IGRyaXZlcidzDQo+ID4+IGNyZWF0ZSgpIGNhbGxiYWNrIGdldHMgY2FsbGVkLiBUaGlzIHNo
b3VsZCBiZSB1c2VkIHRvIGFsbG9jYXRlL2NvbW1pdA0KPiA+IFllcy4gSSBhbSBhbHJlYWR5IHBh
c3QgdGhhdCBzdGFnZS4NCj4gPg0KPiA+PiByZXNvdXJjZXMgZnJvbSBwYXJlbnQgZGV2aWNlIGFu
ZCBvbiByZW1vdmUoKSBjYWxsYmFjayBmcmVlIHRob3NlDQo+IHJlc291cmNlcy4NCj4gPj4gU28g
dGhlcmUgaXMgbm8gbmVlZCB0byBiaW5kIG1seDUgZHJpdmVyIHRvIHRoYXQgbWRldiBkZXZpY2Uu
DQo+ID4+DQo+ID4gSWYgd2UgZG9uJ3QgYmluZCBtbHg1IGRyaXZlciwgdmZpb19tZGV2IGRyaXZl
ciBpcyBib3VuZCB0byBpdC4gU3VjaCBkcml2ZXINCj4gd29uJ3QgY3JlYXRlIG5ldGRldi4NCj4g
DQo+IERvZXNuJ3QgbmVlZCB0by4NCj4gDQo+IENyZWF0ZSBuZXRkZXYgZnJvbSBjcmVhdGUoKSBj
YWxsYmFjay4NCj4gDQpJIHN0cm9uZ2x5IGJlbGlldmUgdGhpcyBpcyBpbmNvcnJlY3Qgd2F5IHRv
IHVzZSBjcmVhdGUoKSBBUEkuDQpCZWNhdXNlLA0KbWRldiBpcyBtZWRpYXRlZCBkZXZpY2UgZnJv
bSBpdHMgcHJpbWFyeSBwY2kgZGV2aWNlLiBJdCBpcyBub3QgYSBwcm90b2NvbCBkZXZpY2UuDQoN
Ckl0IGl0IGFsc28gaW5jb3JyZWN0IHRvIHRlbGwgdXNlciB0aGF0IHZmaW9fbWRldiBkcml2ZXIg
aXMgYm91bmQgdG8gdGhpcyBtZGV2IGFuZCBtbHg1X2NvcmUgZHJpdmVyIGNyZWF0aW5nIG5ldGRl
diBvbiB0b3Agb2YgbWRldi4NCg0KV2hlbiB3ZSB3YW50IHRvIG1hcCB0aGlzIG1kZXYgdG8gVk0s
IHdoYXQgc2hvdWxkIGNyZWF0ZSgpIGRvPw0KV2Ugd2lsbCBoYXZlIHRvIHNoaWZ0IHRoZSBjb2Rl
IGZyb20gY3JlYXRlKCkgdG8gbWRldl9kZXZpY2VfZHJpdmVyKCktPnByb2JlKCkgdG8gYWRkcmVz
cyBhIHVzZSBjYXNlIG9mIHNlbGVjdGl2ZWx5IG1hcHBpbmcgYSBtZGV2IHRvIFZNIG9yIHRvIGhv
c3QgYW5kIGltcGxlbWVudCBhcHByb3ByaWF0ZSBvcGVuL2Nsb3NlIGV0YyBmdW5jdGlvbnMgZm9y
IFZNIGNhc2UuDQoNClNvIHdoeSBub3Qgc3RhcnQgY29ycmVjdGx5IGZyb20gdGhlIGJlZ2lubmlu
Zz8NCg0KDQo+IFRoYW5rcywNCj4gS2lydGkNCj4gDQo+ID4gQWdhaW4sIHdlIGRvIG5vdCB3YW50
IHRvIG1hcCB0aGlzIG1kZXYgdG8gYSBWTS4NCj4gPiBXZSB3YW50IHRvIGNvbnN1bWUgaXQgaW4g
dGhlIGhvc3Qgd2hlcmUgbWRldiBpcyBjcmVhdGVkLg0KPiA+IFNvIEkgYW0gYWJsZSB0byBkZXRh
Y2ggdGhpcyBtZGV2IGZyb20gdmZpb19tZGV2IGRyaXZlciBhcyB1c2F1YWwgdXNpbmcNCj4gPiAk
IGVjaG8gbWRldl9uYW1lID4gLi4vZHJpdmVycy92ZmlvX21kZXYvdW5iaW5kDQo+ID4NCj4gPiBG
b2xsb3dlZCBieSBiaW5kaW5nIGl0IHRvIG1seDVfY29yZSBkcml2ZXIuDQo+ID4NCj4gPiBCZWxv
dyBpcyBzYW1wbGUgb3V0cHV0IGJlZm9yZSBiaW5kaW5nIGl0IHRvIG1seDVfY29yZSBkcml2ZXIu
DQo+ID4gV2hlbiB3ZSBiaW5kIHdpdGggbWx4NV9jb3JlIGRyaXZlciwgdGhhdCBkcml2ZXIgY3Jl
YXRlcyB0aGUgbmV0ZGV2IGluDQo+IGhvc3QuDQo+ID4gSWYgdXNlciB3YW50cyB0byBtYXAgdGhp
cyBtZGV2IHRvIFZNLCB1c2VyIHdvbid0IGJpbmQgdG8gbWx4NV9jb3JlIGRyaXZlci4NCj4gaW5z
dGVhZCBoZSB3aWxsIGJpbmQgdG8gdmZpbyBkcml2ZXIgYW5kIHRoYXQgZG9lcyB1c3VhbCBvcGVu
L3JlbGVhc2UvLi4uDQo+ID4NCj4gPg0KPiA+IGxyd3hyd3hyd3ggMSByb290IHJvb3QgMCBNYXIg
IDcgMTQ6MjQNCj4gPiA2OWVhMTU1MS1kMDU0LTQ2ZTktOTc0ZC04ZWRhZThmMGFlZmUgLT4NCj4g
PiAuLi8uLi8uLi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowMi4yLzAwMDA6MDU6MDAuMC82
OWVhMTU1MS1kMDU0LTQ2DQo+ID4gZTktOTc0ZC04ZWRhZThmMGFlZmUNCj4gPiBbcm9vdEBzdy1t
dHgtMDM2IG5ldC1uZXh0XSMgbHMgLWwNCj4gPiAvc3lzL2J1cy9tZGV2L2RldmljZXMvNjllYTE1
NTEtZDA1NC00NmU5LTk3NGQtOGVkYWU4ZjBhZWZlLw0KPiA+IHRvdGFsIDANCj4gPiBscnd4cnd4
cnd4IDEgcm9vdCByb290ICAgIDAgTWFyICA3IDE0OjI0IGRyaXZlciAtPg0KPiAuLi8uLi8uLi8u
Li8uLi9idXMvbWRldi9kcml2ZXJzL3ZmaW9fbWRldg0KPiA+IGxyd3hyd3hyd3ggMSByb290IHJv
b3QgICAgMCBNYXIgIDcgMTQ6MjQgaW9tbXVfZ3JvdXAgLT4NCj4gLi4vLi4vLi4vLi4vLi4va2Vy
bmVsL2lvbW11X2dyb3Vwcy8wDQo+ID4gbHJ3eHJ3eHJ3eCAxIHJvb3Qgcm9vdCAgICAwIE1hciAg
NyAxNDoyNCBtZGV2X3R5cGUgLT4NCj4gLi4vbWRldl9zdXBwb3J0ZWRfdHlwZXMvbWx4NV9jb3Jl
LW1nbXQNCj4gPiBkcnd4ci14ci14IDIgcm9vdCByb290ICAgIDAgTWFyICA3IDE0OjI0IHBvd2Vy
DQo+ID4gLS13LS0tLS0tLSAxIHJvb3Qgcm9vdCA0MDk2IE1hciAgNyAxNDoyNCByZW1vdmUNCj4g
PiBscnd4cnd4cnd4IDEgcm9vdCByb290ICAgIDAgTWFyICA3IDE0OjI0IHN1YnN5c3RlbSAtPiAu
Li8uLi8uLi8uLi8uLi9idXMvbWRldg0KPiA+IC1ydy1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBN
YXIgIDcgMTQ6MjQgdWV2ZW50DQo+ID4NCj4gPj4gb3Blbi9yZWxlYXNlL3JlYWQvd3JpdGUvbW1h
cC9pb2N0bCBhcmUgcmVndWxhciBmaWxlIG9wZXJhdGlvbnMgZm9yDQo+ID4+IHRoYXQgbWRldiBk
ZXZpY2UuDQo+ID4+DQo+ID4NCj4gPj4gVGhhbmtzLA0KPiA+PiBLaXJ0aQ0KPiA+DQo=
