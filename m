Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9657C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84240218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xM89No+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCVTds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:33:48 -0400
Received: from mail-eopbgr740043.outbound.protection.outlook.com ([40.107.74.43]:18205
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbfCVTdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fWImCqqomlpkY3iZdAg7rwvbYHSdoHEGa1v4LwjAaI=;
 b=xM89No+02OOgDWyuRJGpx6INpyBCohx/KLb8SwBXTLwQ6MGt8RVuO3U8P5/kMag32WTonDoy4rni+BvR8k7OSg1hwUVwESzReUbafRM29cwoTvaPKU2dSB/jq1ytMc77ikI2kji9C+IryRodNbTgLOrsVJVRLw9NA/jb1hbeD9g=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2751.namprd12.prod.outlook.com (52.135.107.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 22 Mar 2019 19:33:44 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 19:33:43 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: RE: [PATCH v2 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Topic: [PATCH v2 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Index: AQHU4CQzOwE6EEZAWEC91l7umX/fDqYX6sEAgAAejgCAAAJgAIAAADDg
Date:   Fri, 22 Mar 2019 19:33:43 +0000
Message-ID: <SN6PR12MB2639D01961ADF8782EE36BA1F8430@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
 <20190321202505.5553-2-Yazen.Ghannam@amd.com>
 <20190322173436.GK12472@zn.tnic>
 <feea1978-04ef-82f9-933e-4ae280391aea@amd.com>
 <20190322193228.GN12472@zn.tnic>
In-Reply-To: <20190322193228.GN12472@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e495d77-4505-454a-7b17-08d6aefd4bba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2751;
x-ms-traffictypediagnostic: SN6PR12MB2751:
x-microsoft-antispam-prvs: <SN6PR12MB27513E10BD37335C4614C00AF8430@SN6PR12MB2751.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(13464003)(76176011)(476003)(71190400001)(6116002)(8676002)(105586002)(256004)(81156014)(93886005)(33656002)(7736002)(8936002)(54906003)(3846002)(74316002)(305945005)(106356001)(66066001)(68736007)(71200400001)(6436002)(97736004)(11346002)(486006)(446003)(2906002)(4326008)(86362001)(7696005)(14454004)(72206003)(102836004)(6246003)(5660300002)(6916009)(53546011)(478600001)(53936002)(81166006)(55016002)(186003)(52536014)(9686003)(26005)(229853002)(6506007)(99286004)(25786009)(316002)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2751;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZU5D5wQp4LoW2d63BwRUioJ9gxiRtLV2AntQro2Fpj/Ttpq+u+jihP5wQnDNDGmI3gDDLp6cZU5EWV1qzaDiwhS2T5i1/mVFofhhnC409F6ChlmwEsOn/OjkOVlcGFoab54g9aFPSuFYk6MPWnAIhpyG3y+xhjoLSP0ZGK9rdZCEJx81bXgwPvy1hi/0JWEfTACGynjzPlflcDsdrHtEF3fDFwCs+O4cknn4IxotIYPwk71qcS+EjRJtdSVmyeHgbyrJA0qphaynhp71w1X5QK/8lClaqpNlbTvyVwvyb4RnnpFJeSXiklgiFoPLs0L9f6K3HfWsGCnJNBbNdtwnRy9DH7hJO/iFISaAGyhi/bZhTcIBfmXVOYUryIE+2xkS1Hs3u+PtimrUhdpAZv0ga1vTQvik+TZuZkt6TQ6ejF0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e495d77-4505-454a-7b17-08d6aefd4bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 19:33:43.9014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyMiwgMjAxOSAyOjMy
IFBNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzog
bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IHRvbnkubHVja0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnOyByYWZhbEBtaWxlY2tpLnBsOw0K
PiBjbGVtZWpAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSB4ODYvTUNF
L0FNRDogRG9uJ3QgcmVwb3J0IEwxIEJUQiBNQ0EgZXJyb3JzIG9uIHNvbWUgRmFtaWx5IDE3aCBt
b2RlbHMNCj4gDQo+IE9uIEZyaSwgTWFyIDIyLCAyMDE5IGF0IDA3OjI0OjAxUE0gKzAwMDAsIEdo
YW5uYW0sIFlhemVuIHdyb3RlOg0KPiA+IEdlbmVyYWxseSwgdGhlIG1vZGVsIGdyb3VwcyBzaGFy
ZSB0aGUgc2FtZSBoYXJkd2FyZSBkZXNpZ24gYW5kIHNvIHRoZQ0KPiA+IHNhbWUgcXVpcmtzLiBT
byBJJ20gdGhpbmtpbmcgdGhhdCBpdCdkIGJlIG1vcmUgZWZmaWNpZW50IHRvIGhhdmUgYQ0KPiA+
IGZpbHRlciBmdW5jdGlvbiB0aGF0IHRhcmdldHMgYSBzcGVjaWZpYyBncm91cCBvZiBtb2RlbHMg
cmF0aGVyIHRoYW4NCj4gPiBvbmUgdGhhdCBjaGVja3MgYWxsIGtub3duIHF1aXJrcyBvbiBhbGwg
bW9kZWxzLg0KPiANCj4gT3Igc2ltcGx5IHN0YXJ0IHdpdGggYSBhbWRfZmlsdGVyX21jZSgpIGZ1
bmN0aW9uIGFuZCB3aGVuIGl0IGdyb3dzIGJpZw0KPiBhbmQgdW53aWVsZHksIG9ubHkgKnRoZW4q
IHN0YXJ0IHRoaW5raW5nIGFib3V0IHNwbGl0dGluZyBpdCBpbnRvIG1vZGVscw0KPiBhbmQgZmFt
aWxpZXMuIEZvciBub3csIHlvdSdyZSBmaW5lIHdpdGggYSBzaW5nbGUgQU1ELXNwZWNpZmljIGZ1
bmN0aW9uLg0KPiANCg0KVW5kZXJzdG9vZC4NCg0KPiA+IE1vc3Qgb2YgdGhlIHF1aXJrcyBhcmUg
ZGVhbHQgd2l0aCBhdCBpbml0IHRpbWUsIGJ1dCB0aGlzIG5lZWRzIGJlIHRvDQo+ID4gZG9uZSBk
dXJpbmcgcnVuIHRpbWUgZm9yIGVhY2ggTUNFIHRoYXQgaXMgbG9nZ2VkLiBTbyBJIGRpZG4ndCB3
YW50IHRvDQo+ID4gYWRkIHVubmVjZXNzYXJ5IGNoZWNrcyB0byB0aGUgTUNFIGhhbmRsZXJzLiBX
ZSBoYXZlIHF1aXJrX25vX3dheV9vdXQoKQ0KPiA+IHRoYXQgZG9lcyBzb21ldGhpbmcgc2ltaWxh
ci4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgYSBjb3VwbGUgb2YgaW5zdHJ1Y3Rpb25zIGNoZWNraW5n
IHZlbmRvciBhbmQgZmFtaWx5IHdvdWxkDQo+IGJlIGF0IGFsbCBub3RpY2VhYmxlIHNvIGxldCdz
IHN0YXJ0IHNpbXBsZS4NCj4gDQoNCk9rYXksIHdpbGwgZG8uDQoNClRoYW5rcywNCllhemVuDQo=
