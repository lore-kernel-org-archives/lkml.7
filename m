Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DBCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC5321019
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gr40kZkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfCETbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:31:38 -0500
Received: from mail-eopbgr820048.outbound.protection.outlook.com ([40.107.82.48]:5490
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbfCETbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9ROM2yo2ZGG5ej9pOsRVAW521wr7d6e+7URhZMWknY=;
 b=Gr40kZkOmPSaIMqI6vzheBIoTfMCchaEtuv/VgR7QOaN0IjyGvTNCC0xH2UTppfvtl+13Xshbvm8lGDtisfmz0ch4EPFenM2sZCDhK6doWdlCnc6cUiNMtu7UX4FycmSg16roCwyXRGqBTFGa8txkGfG/JfneId6r3uzZzk7NTk=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3420.namprd12.prod.outlook.com (20.178.198.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 19:31:35 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 19:31:35 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
Thread-Topic: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
Thread-Index: AQHUyGtPvkSDpgAjRUO4lAxcOgUb+aXnm82AgAAMrACAAokWAIAPnVGAgAL07ICAAITnAIAAN0OAgAADRAA=
Date:   Tue, 5 Mar 2019 19:31:35 +0000
Message-ID: <62f91d1a-4dc7-9628-5c87-5ffca0cd1a0f@amd.com>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
 <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
 <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
 <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
 <57b32bc1-8ef2-1e1e-a70f-04444f5919a2@amd.com>
 <6fbcd261-f9e2-1685-1ef7-f148007aab9d@redhat.com>
 <51078b59-161a-0e13-6d8d-87d37c3375f2@redhat.com>
In-Reply-To: <51078b59-161a-0e13-6d8d-87d37c3375f2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR01CA0024.prod.exchangelabs.com (2603:10b6:805:b6::37)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eeeeef0-58d8-4152-f01f-08d6a1a12daa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3420;
x-ms-traffictypediagnostic: DM6PR12MB3420:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3420;20:S5+SvkZ5/2Qj6c7cIJFyF+NXuGxYj7Wx0TznjqCsVDWqcwR8YidEVXRgjEtOHwltQ9hKa09YFxMDcIvHDVEbwaS5CchYsmqYFGJ5nOFA2kA7gRfKMzruzzUICUrjc9KHA9Ch/CQ9mKo3b32GdQVIGHrolz2255+FAVxBYghTYgEjf4tX8BG/6ayw8KtRycI0eTkmA0QcF6VYKE91QFtjgZnUHyFVb2S14erpUJzZzTwIWYvpr62vzsXk6IRUqxs+
x-microsoft-antispam-prvs: <DM6PR12MB342029942CCBCA03F32D5490EC720@DM6PR12MB3420.namprd12.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(68736007)(15650500001)(97736004)(4326008)(478600001)(305945005)(72206003)(7736002)(966005)(8676002)(2906002)(81156014)(14454004)(106356001)(25786009)(31686004)(8936002)(81166006)(53936002)(105586002)(102836004)(6246003)(99286004)(52116002)(76176011)(14444005)(446003)(186003)(256004)(26005)(386003)(6506007)(53546011)(110136005)(54906003)(316002)(6116002)(93886005)(86362001)(66066001)(11346002)(36756003)(6436002)(5660300002)(486006)(6306002)(6486002)(6512007)(476003)(71190400001)(3846002)(71200400001)(31696002)(2616005)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3420;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n4S1Nkz2XdvAkdo4xRbjIy4c19wecZFC5kWqDxckJT0MNnrF838ritDLPDpQqUB5O3BususvXNcXG9KsKysrvC7n1p0MNh1/V8IQvpC8lHW9a4NBDVVAshU+BVi1HFUBH5U7VfX0UEEn+9fT9NXmKhwAjjMYty1b1TyHgzhO38obG9VQxh2szHkgn7ADKi6522D9ZPtsGg0Sur6lLr5mfysBRVptanpu3pGmUZzRyaIRzgX1/oolfvgVAsvZkdsiduTwetZRbaY20RgCKI4NiHZtW6G74QQrXQ95PHIhG3eYtAnKRGqqZxJlKR6fzMlxLGzoIse9YlxS7svw2Uzgw/NqwsO3xqZTJnN4/KDddMkqr73Y936c5To5GtN9KBPc34ML6s+JkrZkculIIn2i48FIcpXMDs6HXaQTlJEWW58=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF39249D1CFA8248BFEDAC79A9C74624@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eeeeef0-58d8-4152-f01f-08d6a1a12daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 19:31:35.1620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3420
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy81LzE5IDE6MTkgUE0sIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24g
MDUtMDMtMTkgMTc6MDIsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBPbiAw
NS0wMy0xOSAxNTowNiwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+PiBPbiAzLzMvMTkgNDo1
NyBBTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IE9uIDIxLTAy
LTE5IDEzOjMwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPj4+Pj4gSGksDQo+Pj4+Pg0KPj4+Pj4g
T24gMTktMDItMTkgMjI6NDcsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+Pj4+Pj4gT24gMi8x
OS8xOSAzOjAxIFBNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4+Pj4+IEhhbnMsDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IE9uIFR1ZSwgMTkgRmViIDIwMTksIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+
Pj4+Pj4+DQo+Pj4+Pj4+IENjKzogQUNQSS9BTUQgZm9sa3MNCj4+Pj4+Pj4NCj4+Pj4+Pj4+IFZh
cmlvdXMgcGVvcGxlIGFyZSByZXBvcnRpbmcgZmFsc2UgcG9zaXRpdmUgImRvX0lSUTogIy41NSBO
byBpcnENCj4+Pj4+Pj4+IGhhbmRsZXIgZm9yDQo+Pj4+Pj4+PiB2ZWN0b3IiDQo+Pj4+Pj4+PiBt
ZXNzYWdlcyBvbiBBTUQgcnl6ZW4gYmFzZWQgbGFwdG9wcywgc2VlIGUuZy46DQo+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4gaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNTUx
NjA1DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gV2hpY2ggY29udGFpbnMgdGhpcyBkbWVzZyBzbmlwcGV0
Og0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEZlYiAwNyAyMDoxNDoyOSBsb2NhbGhvc3QubG9jYWxkb21h
aW4ga2VybmVsOiBzbXA6IEJyaW5naW5nIHVwDQo+Pj4+Pj4+PiBzZWNvbmRhcnkgQ1BVcw0KPj4+
Pj4+Pj4gLi4uDQo+Pj4+Pj4+PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWlu
IGtlcm5lbDogeDg2OiBCb290aW5nIFNNUA0KPj4+Pj4+Pj4gY29uZmlndXJhdGlvbjoNCj4+Pj4+
Pj4+IEZlYiAwNyAyMDoxNDoyOSBsb2NhbGhvc3QubG9jYWxkb21haW4ga2VybmVsOiAuLi4uIG5v
ZGXCoCAjMCwNCj4+Pj4+Pj4+IENQVXM6wqDCoMKgwqDCoCAjMQ0KPj4+Pj4+Pj4gRmViIDA3IDIw
OjE0OjI5IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiBrZXJuZWw6IGRvX0lSUTogMS41NSBObyBpcnEN
Cj4+Pj4+Pj4+IGhhbmRsZXIgZm9yDQo+Pj4+Pj4+PiB2ZWN0b3INCj4+Pj4+Pj4+IEZlYiAwNyAy
MDoxNDoyOSBsb2NhbGhvc3QubG9jYWxkb21haW4ga2VybmVsOsKgICMyDQo+Pj4+Pj4+PiBGZWIg
MDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogZG9fSVJROiAyLjU1IE5v
IGlycQ0KPj4+Pj4+Pj4gaGFuZGxlciBmb3INCj4+Pj4+Pj4+IHZlY3Rvcg0KPj4+Pj4+Pj4gRmVi
IDA3IDIwOjE0OjI5IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiBrZXJuZWw6wqAgIzMNCj4+Pj4+Pj4+
IEZlYiAwNyAyMDoxNDoyOSBsb2NhbGhvc3QubG9jYWxkb21haW4ga2VybmVsOiBkb19JUlE6IDMu
NTUgTm8gaXJxDQo+Pj4+Pj4+PiBoYW5kbGVyIGZvcg0KPj4+Pj4+Pj4gdmVjdG9yDQo+Pj4+Pj4+
PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogc21wOiBCcm91
Z2h0IHVwIDEgbm9kZSwNCj4+Pj4+Pj4+IDQgQ1BVcw0KPj4+Pj4+Pj4gRmViIDA3IDIwOjE0OjI5
IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiBrZXJuZWw6IHNtcGJvb3Q6IE1heCBsb2dpY2FsDQo+Pj4+
Pj4+PiBwYWNrYWdlczogMQ0KPj4+Pj4+Pj4gRmViIDA3IDIwOjE0OjI5IGxvY2FsaG9zdC5sb2Nh
bGRvbWFpbiBrZXJuZWw6IHNtcGJvb3Q6IFRvdGFsIG9mIDQNCj4+Pj4+Pj4+IHByb2Nlc3NvcnMN
Cj4+Pj4+Pj4+IGFjdGl2YXRlZCAoMTU5NjguNDkgQm9nb01JUFMpDQo+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4gSXQgc2VlbXMgdGhhdCB3ZSBnZXQgYW4gSVJRIGZvciBlYWNoIENQVSBhcyB3ZSBicmluZyBp
dCBvbmxpbmUsDQo+Pj4+Pj4+PiB3aGljaCBmZWVscyB0byBtZSBsaWtlIGl0IGlzIHNvbWUgc29y
dGEgZmFsc2UtcG9zaXRpdmUuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNpZ2gsIHRoYXQgbG9va3MgbGlr
ZSBCSU9TIHZhbHVlIGFkZCBhZ2Fpbi4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSXQncyBub3QgYSBmYWxz
ZSBwb3NpdGl2ZS4gU29tZXRoaW5nIF9JU18gc2VuZGluZyBhIHZlY3RvciA1NSB0byB0aGVzZQ0K
Pj4+Pj4+PiBDUFVzDQo+Pj4+Pj4+IGZvciB3aGF0ZXZlciByZWFzb24uDQo+Pj4+Pj4+DQo+Pj4+
Pj4NCj4+Pj4+PiBJIHJlbWVtYmVyIHNlZWluZyBzb21ldGhpbmcgbGlrZSB0aGlzIGluIHRoZSBw
YXN0IGFuZCBpdCB0dXJuZWQgb3V0DQo+Pj4+Pj4gdG8gYmUNCj4+Pj4+PiBhIEJJT1MgaXNzdWUu
wqAgQklPUyB3YXMgZW5hYmxpbmcgdGhlIEFQcyB0byBpbnRlcmFjdCB3aXRoIHRoZSBsZWdhY3kN
Cj4+Pj4+PiA4MjU5DQo+Pj4+Pj4gaW50ZXJydXB0IGNvbnRyb2xsZXIgd2hlbiBvbmx5IHRoZSBC
U1Agc2hvdWxkLiBEdXJpbmcgUE9TVCB0aGUgQVBzIHdlcmUNCj4+Pj4+PiBleHBvc2VkIHRvIEV4
dElOVC9JTlRSIGV2ZW50cyBhcyBhIHJlc3VsdCBvZiB0aGUgbWlzLWNvbmZpZ3VyYXRpb24NCj4+
Pj4+PiAocHJvYmFibHkgZHVlIHRvIGEgVUVGSSB0aW1lci10aWNrIHVzaW5nIHRoZSA4MjU5KSBh
bmQgdGhpcyBsZWZ0IGENCj4+Pj4+PiBwZW5kaW5nDQo+Pj4+Pj4gRXh0SU5UL0lOVFIgaW50ZXJy
dXB0IGxhdGNoZWQgb24gdGhlIEFQcy4NCj4+Pj4+Pg0KPj4+Pj4+IFdoZW4gdGhlIEFQcyB3ZXJl
IHN0YXJ0ZWQgYnkgdGhlIE9TLCB0aGUgbGF0Y2hlZCBFeHRJTlQvSU5UUg0KPj4+Pj4+IGludGVy
cnVwdCBpcw0KPj4+Pj4+IHByb2Nlc3NlZCBzaG9ydGx5IGFmdGVyIHRoZSBPUyBlbmFibGVzIGlu
dGVycnVwdHMuIFRoZSBBUCB0aGVuDQo+Pj4+Pj4gcXVlcmllcyB0aGUNCj4+Pj4+PiA4MjU5IHRv
IGlkZW50aWZ5IHRoZSB2ZWN0b3IgbnVtYmVyICh3aGljaCBpcyB0aGUgdmFsdWUgb2YgdGhlIDgy
NTkncw0KPj4+Pj4+IElDVzINCj4+Pj4+PiByZWdpc3RlciArIHRoZSBJUlEgbGV2ZWwpLiBUaGUg
bWFzdGVyIDgyNTkncyBJQ1cyIHdhcyBzZXQgdG8gMHgzMCBhbmQsDQo+Pj4+Pj4gc2luY2Ugbm8g
aW50ZXJydXB0cyBhcmUgYWN0dWFsbHkgcGVuZGluZywgdGhlIDgyNTkgd2lsbCByZXNwb25kIHdp
dGgNCj4+Pj4+PiBJUlE3DQo+Pj4+Pj4gKHNwdXJpb3VzIGludGVycnVwdCkgeWllbGRpbmcgYSB2
ZWN0b3Igb2YgMHgzNyBvciA1NS4NCj4+Pj4+Pg0KPj4+Pj4+IFRoZSBPUyB3YXMgbm90IGV4cGVj
dGluZyB2ZWN0b3IgNTUgYW5kIHByaW50ZWQgdGhlIG1lc3NhZ2UuDQo+Pj4+Pj4NCj4+Pj4+PiDC
oMKgRnJvbSB0aGUgSW50ZWwgRGV2ZWxvcGVyJ3MgTWFudWFsOiBWb2wgM2EsIFNlY3Rpb24gMTAu
NS4xOg0KPj4+Pj4+ICJPbmx5IG9uZSBwcm9jZXNzb3IgaW4gdGhlIHN5c3RlbSBzaG91bGQgaGF2
ZSBhbiBMVlQgZW50cnkNCj4+Pj4+PiBjb25maWd1cmVkIHRvDQo+Pj4+Pj4gdXNlIHRoZSBFeHRJ
TlQgZGVsaXZlcnkgbW9kZS4iDQo+Pj4+Pj4NCj4+Pj4+PiBOb3Qgc2F5aW5nIHRoaXMgaXMgdGhl
IHByb2JsZW0sIGJ1dCB2ZXJ5IHdlbGwgY291bGQgYmUuDQo+Pj4+Pg0KPj4+Pj4gVGhhdCBzb3Vu
ZHMgbGlrZSBhIGxpa2VseSBjYW5kaWRhdGUsIGVzcC4gYWxzbyBzaW5jZSB0aGlzIG9ubHkgaGFw
cGVucw0KPj4+Pj4gb25jZSBwZXIgQ1BVIHdoZW4gd2UgZmlyc3Qgb25seSB0aGUgQ1BVLg0KPj4+
Pj4NCj4+Pj4+IENhbiB5b3UgcHJvdmlkZSBtZSB3aXRoIGEgcGF0Y2ggd2l0aCBzb21lIHByaW50
ay1zIC8gcHJfZGVidWdzIHRvDQo+Pj4+PiB0ZXN0IGZvciB0aGlzLCB0aGVuIEkgY2FuIGJ1aWxk
IGEga2VybmVsIHdpdGggdGhhdCBwYXRjaCBhZGRlZCBhbmQNCj4+Pj4+IHdlIGNhbiBzZWUgaWYg
eW91ciBoeXBvdGhlc2lzIGlzIHJpZ2h0Lg0KPj4+Pg0KPj4+PiBQaW5nPyBJIGxpa2UgeW91ciB0
aGVvcnksIGNhbiB5b3UgcHJvdmlkZSBzb21lIGhlbHAgd2l0aCBkZWJ1Z2dpbmcgdGhpcw0KPj4+
PiBmdXJ0aGVyICh0byBwcm92ZSB0aGF0IHlvdXIgdGhlb3J5IGlzIGNvcnJlY3QgKSA/DQo+Pj4N
Cj4+PiBJdCdzIGJlZW4gYSB2ZXJ5IGxvbmcgdGltZSBzaW5jZSBJIGRlYWx0IHdpdGggdGhpcyBh
bmQgSSB3YXMgb25seSBvbiB0aGUNCj4+PiBwZXJpcGhlcnkuIFlvdSBtaWdodCBiZSBhYmxlIHRv
IHByaW50IHRoZSBMVlQgZW50cmllcyBmcm9tIHRoZSBBUElDIGFuZA0KPj4+IHNlZSBpZiBhbnkg
b2YgdGhlbSBoYXZlIGFuIHVuLW1hc2tlZCBFeHRJTlQgZGVsaXZlcnkgbW9kZS7CoCBZb3Ugd291
bGQgbmVlZA0KPj4+IHRvIGRvIHRoaXMgdmVyeSBlYXJseSBiZWZvcmUgTGludXggbW9kaWZpZXMg
YW55IHZhbHVlcy4NCj4+DQo+PiBJJ20gYWZyYWlkIEknbSBub3QgZmFtaWxpYXIgZW5vdWdoIHdp
dGggdGhlIGludGVycnVwdCAvIEFQSUMgcGFydHMgb2YNCj4+IHRoZSBrZXJuZWwgdG8gZG8gc29t
ZXRoaW5nIGxpa2UgdGhpcyBteXNlbGYuDQo+Pg0KPj4+IE9yIHlvdSBjYW4gcmVwb3J0IHRoZSBp
c3N1ZSB0byB0aGUgT0VNIGFuZCBoYXZlIHRoZW0gY2hlY2sgdGhlaXIgQklPUw0KPj4+IGNvZGUg
dG8gc2VlIGlmIHRoZXkgYXJlIGRvaW5nIHRoaXMuDQo+Pg0KPj4gSSB3aWxsIHRyeSB0byBnbyB0
aGlzIHJvdXRlLCBidXQgSSdtIG5vdCByZWFsbHkgaG9wZWZ1bCB0aGF0IHdpbGwNCj4+IGxlYWQg
dG8gYSBzb2x1dGlvbi4NCj4gDQo+IEEgc2ltaWxhciBpc3N1ZSBpcyBhbHNvIHJlcG9ydGVkIGhl
cmU6DQo+IA0KPiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE1
NTE2MDUNCj4gDQo+IFRoZXJlIGFyZSBtdWx0aXBsZSBwZW9wbGUgd2l0aCBkaWZmZXJlbnQgdmVj
dG9ycyAoc28gbGlrZWx5IC8gcG9zc2libHkNCj4gZGlmZmVyZW50IGJ1Z3MpIGNvbW1lbnRpbmcg
b24gdGhhdCBidWcsIGJ1dCBJIGp1c3QgZ290IGNvbmZpcm1hdGlvbg0KPiB0aGF0IHRoZSB2ZWN0
b3IgNTUgaXNzdWUgaXMgYWxzbyBoYXBwZW5pbmcgb24gYW4gQWNlciBzeXN0ZW0gd2l0aCBhbiBB
TUQNCj4gQTggcHJvY2Vzc29yIChJIHN1c3BlY3QgYSBSeXplbiwgYnV0IHRoYXQgc3RpbGwgbmVl
ZHMgdG8gYmUgY29uZmlybWVkKS4NCj4gDQo+IFNvIHRoaXMgc2VlbXMgdG8gYmUgYSBnZW5lcmlj
IGlzc3VlIHdpdGggKHNvbWUpIEFNRCBsYXB0b3BzIGFuZA0KPiBub3Qgc3BlY2lmaWMgdG8gb25l
IE9FTS4NCg0KSSBhbHNvIHNlZSB0aGF0IGNvbW1lbnQgMTcgaXMgZm9yIGFuIEludGVsIGJhc2Vk
IG1hY2hpbmUsIHdoaWNoIHRvIG1lDQppbXBsaWVzIHRoYXQgaXQgcmVhbGx5IGlzIGEgQklPUyBp
c3N1ZS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQo=
