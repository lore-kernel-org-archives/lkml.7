Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B1EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16372217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uwy.onmicrosoft.com header.i=@uwy.onmicrosoft.com header.b="d+WQpqgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfDWUDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:03:12 -0400
Received: from mail-eopbgr800131.outbound.protection.outlook.com ([40.107.80.131]:40811
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfDWUDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwy.onmicrosoft.com;
 s=selector1-uwyo-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyDEFyoYmsWE40e3PKY/oy0TN7kaWFvOO1b8kjQ/RQo=;
 b=d+WQpqgYUrHOct4bQ4d3Z9YH0SQAA6n5SaWojkTBnpY70jX9MqEZ/RfuWtzSF9hyhhuE+TWDXMlM5Mm9A+MGqtTmt5eloh222M381j94GN8tQ6q83ejUZJQ0AjdspbYWsxFb5DefuLEVIwhLwHiG7gG3XA31Q1xLZkDF6+Igclo=
Received: from DM6PR05MB5259.namprd05.prod.outlook.com (20.177.223.223) by
 DM6PR05MB5707.namprd05.prod.outlook.com (20.178.24.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.7; Tue, 23 Apr 2019 20:03:08 +0000
Received: from DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::7537:83ea:1eaa:75ab]) by DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::7537:83ea:1eaa:75ab%3]) with mapi id 15.20.1835.010; Tue, 23 Apr 2019
 20:03:08 +0000
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
Thread-Index: AQHU6eBClqunF/byekqefGejWfaC+aYqIfOAgAcThICAAL18AIAFeNOAgAp38wCAAktGAIAFVH4AgADH4wA=
Date:   Tue, 23 Apr 2019 20:03:08 +0000
Message-ID: <144b56d4-54e6-bccd-4652-22303bcd9168@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
 <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
 <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
 <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
