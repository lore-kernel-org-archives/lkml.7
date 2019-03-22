Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B06CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082F721917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2SPXe7l4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCVTFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:05:30 -0400
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:58115
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfCVTFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LikiyV2jklCfXH0DRkXIXTxC9rImI16qYurmTCtibck=;
 b=2SPXe7l4Itis6+1y6z/zNQlvWMkATK0x7JFjTYmmgieYTaNOwZejV4WhyQyCyh+pBzv+tv1axgxFV7agVQB+xZWVfKZ/zRatSGVfFl6QGUn1FWdyOxHjaU5n6HHHST0Eo433Rydl5YR6Ym+y99NPObFOSj7pvEkcEIeLVP3j2gA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2735.namprd12.prod.outlook.com (52.135.107.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 22 Mar 2019 19:05:27 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 19:05:27 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v2 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Thread-Topic: [PATCH v2 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Thread-Index: AQHU4CQyTsE/SKvH9kGTin5rcQxftKYX59CAgAAcR4A=
Date:   Fri, 22 Mar 2019 19:05:27 +0000
Message-ID: <0a3f1341-35ec-a462-1f3f-a1c5cfe6decd@amd.com>
References: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
 <20190322172405.GJ12472@zn.tnic>
In-Reply-To: <20190322172405.GJ12472@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:406:ee::36) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f87d23ae-0a6a-44a4-3d97-08d6aef95846
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2735;
x-ms-traffictypediagnostic: SN6PR12MB2735:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB27357C43290F18562397A559F8430@SN6PR12MB2735.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(486006)(476003)(14444005)(2616005)(229853002)(446003)(316002)(6306002)(6486002)(54906003)(6512007)(36756003)(8676002)(11346002)(68736007)(71190400001)(86362001)(97736004)(966005)(256004)(72206003)(478600001)(71200400001)(8936002)(26005)(6436002)(6246003)(186003)(6916009)(3846002)(14454004)(6116002)(25786009)(2906002)(5660300002)(4326008)(53936002)(106356001)(105586002)(31696002)(81156014)(81166006)(66066001)(31686004)(102836004)(6506007)(53546011)(305945005)(52116002)(99286004)(386003)(7736002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2735;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3liOsZlktYzSnMQSBeLy/cahFXlmoKHL54kRkuWgdifO+Fws8WRZB4iKdAU011iMm2qPNfRNdLFqxNO400obbkEMY6iAp3pAvkDKyKqP23NUyIP1AbNqGCXwZOs123cGTJPsu/1NOXkFV3uuv69XQQ1onoSLrquVa5fIDaHIsMmEBJiUrWAyw18HEp3zzaaaC7eHfYoTnUVP8xIc3t732TsDKoIfP8j+o9CsqaCv50Ns3y72V2Ac1fwABAICIR0GnKOT+hb7boJy2EN8PIAgKsAzsvjUzi+SuW+5JxdjUUrRKv0zzwvc5PJ9bRVIOL60yseV3/Cgs4yiFnscM7K5E6pREG13H7zBPEx/N2OMB1b96RgDV4rX/RckHxtwZggQr54TQVZCbp8vXncIYpqIq4qwHXI/XApsn7um7V0QWsg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A890DE12BF29F48897EC13F0EF4C8CB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87d23ae-0a6a-44a4-3d97-08d6aef95846
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 19:05:27.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMi8yMDE5IDEyOjI0IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIFRodSwg
TWFyIDIxLCAyMDE5IGF0IDA4OjI1OjE3UE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0K
Pj4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPj4NCj4+IFNv
bWUgc3lzdGVtcyBtYXkgcmVwb3J0IHNwdXJpb3VzIE1DQSBlcnJvcnMuIEluIGdlbmVyYWwsIHNw
dXJpb3VzIE1DQQ0KPj4gZXJyb3JzIG1heSBiZSBkaXNhYmxlZCBieSBjbGVhcmluZyBhIHBhcnRp
Y3VsYXIgYml0IGluIE1DQV9DVEwuIEhvd2V2ZXIsDQo+PiBjbGVhcmluZyBhIGJpdCBpbiBNQ0Ff
Q1RMIG1heSBub3QgYmUgcmVjb21tZW5kZWQgZm9yIHNvbWUgZXJyb3JzLCBzbyB0aGUNCj4+IG9u
bHkgb3B0aW9uIGlzIHRvIGlnbm9yZSB0aGVtLg0KPj4NCj4+IEFuIE1DQSBlcnJvciBpcyBwcmlu
dGVkIGFuZCBoYW5kbGVkIGFmdGVyIGl0IGhhcyBiZWVuIGFkZGVkIHRvIHRoZSBNQ0UNCj4+IGV2
ZW50IHBvb2wuIFNvIGFuIE1DQSBlcnJvciBjYW4gYmUgaWdub3JlZCBieSBub3QgYWRkaW5nIGl0
IHRvIHRoZSBwb29sLg0KPj4NCj4+IENyZWF0ZSBhIGZ1bmN0aW9uIHBvaW50ZXIgdG8gZmlsdGVy
IE1DQSBlcnJvcnMgYW5kIHVzZSB0aGlzIHdoZW4gYWRkaW5nDQo+PiBhbiBlcnJvciB0byB0aGUg
TUNFIGV2ZW50IHBvb2wuDQo+Pg0KPj4gSW5zdGFsbCBhIGRlZmF1bHQgZnVuY3Rpb24gdGhhdCBk
b2VzIG5vdCBmaWx0ZXIgYW55IGVycm9ycy4NCj4+DQo+PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmc+ICMgNC4xNC54DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXplbi5n
aGFubmFtQGFtZC5jb20+DQo+PiAtLS0NCj4+IExpbms6DQo+PiBodHRwczovL2xrbWwua2VybmVs
Lm9yZy9yLzIwMTkwMzA3MjEyNTUyLjg4NjUtMS1ZYXplbi5HaGFubmFtQGFtZC5jb20NCj4+DQo+
PiB2MS0+djI6DQo+PiAqIFRoaXMgaXMgYSBuZXcgcGF0Y2ggcmVwbGFjaW5nIFYxIFBhdGNoIDEg
d2hpY2ggaXMgbm8gbG9uZ2VyIG5lZWRlZC4NCj4+DQo+PiAgYXJjaC94ODYvaW5jbHVkZS9hc20v
bWNlLmggICAgICAgIHwgMyArKysNCj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMg
ICAgfCA2ICsrKysrKw0KPj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2dlbnBvb2wuYyB8IDMg
KysrDQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21jZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
bWNlLmgNCj4+IGluZGV4IDIyZDA1ZTM4MzVmMC4uMGIwYjc5N2E5NTljIDEwMDY0NA0KPj4gLS0t
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbWNlLmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL21jZS5oDQo+PiBAQCAtMjUzLDYgKzI1Myw5IEBAIGV4dGVybiB2b2lkIG1jZV9kaXNhYmxl
X2JhbmsoaW50IGJhbmspOw0KPj4gIGV4dGVybiB2b2lkICgqbWFjaGluZV9jaGVja192ZWN0b3Ip
KHN0cnVjdCBwdF9yZWdzICosIGxvbmcgZXJyb3JfY29kZSk7DQo+PiAgdm9pZCBkb19tYWNoaW5l
X2NoZWNrKHN0cnVjdCBwdF9yZWdzICosIGxvbmcpOw0KPj4gIA0KPj4gKy8qIEZpbHRlciBNQ0Vz
IGZyb20gdGhlIGRlY29kZXIgY2hhaW4uICovDQo+IA0KPiBUaGF0IHNob3VsZCBiZSBzb21ldGhp
bmcgbGlrZToNCj4gDQo+IC8qIERlY2lkZXMgd2hldGhlciB0byBhZGQgTUNFIHJlY29yZHMgdG8g
dGhlIGRlY29kZXIgY2hhaW4gb3IgZmlsdGVyIHRoZW0gb3V0LiAqLw0KPiANCg0KT2theS4gSSds
bCBtYWtlIGEgY2hhbmdlLg0KDQo+PiArZXh0ZXJuIGJvb2wgKCpmaWx0ZXJfbWNlKShzdHJ1Y3Qg
bWNlICptKTsNCj4+ICsNCj4+ICAvKg0KPj4gICAqIFRocmVzaG9sZCBoYW5kbGVyDQo+PiAgICov
DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIGIvYXJjaC94
ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+PiBpbmRleCBiN2ZiNTQxYTQ4NzMuLmVmZmI0MDU4
MWYwOCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPj4g
KysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+PiBAQCAtMTc3MSw2ICsxNzcx
LDEyIEBAIHN0YXRpYyB2b2lkIF9fbWNoZWNrX2NwdV9pbml0X3RpbWVyKHZvaWQpDQo+PiAgCW1j
ZV9zdGFydF90aW1lcih0KTsNCj4+ICB9DQo+PiAgDQo+PiArLyoNCj4+ICsgKiBEb24ndCBmaWx0
ZXIgTUNFcyBieSBkZWZhdWx0LiBJbnN0YWxsIGEgc3lzdGVtLXNwZWNpZmljIGZ1bmN0aW9uLCBp
ZiBuZWVkZWQuDQo+PiArICovDQo+IA0KPiBUaGF0IGNvbW1lbnQgaXMga2luZGEgb2J2aW91cy4N
Cj4gDQoNCk9rYXkuIEknbGwgZHJvcCBpdC4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
