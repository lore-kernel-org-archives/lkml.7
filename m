Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5D420857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="O7OwfZBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfCZJH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:07:58 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:59872
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfCZJH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1r01qmWESY7Y9PzpoQEYAQLVUYGX4EMjaKzwzDshLM=;
 b=O7OwfZBHeCazjc5N7inlt5HxYZnZXK20eAdvsmgx253TyDKjBvc7wAMShDspeSQFxHVu13ms6ngc+TZL2Yp0GcBlNjwJks67hkPAnJMrzfmXxadxfT+kviJyNkNhVXT1TCevI9OOmYifw2SPUD1bhkTjYB3127xm9cBHYkVQ+NM=
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com (10.172.217.137) by
 AM4PR0802MB2258.eurprd08.prod.outlook.com (10.172.217.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 09:07:53 +0000
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::b7:11d9:4d0e:995e]) by AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::b7:11d9:4d0e:995e%4]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 09:07:53 +0000
From:   Ben Gainey <Ben.Gainey@arm.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        Will Deacon <Will.Deacon@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: BUG in "perf: Suppress AUX/OVERWRITE records"?
Thread-Topic: BUG in "perf: Suppress AUX/OVERWRITE records"?
Thread-Index: AQHU4w12v5Mi06394Eazgqc3Su3it6YdfbIAgAAi+wA=
Date:   Tue, 26 Mar 2019 09:07:53 +0000
Message-ID: <3f04004a48a4b5bece9d277d5c51661f4eca7e97.camel@arm.com>
References: <ca9bbbdfada4c02eacb5064fce5d187d0f13f4f0.camel@arm.com>
         <87k1gm86en.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87k1gm86en.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.0 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Gainey@arm.com; 
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7e98bca-6225-41a6-298e-08d6b1ca8779
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0802MB2258;
x-ms-traffictypediagnostic: AM4PR0802MB2258:
x-microsoft-antispam-prvs: <AM4PR0802MB2258B5B13F675F23DE26425E915F0@AM4PR0802MB2258.eurprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(53754006)(40434004)(476003)(2501003)(68736007)(486006)(66066001)(76176011)(81156014)(8676002)(26005)(118296001)(8936002)(36756003)(81166006)(71190400001)(71200400001)(6506007)(11346002)(4326008)(6436002)(2616005)(186003)(6486002)(99286004)(446003)(102836004)(2906002)(3846002)(110136005)(5660300002)(14454004)(86362001)(105586002)(6512007)(7736002)(53936002)(316002)(6116002)(58126008)(54906003)(106356001)(97736004)(14444005)(305945005)(256004)(229853002)(6636002)(72206003)(5024004)(6246003)(25786009)(478600001)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2258;H:AM4PR0802MB2211.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mtu2fhMxD3eIE2SG3lgsYVSNj4fDptZEv1ZyD2nqEXoC791wpBwT2q7dm3kiJo6Bd89QGsBeGsr5jjzyTbgTgPdLAqYP3FHCV1Xd+2LzX4EfzmLgZWWMDaESclP2K0XMnKuCVFe6JfuVxBSkmbXsL7GycZzjC4PaRZ/XXKheUz4PCEoOgakEqKKy3go8KLpgKVPHLtaxE8PKVIYrhwkzHhUzu+LgrJpxjRvsc8Sn/BoPCUU916R9uY09EtzQZ2MgDqbqT3zzohX44z3u3pNNm37G+6iQv0qJqgMb7HC1OoIY84gbDQ0YMs4rhT45BSRQ9gUxrw8Fn7m8llHS4vgmdKR9JmrnOS7KiDsPW1hq6t/cil/Ye0r122450fiBCkWxmPTljdvsw0JJnvYbyBXTxgrGRwxx4eSMAWEGynFzd7Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <158A945F5179064AB8D88853AA2BFFB4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e98bca-6225-41a6-298e-08d6b1ca8779
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 09:07:53.2927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAzLTI2IGF0IDA5OjAyICswMjAwLCBBbGV4YW5kZXIgU2hpc2hraW4gd3Jv
dGU6DQo+IEJlbiBHYWluZXkgPEJlbi5HYWluZXlAYXJtLmNvbT4gd3JpdGVzOg0KPg0KPiA+IEhp
IGFsbA0KPiA+DQo+ID4gUmVnYXJkaW5nIGNvbW1pdCAxNjI3MzE0ZmI1NGEzM2ViZDIzYmQwOGYy
ZTIxNWVhZWQwZjQ0NzEyICJwZXJmOg0KPiA+IFN1cHByZXNzIEFVWC9PVkVSV1JJVEUgcmVjb3Jk
cyIsIEkgaGF2ZSBmb3VuZCB0aGF0IEkgbm8gbG9uZ2VyDQo+ID4gcmVjZWl2ZQ0KPiA+IFBFUkZf
UkVDT1JEX0FVWCBvbiBjb250ZXh0IHN3aXRjaCB3aGVuIGNvbGxlY3RpbmcgZGF0YSBmcm9tIHRo
ZQ0KPiA+IGFybV9zcGUNCj4gPiBQTVUgZHJpdmVyLiBUaGlzIGlzIGJlY2F1c2UsIG9uIGNvbnRl
eHQgc3dpdGNoLCB0aGUgYXJtX3NwZSBkcml2ZXINCj4gPiBjYWxscyBwZXJmX2F1eF9vdXRwdXRf
ZW5kIHdpdGggYGhhbmRsZS0+YXV4X2ZsYWdzID09IDBgLCBmYWlsaW5nDQo+ID4gdGhlDQo+ID4g
dGVzdCBhZGRlZCBpbiB0aGlzIGNvbW1pdC4NCj4gPg0KPiA+IFRoaXMgaXMgYSBwcm9ibGVtIGFz
IGl0IG1lYW5zIHdoZW4gY2FwdHVyaW5nIGRhdGEgZm9yIG11bHRpcGxlDQo+ID4gdGhyZWFkcw0K
PiA+ICh1c2luZyBwZXJmX2V2ZW50X29wZW4pIHdoZXJlIEFVWCBkYXRhIGlzIHdyaXR0ZW4gdG8g
YSBwZXItY3B1DQo+ID4gYnVmZmVyLA0KPiA+IEkgY2FuIG5vIGxvbmdlciBhY2N1cmF0ZWx5IGF0
dHJpYnV0ZSBTUEUgQVVYIGRhdGEgdG8gYW4gaW5kaXZpZHVhbA0KPiA+IHRocmVhZC4NCj4NCj4g
U291bmRzIGxpa2UgUEVSRl9SRUNPUkRfU1dJVENIIHNob3VsZCBiZSBzdWZmaWNpZW50IGZvciB5
b3VyDQo+IHB1cnBvc2VzLA0KPiBoYXZlIHlvdSBjb25zaWRlcmVkIHRoYXQ/DQoNCg0KSSdtIG5v
dCB0cnlpbmcgdG8gdHJhY2sgdGhlIGNvbnRleHQgc3dpdGNoIGl0cyBzZWxmLiBJIHdhbnQga25v
dyB3aGljaA0KY2h1bmtzIG9mIEFVWCBkYXRhIHdlcmUgYXNzb2NpYXRlZCB3aXRoIGEgZ2l2ZW4g
dGhyZWFkLg0KDQpDb25zaWRlcjoNCg0KVGhyZWFkIEEgZXhlY3V0ZXMNCiAuLi4gY29udGV4dCBz
d2l0Y2ggICAgW1dSSVRFUyBBVVggREFUQSBGUk9NIE9GRlNFVCBuLi4ubitsXQ0KVGhyZWFkIEIg
ZXhlY3V0ZXMNCiAuLi4gY29udGV4dCBzd2l0Y2ggICAgW1dSSVRFUyBBVVggREFUQSBGUk9NIE9G
RlNFVCBuK2wuLi5uK2wrbV0NCg0KRnJvbSB0aGUgcG9pbnQgb2YgdmlldyBvZiBzb21lb25lIHJl
YWRpbmcgYmFjayB0aGUgcmluZyBidWZmZXIgZGF0YSBpbg0KdXNlcnNwYWNlLCBkZXBlbmRpbmcg
b24gd2hlbiB0aGUgY29uc3VtZXIgd2FrZXMgd2hpbHN0IHdhaXRpbmcgb24gdGhlDQpyaW5nIGJ1
ZmZlciwgaXQgbWF5IG9ubHkgc2VlIGF1eF9oZWFkL3RhaWwgY292ZXJpbmcgdGhlIHJhbmdlDQpb
bi4uLm4rbCttXS4gUHJpb3IgdG8gdGhpcyBjaGFuZ2UgSSB3b3VsZCBzZWUgdHdvIEFVWCByZWNv
cmRzLCBvbmUgd2l0aA0Kb2Zmc2V0IG4sIGxlbmd0aCBsLCBhbmQgdGhlIHNlY29uZCBvZmZzZXQg
bitsLCBsZW5ndGggbS4gQWZ0ZXIgdGhlDQpjaGFuZ2UsIHRoZXJlIGFyZSBubyBBVVggcmVjb3Jk
cy4NCg0KDQo+DQo+ID4gSWYgSSByZWFkIHRoZSBpbnRlbnQgb2YgdGhlIGNvbW1pdCBhcyB0byBy
ZW1vdmUgT1ZFUldSSVRFIEFVWA0KPiA+IHJlY29yZHMsDQo+ID4gdGhlbiBpdCBzZWVtcyB0aGUg
YWRkZWQgaWYgY29uZGl0aW9uIGlzIGluY29ycmVjdCBhbmQgc2hvdWxkDQo+ID4gcHJvYmFibHkN
Cj4gPiBiZSBmb3JtdWxhdGVkIGFzOg0KPiA+DQo+ID4gICAgIGlmICgoaGFuZGxlLT5hdXhfZmxh
Z3MgJiB+KHU2NClQRVJGX0FVWF9GTEFHX09WRVJXUklURSkgfHwNCj4gPiAhaGFuZGxlLQ0KPiA+
ID4gYXV4X2ZsYWdzKQ0KPiA+DQo+ID4gSXMgdGhpcyBjb3JyZWN0IChhbmQgd291bGQgeW91IGxp
a2UgYSBwYXRjaD8pLCBvciBpcyBteSB1c2Ugb2YNCj4gPiBQRVJGX1JFQ09SRF9BVVggaW5jb3Jy
ZWN0IGluIHRoaXMgY2FzZT8NCj4NCj4gTm8sIHRoZSBwb2ludCBvZiBBVVggcmVjb3JkcyBpcyB0
byBjb21tdW5pY2F0ZSB1c2VmdWwgdGhpbmdzIGFib3V0DQo+IHRoZQ0KPiBkYXRhIGluIEFVWCBi
dWZmZXIuDQoNClN1cmUsIGFuZCBrbm93aW5nIHdoZW4gdGhlIGVuZCBvZiB0aGUgQVVYIGRhdGEg
Zm9yIG9uZSB0aHJlYWQgZW5kcyBhbmQNCnRoZSBuZXh0IHN0YXJ0cyBpcyB1c2VmdWwsIHN1cmVs
eT8NCg0KQWRkaXRpb25hbGx5IHRoZSBjaGFuZ2UgaW50cm9kdWNlZCBpcyBwcmV2ZW50aW5nIHdy
aXRpbmcgYW4NClBFUkZfUkVDT1JEX0FVWCB3aGVuIGZsYWdzIGRvZXMgbm90IGNvbnRhaW4gUEVS
Rl9BVVhfRkxBR19PVkVSV1JJVEUNCihmbGFncz09MCkgd2hpY2ggc2VlbXMgdG8gbm90IGJlIHRo
ZSBpbnRlbnRpb24gb2YgdGhlIGNvbW1pdD8NCg0KPiBJdCB3YXMgYW4gdW5pbnRlbnRpb25hbCBz
aWRlIGVmZmVjdCB0aGF0IGl0IGFsc28NCj4gaGFwcGVuZWQgdG8gY29pbmNpZGUgd2l0aCBjb250
ZXh0IHN3aXRjaGVzIGluIHRoZSBvdmVyd3JpdGUgbW9kZS4NCg0KSSdtIG5vdCB1c2luZyBvdmVy
d3JpdGUgbW9kZSwgSSdtIG9wZW5pbmcgdGhlIG1tYXAgd2l0aCBQUk9UX1dSSVRFDQooaS5lLiBp
biB0cnVuY2F0ZSBtb2RlKS4NCg0KUmVnYXJkcw0KQmVuDQoNCg0KPg0KPiBUaGFua3MsDQo+IC0t
DQo+IEFsZXgNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFu
ZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmls
ZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRz
IHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9y
IGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
