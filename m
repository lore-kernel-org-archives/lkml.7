Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C633C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E937620722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kJ7KuVa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKZOf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:35:29 -0500
Received: from mail-eopbgr720085.outbound.protection.outlook.com ([40.107.72.85]:11344
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfKZOf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:35:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsAOPy1veDbbHuIAwfvMHhDVm8tasi5kIWdCGgYlWSg4gxKK32eKvqg0jcbH2BAU9T/2ufm/pggNU4xf2iv4bPZx6+MLgWiHityLk3YWUKD9kO6ZF0CQg0hTrm9JLXbJdAMA6jksSC0SIwu3K7oki9hnOxLOfFOLqEzX1QrXIR7NN51b8ou9HaUW8tYB/b+T0/uJ6xH9yPCR3cYUub2gEOjoTNCnEgKzmFBwXzQpMBgI8epRyRdOOMxWBeQAG1LEzuCj/IbKdG+ojyEs6eMf5fiQkX+yDlBI2NEeVuYRfTlZIqcfSkLS1XZZ0HpoWY6qjDLWsCHbJElxiRBHPf7e0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFG6sGJuh5GCBigNoHf/CDVIJ96GvDAPFcec6DdFedU=;
 b=U55hZkWv9W8gsoZI81F3me+nQ1J8Ynqch2iMOGCaJad+OSCQRBkons8IWSHGBq/uwaXYS5FQWkGEqCvtFu/fHOosZ6UCOcoCfQZOcrP8yw3c5jbVCPSvWq2ddxcHwPtXkJ/Ia6rcW30MhXgEyifHXb/Du25tlb41BIlD/3Cox5oB6+OUPqa61Ugvn+qtynuwr2qcfIU0cQ6G/ZphvxH+VJaT9NA/UBoeqoP4pqesVBRyeHhXLqobdRj3h8XGAks0jolwHEqElhPop/KcQx6iBGjH3E0+nlMpFpjUA9qNuB7R7TzbdxnhHvGmE3Xhee4cNoXL2CPwzw5+lcAwpU6P7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFG6sGJuh5GCBigNoHf/CDVIJ96GvDAPFcec6DdFedU=;
 b=kJ7KuVa/W3R5NNC6dEaD0VKHQ/MsFBT47gOponVLBEDQz19dbetjh8tmQ4WQ+vxPtj6bQ+mQzmIYw9OEhkIVHuhHYiDA122BvDLlfHKBlD/8Km8lmYBxTyJHIdX1QcHdZdLd0PJ+HT5IbnKGr7w6MjqVQVTVAtVIB3GKvGzj73M=
Received: from MN2PR12MB3232.namprd12.prod.outlook.com (20.179.80.221) by
 MN2PR12MB4141.namprd12.prod.outlook.com (52.135.49.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 14:35:24 +0000
Received: from MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::c4de:9a49:210c:1880]) by MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::c4de:9a49:210c:1880%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 14:35:23 +0000
From:   "Nath, Arindam" <Arindam.Nath@amd.com>
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Jiasen Lin <linjiasen@hygon.cn>
CC:     "S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com> Dave Jiang" 
        <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>,
        "linjiasen007@gmail.com" <linjiasen007@gmail.com>
Subject: RE: Fwd: [PATCH] NTB: Fix an error in get link status
Thread-Topic: Fwd: [PATCH] NTB: Fix an error in get link status
Thread-Index: AQHVpFrbGmxYKGFKUEmz5vA3i7O6b6edg7Ag
Date:   Tue, 26 Nov 2019 14:35:23 +0000
Message-ID: <MN2PR12MB323225CC169836056288CAA39C450@MN2PR12MB3232.namprd12.prod.outlook.com>
References: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
 <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
 <933f74c7-7249-618c-13dc-9e4e47ad75d7@hygon.cn>
 <11b355a8-0fe0-f256-c510-ddf106017703@hygon.cn>
 <CAADLhr7bpb-F0eF1UFXy7AcN=z061mno_QsqGE8z-mvWKvUyCQ@mail.gmail.com>
 <04b4d1ed-ea47-819e-a7e4-b729fa463506@amd.com>
 <5c3155b5-6eed-d955-b18b-59b0cb1c513b@hygon.cn>
 <740bb924-b258-8dda-6469-bc1bee90291f@hygon.cn>
 <c5adca66-024f-8d37-3187-ffba73102ac4@amd.com>
