Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9ECC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF2720693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uwy.onmicrosoft.com header.i=@uwy.onmicrosoft.com header.b="VZufO1H2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfDYQij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:38:39 -0400
Received: from mail-eopbgr780133.outbound.protection.outlook.com ([40.107.78.133]:60739
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfDYQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwy.onmicrosoft.com;
 s=selector1-uwyo-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtYKsbYd3gGTbyW/6oj+USV5dSU5y4w7yQKYIK9PIOM=;
 b=VZufO1H2F5fk1ghZDTN9PiPHBrxdGWKBzpW1k5Gp4d91eGcagyE5MoL/3sHSxC0oC6Lkz174ZaiMMnBRP7vHe/K9O9B8A/Ns+Qj8dMOZSnKMKJq4I08LhLUGHQ83dQrLuiWdtqeCd/h03PbcgRhMO0kOBsXXmJi6GqO5lWNAMXw=
Received: from DM6PR05MB5259.namprd05.prod.outlook.com (20.177.223.223) by
 DM6PR05MB4668.namprd05.prod.outlook.com (20.176.109.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.11; Thu, 25 Apr 2019 16:38:34 +0000
Received: from DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::7537:83ea:1eaa:75ab]) by DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::7537:83ea:1eaa:75ab%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 16:38:34 +0000
From:   "Robert R. Howell" <RHowell@uwyo.edu>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Topic: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Index: AQHU6eBClqunF/byekqefGejWfaC+aYqIfOAgAcThICAAL18AIAFeNOAgAp38wCAAktGAIAFVH4AgADH4wCAAL1BAIACLkCA
Date:   Thu, 25 Apr 2019 16:38:34 +0000
Message-ID: <beab21cb-9f89-b934-e0a4-2fd85c69f4e6@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
 <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
 <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
 <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
 <144b56d4-54e6-bccd-4652-22303bcd9168@uwyo.edu>
 <CAJZ5v0jJEovXXiqs-tzPC7FsGjGL+qxfXCxbTrQZqAxSCv1oyQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJEovXXiqs-tzPC7FsGjGL+qxfXCxbTrQZqAxSCv1oyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [208.45.14.192]
