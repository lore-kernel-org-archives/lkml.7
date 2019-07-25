Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C19C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C8621901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="j+CBebTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbfGYBXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 21:23:12 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:49587
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726300AbfGYBXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiB1g6qh/JCI+owhOf+/d4ONViTuRben0zdWy4CSLF+u4kf05MrQZA5/5kJ8DIjZ9yk0S7RMQPdnagnIK8tvd/zx+hdTqh4u4rSHSbkqp7F6o2CMqeDamnz/aDUzynEKXIMWB7k2875h4ZAI0mKFwa57A0/ryuXa2WO3O1hIxRs+hJtUEZXPvy85VucDGIzmfm/NKJmUtLpLu9u2hfMN4KLNSrjtXWV78QFt/ss9akLSFtZNYq/vtndxymcDvMXxIpcM3ENIYNw+N6cW1Z0YfE8zwUJYJZWsMUK2B04cjAjjWWVKIdq4CWGN3qltSIw4mu6oyWOLm+P1jcVL2e0ALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSyD4PFD6Pte1YYUxa4W05utklrWpXLtLt+q2AoXZPY=;
 b=jCrCeELW+msswefMVRS/CDe9BjDB9/4wWlBOOIJaabO/mwBGpbiP5PdPn8fZt5RQDYtgZ5SULBldMbKkerIjivMQf5kKogovGYDeeZnAh3zU5mtfhUeZxjsIJUQGL7DGBfwXjFpgHGKsbg86ISbHvgiGGNuLiQbOQD79d57kKknYv29CT+utFnw4i6CG83KwJsMnGGCDAPmXDJ+3PTlHjtg4Rb7AnpMV+2W05pKX1t1RQHAoDmNx/EtY9C9raTPINcL4b5BZb2POMoKiB+LZphuQKOLB0vT9pr43NKzCH/zxKhGK8eaguxe7pKbGWTlMEltAH65og8WyPdULImDzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSyD4PFD6Pte1YYUxa4W05utklrWpXLtLt+q2AoXZPY=;
 b=j+CBebTyTmTMOOxJzmaz1PREhrhAq7pbhkf02f81vvNsAHOEIuryBHkdQRisiok+DqRx9uy3fLIBqrMiCb27W9M0pvEiwz5T4MjADROhWLQ8bSQDCSFx2/4KZAGdmekwzt2ItAUOLwzCv0IajBnMh2Bc2NmZpRYjT6tjJA0daLQ=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5033.eurprd05.prod.outlook.com (20.176.236.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.11; Thu, 25 Jul 2019 01:22:29 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec%4]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 01:22:29 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] mm: document zone device struct page field usage
Thread-Topic: [PATCH v3 1/3] mm: document zone device struct page field usage
Thread-Index: AQHVQndVdGqz1nTW0EOQGoyECF17f6baieaA
Date:   Thu, 25 Jul 2019 01:22:29 +0000
Message-ID: <20190725012225.GB32003@mellanox.com>
References: <20190724232700.23327-1-rcampbell@nvidia.com>
 <20190724232700.23327-2-rcampbell@nvidia.com>
