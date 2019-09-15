Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89A1C4CECB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 05:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847142077C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 05:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PosEIWTo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zJGpYxMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfIOFDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 01:03:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49659 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfIOFDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 01:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568523823; x=1600059823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Chks9ClJHwPBARUlK8iqwFCm96S+GK/iZ2/WaJ6ewUc=;
  b=PosEIWTopzlv3oR/APeET77cXnc0QE5EoN3fVKVi51SY+rrHUrRzyIgQ
   oupQBmuu8E7YQXpseeRnlidK5Bx3BlWe+ommrVn7WRg2RNTlaAeNDEzNt
   WMe3WytQWGlIQP1waUueZiQCY/Y2/aUBwOPks0yTdbL3vAyCI1eSj3u6N
   M8lbmf4IAFz7YASFxqAV8wvccn0tFZJK0OHe5id3Ao/bw/tzfdRk/mjOY
   /mX2gC1M6P3GUQKOTEksMAMbvuQCE63UgPh93c6wE4GGQqKdzkZzhIGuA
   ux3OP4YTgW2ojA0YuYwMk4DEh7FlLIQVnmrdzG6tDVKs5lzK0UPtKxjFi
   A==;
IronPort-SDR: i+VxeOkIzDn9gy6rv7eNjAtrJBhEgMpgA1qZYysYxUJyobn7DRZCdcAIaHnEWKAnwAJMyMo/R3
 3Bdk7f45ewcNz7SYLjxZCNBNb25DTk4tNCrl40nuvOZsjTxoCoWsTcaLyJD5gZGFro8u022boE
 w8yLJnJN7ojhFWdLz8257Uidg1+zSt/9tFH2NP5odcjZfHAM6O5ereotVSzojV/vcCrTaUD29W
 3K9y5v7ansiKyGXlTVqou9lByRWBWgSbnJh0YnQIaYj+CAYw4/jw3q8iTIQ9bXXJXrxwnqhBPS
 yDQ=
X-IronPort-AV: E=Sophos;i="5.64,506,1559491200"; 
   d="scan'208";a="119121434"
