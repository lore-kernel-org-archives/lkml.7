Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E7920679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pb1ZffoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfJIThA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:37:00 -0400
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:12917
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729535AbfJIThA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:37:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1jnIBC+ZCyTbMmY5Hjd6sLkF0dzWolWELdB1Gk+jUUs/KbYNN4BqfgBdA5SnP95TbQGaQgBmksTBmZiH2PIb8y5x/FKB0G4zo+jVtc+QICUSAg+2fJ8GQA86SsjppJ7AGzzYpe2Bw9M+rdeIABOqfsVk/OJWkUAgw3vX1mTJfbTtmI43XrgF9FS0nNe/1H53YOQTwb3eW9b7ZvfyYPMW6aUbIK0EEOCtlQ51151dkImkVjtiJKSghPs624PG5GoOgANYs5th8imCYWMRehM66x72Zvfe0kAl+U77B9DRbPNnttip0daefvaeYfhlsK6iv6i9F2gPBiWkvifVl1mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9oH3eePqu6UHumaucwSX0j7mqp6QwBs5tbrJTjoj6Q=;
 b=au5TkzTXbH/OpmpjqjV1B4HFuLgXGstsHUWbuHGQyifN0YN0MKRKwT/79aVQkictC5Ae/FfgQM4I68CYBkkG3+m5bnMBJbMSIzs4+OKI1u3nRoImnGrA0SefsOxPSSEb9EqCThHWshZ/Jd3b5ovemTZvx8dxTLFgzHzCLrgxsXFojvLWSzA9nCPyBz0eOjVY/LUIoBD8BURrXqHvXgPhVXPoRy6NzhX7Rlz1xTjrlWiKPGAnmqKiEp3d8UUBsvNoOXHFuHCBsvcTsq6T8oVjmmt2O2BQVxC6gslbGaVytBE5rgidLKtyoyU0bPKU7iGE4Q3pH92edcVruc/y7AEdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9oH3eePqu6UHumaucwSX0j7mqp6QwBs5tbrJTjoj6Q=;
 b=pb1ZffoAfmlDxc6vVF7nLYkEtYwzkBs6IUsEtOFbKQNuQSpS7SF3zerlCpYTCW74d5NhCGyLY8WWWuXIOzyhvtynHorytgC/VQnKifyiwhRTyEExeJ8WBjQKoM2DLVfcd8TAyVGLPmNmwPNoFtU+tbPFBXv7+T3PXhk0JJPiQoA=
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.173.210) by
 DM6PR12MB3786.namprd12.prod.outlook.com (10.255.173.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 9 Oct 2019 19:36:57 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::bc68:3310:d894:b9f]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::bc68:3310:d894:b9f%6]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 19:36:57 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Jiri Kosina <jikos@kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
CC:     Kurt Garloff <kurt@garloff.de>, Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>
Subject: Re: IOMMU vs Ryzen embedded EMMC controller
Thread-Topic: IOMMU vs Ryzen embedded EMMC controller
Thread-Index: AQHVb7hsQOyE/u2Eok64rlGlf/1aqKc1tHeAgAbXlwCAAAROAIACwXIAgAALx4CAE3F2AIAAA1KA
Date:   Wed, 9 Oct 2019 19:36:57 +0000
Message-ID: <7dfc753a-b189-d8d0-ff83-afcfbab99f71@amd.com>
References: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de>
 <47da1247-fbc1-fe50-041c-3808b0e140bf@garloff.de>
 <nycvar.YEU.7.76.1909251726550.15418@gjva.wvxbf.pm>
 <20190925154256.GB4643@8bytes.org>
 <70b2d326-6257-025c-5ffa-1f543a900073@garloff.de>
 <63913cd8-a0c5-61e3-2f52-139bade01afc@amd.com>
 <nycvar.YFH.7.76.1910092124260.13160@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1910092124260.13160@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
