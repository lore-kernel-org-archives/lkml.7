Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163EEC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06872133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qvcVGZD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfFYO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:26:59 -0400
Received: from mail-eopbgr820082.outbound.protection.outlook.com ([40.107.82.82]:58593
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbfFYO07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZStuvMKBi2BKrtLe/Egtuhh8Ck6pOv83bCeEJHA2aw=;
 b=qvcVGZD7h/44+lZ3Do8HhC7DjgFogP/FIZENFgIS2pSJmIRqxP7hsy0M98JsST1rJp0uJS3BAvj+/lT4rd9A2t3mPOkfXcUjI2aoBsKaaMxJdpzXTResKBtTL52jdG7EOSCMJ3y/C0l5WFkQ/brlv6pAIJZQBZaNgXHPRmiGpM4=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1915.namprd12.prod.outlook.com (10.175.88.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 14:26:54 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935%6]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 14:26:54 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>
CC:     "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Koo, Anthony" <Anthony.Koo@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Lei, Jun" <Jun.Lei@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amd/display: Use msleep instead of udelay for 8ms
 wait
Thread-Topic: [PATCH] drm/amd/display: Use msleep instead of udelay for 8ms
 wait
Thread-Index: AQHVK16Svj0Y/YF920ebwK/y+5gVmKasaT2AgAAEDAA=
Date:   Tue, 25 Jun 2019 14:26:54 +0000
Message-ID: <e4dafd8a-8d14-63cb-f793-4d784051d2a0@amd.com>
References: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
 <20190625140046.31682-1-harry.wentland@amd.com>
 <1561471935.2587.11.camel@pengutronix.de>
In-Reply-To: <1561471935.2587.11.camel@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM5PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::24) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a7d670b-80bc-4abe-fc7f-08d6f9792b95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1915;
x-ms-traffictypediagnostic: DM5PR12MB1915:
x-microsoft-antispam-prvs: <DM5PR12MB1915233F47813131817EF3E283E30@DM5PR12MB1915.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(53936002)(186003)(2201001)(65956001)(99286004)(4326008)(6506007)(386003)(86362001)(25786009)(6116002)(31696002)(6486002)(52116002)(6436002)(65806001)(76176011)(31686004)(229853002)(2906002)(71190400001)(478600001)(71200400001)(65826007)(72206003)(102836004)(6512007)(2501003)(6246003)(256004)(68736007)(5660300002)(7736002)(73956011)(66476007)(14454004)(66446008)(66556008)(66946007)(64756008)(36756003)(54906003)(110136005)(64126003)(58126008)(46003)(316002)(8676002)(8936002)(81166006)(81156014)(446003)(305945005)(11346002)(2616005)(476003)(486006)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1915;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4i5XY2eknywjz0F0KOhSBYp5JUNU15ibn5SeNvmQlJBOff6h9XnB4ahz+d7X1ZNMg6KM91ML+PoVhYpUuCb1ORYFJOhYtrjzlPr2K1o3JPKDTFuesl61pwmT669BwWLWCewtwEqjwi4W73PmYsMQQUAddEI06z73lhAFhKrRdDifzF5zkyEtl/V1MZR6pcCGD8Fsa4qMdcDewG3Ti3g/hDKqqM/m07gZFFx7nc11jmEEbx+9BX5MOIxp2axi6I0Vi+9BJ4c34hQJqEwq2Narymb6Bpj3i1exf+Xxe8RwWyMkBOcktffhnZzRXKrWBm5hFkrMwg7j8pHjNmMH6eRBg4ZLGWTBfpu8XgMbPGt0avhCObOzk+vnWGi0WMDjjYiisZ9NkhI1e+MPiUiOAVUmjWIhsOrm04sdbXeGTl0exn0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F90D05C997421459DAEF498451C0EF2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7d670b-80bc-4abe-fc7f-08d6f9792b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:26:54.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjUuMDYuMTkgdW0gMTY6MTIgc2NocmllYiBMdWNhcyBTdGFjaDoNCj4gSGkgSGFycnksDQo+
DQo+IEFtIERpZW5zdGFnLCBkZW4gMjUuMDYuMjAxOSwgMTA6MDAgLTA0MDAgc2NocmllYiBIYXJy
eSBXZW50bGFuZDoNCj4+IGFybTMyJ3MgdWRlbGF5IG9ubHkgYWxsb3dzIHZhbHVlcyB1cCB0byAy
MDAwIG1pY3Jvc2Vjb25kcy4gbXNsZWVwDQo+PiBkb2VzIHRoZSB0cmljayBmb3IgdXMgaGVyZSBh
cyB0aGVyZSBpcyBubyBwcm9ibGVtIGlmIHRoaXMgaXNuJ3QNCj4+IG1pY3Jvc2Vjb25kIGFjY3Vy
YXRlIGFuZCB0YWtlcyBhIHRhZCBsb25nZXIuDQo+IEEgInRhZCIgbG9uZ2VyIGluIHRoaXMgY2Fz
ZSBtZWFucyBsaWtlbHkgZG91YmxlIHRoZSBpbnRlbmRlZCB3YWl0Lg0KPiBQbGVhc2Ugc2VlICJT
TEVFUElORyBGT1IgflVTRUNTIE9SIFNNQUxMIE1TRUNTICggMTB1cyAtIDIwbXMpIiBpbg0KPiBE
b2N1bWVudGF0aW9uL3RpbWVycy90aW1lcnMtaG93dG8udHh0Lg0KDQpPaCwgdGhhbmtzIHNvIG11
Y2ggZm9yIHRoZSBsaW5rISBJIHdhcyBzZWFyY2hpbmcgZGVzcGVyYXRlbHkgZm9yIHRoaXMgDQp0
aGUgbGFzdCB0aW1lIHRoaXMgY2FtZSB1cCBhbmQgY291bGRuJ3QgZmluZCBpdC4NCg0KQ2xlYXJs
eSBnb2luZyB0byByZW1lbWJlciBub3cgd2hlcmUgdG8gZmluZCB0aGF0Lg0KDQpUaGFua3MsDQpD
aHJpc3RpYW4uDQoNCj4NCj4gVGhlIHNsZWVwIGhlcmUgc2hvdWxkIHVzZSB1c2xlZXBfcmFuZ2Uu
IEluIGdlbmVyYWwgdGhlIERDIGNvZGUgc2VlbXMgdG8NCj4gdXNlIHF1aXRlIGEgbG90IG9mIHRo
ZSB1ZGVsYXkgYnVzeSB3YWl0cy4gSSBkb3VidCB0aGF0IG1hbnkgb2YgdGhvc2UNCj4gb2NjdXJy
ZW5jZXMgYXJlIGluIGF0b21pYyBjb250ZXh0LCBzbyBjb3VsZCBlYXNpbHkgdXNlIGEgc2xlZXBp
bmcgd2FpdC4NCj4NCj4gRGlnZ2luZyBmdXJ0aGVyIHRoaXMgc2VlbXMgdG8gYXBwbHkgYWNyb3Nz
IGFtZGdwdSwgbm90IG9ubHkgREMuDQo+DQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCj4+IC0t
LQ0KPj4gIMKgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwg
MiArLQ0KPj4gIMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjX2xpbmsuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19s
aW5rLmMNCj4+IGluZGV4IDRjMzE5MzBmMWNkZi4uZjVkMDJmODliM2Y5IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jDQo+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4+IEBAIC01
NDgsNyArNTQ4LDcgQEAgc3RhdGljIHZvaWQNCj4+IHJlYWRfZWRwX2N1cnJlbnRfbGlua19zZXR0
aW5nc19vbl9kZXRlY3Qoc3RydWN0IGRjX2xpbmsgKmxpbmspDQo+PiAgwqAJCQlicmVhazsNCj4+
ICDCoAkJfQ0KPj4gICANCj4+IC0JCXVkZWxheSg4MDAwKTsNCj4+ICsJCW1zbGVlcCg4KTsNCj4+
ICDCoAl9DQo+PiAgIA0KPj4gIMKgCUFTU0VSVChzdGF0dXMgPT0gRENfT0spOw0KDQo=