x-clientproxiedby: SN4PR0701CA0021.namprd07.prod.outlook.com
 (2603:10b6:803:28::31) To DM6PR05MB5259.namprd05.prod.outlook.com
 (2603:10b6:5:7f::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RHowell@uwyo.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed3948a1-3baa-4276-4f15-08d6c99c7576
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR05MB4668;
x-ms-traffictypediagnostic: DM6PR05MB4668:
x-microsoft-antispam-prvs: <DM6PR05MB4668536F046727004BFF6304D33D0@DM6PR05MB4668.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(478600001)(72206003)(14444005)(256004)(14454004)(66066001)(5024004)(65956001)(3846002)(53936002)(186003)(58126008)(316002)(75432002)(36756003)(54906003)(71200400001)(71190400001)(99286004)(52116002)(76176011)(65806001)(26005)(102836004)(25786009)(6436002)(386003)(6506007)(53546011)(73956011)(229853002)(66476007)(66946007)(64756008)(66556008)(6486002)(66446008)(6116002)(68736007)(80792005)(97736004)(31696002)(486006)(6246003)(446003)(64126003)(4326008)(31686004)(81166006)(8936002)(81156014)(8676002)(7736002)(88552002)(305945005)(6512007)(786003)(93886005)(476003)(6916009)(5660300002)(2906002)(86362001)(65826007)(11346002)(107886003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR05MB4668;H:DM6PR05MB5259.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uwyo.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qiJ+IdyNCQwtjQjZgoYa8kjzAAHi/O7RmWZGJEmnCC65bKbLO/xGDyc4lFW6dH6VIeQL7Fy2b42RTdfbyafKZavPxX2sFSGwxZbQyH3W22XgOuPCbS3WHgCgXUH7/07Gm3ni39z0NB0YwzdShKsSLcOrnOy/kXrQ4nT3K40nJLeT/VGKTVH5Iz3fvFl/pToYFhkjDuB7S2zLp4zVVinAL7KrcakUNSMLwAiozq9BzhOxcutaSbFBx5sasdkby1zRPLIGjM+8Mgq38om/7ybhoLs9fUyGOvxaoHiUlDB347ROUx/QTTD3gbFMjRWZabB5Vy40gdj6Xcx74fK3I9rRWCEGKWzdTYUFqUVGcBcfjL5KNC/paTmjod+s7U5Ra0kOpYsGBcNxPg6shGoQN2Bum6bDhQ8tXehAwyT61rHR8IQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <607480D1E37FE74D9808E6BADCFA4768@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uwyo.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3948a1-3baa-4276-4f15-08d6c99c7576
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 16:38:34.4474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9cdd7ad-825d-4601-8e9c-a325e02d52da
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNC8xOSAxOjIwIEFNLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCg0KPiBPbiBUdWUs
IEFwciAyMywgMjAxOSBhdCAxMDowMyBQTSBSb2JlcnQgUi4gSG93ZWxsIDxSSG93ZWxsQHV3eW8u
ZWR1PiB3cm90ZToNCj4+DQo+PiBPbiA0LzIzLzE5IDI6MDcgQU0sIFJhZmFlbCBKLiBXeXNvY2tp
IHdyb3RlOg0KPj4+DQo+Pj4gT24gU2F0LCBBcHIgMjAsIDIwMTkgYXQgMTI6NDQgQU0gUm9iZXJ0
IFIuIEhvd2VsbCA8Ukhvd2VsbEB1d3lvLmVkdT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IE9uIDQvMTgv
MTkgNTo0MiBBTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4+Pj4NCj4+Pj4+PiBPbiA0LzgvMTkg
MjoxNiBBTSwgSGFucyBkZSBHb2VkZSB3cm90ZTo+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEhtbSwgaW50
ZXJlc3Rpbmcgc28geW91IGhhdmUgaGliZXJuYXRpb24gd29ya2luZyBvbiBhIFQxMDBUQQ0KPj4+
Pj4+PiAod2l0aCA1LjAgKyAwMmU0NTY0NmQ1M2IgcmV2ZXJ0ZWQpLCByaWdodCA/DQo+Pj4+Pj4+
DQo+Pj4+DQo+Pj4+DQo+Pj4+IEkndmUgbWFuYWdlZCB0byBmaW5kIGEgd2F5IGFyb3VuZCB0aGUg
aTJjX2Rlc2lnbndhcmUgdGltZW91dCBpc3N1ZXMNCj4+Pj4gb24gdGhlIFQxMDBUQSdzLiAgVGhl
IGtleSBpcyB0byBOT1Qgc2V0IERQTV9GTEFHX1NNQVJUX1NVU1BFTkQsDQo+Pj4+IHdoaWNoIHdh
cyBhZGRlZCBpbiB0aGUgMDJlNDU2NDZkNTNiIGNvbW1pdC4NCj4+Pj4NCj4+Pj4gVG8gdGVzdCB0
aGF0IEkndmUgc3RhcnRlZCB3aXRoIGEgNS4xLXJjNSBrZXJuZWwsIGFwcGxpZWQgeW91ciByZWNl
bnQgcGF0Y2gNCj4+Pj4gdG8gYWNwaV9scHNzLmMsIHRoZW4gYXBwbHkgdGhlIGZvbGxvd2luZyBw
YXRjaCBvZiBtaW5lLCByZW1vdmluZw0KPj4+PiBEUE1fRkxBR19TTUFSVF9TVVNQRU5ELiAgKEZv
ciB0aGUgVDEwMCBoYXJkd2FyZSBJIG5lZWQgdG8gYXBwbHkgc29tZQ0KPj4+PiBvdGhlciBwYXRj
aGVzIGFzIHdlbGwgYnV0IHRob3NlIGFyZSBub3QgcmVsYXRlZCB0byB0aGUgaTJjLWRlc2lnbndh
cmUgb3INCj4+Pj4gYWNwaSBpc3N1ZXMgYWRkcmVzc2VkIGhlcmUuKQ0KPj4+Pg0KPj4+PiBPbiBh
IHJlc3VtZSBmcm9tIGhpYmVybmF0aW9uIEkgc3RpbGwgc2VlIG9uZSBlcnJvcjoNCj4+Pj4gICAi
aTJjX2Rlc2lnbndhcmUgODA4NjBGNDE6MDA6IEVycm9yIGkyY19kd194ZmVyIGNhbGxlZCB3aGls
ZSBzdXNwZW5kZWQiDQo+Pj4+IGJ1dCBJIG5vIGxvbmdlciBnZXQgdGhlIGkyY19kZXNpZ253YXJl
IHRpbWVvdXRzLCBhbmQgYXVkaW8gZG9lcyBub3cgd29yaw0KPj4+PiBhZnRlciB0aGUgcmVzdW1l
Lg0KPj4+Pg0KPj4+PiBSZW1vdmluZyBEUE1fRkxBR19TTUFSVF9TVVNQRU5EIG1heSBub3QgYmUg
d2hhdCB5b3Ugd2FudCBmb3Igb3RoZXINCj4+Pj4gaGFyZHdhcmUsIGJ1dCBwZXJoYXBzIHRoaXMg
d2lsbCBnaXZlIHlvdSBhIGNsdWUgYXMgdG8gd2hhdCBpcyBnb2luZw0KPj4+PiB3cm9uZyB3aXRo
IGhpYmVybmF0ZS9yZXN1bWUgb24gdGhlIFQxMDBUQSdzLg0KPj4+DQo+Pj4gV2hhdCBpZiB5b3Ug
ZHJvcCBEUE1fRkxBR19MRUFWRV9TVVNQRU5ERUQgYWxvbmUgaW5zdGVhZD8NCj4+Pg0KPj4NCj4+
IEkgZGlkIHRyeSBkcm9wcGluZyBqdXN0IERQTV9GTEFHX0xFQVZFX1NVU1BFTkRFRCwgZHJvcHBp
bmcganVzdA0KPj4gRFBNX0ZMQUdfU01BUlRfU1VTUEVORCwgYW5kIGRyb3BwaW5nIGJvdGggZmxh
Z3MuICBXaGVuIEkganVzdCBkcm9wDQo+PiBEUE1fRkxBR19MRUFWRV9TVVNQRU5ERUQgSSBzdGls
bCBnZXQgdGhlIGkyY19kZXNpZ253YXJlIHRpbWVvdXRzDQo+PiBhZnRlciB0aGUgcmVzdW1lLiAg
SWYgSSBkcm9wIGp1c3QgRFBNX0ZMQUdfU01BUlRfU1VTUEVORCBvciBkcm9wIGJvdGgsDQo+PiB0
aGVuIHRoZSB0aW1lb3V0cyBnbyBhd2F5Lg0KPiANCj4gT0ssIHRoYW5rcyENCj4gDQo+IElzIG5v
bi1oaWJlcm5hdGlvbiBzeXN0ZW0gc3VzcGVuZCBhZmZlY3RlZCB0b28/DQoNCkkganVzdCByYW4g
c29tZSB0ZXN0cyBvbiBhIFQxMDBUQSwgdXNpbmcgdGhlIDUuMS1yYzUgY29kZSB3aXRoIEhhbnMn
IHBhdGNoIGFwcGxpZWQgDQpidXQgd2l0aG91dCBhbnkgY2hhbmdlcyB0byBpMmMtZGVzaWdud2Fy
ZS1wbGF0ZHJ2LmMsIHNvIHRoZSANCkRQTV9GTEFHX1NNQVJUX1BSRVBBUkUsIERQTV9GTEFHX1NN
QVJUX1NVU1BFTkQsIGFuZCBEUE1fRkxBR19MRUFWRV9TVVNQRU5ERUQgZmxhZ3MgDQphcmUgYWxs
IHNldC4gIA0KDQpTdXNwZW5kIGRvZXMgd29yayBPSywgYW5kIGFmdGVyIHJlc3VtZSBJIGRvIE5P
VCBnZXQgYW55IG9mIHRoZSBjcmlwcGxpbmcgDQppMmNfZGVzaWdud2FyZSB0aW1lb3V0IGVycm9y
cyB3aGljaCBjYXVzZSBzb3VuZCB0byBmYWlsIGFmdGVyIGhpYmVybmF0ZS4gIEkgRE8gc2VlIG9u
ZSANCiAgImkyY19kZXNpZ253YXJlIDgwODYwRjQxOjAwOiBFcnJvciBpMmNfZHdfeGZlciBjYWxs
IHdoaWxlIHN1c3BlbmRlZCINCmVycm9yIG9uIHJlc3VtZSwganVzdCBhcyBJIGRvIG9uIGhpYmVy
bmF0ZS4gIEkndmUgYXR0YWNoZWQgYSBwb3J0aW9uIG9mIGRtZXNnIGJlbG93Lg0KVGhlICJhc3Vz
X3dtaTogIFVua25vd24ga2V5IDc5IHByZXNzZWQiIGVycm9yIGlzIGEgZ2xpdGNoIHdoaWNoIG9j
Y3VycyANCmludGVybWl0dGVudGx5IG9uIHRoZXNlIG1hY2hpbmVzLCBidXQgZG9lc24ndCBzZWVt
IHJlbGF0ZWQgdG8gdGhlIG90aGVyIGlzc3Vlcy4gIA0KSSBoYWQgb25lIHRlc3QgcnVuIHdoZW4g
aXQgd2FzIGFic2VudCBidXQgdGhlIHJlc3Qgb2YgdGhlIG1lc3NhZ2VzIHdlcmUgdGhlIA0Kc2Ft
ZSAtLSBidXQgdGhlbiBrZXB0IGdldHRpbmcgdGhhdCB1bmtub3duIGtleSBlcnJvciBvbiBhbGwg
bXkgbGF0ZXIgdHJpZXMuDQoNCkkgZGlkIG5vdGljZSB0aGUgIjJzaWRsZSIgaW4gdGhlIGZvbGxv
d2luZyByYXRoZXIgdGhhbiAic2hhbGxvdyIgb3IgImRlZXAiLiAgQQ0KY2F0IG9mIC9zeXMvcG93
ZXIvc3RhdGUgc2hvd3MgImZyZWV6ZSBtZW0gZGlzayIgYnV0IGENCmNhdCBvZiAvc3lzL3Bvd2Vy
L21lbV9zbGVlcCIgc2hvd3Mgb25seSAiW3MyaWRsZV0gc28gaXQgbG9va3MgbGlrZSBzaGFsbG93
IGFuZCBkZWVwIA0KYXJlIG5vdCBlbmFibGVkIGZvciB0aGlzIHN5c3RlbS4gIEkgZGlkIGNoZWNr
IHRoZSBpbnB1dCBwb3dlciAob3IgcmVhbGx5IGN1cnJlbnQpIA0KYXMgaXQgd2VudCBpbnRvIHN1
c3BlbmQgYW5kIHRoZSBtaWNyby11c2IgcG93ZXIgaW5wdXQgZHJvcHMgZnJvbSBhYm91dCANCjAu
NSBhbXBzIHRvIDAuMDUgYW1wcy4gIEJ1dCBjbGVhcmx5IGEgbG90IG9mIGRldmljZXMgYXJlIHN0
aWxsIGFjdGl2ZSwgYXMgbW92ZW1lbnQgDQpvZiBhIGJsdWV0b290aCBtb3VzZSAodGhlIE1YIEFu
eXdoZXJlIDIpIHdpbGwgd2FrZSBpdCBmcm9tIHN1c3BlbmQuICBUaGF0IHByZXN1bWFibHkgaXMg
DQp3aHkgc3VzcGVuZCBkb2Vzbid0IHRyaWdnZXIgdGhlIHNhbWUgaTJjX2Rlc2lnbndhcmUgcHJv
YmxlbXMgYXMgaGliZXJuYXRlLg0KDQpMZXQgbWUga25vdyBpZiBJIGNhbiBkbyBhbnkgb3RoZXIg
dGVzdHMuDQoNCkJvYiBIb3dlbGwNCg0KLS0tLURNRVNHIE9VVFBVVCBPTiBTVVNQRU5ELS0tLS0t
LS0tLS0tLS0tLS0tDQpbICAgNzEuNzkxNDk1XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFt
aWx5IDM4DQpbICAgNzMuMTUwNzM2XSBpbnB1dDogTVggQW55d2hlcmUgMiBLZXlib2FyZCBhcyAv
ZGV2aWNlcy92aXJ0dWFsL21pc2MvdWhpZC8wMDA1OjA0NkQ6QjAxMy4wMDA1L2lucHV0L2lucHV0
MjQNClsgICA3My4xNTY2MTJdIGlucHV0OiBNWCBBbnl3aGVyZSAyIE1vdXNlIGFzIC9kZXZpY2Vz
L3ZpcnR1YWwvbWlzYy91aGlkLzAwMDU6MDQ2RDpCMDEzLjAwMDUvaW5wdXQvaW5wdXQyNQ0KWyAg
IDczLjE1OTUwNF0gaGlkLWdlbmVyaWMgMDAwNTowNDZEOkIwMTMuMDAwNTogaW5wdXQsaGlkcmF3
NDogQkxVRVRPT1RIIEhJRCB2MC4wNyBLZXlib2FyZCBbTVggQW55d2hlcmUgMl0gb24gNzQ6RDA6
MkI6REY6Nzc6RTkNClsgIDEwMi43MTkxNzBdIGFzdXNfd21pOiBVbmtub3duIGtleSA3OSBwcmVz
c2VkDQpbICAxMDIuODk3MjE0XSBhc3VzX3dtaTogVW5rbm93biBrZXkgNzkgcHJlc3NlZA0KWyAg
MTA0LjI5ODQwOV0gUE06IHN1c3BlbmQgZW50cnkgKHMyaWRsZSkNClsgIDEwNC4yOTg0MTRdIFBN
OiBTeW5jaW5nIGZpbGVzeXN0ZW1zIC4uLiBkb25lLg0KWyAgMTA1LjQxMDg4M10gRnJlZXppbmcg
dXNlciBzcGFjZSBwcm9jZXNzZXMgLi4uIChlbGFwc2VkIDAuMDAyIHNlY29uZHMpIGRvbmUuDQpb
ICAxMDUuNDEzNTU2XSBPT00ga2lsbGVyIGRpc2FibGVkLg0KWyAgMTA1LjQxMzU1OF0gRnJlZXpp
bmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyAuLi4gKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykg
ZG9uZS4NClsgIDEyMy4zNTM3MjBdIGkyY19kZXNpZ253YXJlIDgwODYwRjQxOjAwOiBFcnJvciBp
MmNfZHdfeGZlciBjYWxsIHdoaWxlIHN1c3BlbmRlZA0KWyAgMTIzLjYzNTAyOF0gQUNQSTogYnV0
dG9uOiBUaGUgbGlkIGRldmljZSBpcyBub3QgY29tcGxpYW50IHRvIFNXX0xJRC4NClsgIDEyNC4w
ODY0MjFdIE9PTSBraWxsZXIgZW5hYmxlZC4NClsgIDEyNC4wODY0OTFdIFJlc3RhcnRpbmcgdGFz
a3MgLi4uIGRvbmUuDQpbICAxMjQuMTIwNjQ3XSBQTTogc3VzcGVuZCBleGl0DQpbICAxMjQuOTM5
NTY2XSBhc3VzX3dtaTogVW5rbm93biBrZXkgNzkgcHJlc3NlZA0K