In-Reply-To: <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [208.45.14.192]
x-clientproxiedby: CY4PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:910:60::17) To DM6PR05MB5259.namprd05.prod.outlook.com
 (2603:10b6:5:7f::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RHowell@uwyo.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0481b1f1-f1d1-4ff1-5f80-08d6c826b49c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR05MB5707;
x-ms-traffictypediagnostic: DM6PR05MB5707:
x-microsoft-antispam-prvs: <DM6PR05MB570721B867964A927A38F0B1D3230@DM6PR05MB5707.namprd05.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(8936002)(305945005)(386003)(2616005)(186003)(476003)(6506007)(71200400001)(36756003)(65826007)(53546011)(7736002)(8676002)(6512007)(316002)(786003)(6246003)(107886003)(102836004)(4326008)(26005)(75432002)(53936002)(25786009)(446003)(11346002)(71190400001)(58126008)(81156014)(486006)(54906003)(81166006)(14454004)(5660300002)(76176011)(229853002)(6436002)(52116002)(6486002)(66476007)(97736004)(66946007)(80792005)(66556008)(73956011)(66446008)(3846002)(64756008)(64126003)(2906002)(6916009)(68736007)(6116002)(31696002)(88552002)(14444005)(478600001)(72206003)(65806001)(86362001)(256004)(99286004)(66066001)(65956001)(93886005)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR05MB5707;H:DM6PR05MB5259.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uwyo.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x+AGK38qQo9Hw4X0lGcKQL1XfLY/4HKHX3reEJ7zc2HraXx0kU1OXpE3PqWOFqSmefXjKQO9D6vnE+7EgriTDnpMtdkj2czna8mSHyqxw9NXd+mrV2XiYwEz/mca69KYnD6VUjDnMVkTKdPYVBWY89krhiVswLr1O9tVr47Im0F2ryItgo868fJe3o3UPoMtsRywlJZCisXrm/lw/qa43JKlratoyUdXIRxjb5t45shxBMSYc1Hg0qUZb0st/gMdrQcwT970ZMo0ZsIdg0Wbs1x5CxXvQ2Xow53T7qBJtuzl5oypQxcMHUiybRG95dpaftj/4jmvqaPbTpConcAlbknB432nBlK7pRgCz4bC6WxTEgFHUiWd35qJdvVKnEY8iyuTMP8VskIfUbOl0SrumMRwgUs9ZXVaq+rk5NbQ4IY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6BD045827275745BB4D9BFBEC234952@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uwyo.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0481b1f1-f1d1-4ff1-5f80-08d6c826b49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 20:03:08.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9cdd7ad-825d-4601-8e9c-a325e02d52da
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMy8xOSAyOjA3IEFNLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gDQo+IE9uIFNh
dCwgQXByIDIwLCAyMDE5IGF0IDEyOjQ0IEFNIFJvYmVydCBSLiBIb3dlbGwgPFJIb3dlbGxAdXd5
by5lZHU+IHdyb3RlOg0KPj4NCj4+IE9uIDQvMTgvMTkgNTo0MiBBTSwgSGFucyBkZSBHb2VkZSB3
cm90ZToNCj4+DQo+Pj4+IE9uIDQvOC8xOSAyOjE2IEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOj4N
Cj4+Pj4+DQo+Pj4+PiBIbW0sIGludGVyZXN0aW5nIHNvIHlvdSBoYXZlIGhpYmVybmF0aW9uIHdv
cmtpbmcgb24gYSBUMTAwVEENCj4+Pj4+ICh3aXRoIDUuMCArIDAyZTQ1NjQ2ZDUzYiByZXZlcnRl
ZCksIHJpZ2h0ID8NCj4+Pj4+DQo+Pg0KPj4NCj4+IEkndmUgbWFuYWdlZCB0byBmaW5kIGEgd2F5
IGFyb3VuZCB0aGUgaTJjX2Rlc2lnbndhcmUgdGltZW91dCBpc3N1ZXMNCj4+IG9uIHRoZSBUMTAw
VEEncy4gIFRoZSBrZXkgaXMgdG8gTk9UIHNldCBEUE1fRkxBR19TTUFSVF9TVVNQRU5ELA0KPj4g
d2hpY2ggd2FzIGFkZGVkIGluIHRoZSAwMmU0NTY0NmQ1M2IgY29tbWl0Lg0KPj4NCj4+IFRvIHRl
c3QgdGhhdCBJJ3ZlIHN0YXJ0ZWQgd2l0aCBhIDUuMS1yYzUga2VybmVsLCBhcHBsaWVkIHlvdXIg
cmVjZW50IHBhdGNoDQo+PiB0byBhY3BpX2xwc3MuYywgdGhlbiBhcHBseSB0aGUgZm9sbG93aW5n
IHBhdGNoIG9mIG1pbmUsIHJlbW92aW5nDQo+PiBEUE1fRkxBR19TTUFSVF9TVVNQRU5ELiAgKEZv
ciB0aGUgVDEwMCBoYXJkd2FyZSBJIG5lZWQgdG8gYXBwbHkgc29tZQ0KPj4gb3RoZXIgcGF0Y2hl
cyBhcyB3ZWxsIGJ1dCB0aG9zZSBhcmUgbm90IHJlbGF0ZWQgdG8gdGhlIGkyYy1kZXNpZ253YXJl
IG9yDQo+PiBhY3BpIGlzc3VlcyBhZGRyZXNzZWQgaGVyZS4pDQo+Pg0KPj4gT24gYSByZXN1bWUg
ZnJvbSBoaWJlcm5hdGlvbiBJIHN0aWxsIHNlZSBvbmUgZXJyb3I6DQo+PiAgICJpMmNfZGVzaWdu
d2FyZSA4MDg2MEY0MTowMDogRXJyb3IgaTJjX2R3X3hmZXIgY2FsbGVkIHdoaWxlIHN1c3BlbmRl
ZCINCj4+IGJ1dCBJIG5vIGxvbmdlciBnZXQgdGhlIGkyY19kZXNpZ253YXJlIHRpbWVvdXRzLCBh
bmQgYXVkaW8gZG9lcyBub3cgd29yaw0KPj4gYWZ0ZXIgdGhlIHJlc3VtZS4NCj4+DQo+PiBSZW1v
dmluZyBEUE1fRkxBR19TTUFSVF9TVVNQRU5EIG1heSBub3QgYmUgd2hhdCB5b3Ugd2FudCBmb3Ig
b3RoZXINCj4+IGhhcmR3YXJlLCBidXQgcGVyaGFwcyB0aGlzIHdpbGwgZ2l2ZSB5b3UgYSBjbHVl
IGFzIHRvIHdoYXQgaXMgZ29pbmcNCj4+IHdyb25nIHdpdGggaGliZXJuYXRlL3Jlc3VtZSBvbiB0
aGUgVDEwMFRBJ3MuDQo+IA0KPiBXaGF0IGlmIHlvdSBkcm9wIERQTV9GTEFHX0xFQVZFX1NVU1BF
TkRFRCBhbG9uZSBpbnN0ZWFkPw0KPiANCg0KSSBkaWQgdHJ5IGRyb3BwaW5nIGp1c3QgRFBNX0ZM
QUdfTEVBVkVfU1VTUEVOREVELCBkcm9wcGluZyBqdXN0IA0KRFBNX0ZMQUdfU01BUlRfU1VTUEVO
RCwgYW5kIGRyb3BwaW5nIGJvdGggZmxhZ3MuICBXaGVuIEkganVzdCBkcm9wIA0KRFBNX0ZMQUdf
TEVBVkVfU1VTUEVOREVEIEkgc3RpbGwgZ2V0IHRoZSBpMmNfZGVzaWdud2FyZSB0aW1lb3V0cyAN
CmFmdGVyIHRoZSByZXN1bWUuICBJZiBJIGRyb3AganVzdCBEUE1fRkxBR19TTUFSVF9TVVNQRU5E
IG9yIGRyb3AgYm90aCwgDQp0aGVuIHRoZSB0aW1lb3V0cyBnbyBhd2F5Lg0KDQpCb2IgSG93ZWxs
DQo=