In-Reply-To: <20190724232700.23327-2-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:208:19b::18) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b28fc4-e637-4650-b9d6-08d7109e8f4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB5033;
x-ms-traffictypediagnostic: DB7PR05MB5033:
x-microsoft-antispam-prvs: <DB7PR05MB503367D896688472023A717BCFC10@DB7PR05MB5033.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(186003)(305945005)(7736002)(3846002)(386003)(6246003)(8936002)(54906003)(81166006)(81156014)(6116002)(478600001)(14454004)(486006)(5660300002)(476003)(11346002)(7416002)(71200400001)(71190400001)(316002)(6506007)(102836004)(26005)(2616005)(2906002)(446003)(86362001)(14444005)(6436002)(66066001)(256004)(36756003)(25786009)(99286004)(6512007)(53936002)(8676002)(33656002)(229853002)(6486002)(4326008)(6916009)(1076003)(66574012)(66446008)(64756008)(66556008)(66476007)(66946007)(76176011)(52116002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5033;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: flQVxxpLf8TH57fBXd2c/WcSly6nYdfGAUomIMCVQSTAs9gd9jI4srZ71F+lmHM3Vt91t82NrLfEr06DbX8HNuSHWxEQLYiTcdNEclNePqI2vaFOXegX5BUJT3MsD5KvRvhQsa0PNzAGmwv+G4xkpDBa61BJkeEJOzoH7UTgEDGaxd07MEFcNyoUJI9t0lJYBFVVVKCQVxP+h/2pqCRxfcs4OG3bUl9fLxMX0DbAuy7/Uuw8cLcJoKs2ycuIKPj9sdFKp2kd2cOnLGBSMFc0eW8PwyXFkpYtkzqzYyaR3hDi2aZxHotJOD7V6ZaxfoCYnQASfXaVtalNXCd84WT+U/lZTWk2/2dC4N+hL+pIB7vBWvCVQgO8ZqHncQcumbMErriFN414iNmlzeXi1V2zELxd56daVmzL4XPa0iAcDNo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE3B413FB239744199F9D95B1A9E6A28@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b28fc4-e637-4650-b9d6-08d7109e8f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 01:22:29.2171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMjQsIDIwMTkgYXQgMDQ6MjY6NThQTSAtMDcwMCwgUmFscGggQ2FtcGJlbGwg
d3JvdGU6DQo+IFN0cnVjdCBwYWdlIGZvciBaT05FX0RFVklDRSBwcml2YXRlIHBhZ2VzIHVzZXMg
dGhlIHBhZ2UtPm1hcHBpbmcgYW5kDQo+IGFuZCBwYWdlLT5pbmRleCBmaWVsZHMgd2hpbGUgdGhl
IHNvdXJjZSBhbm9ueW1vdXMgcGFnZXMgYXJlIG1pZ3JhdGVkIHRvDQo+IGRldmljZSBwcml2YXRl
IG1lbW9yeS4gVGhpcyBpcyBzbyBybWFwX3dhbGsoKSBjYW4gZmluZCB0aGUgcGFnZSB3aGVuDQo+
IG1pZ3JhdGluZyB0aGUgWk9ORV9ERVZJQ0UgcHJpdmF0ZSBwYWdlIGJhY2sgdG8gc3lzdGVtIG1l
bW9yeS4NCj4gWk9ORV9ERVZJQ0UgcG1lbSBiYWNrZWQgZnNkYXggcGFnZXMgYWxzbyB1c2UgdGhl
IHBhZ2UtPm1hcHBpbmcgYW5kDQo+IHBhZ2UtPmluZGV4IGZpZWxkcyB3aGVuIGZpbGVzIGFyZSBt
YXBwZWQgaW50byBhIHByb2Nlc3MgYWRkcmVzcyBzcGFjZS4NCj4gDQo+IEFkZCBjb21tZW50cyB0
byBzdHJ1Y3QgcGFnZSBhbmQgcmVtb3ZlIHRoZSB1bnVzZWQgIl96ZF9wYWRfMSIgZmllbGQNCj4g
dG8gbWFrZSB0aGlzIG1vcmUgY2xlYXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWxwaCBDYW1w
YmVsbCA8cmNhbXBiZWxsQG52aWRpYS5jb20+DQo+IFJldmlld2VkLWJ5OiBKb2huIEh1YmJhcmQg
PGpodWJiYXJkQG52aWRpYS5jb20+DQo+IENjOiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFk
ZWFkLm9yZz4NCj4gQ2M6IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+DQo+IENjOiBD
aHJpc3RvcGggTGFtZXRlciA8Y2xAbGludXguY29tPg0KPiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUu
aGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUBy
ZWRoYXQuY29tPg0KPiBDYzogIktpcmlsbCBBIC4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVtb3ZA
bGludXguaW50ZWwuY29tPg0KPiBDYzogTGFpIEppYW5nc2hhbiA8amlhbmdzaGFubGFpQGdtYWls
LmNvbT4NCj4gQ2M6IE1hcnRpbiBTY2h3aWRlZnNreSA8c2Nod2lkZWZza3lAZGUuaWJtLmNvbT4N
Cj4gQ2M6IFBla2thIEVuYmVyZyA8cGVuYmVyZ0BrZXJuZWwub3JnPg0KPiBDYzogUmFuZHkgRHVu
bGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBBbmRyZXkgUnlhYmluaW4gPGFyeWFi
aW5pbkB2aXJ0dW96em8uY29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
DQo+IENjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+DQo+IENjOiBBbmRyZXcg
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBDYzogTGludXMgVG9ydmFsZHMg
PHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiAgaW5jbHVkZS9saW51eC9tbV90eXBl
cy5oIHwgMTEgKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQoNClJhbHBoLCB5b3UgbWFya2VkIHNvbWUgb2YgdGhlcyBwYXRjaGVz
IGFzIG1tL2htbSwgYnV0IEkgZmVlbCBpdCBpcw0KYmVzdCBpZiBBbmRyZXcgdGFrZXMgdGhlbSB0
aHJvdWdoIHRoZSBub3JtYWwgLW1tIHBhdGguDQoNClRoZXkgZG9uJ3QgdG91Y2ggaG1tLmMgb3Ig
bW11IG5vdGlmaWVycyBzbyBJIGRvbid0IGZvcnNlZSBjb25mbGljdHMsDQphbmQgSSBkb24ndCBm
ZWVsIGNvbWZvcnRhYmxlIHRvIHJldmlldyB0aGlzIGNvZGUuDQoNClJlZ2FyZHMsDQpKYXNvbg0K
