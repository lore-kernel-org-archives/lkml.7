Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF107C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723D0217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uwy.onmicrosoft.com header.i=@uwy.onmicrosoft.com header.b="FuPD6vCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfDSWoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:44:46 -0400
Received: from mail-eopbgr770115.outbound.protection.outlook.com ([40.107.77.115]:57753
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfDSWoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwy.onmicrosoft.com;
 s=selector1-uwyo-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiAuyR5KdUF+Rd9F4P6zD2OxrNDm2E/VISMF0L00TLU=;
 b=FuPD6vCxuWufTPa3jnDEJ3VEzvWVrXj/McN0HYNvCzP0BcFUX4CgJaoyusYFamaOGHl/3FumMetjZ48H/hBNIYIVHxgMyZwHUwVuQBPU7Meu8sziIgcx6bQ3HANE+3BM4twzBGKZ5ETprw9CJroJB2vmDhJs8WWwagH8/DU9aco=
Received: from DM6PR05MB5259.namprd05.prod.outlook.com (20.177.223.223) by
 DM6PR05MB4140.namprd05.prod.outlook.com (20.176.72.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.6; Fri, 19 Apr 2019 22:44:04 +0000
Received: from DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::ed6e:ffe4:83a:29c7]) by DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::ed6e:ffe4:83a:29c7%4]) with mapi id 15.20.1813.011; Fri, 19 Apr 2019
 22:44:04 +0000
From:   "Robert R. Howell" <RHowell@uwyo.edu>
To:     Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Topic: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Index: AQHU6eBClqunF/byekqefGejWfaC+aYqIfOAgAcThICAAL18AIAFeNOAgAp38wCAAktGAA==
Date:   Fri, 19 Apr 2019 22:44:04 +0000
Message-ID: <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
 <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