x-originating-ip: [165.204.77.11]
x-clientproxiedby: SN1PR12CA0096.namprd12.prod.outlook.com
 (2603:10b6:802:21::31) To DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19853415-48cd-414b-570a-08d74cf00bcf
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB3786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37867C5197E4162694435611F3950@DM6PR12MB3786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(186003)(6436002)(31686004)(25786009)(14454004)(2616005)(11346002)(76176011)(81166006)(6246003)(52116002)(4326008)(81156014)(36756003)(446003)(6116002)(53546011)(486006)(5024004)(6506007)(476003)(6636002)(229853002)(386003)(102836004)(256004)(3846002)(316002)(26005)(2906002)(8676002)(6486002)(65806001)(65956001)(66066001)(31696002)(66556008)(66476007)(66946007)(64756008)(66446008)(305945005)(54906003)(5660300002)(7736002)(6512007)(8936002)(86362001)(99286004)(71200400001)(478600001)(110136005)(71190400001)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3786;H:DM6PR12MB3865.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3S+wFgQrTxxF8+RSBluVgZUnLEQEoiGmqyWj7oTVBqO+t11ZoZmReq8gdY95ivGQncqcw53DGX30Tdk0VwreTwJRYTemOgy51i0t9o2qA6KZnOLitwPZLN+PknWodMwqFPqAkF/QZdthAQ+PDyZXvWJm3SHTfkoyISe0CsmjhbJ0wZ6Zdp+BhSkZ7zWoyxXR0yCN2cSt+JrjGp9R4SGz04dyfao06/C3pB0j8jcQapsWLjxUuMqWANr9MCMexU3GxdJj0wEiNy1fXX1fXKrnD2ymP1u+OqDtEVOAIlBa9CyJJbdHv5tfoxqEMpamO3+kx0l2od9fnVJFgAdfTIMFGj1LrRkM786e1iGRIgDR/59Nfun0A9R1wKXjC946ZEGPThvKNVCMVuDeCgK8xZS2OxXvQ/WNSvaRTs3maw5Y2I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <550D94580287FC4B90B6E94657F35667@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19853415-48cd-414b-570a-08d74cf00bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 19:36:57.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i96mwk6DbmAxCi/g0q53f+n6zK7AHP/uyjgBiN/bhPYhH1GY0klo/TsjzzgMb4GIq7nETioqNGsxY4JKKqsztg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDEwLzkvMTkgMjoyNSBQTSwgSmlyaSBLb3NpbmEgd3JvdGU6DQo+IE9uIEZyaSwg
MjcgU2VwIDIwMTksIFNoYWgsIE5laGFsLWJha3VsY2hhbmRyYSB3cm90ZToNCj4gDQo+Pj4+PiBE
byB5b3UgaGF2ZSBCQVIgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZXMgaW4gZG1lc2cgd2l0aCBJ
T01NVSBvbj8NCj4+Pg0KPj4+IE5vLiBUaGUgZGV2aWNlIGlzICpub3QqIHRyZWF0ZWQgYXMgUENJ
IGRldmljZSBhbmQgSSBzdGlsbCB0aGluayB0aGF0DQo+Pj4gdGhpcyBpcyB0aGUgc291cmNlIG9m
IHRoZSBldmlsLg0KPj4+DQo+Pj4+PiBBY3R1YWxseSwgc2hhcmluZyBib3RoIHdvcmtpbmcgYW5k
IG5vbi13b3JraW5nIGRtZXNnLCBhcyB3ZWxsIGFzDQo+Pj4+PiAvcHJvYy9pb21lbSBjb250ZW50
cywgd291bGQgYmUgaGVscGZ1bC4NCj4gDQo+Pj4+IFllcywgY2FuIHlvdSBwbGVhc2UgZ3JhYiBk
bWVzZyBmcm9tIGEgYm9vdCB3aXRoIGlvbW11IGVuYWJsZWQgYW5kIGFkZA0KPj4+PiAnYW1kX2lv
bW11X2R1bXAnIHRvIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lPyBUaGF0IHNob3VsZCBnaXZlIHNv
bWUNCj4+Pj4gaGludHMgb24gd2hhdCBpcyBnb2luZyBvbi4NCj4+Pg0KPj4+IEZvciBub3cgSSBh
dHRhY2ggYSBkbWVzZyBhbmQgaW9tZW0gZnJvbSB0aGUgYm9vdCB3aXRoIElPTU1VIGVuYWJsZWQu
DQo+Pj4gTm90aGluZyBtdWNoIGludGVyZXN0aW5nIHdpdGhvdXQgSU9NTVUsIHNkaGNpLWFjcGkg
dGhlcmUganVzdCB3b3JrcyAtLQ0KPj4+IGxldCBtZSBrbm93IGlmIHlvdSBzdGlsbCB3YW50IG1l
IHRvIHNlbmQgdGhlIGtlcm5lbCBtc2cuDQo+Pj4NCj4+PiBUaGFua3MgZm9yIGxvb2tpbmcgaW50
byB0aGlzIQ0KPj4+DQo+Pg0KPj4gSSBoYXZlIGFkZGVkIFN1cmF2ZWUgZnJvbSBBTUQgaW4gdGhl
IG1haWwgbG9vcC4gSGUgd29ya3Mgb24gSU9NTVUgcGFydC4NCj4+IEFzIHBlciBteSB1bmRlcnN0
YW5kaW5nLCBpdCBuZWVkcyBhIHBhdGNoIGluIElPTU1VIGRyaXZlciBmb3IgYWRkaW5nDQo+PiBz
dXBwb3J0IG9mIEVNTUMuIE5vdGUgdGhhdCBvbiBSeXplbiBwbGF0Zm9ybSB3ZSBoYXZlIEVNTUMg
NS4wIGFzIEFDUEkNCj4+IGRldmljZS4NCj4gDQo+IEZyaWVuZGx5IHBpbmcgLi4uIGFueSBuZXdz
IGhlcmU/DQo+IA0KPiBUaGFua3MsDQo+IA0KDQpDb3VsZCB5b3UgcGxlYXNlIGJvb3QgdGhlIHN5
c3RlbSB3LyBrZXJuZWwgb3B0aW9uIGFtZF9pb21tdV9kdW1wPTEsDQphbmQgZG8gImRtZXNnIHwg
Z3JlcCBBTUQtVmkiLiBUaGVuIHByb3ZpZGUgdGhlIG91dHB1dC4NCg0KSSBzdXNwZWN0IHRoYXQg
dGhlcmUgaXMgc29tZXRoaW5nIG1pc3NpbmcgaW4gdGhlIElWUlMgdGFibGUsIHdoZXJlIGl0IG5l
ZWRzDQp0byBwcm92aWRlIEFDUEkgSElEIGZvciB0aGUgZU1NQyBkZXZpY2UuDQoNClNlZSBrZXJu
ZWwgcGFyYW1ldGVyOg0KDQppdnJzX2FjcGloaWQgICAgW0hXLFg4Nl82NF0NCiAgICAgICAgICAg
ICAgICAgICAgICAgICBQcm92aWRlIGFuIG92ZXJyaWRlIHRvIHRoZSBBQ1BJLUhJRDpVSUQ8LT5E
RVZJQ0UtSUQNCiAgICAgICAgICAgICAgICAgICAgICAgICBtYXBwaW5nIHByb3ZpZGVkIGluIHRo
ZSBJVlJTIEFDUEkgdGFibGUuIEZvcg0KICAgICAgICAgICAgICAgICAgICAgICAgIGV4YW1wbGUs
IHRvIG1hcCBVQVJULUhJRDpVSUQgQU1EMDAyMDowIHRvDQogICAgICAgICAgICAgICAgICAgICAg
ICAgUENJIGRldmljZSAwMDoxNC41IHdyaXRlIHRoZSBwYXJhbWV0ZXIgYXM6DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpdnJzX2FjcGloaWRbMDA6MTQuNV09QU1EMDAyMDowDQoN
CkhlcmUgd2UgbWlnaHQgbmVlZCB0byBkby4NCg0KICAgICBpdnJzX2FjcGloaWRbMDA6MTMuMV09
PGVtbWMgQUNQSSBISUQgb24gdGhhdCBzeXN0ZW0+DQoNClRoYW5rcywNClN1cmF2ZWUNCg==
