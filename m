Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8757B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Tyb6CKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfCKLiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:38:11 -0400
Received: from mail-eopbgr700089.outbound.protection.outlook.com ([40.107.70.89]:58584
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726914AbfCKLiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoQrWar4GK4K3ovJgOD+k75O4DaW9MpKVclXcrvbBQw=;
 b=0Tyb6CKNxENgOWp2PPrwhQ9GdIxsbYKI6DpaulwYnsuYEA8X0Au7iqlwEJopMVHXryHeaBCwi9JDLxnHwxiiG0AvRSYYApa7g9JSuLRloPVfr0Gc1sDcIm/QubUzy6gHHRpmfr2SuR4QBwxI3EK1M+RjDNl2iioNrtUFeVYg3rM=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3227.namprd12.prod.outlook.com (20.179.105.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Mon, 11 Mar 2019 11:38:05 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 11:38:05 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Oren Twaig <oren@scalemp.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] svm: Fix AVIC incomplete IPI emulation
Thread-Topic: [PATCH] svm: Fix AVIC incomplete IPI emulation
Thread-Index: AQHU0rY9293WXGT45E2nygfc4G4QEKYGWFMA
Date:   Mon, 11 Mar 2019 11:38:05 +0000
Message-ID: <ab2b29ac-adcf-12ab-7c53-cc427995e94c@amd.com>
References: <d53d2240-d1f1-da04-9126-9eb3518d0047@scalemp.com>
In-Reply-To: <d53d2240-d1f1-da04-9126-9eb3518d0047@scalemp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
x-originating-ip: [165.204.77.1]
x-clientproxiedby: SN4PR0401CA0026.namprd04.prod.outlook.com
 (2603:10b6:803:2a::12) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a8aa43b-8ada-424f-1c58-08d6a61606cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3227;
x-ms-traffictypediagnostic: DM6PR12MB3227:
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3227;20:lYQ1hNT4585xXqBXA0jYfOiCm29sa0xzNjMJoHU3SFanm1N1dmDuPOtUubNLPVXrAuO3WRp5BAayi9B76epiogs6mpR749nGowg436p86qmqHYjcTy13/Rm3n8NfBsiRX/V/gv/87/fCw1B8KZ11Eh/sEJnW6VPHBZUsx3i7o3gDLJPV3K9Zlt8biaYSl11hV18Pt/D2/+Zc213Y6sw/0lHYzehsV7TRor4+fNwe+bBtwzn/pbgiVEsP02LZSKZs
x-microsoft-antispam-prvs: <DM6PR12MB3227874A8FCF0DBC3EAF9E86F3480@DM6PR12MB3227.namprd12.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(53936002)(105586002)(25786009)(386003)(26005)(54906003)(102836004)(6506007)(6246003)(53546011)(72206003)(6486002)(52116002)(6436002)(99286004)(3846002)(36756003)(6116002)(81156014)(81166006)(14454004)(6512007)(64126003)(229853002)(76176011)(31686004)(65956001)(66066001)(65806001)(478600001)(8676002)(486006)(31696002)(2906002)(14444005)(256004)(305945005)(71200400001)(7736002)(71190400001)(8936002)(86362001)(2616005)(476003)(11346002)(446003)(65826007)(186003)(97736004)(106356001)(58126008)(5660300002)(68736007)(6916009)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3227;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xFdbRfYVchRPbCmNwEcXYYB9gQcHVTs1J7cfOBSp3vjKWR+m/7WgBUWH+YCQccXYPyAkSHxO9bzCWfrgqsLEGy2YsGTrRdSv9SFg6DxmtofjBYuf2uIPE1OQuZQ6BO009jEyfoCwr1E1b8NYp0tBrpKjIZD4hte1U3mucU7bpUBm8dJq+c7s3LTPAQOx7tLKH34DGfp0oIQtdSESGx8cGh8+QXUr3L4YQLN0FjA2y6hcbAkYnB8CM6uaN/YTEdh7azuD1g1KjYTifgAQwGaPiziZvp58LLVK7ymN17+GXIw+OTB+FIils57jPSfQRSBWMBnq7fr5c9NgaR99G+aloj9uwtk8O26dnlEeTQYEI/owQY8hX7iXaop552a2JAj2O52waYAW4coZU+x6VUbkTSfOjXbHJ7azMKVKwqIkDRA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E7606A84EEF004D8C4D64CC5ADD986C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8aa43b-8ada-424f-1c58-08d6a61606cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 11:38:05.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT3JlbiwNCg0KU29ycnkgZm9yIGRlbGF5IHJlc3BvbnNlLg0KDQpPbiAzLzUvMTkgMToxNSBB
TSwgT3JlbiBUd2FpZyB3cm90ZToNCj4gSGVsbG8gU3VyYXZlZSwNCj4gDQo+IEFjY29yZGluZyB0
byBBTUQncyBTRE0sIHRoZSB0YXJnZXQtbm90LXJ1bm5pbmcgaW5jb21wbGV0ZQ0KPiBpcGkgZXhp
dCBpcyBvbmx5IHJlY2VpdmVkIGlmIGFueSBvZiB0aGUgZGVzdGluYXRpb24gY3B1cyBoYWQgdGhl
DQo+IG5vdC1ydW5uaW5nIGJpdCBzZXQgaW4gdGhlIGF2aWMgYmFja2luZyBwYWdlLg0KDQpJIGJl
bGlldmUgeW91IGFyZSByZWZlcnJpbmcgdG8gdGhlICJpc1J1bm5pbmciIChJUikgYml0IGlzIGlu
IHRoZQ0KQVZJQyBwaHlzaWNhbCBBUElDIElEIHRhYmxlIGVudHJ5Lg0KDQo+IEhvd2V2ZXIsIG5v
dCBiZWZvcmUgdGhlIENQVSBfYWxyZWFkeV8gc2V0IHRoZSByZWxldmFudCBJUlIgYml0DQo+IGlu
IGFsbCB0aGVzZSBjcHVzLg0KDQpOb3Qgc3VyZSB3aGF0IHlvdSBtZWFudCBoZXJlLg0KDQo+IElu
IHRoaXMgY2hhbmdlLCB0aGUgcGF0Y2ggZm9yY2VzIEtWTSB0byBzZW5kIGFub3RoZXIgaW50ZXJy
dXB0IA0KPiB0byB0aGUgdmNwdSB3aGV0aGVyIFNWTSBhbHJlYWR5IGRpZCB0aGF0IG9yIG5vdC4g
V2hpY2ggbWVhbnMNCj4gdGhlIHZjcHUvcywgdW5kZXIgc29tZSBjb25kaXRpb25zLCBjYW4gZ2V0
IGFuIEVYVFJBIGludGVycnVwdA0KPiBpdCBuZXZlciBpbnRlbmRlZCB0byBnZXQgPj4gRXhhbXBs
ZToNCj4gIMKgIDEuIHZjcHUgQjogSXMgaW4gIm5vdC1ydW5uaW5nIiBzdGF0ZS4NCj4gIMKgIDIu
IHZjcHUgQTogV3JpdGVzIHRvIHRoZSBJQ1IgdG8gc2VuZCB2ZWN0b3IgODAgdG8gdmNwdSBCDQo+
ICDCoCAzLiB2Y3B1IEE6IFNWTSB1cGRhdGVzIHZjcHUgQiBJUlIgd2l0aCBiaXQgODANCj4gIMKg
IDQuIHZjcHUgQTogU1ZNIGV4aXRzIG9uIGluY29tcGxldGUgSVBJIHRhcmdldC1ub3QtcnVubmlu
ZyBleGl0Lg0KPiAgwqAgNS4gdmNwdSBBOiBOb3cgc3RvcHMgZXhlY3V0aW5nIGFueSBjb2RlIEAg
aHlwZXJ2aXNvciBsZXZlbC4NCj4gIMKgIDYuIHZjcHUgQjogRHVlIHRvIGFub3RoZXIgaW50ZXJy
dXB0IChsaWtlIGxhcGljIHRpbWVyKQ0KPiAgwqDCoMKgwqAgcmVzdW1lcyBydW5uaW5nIHRoZSBn
dWVzdC4gV2hpbGUgaGFuZGxpbmcgaW50ZXJydXB0cywNCj4gIMKgwqDCoMKgIGl0IGFsc28gaGFu
ZGxlcyBpbnRlcnJ1cHQgdmVjdG9yIDgwIChhcyBpdCdzIGluIGhpcyBJUlIpDQo+ICDCoCA3LiB2
Y3B1IEE6IHJlc3VtZXMgZXhlY3V0aW5nIHRoZSBiZWxvdyBjb2RlIGFuZCBzZW5kcw0KPiAgwqDC
oMKgwqAgYW4gX2FkZGl0aW9uYWxfaW50ZXJydXB0IHRvIHZjcHUgQi4NCj4gDQo+IE92ZXJhbGws
IHZjcHUgQiBnb3QgdHdvIGludGVycnVwdHMuIFRoZSBzZWNvbmQgaXMgdW53YW50ZWQgYW5kDQo+
IG5vdCBkb2N1bWVudGVkIGluIHRoZSBzeXN0ZW0gYXJjaGl0ZWN0dXJlLg0KPg0KPiBDYW4geW91
IHBsZWFzZSBlbGFib3JhdGUgbW9yZSB0byB3aHkgdGhlIGltcGxlbWVudGF0aW9uDQo+IGJlbG93
IGNvbmZsaWN0IHdpdGggdGhlIHNwZWNpZmljYXRpb25zICh3aGljaCB3YXMgdGhlIGNvZGUNCj4g
YmVmb3JlIHRoaXMgY29tbWl0KSA/DQpUaGlzIHBhdGNoIHdhcyBpbnRyb2R1Y2VkIHRvIGZpeCBh
biBpc3N1ZSB3aGVyZSB0aGUgU1ZNIGRyaXZlciB0cmllcyB0bw0KaGFuZGxlIHRoZSBzdGVwIDUg
YWJvdmUgYnkgc2NoZWR1bGluZyB2Y3B1IEIgaW50byBfcnVubmluZ18gc3RhdGUgdG8gaGFuZGxl
DQp0aGUgSVBJIGZyb20gdmNwdSBBLiBIb3dldmVyLCBwcmlvciB0byB0aGlzIHBhdGNoLCB2Y3B1
IEIgd2FzIG5ldmVyIGdldA0Kc2NoZWR1bGVkIHRvIHJ1biB1bmxlc3MgdGhlcmUgYXJlIG90aGVy
IGludGVycnVwdHMgKGUuZy4gdGltZXIpLg0KVGhpcyBzaG91bGQgbm90IGJlIHRoZSBjYXNlIGFz
IFZjcHUgQiBzaG91bGQgaGF2ZSBiZWVuIHJ1bm5pbmcgcmVnYXJkbGVzcw0Kb2Ygb3RoZXIgaW50
ZXJydXB0cy4gU28sIEkgZG9uJ3QgdGhpbmsgc3RlcCA2IGFuZCA3IGFib3ZlIGFyZSBjb3JyZWN0
Lg0KDQpUaGUgaXNzdWUgd2FzIGNhdXNlZCBieSB0aGUgYXBpYy0+aXJyX3BlbmRpbmcgbm90IHNl
dCB0byB0cnVlIHdoZW4gdHJ5aW5nIHRvDQpnZXQgdmNwdSBCIHNjaGVkdWxlZC4gVGhpcyBmbGFn
IGlzIGNoZWNrZWQgaW4gYXBpY19maW5kX2hpZ2hlc3RfaXJyKCkgYmVmb3JlDQpzZWFyY2hpbmcg
Zm9yIHRoZSBoaWdoZXN0IGJpdC4NCg0KVG8gZml4IHRoZSBpc3N1ZSwgSSBkZWNpZGVkIHRvIGxl
dmVyYWdlIHRoZSBleGlzdGluZyBlbXVsYXRpb24gY29kZSBmb3INCklDUiBhbmQgSUNSMiwgd2hp
Y2ggaW4gdHVybiBjYWxscyBhcGljX3NlbmRfaXBpKCkgdG8gZGVsaXZlciBpbnRlcnJ1cHQgdG8g
dnB1IEIuDQoNCkhvd2V2ZXIsIGxvb2tpbmcgYSBiaXQgbW9yZSBjbG9zZWx5LCBJIG5vdGljZSB0
aGUgbG9naWMgaW4gc3ZtX2RlbGl2ZXJfYXZpY19pbnRyKCkNCnNob3VsZCBhbHNvIGhhdmUgYmVl
biBjaGFuZ2VkIGZyb20ga3ZtX3ZjcHVfd2FrZV91cCgpIHRvIGt2bV92Y3B1X2tpY2soKQ0Kc2lu
Y2UgdGhlIGxhdHRlciB3aWxsIHJlc3VsdCBpbiBjbGVhcmluZyB0aGUgSVJSIGJpdCBmb3IgdGhl
IElQSSB2ZWN0b3INCndoZW4gdHJ5aW5nIHRvIHNlbmQgSVBJIGFzIHBhcnQgb2YgdGhlIGZvbGxv
d2luZyBjYWxsIHBhdGguDQoNCiAgIHZjcHVfZW50ZXJfZ3Vlc3QoKQ0KICAgICB8LS0gaW5qZWN0
X3BlbmRpbmdfZXZlbnQoKQ0KICAgICAgIHwtLSBrdm1fY3B1X2dldF9pbnRlcnJ1cHQoKQ0KICAg
ICAgICAgfC0tICBrdm1fZ2V0X2FwaWNfaW50ZXJydXB0KCkNCiAgICAgICAgICAgfC0tIGFwaWNf
Y2xlYXJfaXJyKCkNCiAgICAgICAgICAgfC0tIGFwaWNfc2V0X2lzcigpDQogICAgICAgICAgIHwt
LSBhcGljX3VwZGF0ZV9wcHIoKSAuLi4uDQoNClBsZWFzZSBzZWUgdGhlIHBhdGNoIGJlbG93Lg0K
DQpOb3Qgc3VyZSBpZiB0aGlzIHdvdWxkIGFkZHJlc3MgdGhlIHByb2JsZW0geW91IGFyZSBzZWVp
bmcuDQoNClRoYW5rcywNClN1cmF2ZWUNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0u
YyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KaW5kZXggMjRkZmE2YTkzNzExLi5kMjg0MWMzZGJjMDQg
MTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gveDg2L2t2bS9zdm0u
Yw0KQEAgLTUyMTksMTEgKzUyNTYsMTMgQEAgc3RhdGljIHZvaWQgc3ZtX2RlbGl2ZXJfYXZpY19p
bnRyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaW50IHZlYykNCiAgICAgICAgIGt2bV9sYXBpY19z
ZXRfaXJyKHZlYywgdmNwdS0+YXJjaC5hcGljKTsNCiAgICAgICAgIHNtcF9tYl9fYWZ0ZXJfYXRv
bWljKCk7DQoNCi0gICAgICAgaWYgKGF2aWNfdmNwdV9pc19ydW5uaW5nKHZjcHUpKQ0KKyAgICAg
ICBpZiAoYXZpY192Y3B1X2lzX3J1bm5pbmcodmNwdSkpIHsNCiAgICAgICAgICAgICAgICAgd3Jt
c3JsKFNWTV9BVklDX0RPT1JCRUxMLA0KICAgICAgICAgICAgICAgICAgICAgICAga3ZtX2NwdV9n
ZXRfYXBpY2lkKHZjcHUtPmNwdSkpOw0KLSAgICAgICBlbHNlDQotICAgICAgICAgICAgICAga3Zt
X3ZjcHVfd2FrZV91cCh2Y3B1KTsNCisgICAgICAgfSBlbHNlIHsNCisgICAgICAgICAgICAgICBr
dm1fbWFrZV9yZXF1ZXN0KEtWTV9SRVFfRVZFTlQsIHZjcHUpOw0KKyAgICAgICAgICAgICAgIGt2
bV92Y3B1X2tpY2sodmNwdSk7DQorICAgICAgIH0NCiAgfQ0KDQogIHN0YXRpYyB2b2lkIHN2bV9p
cl9saXN0X2RlbChzdHJ1Y3QgdmNwdV9zdm0gKnN2bSwgc3RydWN0IGFtZF9pb21tdV9waV9kYXRh
ICpwaSkNCg==
