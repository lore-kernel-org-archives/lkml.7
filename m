Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93133C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536B82186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F4Mvo1jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfH0JgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:36:11 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:29657 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfH0JgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:36:10 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d64f8570000>; Tue, 27 Aug 2019 17:31:03 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 27 Aug 2019 02:31:03 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 27 Aug 2019 02:31:03 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 09:31:02 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.55) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Aug 2019 09:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n237M4Gj6bljmsZx3/P/63hLCfF7D6ufiSdP+WP5zpviZRaqDL1ANM8spZb7xGfFd/bNGDT5xfV9UxML1Kw3KYqDfZNR38WNH95E5MvtVjUQ92mgcn9B4CuPUlqV/BFhpKh4F1gr0yGEaoBathZa9UfjAgoVXYnLo32BJyrM0+GF7zCmVSes10vb0GNSVpPuNsk+uvPPeGaeG/CmlRon/67TYjsrJu8oBUIWMWHHDCEq2ajq/w0plYoiCdVm7eBjokMp3gP6Tf1aQ1ez0q2Tjm6Drplt0Wl/ip0J/n49Tozbejy53NqMTobzVacsSDvE8yZ3vpkt2r+DPGZ+yN/SHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLIbnxxyczWsZ7CxB5x8i2KIDduOErg416Gt+h083/M=;
 b=OB+L4zJdmKY1Mwb1j7zMrNjbCjMn+Aq+PJehRvV5vtAnmaTose9TZWfhKxSnN67cnzFHKHcN0RUMetNgcsvPD9t8o5TsyCYRN50AA/u6rg8jqysbrGgT1P4+ORweVWDrMOthhCnXpVmfBGEB39KJg7UwS5TyQ631bQH9F89o/VMH+05VP7nWc+RCCTdrgpszXFRK9oVVnHRkqGSA9Dhr1JOehlfTRlmhW0CfmBzzCY7z+BKATqVysNA/trqMVgCooDjWxLcvDH3nEFzs5yOL5lIs3WBt0QLI8vYnbTYmA7uW64LEinTsZr5YURsnoYQYZn0FmLKBfnFFcN9YJdccLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from SN6PR12MB2734.namprd12.prod.outlook.com (52.135.107.25) by
 SN6PR12MB2831.namprd12.prod.outlook.com (20.177.251.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:31:00 +0000
Received: from SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b]) by SN6PR12MB2734.namprd12.prod.outlook.com
 ([fe80::fdaf:cdfc:c0da:f84b%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 09:31:00 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shardar Mohammed" <smohammed@nvidia.com>
Subject: RE: [PATCH 10/14] serial: tegra: add support to use 8 bytes trigger
Thread-Topic: [PATCH 10/14] serial: tegra: add support to use 8 bytes trigger
Thread-Index: AQHVUQE4wj5hoiCI50enOZd85jwEVqcC94aAgAvZPAA=
Date:   Tue, 27 Aug 2019 09:31:00 +0000
Message-ID: <SN6PR12MB27340AB6574C72FD4DCC901DC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-11-git-send-email-kyarlagadda@nvidia.com>
 <dda0d866-ae7a-8655-7b26-4c28249c0be8@nvidia.com>
In-Reply-To: <dda0d866-ae7a-8655-7b26-4c28249c0be8@nvidia.com>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kyarlagadda@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-27T09:30:58.1696490Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=a9250423-17f4-41d0-aca9-06cf50cc2627;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyarlagadda@nvidia.com; 
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e621a87-515f-4d1f-6ebb-08d72ad145f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2831;
x-ms-traffictypediagnostic: SN6PR12MB2831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28317AFD528FCD0A798867D3C3A00@SN6PR12MB2831.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39850400004)(136003)(199004)(189003)(13464003)(486006)(86362001)(55016002)(76116006)(66476007)(66556008)(64756008)(66446008)(26005)(186003)(66946007)(229853002)(66066001)(478600001)(54906003)(81156014)(81166006)(110136005)(8676002)(8936002)(102836004)(71200400001)(53546011)(7736002)(3846002)(14454004)(6116002)(305945005)(74316002)(71190400001)(25786009)(52536014)(4326008)(446003)(5660300002)(11346002)(6246003)(55236004)(107886003)(76176011)(316002)(2501003)(256004)(9686003)(2906002)(476003)(53936002)(7696005)(14444005)(6436002)(99286004)(6506007)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2831;H:SN6PR12MB2734.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6TL3hRA2FDpXjOtgv7sbROdSXr/ZVpQC89pALyYsKNlRWE+tWZPxUCDNJrBMnSVY76KvjrkCi7EkF42c9HWlREtgjL7D/I5G3hbRkWil3qTheu0eJVYYFqSD66hcNocv5hFOS14WQuonaa5WJOThOhHuropAS+z6whrgL2bJoBCVSzpwEj861ZgA1XlIEZaFpatkK1ljUe/EAAEBzbJSng4aDP3jn3tRDtQv7RTSVYg+0ztPiK1qxGVyUubWEaDlyKy1aP8Z6o8XNJrmnzHNRB1WI8Zux5X3Vavc2J6zDWIFYt+gBPsPhGuc8esR8PiOoeDYDQdoj9teKWRPvPENNGB4+3HeY7ZBgsVB9m1Xf5CJxIGcNxPPgYl3tCBzuxkvscVUD7WqY+IVwk2p8xdxT998DLE40Iyr3VWxJjdEKHI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e621a87-515f-4d1f-6ebb-08d72ad145f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:31:00.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKGjGCK4j0bnQ+xjcs+n2CN5SAJMWpaLcWJ9CtendKHYYCpnxC4au3tlbhwaU5OJwWN2+Dt9WrXssojpSRP17A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566898263; bh=lLIbnxxyczWsZ7CxB5x8i2KIDduOErg416Gt+h083/M=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=F4Mvo1jbW/HUkZNTNfgWZLdl8Qnl02i/YXbrpF+N/d6c8XWloIeaOT290S7Elj2Bu
         gTNTu8LBkEO67lDRFO25/VxHhRnLelpofvzRA0WW5n9SniKU+SaLSXjlBlp077b0OD
         1eO/DKAickmo8FEvCrqbi+VKIusOLhaYJlrYPsFydwSowJtANKJWY6wM8zpMEvehSc
         K/lWJL4Smi5b6roaovqESO8NCulD27tsGzvfLuPH5hj+oc6iqAoH8T6U5UMU7BceWn
         6zeAg0lbCVTqkjv/zzHcVXT9Et+/6j4oURo+QUAlV3VCTuOemSaJYkK8GCR2z49zsO
         KsQNmqTqP747w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBIdW50ZXIgPGpv
bmF0aGFuaEBudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIwMTkgMTo1
OSBBTQ0KPiBUbzogS3Jpc2huYSBZYXJsYWdhZGRhIDxreWFybGFnYWRkYUBudmlkaWEuY29tPjsN
Cj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5y
dXRsYW5kQGFybS5jb207DQo+IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsgTGF4bWFuIERld2Fu
Z2FuIDxsZGV3YW5nYW5AbnZpZGlhLmNvbT47DQo+IGpzbGFieUBzdXNlLmNvbQ0KPiBDYzogbGlu
dXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiB0ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IFNoYXJkYXIgTW9oYW1tZWQNCj4gPHNtb2hhbW1lZEBudmlkaWEuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDEwLzE0XSBzZXJpYWw6IHRlZ3JhOiBhZGQgc3VwcG9ydCB0byB1c2UgOCBi
eXRlcyB0cmlnZ2VyDQo+IA0KPiANCj4gT24gMTIvMDgvMjAxOSAxMjoyOCwgS3Jpc2huYSBZYXJs
YWdhZGRhIHdyb3RlOg0KPiA+IEZyb206IFNoYXJkYXIgU2hhcmlmZiBNZCA8c21vaGFtbWVkQG52
aWRpYS5jb20+DQo+ID4NCj4gPiBBZGQgc3VwcG9ydCB0byB1c2UgOCBieXRlcyB0cmlnZ2VyIGZv
ciBUZWdyYTE4NiBTT0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFyZGFyIFNoYXJpZmYg
TWQgPHNtb2hhbW1lZEBudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgWWFy
bGFnYWRkYSA8a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbC10ZWdyYS5jIHwgMTMgKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsLXRlZ3JhLmMgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvc2VyaWFsLXRlZ3JhLmMNCj4gPiBpbmRleCAzMjk5MjNjLi4wM2QxZDIwIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWwtdGVncmEuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9zZXJpYWwtdGVncmEuYw0KPiA+IEBAIC04OCw2ICs4OCw3IEBAIHN0
cnVjdCB0ZWdyYV91YXJ0X2NoaXBfZGF0YSB7DQo+ID4gIAlib29sCXN1cHBvcnRfY2xrX3NyY19k
aXY7DQo+ID4gIAlib29sCWZpZm9fbW9kZV9lbmFibGVfc3RhdHVzOw0KPiA+ICAJaW50CXVhcnRf
bWF4X3BvcnQ7DQo+ID4gKwlpbnQJZG1hX2J1cnN0X2J5dGVzOw0KPiANCj4gSSBhc3N1bWUgdGhh
dCB0aGlzIGlzIGEgbWF4aW11bSwgc28gd2h5IG5vdCBzYXkgbWF4X2RtYV9idXJzdF9ieXRlcz8N
Clllcy4gVGhpcyBpcyBtYXhpbXVtLiBXaWxsIHVwZGF0ZS4NCg0KPiANCj4gPiAgfTsNCj4gPg0K
PiA+ICBzdHJ1Y3QgdGVncmFfdWFydF9wb3J0IHsNCj4gPiBAQCAtOTMzLDcgKzkzNCwxMiBAQCBz
dGF0aWMgaW50IHRlZ3JhX3VhcnRfaHdfaW5pdChzdHJ1Y3QNCj4gdGVncmFfdWFydF9wb3J0ICp0
dXApDQo+ID4gIAkgKiBwcm9ncmFtbWVkIGluIHRoZSBETUEgcmVnaXN0ZXJzLg0KPiA+ICAJICov
DQo+ID4gIAl0dXAtPmZjcl9zaGFkb3cgPSBVQVJUX0ZDUl9FTkFCTEVfRklGTzsNCj4gPiAtCXR1
cC0+ZmNyX3NoYWRvdyB8PSBVQVJUX0ZDUl9SX1RSSUdfMDE7DQo+ID4gKw0KPiA+ICsJaWYgKHR1
cC0+Y2RhdGEtPmRtYV9idXJzdF9ieXRlcyA9PSA4KQ0KPiA+ICsJCXR1cC0+ZmNyX3NoYWRvdyB8
PSBVQVJUX0ZDUl9SX1RSSUdfMTA7DQo+ID4gKwllbHNlDQo+ID4gKwkJdHVwLT5mY3Jfc2hhZG93
IHw9IFVBUlRfRkNSX1JfVFJJR18wMTsNCj4gPiArDQo+ID4gIAl0dXAtPmZjcl9zaGFkb3cgfD0g
VEVHUkFfVUFSVF9UWF9UUklHXzE2QjsNCj4gPiAgCXRlZ3JhX3VhcnRfd3JpdGUodHVwLCB0dXAt
PmZjcl9zaGFkb3csIFVBUlRfRkNSKTsNCj4gPg0KPiA+IEBAIC0xMDQ2LDcgKzEwNTIsNyBAQCBz
dGF0aWMgaW50DQo+IHRlZ3JhX3VhcnRfZG1hX2NoYW5uZWxfYWxsb2NhdGUoc3RydWN0IHRlZ3Jh
X3VhcnRfcG9ydCAqdHVwLA0KPiA+ICAJCX0NCj4gPiAgCQlkbWFfc2NvbmZpZy5zcmNfYWRkciA9
IHR1cC0+dXBvcnQubWFwYmFzZTsNCj4gPiAgCQlkbWFfc2NvbmZpZy5zcmNfYWRkcl93aWR0aCA9
DQo+IERNQV9TTEFWRV9CVVNXSURUSF8xX0JZVEU7DQo+ID4gLQkJZG1hX3Njb25maWcuc3JjX21h
eGJ1cnN0ID0gNDsNCj4gPiArCQlkbWFfc2NvbmZpZy5zcmNfbWF4YnVyc3QgPSB0dXAtPmNkYXRh
LT5kbWFfYnVyc3RfYnl0ZXM7DQo+ID4gIAkJdHVwLT5yeF9kbWFfY2hhbiA9IGRtYV9jaGFuOw0K
PiA+ICAJCXR1cC0+cnhfZG1hX2J1Zl92aXJ0ID0gZG1hX2J1ZjsNCj4gPiAgCQl0dXAtPnJ4X2Rt
YV9idWZfcGh5cyA9IGRtYV9waHlzOw0KPiA+IEBAIC0xMzI1LDYgKzEzMzEsNyBAQCBzdGF0aWMg
c3RydWN0IHRlZ3JhX3VhcnRfY2hpcF9kYXRhDQo+IHRlZ3JhMjBfdWFydF9jaGlwX2RhdGEgPSB7
DQo+ID4gIAkuc3VwcG9ydF9jbGtfc3JjX2RpdgkJPSBmYWxzZSwNCj4gPiAgCS5maWZvX21vZGVf
ZW5hYmxlX3N0YXR1cwk9IGZhbHNlLA0KPiA+ICAJLnVhcnRfbWF4X3BvcnQJCQk9IDUsDQo+ID4g
KwkuZG1hX2J1cnN0X2J5dGVzCQk9IDQsDQo+IA0KPiBJc24ndCBpdCBzaW1wbGVyIHRvIHN0b3Jl
IHRoZSBUUklHIHZhbHVlIGhlcmU/DQo+IA0KPiBKb24NClRSSUcgdmFsdWUgd2lsbCBoYXZlIHRv
IGJlIGNvbnZlcnRlZCB0byBtYXggYnVyc3QgYW5kIG9uZSBvZiBpdCBuZWVkcyB0byBiZQ0KZGVy
aXZlZCBmcm9tIG90aGVyLg0KS1kNCj4gDQo+IC0tDQo+IG52cHVibGljDQo=
