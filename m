Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55E2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lH3Z2P2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfCEOGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:06:30 -0500
Received: from mail-eopbgr720061.outbound.protection.outlook.com ([40.107.72.61]:30139
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfCEOGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpzb8LN3jZIxXOBhfS/Aj3lGEX3eyNZs8X1uLd3Dl6g=;
 b=lH3Z2P2+q2/jlqDOpBE0QrYXo1IEz8qX6LxoFsbcMKc5yc8aov96gg7DA9oq1b3lhnoXWWCh7pzeoYgkuyuABFn8PsmdqKBmQoRfTjpYjwL9v7ols5fS/q2H9J1tEA2q3B+Nw4i7s2FhPybPRWF4U2aVYXXocEtEq8w2s5VX1tY=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3129.namprd12.prod.outlook.com (20.178.31.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Tue, 5 Mar 2019 14:06:26 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 14:06:26 +0000
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
Thread-Index: AQHUyGtPvkSDpgAjRUO4lAxcOgUb+aXnm82AgAAMrACAAokWAIAPnVGAgANZgYA=
Date:   Tue, 5 Mar 2019 14:06:25 +0000
Message-ID: <57b32bc1-8ef2-1e1e-a70f-04444f5919a2@amd.com>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
 <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
 <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
 <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
In-Reply-To: <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0134.namprd05.prod.outlook.com
 (2603:10b6:803:2c::12) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81e52cd5-f6bc-4308-58bc-08d6a173c150
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3129;
x-ms-traffictypediagnostic: DM6PR12MB3129:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3129;20:QV+FQBppSSwCYCSBm3yXGT7lJZiJ05u88aexMrJZ3aklYrNv9bIBggh7PTHvVwl7IU02mtHp34QTQXQ3t1dKCuJPSFBGK4IF6YkPF1FHqG4HcdktQ5Mt9NgT9TX/+fkv5EPcTT3HUPw0UMi46mwZxkJRoxSUCSVBv8kdTSTNmHreqg3dflza74EvnzWRHu+Rc/cRAFoVRoC8Y/qR0O9ECTv/vHQQ3oxsfHocbbEIHahZBGlEM5Shmtq0dQNa6R6a
x-microsoft-antispam-prvs: <DM6PR12MB312904953CFF5CBE5D7010A9EC720@DM6PR12MB3129.namprd12.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(189003)(93886005)(476003)(15650500001)(86362001)(106356001)(6486002)(105586002)(99286004)(6436002)(486006)(110136005)(54906003)(36756003)(76176011)(52116002)(6306002)(2906002)(446003)(31686004)(386003)(6512007)(6506007)(2616005)(102836004)(81156014)(3846002)(8676002)(6116002)(186003)(11346002)(31696002)(26005)(53936002)(53546011)(4326008)(66066001)(229853002)(8936002)(81166006)(5660300002)(14444005)(966005)(6246003)(305945005)(7736002)(316002)(71200400001)(71190400001)(25786009)(478600001)(68736007)(14454004)(97736004)(256004)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3129;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hm98RW1VuA7eCOqn6x+hionQ7kyTCpf0FOW9ViuRY8hWCHV8ZhREX2nl810hCZ9zkAL/0taC9o6Lpyh9xCruT+96GBAswkbSiQtJz4b9zr8EtO0YTNR2ATa/lG0iBmxD3kMOShE9jEbO0xUufue+YRGNb6fsM7INzfJiEDjqOY06YZ0vA56+9Me3fPHgyYOKV4icJebK4dZy8tjpaBXQM9b2Vh7f5dNHWGwYvgPwB20RGBi30DkvyC5CA646PU4b7XocONggK3QzG2GhdNYc8HZuf+bbp725tGOlAtYh0V19uIDFe1uFCA7Z2LBMIPsWBVIvw1O5bBSYSFhtPbk2+i9wCfweFslDCxEKzv28OlZrt8P/iM9+Rbs+Y7BIV0GCt0OQk4xzxBThVHR1lp+8bLJxMX8rmi3cQGWQiefoGHM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50B80FF18F1E8A40AB56B10A3B0462D9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e52cd5-f6bc-4308-58bc-08d6a173c150
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 14:06:25.9815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zLzE5IDQ6NTcgQU0sIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24g
MjEtMDItMTkgMTM6MzAsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBPbiAx
OS0wMi0xOSAyMjo0NywgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+PiBPbiAyLzE5LzE5IDM6
MDEgUE0sIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+Pj4gSGFucywNCj4+Pj4NCj4+Pj4gT24g
VHVlLCAxOSBGZWIgMjAxOSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4+Pj4NCj4+Pj4gQ2MrOiBB
Q1BJL0FNRCBmb2xrcw0KPj4+Pg0KPj4+Pj4gVmFyaW91cyBwZW9wbGUgYXJlIHJlcG9ydGluZyBm
YWxzZSBwb3NpdGl2ZSAiZG9fSVJROiAjLjU1IE5vIGlycQ0KPj4+Pj4gaGFuZGxlciBmb3INCj4+
Pj4+IHZlY3RvciINCj4+Pj4+IG1lc3NhZ2VzIG9uIEFNRCByeXplbiBiYXNlZCBsYXB0b3BzLCBz
ZWUgZS5nLjoNCj4+Pj4+DQo+Pj4+PiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19i
dWcuY2dpP2lkPTE1NTE2MDUNCj4+Pj4+DQo+Pj4+PiBXaGljaCBjb250YWlucyB0aGlzIGRtZXNn
IHNuaXBwZXQ6DQo+Pj4+Pg0KPj4+Pj4gRmViIDA3IDIwOjE0OjI5IGxvY2FsaG9zdC5sb2NhbGRv
bWFpbiBrZXJuZWw6IHNtcDogQnJpbmdpbmcgdXANCj4+Pj4+IHNlY29uZGFyeSBDUFVzDQo+Pj4+
PiAuLi4NCj4+Pj4+IEZlYiAwNyAyMDoxNDoyOSBsb2NhbGhvc3QubG9jYWxkb21haW4ga2VybmVs
OiB4ODY6IEJvb3RpbmcgU01QDQo+Pj4+PiBjb25maWd1cmF0aW9uOg0KPj4+Pj4gRmViIDA3IDIw
OjE0OjI5IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiBrZXJuZWw6IC4uLi4gbm9kZcKgICMwLA0KPj4+
Pj4gQ1BVczrCoMKgwqDCoMKgICMxDQo+Pj4+PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0Lmxv
Y2FsZG9tYWluIGtlcm5lbDogZG9fSVJROiAxLjU1IE5vIGlycQ0KPj4+Pj4gaGFuZGxlciBmb3IN
Cj4+Pj4+IHZlY3Rvcg0KPj4+Pj4gRmViIDA3IDIwOjE0OjI5IGxvY2FsaG9zdC5sb2NhbGRvbWFp
biBrZXJuZWw6wqAgIzINCj4+Pj4+IEZlYiAwNyAyMDoxNDoyOSBsb2NhbGhvc3QubG9jYWxkb21h
aW4ga2VybmVsOiBkb19JUlE6IDIuNTUgTm8gaXJxDQo+Pj4+PiBoYW5kbGVyIGZvcg0KPj4+Pj4g
dmVjdG9yDQo+Pj4+PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5l
bDrCoCAjMw0KPj4+Pj4gRmViIDA3IDIwOjE0OjI5IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiBrZXJu
ZWw6IGRvX0lSUTogMy41NSBObyBpcnENCj4+Pj4+IGhhbmRsZXIgZm9yDQo+Pj4+PiB2ZWN0b3IN
Cj4+Pj4+IEZlYiAwNyAyMDoxNDoyOSBsb2NhbGhvc3QubG9jYWxkb21haW4ga2VybmVsOiBzbXA6
IEJyb3VnaHQgdXAgMSBub2RlLA0KPj4+Pj4gNCBDUFVzDQo+Pj4+PiBGZWIgMDcgMjA6MTQ6Mjkg
bG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogc21wYm9vdDogTWF4IGxvZ2ljYWwNCj4+Pj4+
IHBhY2thZ2VzOiAxDQo+Pj4+PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWlu
IGtlcm5lbDogc21wYm9vdDogVG90YWwgb2YgNA0KPj4+Pj4gcHJvY2Vzc29ycw0KPj4+Pj4gYWN0
aXZhdGVkICgxNTk2OC40OSBCb2dvTUlQUykNCj4+Pj4+DQo+Pj4+PiBJdCBzZWVtcyB0aGF0IHdl
IGdldCBhbiBJUlEgZm9yIGVhY2ggQ1BVIGFzIHdlIGJyaW5nIGl0IG9ubGluZSwNCj4+Pj4+IHdo
aWNoIGZlZWxzIHRvIG1lIGxpa2UgaXQgaXMgc29tZSBzb3J0YSBmYWxzZS1wb3NpdGl2ZS4NCj4+
Pj4NCj4+Pj4gU2lnaCwgdGhhdCBsb29rcyBsaWtlIEJJT1MgdmFsdWUgYWRkIGFnYWluLg0KPj4+
Pg0KPj4+PiBJdCdzIG5vdCBhIGZhbHNlIHBvc2l0aXZlLiBTb21ldGhpbmcgX0lTXyBzZW5kaW5n
IGEgdmVjdG9yIDU1IHRvIHRoZXNlDQo+Pj4+IENQVXMNCj4+Pj4gZm9yIHdoYXRldmVyIHJlYXNv
bi4NCj4+Pj4NCj4+Pg0KPj4+IEkgcmVtZW1iZXIgc2VlaW5nIHNvbWV0aGluZyBsaWtlIHRoaXMg
aW4gdGhlIHBhc3QgYW5kIGl0IHR1cm5lZCBvdXQgdG8gYmUNCj4+PiBhIEJJT1MgaXNzdWUuwqAg
QklPUyB3YXMgZW5hYmxpbmcgdGhlIEFQcyB0byBpbnRlcmFjdCB3aXRoIHRoZSBsZWdhY3kgODI1
OQ0KPj4+IGludGVycnVwdCBjb250cm9sbGVyIHdoZW4gb25seSB0aGUgQlNQIHNob3VsZC4gRHVy
aW5nIFBPU1QgdGhlIEFQcyB3ZXJlDQo+Pj4gZXhwb3NlZCB0byBFeHRJTlQvSU5UUiBldmVudHMg
YXMgYSByZXN1bHQgb2YgdGhlIG1pcy1jb25maWd1cmF0aW9uDQo+Pj4gKHByb2JhYmx5IGR1ZSB0
byBhIFVFRkkgdGltZXItdGljayB1c2luZyB0aGUgODI1OSkgYW5kIHRoaXMgbGVmdCBhIHBlbmRp
bmcNCj4+PiBFeHRJTlQvSU5UUiBpbnRlcnJ1cHQgbGF0Y2hlZCBvbiB0aGUgQVBzLg0KPj4+DQo+
Pj4gV2hlbiB0aGUgQVBzIHdlcmUgc3RhcnRlZCBieSB0aGUgT1MsIHRoZSBsYXRjaGVkIEV4dElO
VC9JTlRSIGludGVycnVwdCBpcw0KPj4+IHByb2Nlc3NlZCBzaG9ydGx5IGFmdGVyIHRoZSBPUyBl
bmFibGVzIGludGVycnVwdHMuIFRoZSBBUCB0aGVuIHF1ZXJpZXMgdGhlDQo+Pj4gODI1OSB0byBp
ZGVudGlmeSB0aGUgdmVjdG9yIG51bWJlciAod2hpY2ggaXMgdGhlIHZhbHVlIG9mIHRoZSA4MjU5
J3MgSUNXMg0KPj4+IHJlZ2lzdGVyICsgdGhlIElSUSBsZXZlbCkuIFRoZSBtYXN0ZXIgODI1OSdz
IElDVzIgd2FzIHNldCB0byAweDMwIGFuZCwNCj4+PiBzaW5jZSBubyBpbnRlcnJ1cHRzIGFyZSBh
Y3R1YWxseSBwZW5kaW5nLCB0aGUgODI1OSB3aWxsIHJlc3BvbmQgd2l0aCBJUlE3DQo+Pj4gKHNw
dXJpb3VzIGludGVycnVwdCkgeWllbGRpbmcgYSB2ZWN0b3Igb2YgMHgzNyBvciA1NS4NCj4+Pg0K
Pj4+IFRoZSBPUyB3YXMgbm90IGV4cGVjdGluZyB2ZWN0b3IgNTUgYW5kIHByaW50ZWQgdGhlIG1l
c3NhZ2UuDQo+Pj4NCj4+PiDCoEZyb20gdGhlIEludGVsIERldmVsb3BlcidzIE1hbnVhbDogVm9s
IDNhLCBTZWN0aW9uIDEwLjUuMToNCj4+PiAiT25seSBvbmUgcHJvY2Vzc29yIGluIHRoZSBzeXN0
ZW0gc2hvdWxkIGhhdmUgYW4gTFZUIGVudHJ5IGNvbmZpZ3VyZWQgdG8NCj4+PiB1c2UgdGhlIEV4
dElOVCBkZWxpdmVyeSBtb2RlLiINCj4+Pg0KPj4+IE5vdCBzYXlpbmcgdGhpcyBpcyB0aGUgcHJv
YmxlbSwgYnV0IHZlcnkgd2VsbCBjb3VsZCBiZS4NCj4+DQo+PiBUaGF0IHNvdW5kcyBsaWtlIGEg
bGlrZWx5IGNhbmRpZGF0ZSwgZXNwLiBhbHNvIHNpbmNlIHRoaXMgb25seSBoYXBwZW5zDQo+PiBv
bmNlIHBlciBDUFUgd2hlbiB3ZSBmaXJzdCBvbmx5IHRoZSBDUFUuDQo+Pg0KPj4gQ2FuIHlvdSBw
cm92aWRlIG1lIHdpdGggYSBwYXRjaCB3aXRoIHNvbWUgcHJpbnRrLXMgLyBwcl9kZWJ1Z3MgdG8N
Cj4+IHRlc3QgZm9yIHRoaXMsIHRoZW4gSSBjYW4gYnVpbGQgYSBrZXJuZWwgd2l0aCB0aGF0IHBh
dGNoIGFkZGVkIGFuZA0KPj4gd2UgY2FuIHNlZSBpZiB5b3VyIGh5cG90aGVzaXMgaXMgcmlnaHQu
DQo+IA0KPiBQaW5nPyBJIGxpa2UgeW91ciB0aGVvcnksIGNhbiB5b3UgcHJvdmlkZSBzb21lIGhl
bHAgd2l0aCBkZWJ1Z2dpbmcgdGhpcw0KPiBmdXJ0aGVyICh0byBwcm92ZSB0aGF0IHlvdXIgdGhl
b3J5IGlzIGNvcnJlY3QgKSA/DQoNCkl0J3MgYmVlbiBhIHZlcnkgbG9uZyB0aW1lIHNpbmNlIEkg
ZGVhbHQgd2l0aCB0aGlzIGFuZCBJIHdhcyBvbmx5IG9uIHRoZQ0KcGVyaXBoZXJ5LiBZb3UgbWln
aHQgYmUgYWJsZSB0byBwcmludCB0aGUgTFZUIGVudHJpZXMgZnJvbSB0aGUgQVBJQyBhbmQNCnNl
ZSBpZiBhbnkgb2YgdGhlbSBoYXZlIGFuIHVuLW1hc2tlZCBFeHRJTlQgZGVsaXZlcnkgbW9kZS4g
IFlvdSB3b3VsZCBuZWVkDQp0byBkbyB0aGlzIHZlcnkgZWFybHkgYmVmb3JlIExpbnV4IG1vZGlm
aWVzIGFueSB2YWx1ZXMuDQoNCk9yIHlvdSBjYW4gcmVwb3J0IHRoZSBpc3N1ZSB0byB0aGUgT0VN
IGFuZCBoYXZlIHRoZW0gY2hlY2sgdGhlaXIgQklPUw0KY29kZSB0byBzZWUgaWYgdGhleSBhcmUg
ZG9pbmcgdGhpcy4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5z
DQo=