Received: from mail-by2nam05lp2054.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.54])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2019 13:03:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJEzRzoADf6z+1RwTTzYckGU89EhUaMbW2JR4JuT2OtbkCA1w2FDcDB0QcjQW2TWTZoFOh+4TAs9qG8CuCDvI4VYbgnsvL5ZOTURsnewSAMhCOWcsmE8m+G2fZcighJgQnGaUoYGjAHkzdlwTeYQSe/vmw8RSn7/RO4wgLfe0ChocmRRc/Y+dIyuh8wqJP1j4zttFnAK9maZ92OeYCcBDUcH6IhOVliNb9CkbXmMPO9hHCo9jEuvL9nZwYuEAN19BDtrRX/0f+Lk6Kvx0j+RAXcQH5K1UYUuOhVW/p6MfXtX76i8dBcEf7dtn79SGVTSCghSdZkfHczwTNwoZz09kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chks9ClJHwPBARUlK8iqwFCm96S+GK/iZ2/WaJ6ewUc=;
 b=Fbr5BTXojR8fqe5eaJQshxm9ThWDMjAodJK4fVvDgDQR3QQsLDTQ/GQrCSVIO0WCiaz/QIsga9JiXPgay36rP5BF9TrfSQK6Qr5G2gsvU841DZsCA3iL0VVFaaXppD+8dKh81L8ThsOTaCLqQfCOi6kXSlOiRFb7C3/qa+Zo8hI+ASyNJ/mhY4H/jzTzynWeA7sgcdSQ2bpvptVR8tac+F4mrNXBn+geAOJfvVyC+ecBeQdxyTMtjg8ZfZtW9MwsGbqw/whqJ6U6HqAYoDwwzw8KN/IEjiGifRN8vlflg02YUDGqwGnVX8TLWrshkzfdQWbrbkdtUYxDQG4P8gyLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chks9ClJHwPBARUlK8iqwFCm96S+GK/iZ2/WaJ6ewUc=;
 b=zJGpYxMcQlS/xbeM5zEVocS3K9TB+hcwEZZe05aKpojwx4lXU3viQdrjNXt1fmx7e9VQpwvrYxZ9bS8sVe+NB9SP4Prv7PXL0TcS29reraab13t3yRacpCGJajgF2xpCs2Ta83e7dXV497CLrL3XxpLKS5Y7QjA/xW7LmBQLGOI=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6029.namprd04.prod.outlook.com (20.178.246.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Sun, 15 Sep 2019 05:03:38 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2263.023; Sun, 15 Sep 2019
 05:03:38 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "guoren@kernel.org" <guoren@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "julien.grall@arm.com" <julien.grall@arm.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Thread-Topic: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Thread-Index: AQHU4ARW4cwQ4eGTBkiNSNBcx5My8aaNvxWAgBVs3wCAAA0vgIAABQWAgAAz5gCAAAYHgIABXjKAgAZcEYCAdrxbgIAHNtEAgAMkQoCAAPtQ0A==
Date:   Sun, 15 Sep 2019 05:03:38 +0000
Message-ID: <MN2PR04MB606117F2AC47385EF23D267D8D8D0@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
 <mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e>
In-Reply-To: <mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.49.169]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 077cc312-e726-46a6-dd40-08d7399a1201
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6029;
x-ms-traffictypediagnostic: MN2PR04MB6029:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB602981B00CEC0AC7D7A86E488D8D0@MN2PR04MB6029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01613DFDC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(13464003)(189003)(74316002)(316002)(966005)(25786009)(3846002)(76116006)(26005)(6116002)(55236004)(305945005)(66066001)(66946007)(66446008)(64756008)(66556008)(66476007)(102836004)(256004)(54906003)(2501003)(7736002)(478600001)(4326008)(33656002)(110136005)(229853002)(53546011)(6506007)(14454004)(81166006)(6246003)(81156014)(7696005)(446003)(9686003)(11346002)(99286004)(6306002)(71190400001)(71200400001)(6436002)(5660300002)(7416002)(476003)(186003)(55016002)(76176011)(53936002)(52536014)(8936002)(86362001)(486006)(2906002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6029;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sQdWGfS4ONuNECE4i/uE3dTO4x8zKnKX2PHAImSkDJWFtLybrmdz3BVjJpsoMXXR8uzGd9+DX6Ks6WoieOIaaQOklc6RH3UzkIFYfhBSTf5MHafJort67RCKNyYpCv1oXto4ieW5yPHPz0m1ZRHU7k7El/M1y0A4BMwgF228F95pKwvIBUeTXWtgjknDt68k5Sj/gOCCAFwuy5hVqoC4v5hrZ2YmIMwTlK8dfMF+AV2GKNvr1i5VRLo+Rw2E0dtvQ/DrjXCF/Dt1x0IqLxxVQMrJnPQzFQ75JBVs1Vgei2YSkUtVyLcZBDXdnBpMxKIlE/suVBQK8tix2c7l39Le+eeusflBrramYGz5oHnKGsVBIfQccaFIs/QLZNbDBLM/jPLZNwkRkV8TFd6qebJUz3QBz0Xn4LW+iN0ReO8cT1M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077cc312-e726-46a6-dd40-08d7399a1201
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2019 05:03:38.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xaVWlQjH/gbtQ3nYyFIu1lMCo3QEl5NxVddA23LCZjlRgg7Kvm3fjkty3KMHn+rZc482PPy1Bq7F8hWnhbH/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBQYWxtZXIgRGFiYmVsdA0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVt
YmVyIDE0LCAyMDE5IDc6MzEgUE0NCj4gVG86IHdpbGxAa2VybmVsLm9yZw0KPiBDYzogZ3VvcmVu
QGtlcm5lbC5vcmc7IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPjsNCj4ganVsaWVu
LnRoaWVycnlAYXJtLmNvbTsgYW91QGVlY3MuYmVya2VsZXkuZWR1OyBqYW1lcy5tb3JzZUBhcm0u
Y29tOw0KPiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgc3V6dWtpLnBvdWxvc2VAYXJt
LmNvbTsNCj4gbWFyYy56eW5naWVyQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyBB
bnVwIFBhdGVsDQo+IDxBbnVwLlBhdGVsQHdkYy5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBycHB0QGxpbnV4LmlibS5jb207IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5m
cmFkZWFkLm9yZz47IEF0aXNoIFBhdHJhDQo+IDxBdGlzaC5QYXRyYUB3ZGMuY29tPjsganVsaWVu
LmdyYWxsQGFybS5jb207IGdhcnlAZ2FyeWd1by5uZXQ7IFBhdWwNCj4gV2FsbXNsZXkgPHBhdWwu
d2FsbXNsZXlAc2lmaXZlLmNvbT47IGNocmlzdG9mZmVyLmRhbGxAYXJtLmNvbTsgbGludXgtDQo+
IHJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHU7
IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIDExLzE0XSBhcm02
NDogTW92ZSB0aGUgQVNJRCBhbGxvY2F0b3IgY29kZSBpbiBhDQo+IHNlcGFyYXRlIGZpbGUNCj4g
DQo+IE9uIFRodSwgMTIgU2VwIDIwMTkgMDc6MDI6NTYgUERUICgtMDcwMCksIHdpbGxAa2VybmVs
Lm9yZyB3cm90ZToNCj4gPiBPbiBTdW4sIFNlcCAwOCwgMjAxOSBhdCAwNzo1Mjo1NUFNICswODAw
LCBHdW8gUmVuIHdyb3RlOg0KPiA+PiBPbiBNb24sIEp1biAyNCwgMjAxOSBhdCA2OjQwIFBNIFdp
bGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+PiA+ID4gSSdsbCBrZWVwIG15
IHN5c3RlbSB1c2UgdGhlIHNhbWUgQVNJRCBmb3IgU01QICsgSU9NTVUgOlANCj4gPj4gPg0KPiA+
PiA+IFlvdSB3aWxsIHdhbnQgYSBzZXBhcmF0ZSBhbGxvY2F0b3IgZm9yIHRoYXQ6DQo+ID4+ID4N
Cj4gPj4gPiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMTkwNjEwMTg0NzE0LjY3ODYtMi1q
ZWFuLXBoaWxpcHBlLmJydWNrDQo+ID4+ID4gZXJAYXJtLmNvbQ0KPiA+Pg0KPiA+PiBZZXMsIGl0
IGlzIGhhcmQgdG8gbWFpbnRhaW4gQVNJRCBiZXR3ZWVuIElPTU1VIGFuZCBDUFVNTVUgb3INCj4g
Pj4gZGlmZmVyZW50IHN5c3RlbSwgYmVjYXVzZSBpdCdzIGRpZmZpY3VsdCB0byBzeW5jaHJvbml6
ZSB0aGUgSU9fQVNJRA0KPiA+PiB3aGVuIHRoZSBDUFUgQVNJRCBpcyByb2xsb3Zlci4NCj4gPj4g
QnV0IHdlIGNvdWxkIHN0aWxsIHVzZSBoYXJkd2FyZSBicm9hZGNhc3QgVExCIGludmFsaWRhdGlv
bg0KPiA+PiBpbnN0cnVjdGlvbiB0byB1bmlmb3JtbHkgbWFuYWdlIHRoZSBBU0lEIGFuZCBJT19B
U0lELCBvciBPVEhFUl9BU0lEIGluDQo+IG91ciBJT01NVS4NCj4gPg0KPiA+IFRoYXQncyBwcm9i
YWJseSBhIGJhZCBpZGVhLCBiZWNhdXNlIHlvdSdsbCBsaWtlbHkgc3RhbGwgZXhlY3V0aW9uIG9u
DQo+ID4gdGhlIENQVSB1bnRpbCB0aGUgSU9UTEIgaGFzIGNvbXBsZXRlZCBpbnZhbGlkYXRpb24u
IEluIHRoZSBjYXNlIG9mDQo+ID4gQVRTLCBJIHRoaW5rIGFuIGVuZHBvaW50IEFUQyBpcyBwZXJt
aXR0ZWQgdG8gdGFrZSBvdmVyIGEgbWludXRlIHRvDQo+ID4gcmVzcG9uZC4gSW4gcmVhbGl0eSwg
SSBzdXNwZWN0IHRoZSB3b3JzdCB5b3UnbGwgZXZlciBzZWUgd291bGQgYmUgaW4NCj4gPiB0aGUg
bXNlYyByYW5nZSwgYnV0IHRoYXQncyBzdGlsbCBhbiB1bmFjY2VwdGFibGUgcGVyaW9kIG9mIHRp
bWUgdG8gaG9sZCBhDQo+IENQVS4NCj4gPg0KPiA+PiBXZWxjb21lIHRvIGpvaW4gb3VyIGRpc3Nj
dXNpb246DQo+ID4+ICJJbnRyb2R1Y2UgYW4gaW1wbGVtZW50YXRpb24gb2YgSU9NTVUgaW4gbGlu
dXgtcmlzY3YiDQo+ID4+IDkgU2VwIDIwMTksIDEwOjQ1IEphZGUtcm9vbS1JJklJIChDb3JpbnRo
aWEgSG90ZWwgTGlzYm9uKSBSSVNDLVYgTUMNCj4gPg0KPiA+IEkgYXR0ZW5kZWQgdGhpcyBzZXNz
aW9uLCBidXQgaXQgdW5mb3J0dW5hdGVseSByYWlzZWQgbWFueSBtb3JlDQo+ID4gcXVlc3Rpb25z
IHRoYW4gaXQgYW5zd2VyZWQuDQo+IA0KPiBZYSwgd2UncmUgYSBsb25nIHdheSBmcm9tIGZpZ3Vy
aW5nIHRoaXMgb3V0Lg0KDQpGb3IgZXZlcnlvbmUncyByZWZlcmVuY2UsIGhlcmUgaXMgb3VyIGZp
cnN0IGF0dGVtcHQgYXQgUklTQy1WIEFTSUQgYWxsb2NhdG9yOg0KaHR0cDovL2FyY2hpdmUubHdu
Lm5ldDo4MDgwL2xpbnV4LWtlcm5lbC8yMDE5MDMyOTA0NTExMS4xNDA0MC0xLWFudXAucGF0ZWxA
d2RjLmNvbS9ULyN1DQoNClJlZ2FyZHMsDQpBbnVwDQo=