In-Reply-To: <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [208.45.13.3]
x-clientproxiedby: SN6PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:805:2a::30) To DM6PR05MB5259.namprd05.prod.outlook.com
 (2603:10b6:5:7f::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RHowell@uwyo.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85a0ea2c-6c60-4d97-30f5-08d6c5188615
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR05MB4140;
x-ms-traffictypediagnostic: DM6PR05MB4140:
x-microsoft-antispam-prvs: <DM6PR05MB4140A835F6B14A67B41397D5D3270@DM6PR05MB4140.namprd05.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(66946007)(8936002)(75432002)(65826007)(64126003)(2501003)(7736002)(6486002)(26005)(71200400001)(2906002)(305945005)(81166006)(72206003)(86362001)(66476007)(4326008)(93886005)(31696002)(88552002)(81156014)(478600001)(52116002)(14454004)(11346002)(316002)(65806001)(36756003)(110136005)(786003)(71190400001)(107886003)(80792005)(3846002)(2616005)(446003)(486006)(66556008)(31686004)(99286004)(97736004)(6116002)(8676002)(229853002)(5660300002)(58126008)(386003)(14444005)(54906003)(6506007)(6246003)(76176011)(53546011)(68736007)(53936002)(102836004)(6436002)(25786009)(65956001)(66066001)(476003)(256004)(73956011)(6512007)(66446008)(186003)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR05MB4140;H:DM6PR05MB5259.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uwyo.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BlTHPtLXecE2u6XVhgUBGuFFjXGI+5ieevZ3xqz/9Tbsghd8+tmuBWGymVKDo8Bkh20iLAmi6V1q0VqKkdRT0+Y1yGdIYsOgHiyTF3HqJaYKqR1Ig+Dct/UOXoYYiErV9vqSoiObUD88ZQOcKsbGHoCIOVIc3GgeLgvgABxT5uQr/LEjhwg4ofGU53fxMLufUuhcyC+BRtezWvTcJAd46bcYa42c6taJdV5Zd09s2Jvby4cbqQwF5RRTCtwoDiDlzEf/cd2Ao5rPgpE5OJifwVKrPPRB3ioktVc2EXEy13pN3t/bSZpfb9Hplc0PTLJ+xBspXlBk4rdbEZ0n2Fpi9EaUCatWQnnsYtnwES2cw8OApuxJiDW1jpdrKgJLvh0nBBmnqEETRumvaGv2a56tPshx5jZbwgE2Yt6M8vWTMbc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5503D6600E9354FA5A0BF32F78DB661@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uwyo.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a0ea2c-6c60-4d97-30f5-08d6c5188615
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 22:44:04.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9cdd7ad-825d-4601-8e9c-a325e02d52da
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOC8xOSA1OjQyIEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KDQo+PiBPbiA0LzgvMTkg
MjoxNiBBTSwgSGFucyBkZSBHb2VkZSB3cm90ZTo+DQo+Pj4NCj4+PiBIbW0sIGludGVyZXN0aW5n
IHNvIHlvdSBoYXZlIGhpYmVybmF0aW9uIHdvcmtpbmcgb24gYSBUMTAwVEENCj4+PiAod2l0aCA1
LjAgKyAwMmU0NTY0NmQ1M2IgcmV2ZXJ0ZWQpLCByaWdodCA/DQo+Pj4NCg0KPiBTdGlsbCBzaW5j
ZSBteSBwYXRjaCBpcyByZWdyZXNzaW5nIHRoaW5ncyBmb3IgeW91IEkgd2lsbCB0cnkgdG8NCj4g
dGFrZSBhIGxvb2sgYXQgdGhpcyBhbmQgc2VlIGlmIEkgY2FuIHJlcHJvZHVjZSBhbmQgY29tZSB1
cCB3aXRoDQo+IGEgZml4LiBCdXQgdGhpcyBpcyBub3QgZ29pbmcgdG8gYmUgYSBoaWdoIHByaW9y
aXR5IHRoaW5nIGZvciBtZSB0bw0KPiB3b3JrIG9uLg0KPiANCj4gSW4gdGhlIG1lYW4gdGltZSBJ
J3ZlIGdvbmUgYWhlYWQgYW5kIHN1Ym1pdHRlZCBteSB2ZXJzaW9uIG9mIHRoZQ0KPiBmaXggZm9y
IHRoZSBwcm9ibGVtIEthaS1IZW5nIHdhcyBzZWVpbmcsIHNpbmNlIHRoYXQgZG9lcyBub3Qgc2Vl
bQ0KPiB0byBtYWtlIHlvdXIgcHJvYmxlbSB3b3JzZTsgYW5kIGl0IHdpbGwgYmUgZ29vZCB0byBn
ZXQgdGhhdCBwcm9ibGVtDQo+IGZpeGVkLg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCj4g
DQoNCkkndmUgbWFuYWdlZCB0byBmaW5kIGEgd2F5IGFyb3VuZCB0aGUgaTJjX2Rlc2lnbndhcmUg
dGltZW91dCBpc3N1ZXMNCm9uIHRoZSBUMTAwVEEncy4gIFRoZSBrZXkgaXMgdG8gTk9UIHNldCBE
UE1fRkxBR19TTUFSVF9TVVNQRU5ELA0Kd2hpY2ggd2FzIGFkZGVkIGluIHRoZSAwMmU0NTY0NmQ1
M2IgY29tbWl0Lg0KDQpUbyB0ZXN0IHRoYXQgSSd2ZSBzdGFydGVkIHdpdGggYSA1LjEtcmM1IGtl
cm5lbCwgYXBwbGllZCB5b3VyIHJlY2VudCBwYXRjaA0KdG8gYWNwaV9scHNzLmMsIHRoZW4gYXBw
bHkgdGhlIGZvbGxvd2luZyBwYXRjaCBvZiBtaW5lLCByZW1vdmluZyANCkRQTV9GTEFHX1NNQVJU
X1NVU1BFTkQuICAoRm9yIHRoZSBUMTAwIGhhcmR3YXJlIEkgbmVlZCB0byBhcHBseSBzb21lIA0K
b3RoZXIgcGF0Y2hlcyBhcyB3ZWxsIGJ1dCB0aG9zZSBhcmUgbm90IHJlbGF0ZWQgdG8gdGhlIGky
Yy1kZXNpZ253YXJlIG9yIA0KYWNwaSBpc3N1ZXMgYWRkcmVzc2VkIGhlcmUuKSAgDQoNCk9uIGEg
cmVzdW1lIGZyb20gaGliZXJuYXRpb24gSSBzdGlsbCBzZWUgb25lIGVycm9yOg0KICAiaTJjX2Rl
c2lnbndhcmUgODA4NjBGNDE6MDA6IEVycm9yIGkyY19kd194ZmVyIGNhbGxlZCB3aGlsZSBzdXNw
ZW5kZWQiDQpidXQgSSBubyBsb25nZXIgZ2V0IHRoZSBpMmNfZGVzaWdud2FyZSB0aW1lb3V0cywg
YW5kIGF1ZGlvIGRvZXMgbm93IHdvcmsNCmFmdGVyIHRoZSByZXN1bWUuDQoNClJlbW92aW5nIERQ
TV9GTEFHX1NNQVJUX1NVU1BFTkQgbWF5IG5vdCBiZSB3aGF0IHlvdSB3YW50IGZvciBvdGhlciAN
CmhhcmR3YXJlLCBidXQgcGVyaGFwcyB0aGlzIHdpbGwgZ2l2ZSB5b3UgYSBjbHVlIGFzIHRvIHdo
YXQgaXMgZ29pbmcNCndyb25nIHdpdGggaGliZXJuYXRlL3Jlc3VtZSBvbiB0aGUgVDEwMFRBJ3Mu
DQoNCldpdGggdGhlIGFib3ZlIG5vdyB3b3JraW5nIEkndmUgYWxzbyBleHBlcmltZW50ZWQgd2l0
aCBteSBzeXN0ZW1kDQpoaWJlcm5hdGUgc2NyaXB0IGFuZCBhdCBsZWFzdCBpbiBsaW1pdGVkIHRl
c3RpbmcgSSBvbmx5IG5lZWQgdG8NCnJlbW92ZSB0aGUgYnJjbWZtYWMgYW5kIGhjaV91YXJ0IGRy
aXZlcnMgYmVmb3JlIGhpYmVybmF0ZS4NCkkgbm8gbG9uZ2VyIG5lZWQgdG8gcmVtb3ZlIHNvdW5k
IGRyaXZlcnMgb3IgdGhlIG90aGVyIG9uZXMgc2hvd24gaW4gDQpteSBlYXJsaWVyIHNjcmlwdC4g
IFdpdGhvdXQgbW9yZSB0ZXN0aW5nIEknbSBub3Qgc3VyZSBhdCB3aGF0IHBvaW50DQppbiBrZXJu
ZWwgZGV2ZWxvcG1lbnQgdGhvc2Ugb3RoZXIgZHJpdmVyIHJlbW92YWxzIHN0b3BwZWQgYmVpbmcg
bmVjZXNzYXJ5Lg0KDQpMZXQgbWUga25vdyBpZiBJIGNhbiBkbyBhbnkgb3RoZXIgdGVzdHMgdG8g
aGVscC4NCg0KQm9iIEhvd2VsbA0KDQoNCg0KLS0tDQpkaWZmIC11cHJOIGxpbnV4X29yaWdpbmFs
L2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1wbGF0ZHJ2LmMgbGludXgvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLXBsYXRkcnYuYw0KLS0tIGxpbnV4X29yaWdpbmFs
L2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1wbGF0ZHJ2LmMJMjAxOS0wNC0xNCAx
NjoxNzo0MS4wMDAwMDAwMDAgLTA2MDANCisrKyBsaW51eC9kcml2ZXJzL2kyYy9idXNzZXMvaTJj
LWRlc2lnbndhcmUtcGxhdGRydi5jCTIwMTktMDQtMTggMjI6NDU6NTguODM2MjQ2ODg5IC0wNjAw
DQpAQCAtMzY3LDcgKzM2Nyw2IEBAIHN0YXRpYyBpbnQgZHdfaTJjX3BsYXRfcHJvYmUoc3RydWN0
IHBsYXQNCg0KIAlkZXZfcG1fc2V0X2RyaXZlcl9mbGFncygmcGRldi0+ZGV2LA0KIAkJCQlEUE1f
RkxBR19TTUFSVF9QUkVQQVJFIHwNCi0JCQkJRFBNX0ZMQUdfU01BUlRfU1VTUEVORCB8DQogCQkJ
CURQTV9GTEFHX0xFQVZFX1NVU1BFTkRFRCk7DQoNCiAJLyogVGhlIGNvZGUgYmVsb3cgYXNzdW1l
cyBydW50aW1lIFBNIHRvIGJlIGRpc2FibGVkLiAqLw0KLS0tDQo=