In-Reply-To: <c5adca66-024f-8d37-3187-ffba73102ac4@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2019-11-26T14:31:36Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=c425bd55-2888-491f-8e72-0000f0a39a26;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_enabled: true
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_setdate: 2019-11-26T14:35:21Z
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_method: Privileged
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_name: Non-Business
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_actionid: 458fdfe8-fcea-4f6f-a1ef-00007c94a679
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Arindam.Nath@amd.com; 
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac7fc78a-0bdc-4e4c-ba0f-08d7727ddf31
x-ms-traffictypediagnostic: MN2PR12MB4141:|MN2PR12MB4141:|MN2PR12MB4141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41416DC9B1FC5DD35FE1B8F89C450@MN2PR12MB4141.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(13464003)(53546011)(186003)(26005)(33656002)(8936002)(2906002)(305945005)(6506007)(102836004)(6436002)(7696005)(76176011)(446003)(11346002)(229853002)(4326008)(9686003)(86362001)(6246003)(55016002)(25786009)(71200400001)(66476007)(7736002)(5660300002)(66946007)(66446008)(76116006)(64756008)(66556008)(14454004)(110136005)(8676002)(6116002)(3846002)(99286004)(74316002)(81166006)(81156014)(316002)(66066001)(256004)(52536014)(478600001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4141;H:MN2PR12MB3232.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjQEOXxcGO2FTJ8LnhalcIUrquDM0BUnJRVhPoxiusAsyFjZkie500MYBgMfE1rR5brE2BH9pRVazfWzCsyi4YuCoylvyAjcDa5KbeKT5gI1YNF8HhUQf+rC8iOU7TY3cljxnDmhQexzEuqDUsc6SOYo5/tTs4vseV2SqvY3tCwkCWOEXSqcwLVQm7aof7b1l8BmJdgoKqUFF8ZbCTdsoTjIj7zGMZR4MJXhk3xnpBHsjHi1p+1DXJflABHwtyl3Bkp28BDEHPg1k1srXmYTOe0j18FgjNcc+jM5WP27YQrfpunYCjYl62GdsSdPJDnINkylqhWqiROsEOxBWBwPikWmIOCIs0yQSCSHQeUPn14DA48ZiIvhADzdU+2K+s4qkFPAdSVGRIh8s6/oumjIU0CSTB8GmMMSQ50K0uaAeUQ4MdS1tC/iVyERo2D22wyj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7fc78a-0bdc-4e4c-ba0f-08d7727ddf31
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 14:35:23.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUe+lcYoOSEYYF2OYDkvZDuUwkKxJ4rhiqGxI5w1GXRPZ37Fdg/HaRzncsiBK8vs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNZWh0YSwgU2FuanUgPFNhbmp1
Lk1laHRhQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI2LCAyMDE5IDE4OjQw
DQo+IFRvOiBKaWFzZW4gTGluIDxsaW5qaWFzZW5AaHlnb24uY24+DQo+IENjOiBTLWssIFNoeWFt
LXN1bmRhciA8U2h5YW0tc3VuZGFyLlMta0BhbWQuY29tPiBEYXZlIEppYW5nDQo+IDxkYXZlLmpp
YW5nQGludGVsLmNvbT47IE5hdGgsIEFyaW5kYW0gPEFyaW5kYW0uTmF0aEBhbWQuY29tPjsgQWxs
ZW4NCj4gSHViYmUgPGFsbGVuYmhAZ21haWwuY29tPjsgbGludXgta2VybmVsIDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gbGludXgtbnRiIDxsaW51eC1udGJAZ29vZ2xlZ3JvdXBz
LmNvbT47IGxpbmppYXNlbjAwN0BnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IEZ3ZDogW1BBVENI
XSBOVEI6IEZpeCBhbiBlcnJvciBpbiBnZXQgbGluayBzdGF0dXMNCj4gDQo+IA0KPiA+IEhpIFNh
bmpheSBSIE1laHRhDQo+ID4NCj4gPiBJbiBtb3JlIGNvbXBsZXggdG9wb2xvZ3ksIHJlYWQgdGhl
IExpbmsgU3RhdHVzIGFuZCBDb250cm9sIHJlZ2lzdGVyIG9mDQo+ID4gUlAgaXMgYWxzbyB3cm9u
Zy4gU3VwcG9zZSB0aGF0IGEgUENJZSBzd2l0Y2ggYnJpZGdlIHRvIHRoZSBTZWNvbmRhcnkgUlAs
DQo+ID4gYW5kIFNlY29uZGFyeSBpbnRlcm5hbCBTVy5kcyBpcyBhIGNoaWxkIGRldmljZSBmb3Ig
c3dpdGNoJ3MgZG93bnN0cmVhbQ0KPiA+IHBvcnQgYXMgaWxsdXN0cmF0ZWQgaW4gdGhlIGZvbGxv
d2luZyB0b3BvbG9neS4NCj4gPg0KPiA+IEluIHNlY29uZGFyeSBQQ0kgZG9tYWluOg0KPiA+IFNl
Y29uZGFyeSBSUC0tU3dpdGNoIFVQLS1Td2l0Y2ggRFAtLVNlY29uZGFyeSBpbnRlcm5hbCBTVy51
cy0tDQo+IFNlY29uZGFyeQ0KPiA+IGludGVybmFsIFNXLmRzLS1TZWNvbmRhcnkgTlRCDQo+ID4N
Cj4gPiBwY2lfcnAgPSBwY2lfZmluZF9wY2llX3Jvb3RfcG9ydChuZGV2LT5udGIucGRldikgd2ls
bCByZXR1cm4gdGhlDQo+ID4gU2Vjb25kYXJ5IFJQLCBhbmQgcGNpZV9jYXBhYmlsaXR5X3JlYWRf
ZHdvcmQocGNpX3JwLA0KPiA+IFBDSV9FWFBfTE5LQ1RMLCZzdGF0KSB3aWxsIGdldCB0aGUgbGlu
ayBzdGF0dXMgYmV0d2VlbiBTZWNvbmRhcnkgUlAgYW5kDQo+ID4gU3dpdGNoIFVQLiBNYXliZSwg
cmVhZCB0aGUgTGluayBTdGF0dXMgYW5kIGNvbnRyb2wgcmVnaXN0ZXIgb2YgU2Vjb25kYXJ5DQo+
ID4gaW50ZXJuYWwgU1cudXMgaXMgYXBwcm9wcmlhdGUuDQo+ID4NCj4gSGkgSmlhbnNlbiBMaW4s
DQo+IA0KPiBJIG1vZGlmaWVkIHRoZSBjb2RlIGFzIHBlciB5b3VyIHN1Z2dlc3Rpb24gYW5kIGlz
IHdvcmtpbmcgZmluZS4NCj4gQWRkaW5nIEFyaW5kYW0gZm9yIGNvbW1lbnRzIHdobyB3YXMgdGhl
IGNvLWF1dGhvciBvZiB0aGUgcGF0Y2ggSSB3YXMNCj4gYWJvdXQgdG8gc2VuZCBmb3IgdXBzdHJl
YW0gcmV2aWV3Lg0KDQpIaSBKaWFuc2VuIExpbiwNCg0KSSBhbSBva2F5IHdpdGggdGhlIGNoYW5n
ZXMgcHJvcG9zZWQgYnkgeW91LiBCdXQgb25lIHRoaW5nIHdlIG5lZWQgdG8ga2VlcA0KaW4gbWlu
ZCBpcyB0aGF0LCB0aGUgY29uZmlndXJhdGlvbiBTV1VTK1NXRFMrRVAgYXMgdmlzaWJsZSBmcm9t
IHRoZSBOVEINCnNlY29uZGFyeSwgbWlnaHQgY2hhbmdlIGluIGZ1dHVyZSBBTUQgaW1wbGVtZW50
YXRpb25zIHdoZXJlIHRoZXNlIGludGVybmFsDQpzd2l0Y2hlcyBhcmUgbm90IHByZXNlbnQgYW55
bW9yZS4gU28gd2UgbWlnaHQgaGF2ZSB0byByZS12aXNpdCB0aGUgcGF0Y2gNCmFnYWluIGxhdGVy
Lg0KDQpUaGFua3MsDQpBcmluZGFtDQoNCj4gDQo+IFRoYW5rcywNCj4gU2FuamF5IE1laHRhDQo+
ID4gc3RydWN0IHBjaV9kZXYgKnBjaV91cCA9IE5VTEw7DQo+ID4gc3RydWN0IHBjaV9kZXYgKnBj
aV9kcCA9IE5VTEw7DQo+ID4NCj4gPiBpZiAobmRldi0+bnRiLnRvcG8gPT0gTlRCX1RPUE9fU0VD
KSB7DQo+ID4gwqDCoMKgIC8qIExvY2F0ZSB0aGUgcG9pbnRlciB0byBTZWNvbmRhcnkgdXAgZm9y
IHRoaXMgZGV2aWNlICovDQo+ID4gwqDCoMKgIHBjaV9kcCA9IHBjaV91cHN0cmVhbV9icmlkZ2Uo
bmRldi0+bnRiLnBkZXYpOw0KPiA+IMKgwqDCoCAvKiBSZWFkIHRoZSBQQ0llIExpbmsgQ29udHJv
bCBhbmQgU3RhdHVzIHJlZ2lzdGVyICovDQo+ID4gwqDCoMKgIGlmIChwY2lfZHApIHsNCj4gPiDC
oMKgwqDCoMKgwqAgcGNpX3VwID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShwY2lfZHApOw0KPiA+IMKg
wqDCoMKgwqDCoCBpZiAocGNpX3VwKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByYyA9IHBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKHBjaV91cCwgUENJX0VYUF9MTktDVEws
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmc3Rh
dCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmMpDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gwqDCoMKgwqDCoMKgIH0NCj4gPiB9DQo+
ID4NCj4gPiBUaGFua3MsDQo+ID4gSmlhbnNlbiBMaW4NCj4gPg0KPiA+PiBJIGhhdmUgbW9kaWZp
ZWQgdGhlIGNvZGUgYWNjb3JkaW5nIHRvIHlvdXIgc3VnZ2VzdGlvbiBhbmQgdGVzdGVkIGl0DQo+
ID4+IG9uIERoeWFuYSBwbGF0Zm9ybSwgaXQgd29ya3Mgd2VsbCwgZXhwZWN0IHRvIHJlY2VpY2Ug
eW91ciBwYXRjaC4NCj4gPj4NCj4gPj4gQmVmb3JlIG1vZGlmeSB0aGUgY29kZSwgcmVhZCB0aGUg
TGluayBTdGF0dXMgYW5kIGNvbnRyb2wgcmVnaXN0ZXIgb2YgdGhlDQo+ID4+IHNlY29uZGFyeSBO
VEIgZGV2aWNlIHRvIGdldCBsaW5rIHN0YXR1cy4NCj4gPj4NCj4gPj4gY2F0IC9zeXMva2VybmVs
L2RlYnVnL250Yl9od19hbWQvMDAwMFw6NDNcOjAwLjEvaW5mbw0KPiA+PiBOVEIgRGV2aWNlIElu
Zm9ybWF0aW9uOg0KPiA+PiBDb25uZWN0aW9uIFRvcG9sb2d5IC3CoMKgIE5UQl9UT1BPX1NFQw0K
PiA+PiBMTksgU1RBIC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MTEwMzAwNDINCj4g
Pj4gTGluayBTdGF0dXMgLcKgwqDCoMKgwqDCoMKgwqDCoMKgIFVwDQo+ID4+IExpbmsgU3BlZWQg
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJLUUgR2VuIDMNCj4gPj4gTGluayBXaWR0aCAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB4MTYNCj4gPj4NCj4gPj4gQWZ0ZXIgbW9kaWZ5IHRoZSBjb2Rl
LCByZWFkIHRoZSBMaW5rIFN0YXR1cyBhbmQgY29udHJvbCByZWdpc3RlciBvZiB0aGUNCj4gPj4g
c2Vjb25kYXJ5IFJQIHRvIGdldCBsaW5rIHN0YXR1cy4NCj4gPj4NCj4gPj4gY2F0IC9zeXMva2Vy
bmVsL2RlYnVnL250Yl9od19hbWQvMDAwMFw6NDNcOjAwLjEvaW5mbw0KPiA+PiBOVEIgRGV2aWNl
IEluZm9ybWF0aW9uOg0KPiA+PiBDb25uZWN0aW9uIFRvcG9sb2d5IC3CoMKgIE5UQl9UT1BPX1NF
Qw0KPiA+PiBMTksgU1RBIC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NzA4MzAwNDIN
Cj4gPj4gTGluayBTdGF0dXMgLcKgwqDCoMKgwqDCoMKgwqDCoMKgIFVwDQo+ID4+IExpbmsgU3Bl
ZWQgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJLUUgR2VuIDMNCj4gPj4gTGluayBXaWR0aCAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4OA0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IEppYXNl
biBMaW4NCj4gPj4NCj4gPj4+IC0tLQ0KPiA+Pj4gwqAgZHJpdmVycy9udGIvaHcvYW1kL250Yl9o
d19hbWQuYyB8IDI3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+Pj4gwqAgZHJp
dmVycy9udGIvaHcvYW1kL250Yl9od19hbWQuaCB8wqAgMSAtDQo+ID4+PiDCoCAyIGZpbGVzIGNo
YW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnRiL2h3L2FtZC9udGJfaHdfYW1kLmMNCj4gPj4+IGIvZHJpdmVy
cy9udGIvaHcvYW1kL250Yl9od19hbWQuYw0KPiA+Pj4gaW5kZXggMTRhZDY5Yy4uOTFlMTk2NiAx
MDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbnRiL2h3L2FtZC9udGJfaHdfYW1kLmMNCj4gPj4+
ICsrKyBiL2RyaXZlcnMvbnRiL2h3L2FtZC9udGJfaHdfYW1kLmMNCj4gPj4+IEBAIC04NDIsNiAr
ODQyLDggQEAgc3RhdGljIGlubGluZSB2b2lkIG5kZXZfaW5pdF9zdHJ1Y3Qoc3RydWN0DQo+ID4+
PiBhbWRfbnRiX2RldiAqbmRldiwNCj4gPj4+IMKgIHN0YXRpYyBpbnQgYW1kX3BvbGxfbGluayhz
dHJ1Y3QgYW1kX250Yl9kZXYgKm5kZXYpDQo+ID4+PiDCoCB7DQo+ID4+PiDCoMKgwqDCoMKgIHZv
aWQgX19pb21lbSAqbW1pbyA9IG5kZXYtPnBlZXJfbW1pbzsNCj4gPj4+ICvCoMKgwqAgc3RydWN0
IHBjaV9kZXYgKnBjaV9ycCA9IE5VTEw7DQo+ID4+PiArwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpw
ZGV2ID0gTlVMTDsNCj4gPj4+IMKgwqDCoMKgwqAgdTMyIHJlZywgc3RhdDsNCj4gPj4+IMKgwqDC
oMKgwqAgaW50IHJjOw0KPiA+Pj4gQEAgLTg1NSwxMCArODU3LDI3IEBAIHN0YXRpYyBpbnQgYW1k
X3BvbGxfbGluayhzdHJ1Y3QgYW1kX250Yl9kZXYNCj4gKm5kZXYpDQo+ID4+PiDCoMKgwqDCoMKg
IG5kZXYtPmNudGxfc3RhID0gcmVnOw0KPiA+Pj4gLcKgwqDCoCByYyA9IHBjaV9yZWFkX2NvbmZp
Z19kd29yZChuZGV2LT5udGIucGRldiwNCj4gPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQU1EX0xJTktfU1RBVFVTX09GRlNFVCwgJnN0YXQpOw0KPiA+Pj4gLcKgwqDC
oCBpZiAocmMpDQo+ID4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4+PiArwqDCoMKg
IGlmIChuZGV2LT5udGIudG9wbyA9PSBOVEJfVE9QT19TRUMpIHsNCj4gPj4+ICvCoMKgwqDCoMKg
wqDCoCAvKiBMb2NhdGUgdGhlIHBvaW50ZXIgdG8gUENJZSBSb290IFBvcnQgZm9yIHRoaXMgZGV2
aWNlICovDQo+ID4+PiArwqDCoMKgwqDCoMKgwqAgcGNpX3JwID0gcGNpX2ZpbmRfcGNpZV9yb290
X3BvcnQobmRldi0+bnRiLnBkZXYpOw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIFJlYWQgdGhl
IFBDSWUgTGluayBDb250cm9sIGFuZCBTdGF0dXMgcmVnaXN0ZXIgKi8NCj4gPj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAocGNpX3JwKSB7DQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYyA9
IHBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKHBjaV9ycCwgUENJX0VYUF9MTktDVEwsDQo+ID4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICZzdGF0KTsNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyYykNCj4gPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4+PiArwqDCoMKgwqDC
oMKgwqAgfQ0KPiA+Pj4gK8KgwqDCoCB9IGVsc2UgaWYgKG5kZXYtPm50Yi50b3BvID09IE5UQl9U
T1BPX1BSSSkgew0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+ID4+PiArwqDCoMKgwqDCoMKg
wqDCoCAqIEZvciBOVEIgcHJpbWFyeSwgd2Ugc2ltcGx5IHJlYWQgdGhlIExpbmsgU3RhdHVzIGFu
ZCBjb250cm9sDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHJlZ2lzdGVyIG9mIHRoZSBOVEIg
ZGV2aWNlIGl0c2VsZi4NCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4+PiArwqDCoMKg
wqDCoMKgwqAgcGRldiA9IG5kZXYtPm50Yi5wZGV2Ow0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIHJj
ID0gcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQocGRldiwgUENJX0VYUF9MTktDVEwsICZzdGF0
KTsNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmMpDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gMDsNCj4gPj4+ICvCoMKgwqAgfQ0KPiA+Pj4gKw0KPiA+Pj4gwqDCoMKg
wqDCoCBuZGV2LT5sbmtfc3RhID0gc3RhdDsNCj4gPj4+IMKgwqDCoMKgwqAgcmV0dXJuIDE7DQo+
ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udGIvaHcvYW1kL250Yl9od19hbWQuaA0KPiA+Pj4g
Yi9kcml2ZXJzL250Yi9ody9hbWQvbnRiX2h3X2FtZC5oDQo+ID4+PiBpbmRleCAxMzlhMzA3Li4z
OWU1ZDE4IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9udGIvaHcvYW1kL250Yl9od19hbWQu
aA0KPiA+Pj4gKysrIGIvZHJpdmVycy9udGIvaHcvYW1kL250Yl9od19hbWQuaA0KPiA+Pj4gQEAg
LTUzLDcgKzUzLDYgQEANCj4gPj4+IMKgICNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCj4gPj4+IMKg
ICNkZWZpbmUgQU1EX0xJTktfSEJfVElNRU9VVMKgwqDCoCBtc2Vjc190b19qaWZmaWVzKDEwMDAp
DQo+ID4+PiAtI2RlZmluZSBBTURfTElOS19TVEFUVVNfT0ZGU0VUwqDCoMKgIDB4NjgNCj4gPj4+
IMKgICNkZWZpbmUgTlRCX0xJTl9TVEFfQUNUSVZFX0JJVMKgwqDCoCAweDAwMDAwMDAyDQo+ID4+
PiDCoCAjZGVmaW5lIE5UQl9MTktfU1RBX1NQRUVEX01BU0vCoMKgwqAgMHgwMDBGMDAwMA0KPiA+
Pj4gwqAgI2RlZmluZSBOVEJfTE5LX1NUQV9XSURUSF9NQVNLwqDCoMKgIDB4MDNGMDAwMDANCj4g
Pj4+DQo=
