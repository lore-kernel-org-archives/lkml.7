Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82502133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U2TG586t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbfDJQgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:36:33 -0400
Received: from mail-eopbgr680085.outbound.protection.outlook.com ([40.107.68.85]:22336
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732115AbfDJQgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huCHBHp1xJZ/ZXiD4sW+cDJp5nPhqXZHiqAhvYd+AI8=;
 b=U2TG586tYuttxb+kDFppcoTmWoiNKUf2c36RVX1d27vBrauyXEt450KnPmEuh5GOQJgZ+tKqk1cKN2nmdSWWa9ezQZPMowP7MyMHCbiaE3Ucd7AMt9hD5jMbweG8GM2kWqkIICKIlp/OhwLHj3J1h8u0fNX2ojW61l/pB7SpKkI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 16:36:30 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 16:36:30 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Thread-Topic: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Thread-Index: AQHU7hUSVDLUqZVqKEupBAtcrt9jWqYyi0gAgAAIfUCAAbc/AIABTYIg
Date:   Wed, 10 Apr 2019 16:36:30 +0000
Message-ID: <SN6PR12MB2639C9B48E46DA6A8BA9DB3DF82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-3-Yazen.Ghannam@amd.com>
 <20190408175142.GK15689@zn.tnic>
 <SN6PR12MB26397E000684890C92075985F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190409203412.GE6150@zn.tnic>
In-Reply-To: <20190409203412.GE6150@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc33d7f4-196c-44d2-fa1f-08d6bdd2af62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2688;
x-ms-traffictypediagnostic: SN6PR12MB2688:
x-microsoft-antispam-prvs: <SN6PR12MB26886DCBC439C76A926DB9A2F82E0@SN6PR12MB2688.namprd12.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(13464003)(199004)(189003)(256004)(4326008)(478600001)(14444005)(6246003)(66066001)(3846002)(76176011)(93886005)(26005)(5660300002)(53546011)(53936002)(6506007)(2906002)(186003)(6116002)(72206003)(55016002)(54906003)(102836004)(52536014)(6916009)(97736004)(8676002)(105586002)(99286004)(9686003)(6436002)(14454004)(8936002)(74316002)(68736007)(81166006)(81156014)(106356001)(7736002)(229853002)(476003)(11346002)(25786009)(33656002)(446003)(71200400001)(305945005)(486006)(71190400001)(86362001)(316002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oFZy01syNMBAhJN+wAGrQXxSQVlvXEYUkolJYyttb3Hj+aLcCzDYoVN0li4Um67+meSfAXbixUipU3ec+2FMF6KB5Egzm6Szv2QikZxWmytI98gareHGusgwmpu1Bv8/ykfG3cF4g3y+8UZH829RQkIjz+x3jq+zHvP0SnZRwo1VIoLIVg2ofT9v4ya8ui8AImzkLVyDzCIe9QP0/9Dqds0wB62SLsJnPIgiY5ct2iUcwjm1k55fEHGMMVbNXa6V5/ytrIzaujD99s5l2dsrjaGPJmtX1HQiQqD4u5mqXzZx+GidOKOfQLc3xmclvJTNSIJRbDs51zF/f+u3aXDbzQ6K16nZNdSTPjLNeXnfE+Bwprn2busH8fgYRXLgpELhT5uEzul0EJVNGAMGNUmBubbm5CigFLz4DDZI6yISiF4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc33d7f4-196c-44d2-fa1f-08d6bdd2af62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 16:36:30.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgOSwgMjAxOSAzOjM0IFBNDQo+IFRv
OiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzogbGludXgtZWRh
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHRvbnkubHVj
a0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5E
IDIvNV0geDg2L01DRTogSGFuZGxlIE1DQSBjb250cm9scyBpbiBhIHBlcl9jcHUgd2F5DQo+IA0K
PiBPbiBNb24sIEFwciAwOCwgMjAxOSBhdCAwNjo1NTo1OVBNICswMDAwLCBHaGFubmFtLCBZYXpl
biB3cm90ZToNCj4gPiBXZSBhbHJlYWR5IGhhdmUgdGhlIGNhc2Ugd2hlcmUgc29tZSBiYW5rcyBh
cmUgbm90IGluaXRpYWxpemVkIGVpdGhlcg0KPiA+IGR1ZSB0byBxdWlya3Mgb3IgYmVjYXVzZSB0
aGV5IGFyZSBSZWFkLWFzLVplcm8sIGJ1dCB3ZSBkb24ndCB0cnkgdG8NCj4gPiBza2lwIGNyZWF0
aW5nIHRoZWlyIGZpbGVzLiBXaXRoIHRoaXMgZnVsbCBzZXQgKHNlZSBwYXRjaCA1KSwgYW4gdW51
c2VkDQo+ID4gYmFuayB3aWxsIHJldHVybiBhIGNvbnRyb2wgdmFsdWUgb2YgMC4NCj4gDQo+IFNv
IHNldF9iYW5rKCkgaXMgY2hhbmdlZCB0byBkbzoNCj4gDQo+IEBAIC0yMDg4LDcgKzIwOTcsNyBA
QCBzdGF0aWMgc3NpemVfdCBzZXRfYmFuayhzdHJ1Y3QgZGV2aWNlICpzLCBzdHJ1Y3QgZGV2aWNl
X2F0dHJpYnV0ZSAqYXR0ciwNCj4gICAgICAgICBpZiAoa3N0cnRvdTY0KGJ1ZiwgMCwgJm5ldykg
PCAwKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAtICAgICAgIGlm
IChiYW5rID49IG1jYV9jZmcuYmFua3MpDQo+ICsgICAgICAgaWYgKGJhbmsgPj0gcGVyX2NwdShu
dW1fYmFua3MsIHMtPmlkKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAN
Cj4gDQo+IEhvdyB3b3VsZCB0aGF0IHdvcmsgaWYgdGhlIGRpc2FibGVkL25vdC1wcmVzZW50IGJh
bmsgaXMgaW4gdGhlIG1pZGRsZT8NCj4gVGhlIG9sZCBleGFtcGxlOiBiYW5rMyBvbiBDUFU1Lg0K
PiANCj4gPiBXb3VsZCB0aGF0IGJlIHN1ZmZpY2llbnQgdG8gaW5kaWNhdGUgdGhhdCBhIGJhbmsg
aXMgbm90IHVzZWQ/DQo+IA0KPiBXZWxsLCBpdCBzaG91bGQgbm90IGFsbG93IGZvciBhbnkgY29u
dHJvbCBiaXRzIHRvIGJlIHNldCBhbmQgaXQgc2hvdWxkDQo+IGhhdmUgdGhlIHByb3BlciBiYW5r
IG51bWJlci4NCj4gDQoNCldlIGhhdmUgdGhpcyBjYXNlIG9uIEFNRCBGYW1pbHkgMTdoIHdpdGgg
QmFuayA0LiBUaGUgaGFyZHdhcmUgZW5mb3JjZXMgdGhpcyBiYW5rIHRvIGJlIFJlYWQtYXMtWmVy
by9Xcml0ZXMtSWdub3JlZC4NCg0KVGhpcyBiZWhhdmlvciBpcyBlbmZvcmNlZCB3aGV0aGVyIHRo
ZSBiYW5rIGlzIGluIHRoZSBtaWRkbGUgb3IgYXQgdGhlIGVuZC4NCg0KPiA+IEJ1dCBJIGRvIGhh
dmUgYSBjb3VwbGUgb2YgdGhvdWdodHM6DQo+IA0KPiA+IDEpIFdpbGwgbWlzc2luZyBiYW5rcyBj
b25mdXNlIHVzZXJzPyBBcyBtZW50aW9uZWQsIHdlIGFscmVhZHkgaGF2ZSB0aGUNCj4gPiBjYXNl
IG9mIHVudXNlZC91bmluaXRpYWxpemVkIGJhbmtzIHRvZGF5LCBidXQgd2UgZG9uJ3Qgc2tpcCB0
aGVpciBmaWxlDQo+ID4gY3JlYXRpb24uIGEpIFdpbGwgdGhpcyBhZmZlY3QgYW55IHVzZXJzcGFj
ZSB0b29scz8NCj4gDQo+IEkgZ3Vlc3MgaXQgd291bGQgYmUgZWFzaWVyIGlmIHdlIGtlZXAgY3Jl
YXRpbmcgYWxsIGZpbGVzIGJ1dCBkZW5vdGUgcHJvcGVybHkNCj4gd2hpY2ggYmFua3MgYXJlIGRp
c2FibGVkLg0KPiANCg0KSSdtIHRoaW5raW5nIHRvIHJlZG8gdGhlIHN5c2ZzIGludGVyZmFjZSBm
b3IgYmFua3MgaW4gYW5vdGhlciBwYXRjaCBzZXQuIEkgY291bGQgaW5jbHVkZSBhIG5ldyBmaWxl
IHRvIGluZGljYXRlIGVuYWJsZWQvZGlzYWJsZWQsIG9yIG1heWJlIGp1c3QgdXBkYXRlIHRoZSBk
b2N1bWVudGF0aW9uIHRvIGRlc2NyaWJlIHRoaXMgY2FzZS4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
