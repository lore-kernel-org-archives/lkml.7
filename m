Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AABAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387FC2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lz3VnyFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCMDIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:08:07 -0400
Received: from mail-eopbgr790055.outbound.protection.outlook.com ([40.107.79.55]:35264
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbfCMDIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ixox7zvbEvDA22AGQJCkDuqBYAu4tii86wPtV9NcvU=;
 b=lz3VnyFo9L27uqlzDn+D2f2jezgQlZxuK+mRc3zVEMmsRN79wQVHrK/M5XRu8SIfa7DyDCIPgDN1mk1araA5SgozcSTKtXkF5YkdnxTL3LgCWdlIm1Yz/uYCnoeTt8sTyThtrZo0mDVfcHfCXn3vWdbpnqwVpXuERubw2VD9TsQ=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3083.namprd12.prod.outlook.com (20.178.30.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 03:08:03 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 03:08:03 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Oren Twaig <oren@scalemp.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] svm: Fix AVIC incomplete IPI emulation
Thread-Topic: [PATCH] svm: Fix AVIC incomplete IPI emulation
Thread-Index: AQHU0rY9293WXGT45E2nygfc4G4QEKYGWFMAgAKWJAA=
Date:   Wed, 13 Mar 2019 03:08:03 +0000
Message-ID: <55f8c19a-2838-5987-a50b-f87edb80aa5c@amd.com>
References: <d53d2240-d1f1-da04-9126-9eb3518d0047@scalemp.com>
 <ab2b29ac-adcf-12ab-7c53-cc427995e94c@amd.com>
In-Reply-To: <ab2b29ac-adcf-12ab-7c53-cc427995e94c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
x-originating-ip: [110.169.70.41]
x-clientproxiedby: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e8e715c-70b6-407e-b053-08d6a7611b48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3083;
x-ms-traffictypediagnostic: DM6PR12MB3083:
x-microsoft-antispam-prvs: <DM6PR12MB308366C6E1E2070AF07A136CF34A0@DM6PR12MB3083.namprd12.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(81156014)(478600001)(71190400001)(53936002)(8676002)(97736004)(99286004)(386003)(6506007)(53546011)(58126008)(4326008)(102836004)(6916009)(76176011)(52116002)(71200400001)(54906003)(6512007)(81166006)(486006)(2906002)(6436002)(68736007)(31686004)(14454004)(105586002)(2616005)(8936002)(446003)(476003)(106356001)(11346002)(65826007)(64126003)(305945005)(6246003)(6486002)(36756003)(26005)(6116002)(3846002)(31696002)(186003)(65806001)(66066001)(229853002)(5660300002)(65956001)(25786009)(316002)(14444005)(256004)(86362001)(72206003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3083;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X6BJw5dKQVbpGDCmYnG0CrOD3ZPkTJIHVAAOsHngaMim87fmJu5lzvDbGNgDkY+J25U7x3JjJzknbl0vrazKy9XoinewHzVNGxix1Ss0U1/iBznRUnAvD6lpYhUV+tAcHwPrH/IrgcXCVGkqWfMpXKF2pj32DTq96W+9b/U8z2r0eA459pPCPeb9h8PTt+YAL47r9MPKAACDmdb7lLkyOI40V5p/SSv4SXkU+0hmF9tNnDC/yIbXPqmQ3Hb9bxc/7SgsLz3iX/uQop83Y9K1+zz4zMlfb+KGpjBvqST/a8oZzewqzffjgkTyQ/RxQ4eoj3fvVy2vV8d3JlusW010WGfDvUjqhqJfeaKbOxKjmD2/piTqtcUY7ebm2QCymh5wVf0eSk5k8RKq2BdAZGkz3NYwJJauUR04DujGgOTRlVg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48E7A5F734586A409DA76A6A3B7DC4FD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8e715c-70b6-407e-b053-08d6a7611b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 03:08:03.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T3JlbiwNCg0KT24gMy8xMS8xOSA2OjM4IFBNLCBTdXRoaWt1bHBhbml0LCBTdXJhdmVlIHdyb3Rl
Og0KPiBIb3dldmVyLCBsb29raW5nIGEgYml0IG1vcmUgY2xvc2VseSwgSSBub3RpY2UgdGhlIGxv
Z2ljIGluIHN2bV9kZWxpdmVyX2F2aWNfaW50cigpDQo+IHNob3VsZCBhbHNvIGhhdmUgYmVlbiBj
aGFuZ2VkIGZyb20ga3ZtX3ZjcHVfd2FrZV91cCgpIHRvIGt2bV92Y3B1X2tpY2soKQ0KPiBzaW5j
ZSB0aGUgbGF0dGVyIHdpbGwgcmVzdWx0IGluIGNsZWFyaW5nIHRoZSBJUlIgYml0IGZvciB0aGUg
SVBJIHZlY3Rvcg0KPiB3aGVuIHRyeWluZyB0byBzZW5kIElQSSBhcyBwYXJ0IG9mIHRoZSBmb2xs
b3dpbmcgY2FsbCBwYXRoLg0KPiANCj4gICAgIHZjcHVfZW50ZXJfZ3Vlc3QoKQ0KPiAgICAgICB8
LS0gaW5qZWN0X3BlbmRpbmdfZXZlbnQoKQ0KPiAgICAgICAgIHwtLSBrdm1fY3B1X2dldF9pbnRl
cnJ1cHQoKQ0KPiAgICAgICAgICAgfC0tICBrdm1fZ2V0X2FwaWNfaW50ZXJydXB0KCkNCj4gICAg
ICAgICAgICAgfC0tIGFwaWNfY2xlYXJfaXJyKCkNCj4gICAgICAgICAgICAgfC0tIGFwaWNfc2V0
X2lzcigpDQo+ICAgICAgICAgICAgIHwtLSBhcGljX3VwZGF0ZV9wcHIoKSAuLi4uDQo+IA0KPiBQ
bGVhc2Ugc2VlIHRoZSBwYXRjaCBiZWxvdy4NCj4gDQo+IE5vdCBzdXJlIGlmIHRoaXMgd291bGQg
YWRkcmVzcyB0aGUgcHJvYmxlbSB5b3UgYXJlIHNlZWluZy4NCj4gDQo+IFRoYW5rcywNCj4gU3Vy
YXZlZQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0uYyBiL2FyY2gveDg2L2t2
bS9zdm0uYw0KPiBpbmRleCAyNGRmYTZhOTM3MTEuLmQyODQxYzNkYmMwNCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYva3ZtL3N2bS5jDQo+ICsrKyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KPiBAQCAt
NTIxOSwxMSArNTI1NiwxMyBAQCBzdGF0aWMgdm9pZCBzdm1fZGVsaXZlcl9hdmljX2ludHIoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCBpbnQgdmVjKQ0KPiAgICAgICAgICAga3ZtX2xhcGljX3NldF9p
cnIodmVjLCB2Y3B1LT5hcmNoLmFwaWMpOw0KPiAgICAgICAgICAgc21wX21iX19hZnRlcl9hdG9t
aWMoKTsNCj4gDQo+IC0gICAgICAgaWYgKGF2aWNfdmNwdV9pc19ydW5uaW5nKHZjcHUpKQ0KPiAr
ICAgICAgIGlmIChhdmljX3ZjcHVfaXNfcnVubmluZyh2Y3B1KSkgew0KPiAgICAgICAgICAgICAg
ICAgICB3cm1zcmwoU1ZNX0FWSUNfRE9PUkJFTEwsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICBrdm1fY3B1X2dldF9hcGljaWQodmNwdS0+Y3B1KSk7DQo+IC0gICAgICAgZWxzZQ0KPiAtICAg
ICAgICAgICAgICAga3ZtX3ZjcHVfd2FrZV91cCh2Y3B1KTsNCj4gKyAgICAgICB9IGVsc2Ugew0K
PiArICAgICAgICAgICAgICAga3ZtX21ha2VfcmVxdWVzdChLVk1fUkVRX0VWRU5ULCB2Y3B1KTsN
Cj4gKyAgICAgICAgICAgICAgIGt2bV92Y3B1X2tpY2sodmNwdSk7DQo+ICsgICAgICAgfQ0KPiAg
ICB9DQo+IA0KPiAgICBzdGF0aWMgdm9pZCBzdm1faXJfbGlzdF9kZWwoc3RydWN0IHZjcHVfc3Zt
ICpzdm0sIHN0cnVjdCBhbWRfaW9tbXVfcGlfZGF0YSAqcGkpDQoNClBsZWFzZSBpZ25vcmUgdGhl
IHBhcnQgbWVudGlvbmVkIGFib3ZlLiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBzaG91bGQg
YWxyZWFkeSBiZSBmaW5lLg0KDQpTdXJhdmVlDQo=
