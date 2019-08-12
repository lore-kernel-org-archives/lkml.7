Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE43C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C360206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="Ajiuw7HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfHLTMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:12:37 -0400
Received: from mail-eopbgr20132.outbound.protection.outlook.com ([40.107.2.132]:39490
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbfHLTMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRf0lQteb2kyb36dysOLXYc3NfjDUhGbEDl+z7zbMUoXnyLdlgbGKCZCNWaxGMI6alt5IgR2RPRmIAXwtBNkq3TgrfDmL1GThu1AWRE6w9Nve1SuDIqfsnVaOStvHrnMqD806usiOsPJo99wJ+RVD99IvnPEeu2UmDeXyhHXTFDvsXopqkyPVaidgLWFIgWFnJAciAWUq4np4uiVjU3MvQcPHhPDNs0ZdYJ+kUgvRJM2axhYWiTf2cYkh+aYfrQu/DQzGWoCp8OPC9vmXLiz0sUtatqmtwcbaxdD9jt/257mFTOYnj4W84u4vRZFrZ0qI1YSqCI8cvbdEw1gf+yc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syvyBpZHpxcK96/tEcEPAKMI0C3tURz9UyVv0x/o2p4=;
 b=aYfGcOJuFK0oKAfG9u3AlKO1I/tlJzt67m62IjWsKdfhPaNF6O4AE79/LOnyjyem32h+g7pyg7SRw4YIC9UymNV+LVGNfmkKqAbK+2hc77TeeWN0M5u5NFLXNIlWr0veCIaU43FvDYpJbLKMhGstj0E7b+JepIKcLeVfm1+sATPXe3YqDcDrOQPOpT8C1tffTd+teo9TqcEHWDWJZBbnydDbKLGa8TIaa4CgSjJkYTAqhVmn+Q1Xc6X5WZuiqFVQnocQMkvM/3VP56ajKLGygw+A1QzuFdN+GRfCsBYRW5cXktWTrdT6ImdxssAD6k3F6k/I8Rye+QzCIfLSQjaVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syvyBpZHpxcK96/tEcEPAKMI0C3tURz9UyVv0x/o2p4=;
 b=Ajiuw7HOQXWegR61ou/xQPaXztgmeucLXnJwwGw6o1YaUKROBBFEtwkPNUlaq3Mlx/LOPIwEyE0heb+brJ/4BgcR1Ib5dybDvjS/gPfE3qdQagEaRFmy3ykrX7dCCHnvVKi1D3Bri/iR4bOVzeekdroH2UWcUxYSzvKZtnSLwmo=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3949.eurprd04.prod.outlook.com (52.134.17.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 19:12:32 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 19:12:32 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
Thread-Topic: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Thread-Index: AQHVTidIVfq9W1HbR0i2bNtry39Joab0Aj2AgAN9ywCAADnOgIAAFmOAgAAEuYCAABJ6gA==
Date:   Mon, 12 Aug 2019 19:12:32 +0000
Message-ID: <51259945-bae1-3aa3-a59b-53de25eb60f1@silicom-usa.com>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
 <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com>
 <20190812180613.GA18377@infradead.org>
In-Reply-To: <20190812180613.GA18377@infradead.org>
Reply-To: Stephen Douthit <stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:404:f7::17) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9db11d59-5912-44bc-eca4-08d71f5906bc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB3949;
x-ms-traffictypediagnostic: VI1PR0402MB3949:
x-microsoft-antispam-prvs: <VI1PR0402MB3949833219005E2546B79BE294D30@VI1PR0402MB3949.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(346002)(39850400004)(55674003)(199004)(189003)(31686004)(316002)(26005)(5660300002)(3846002)(66066001)(6116002)(305945005)(2906002)(186003)(7736002)(71190400001)(71200400001)(8676002)(54906003)(3450700001)(43066004)(66946007)(81156014)(478600001)(6506007)(14454004)(36756003)(386003)(2616005)(52116002)(4326008)(6246003)(53546011)(446003)(6916009)(25786009)(14444005)(11346002)(31696002)(256004)(81166006)(6486002)(76176011)(64756008)(8936002)(66556008)(66476007)(6436002)(86362001)(102836004)(6512007)(66446008)(99286004)(476003)(229853002)(53936002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3949;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NGFY6YuQ9bfBW9i8ST+QqawvEdptWDJ727NXXghsYbEXdN82Rgdc7p9JCeUlhSpJwM+nNtivv/H/relssytFfY1ZzUCtr8TqdJVPoSPW+j03OzaMy+y1UVWh4vpDFAcwM9Gbty5u8OkJqcGTEHFcJwrCMP3RIf4tRTVXnEvx9wmDZNKYXLNkx/hHXUdpQKTmzi73tKEi94hBXhetLaFoBgQKeFBeGe1NmfkmOKGqb6A9QCZ3CM6KBiZwV6BgbwoVgJKEDXV24c1IisBlTtevZXy3n8YSyGA47gTKM9dIdb5zPDB8AJXZwM5yiZu3rbIvOYZ18RRVx/GbVnyIGka2qGp15b/tk0bBibX9xxfcnWBYfTiR86GVZSXDEq7lS55FlUoFI5d2e1Lzg6GCYN3a0EN8QJu95WCy+i0rR+wFnGc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF8B450BA49814DBC275396A356C4A3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db11d59-5912-44bc-eca4-08d71f5906bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 19:12:32.4398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbHthWRITPyJtQL7kIF+GPbCIODog2nhpJWbzh+yqUOKLXWzOIYJAdXm2SGYRWL/Bml4KXAXGqhaRNtxfmYHiJtOEdt2TKgfGcN+hqBc3gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMi8xOSAyOjA2IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9uLCBB
dWcgMTIsIDIwMTkgYXQgMDU6NDk6MjlQTSArMDAwMCwgU3RlcGhlbiBEb3V0aGl0IHdyb3RlOg0K
Pj4gRG9lcyBhbnlvbmUga25vdyB0aGUgYmFja2dyb3VuZCBvZiB0aGUgb3JpZ2luYWwgUENTIHdv
cmthcm91bmQ/DQo+IA0KPiBCYXNlZCBvbiBhIGZldyBnaXQtYmxhbWUgaXRlcmF0aW9ucyBvbiBo
aXN0b3J5LmdpdCB0aGUgb3JpZ2luYWwgUENTDQo+IGhhbmRsaW5nIChqdXN0IHdoZW4gaW5pdGlh
bGl6aW5nKSBnb2VzIGJhY2sgdG8gdGhpcyBCSyBjb21taXQ6DQo+IA0KPiAtLQ0KPiAgRnJvbSBj
MDgzNWI4MzhlNzZjOTUwMGZhY2FkMDVkYzMwNTE3MGExYTU3N2E4IE1vbiBTZXAgMTcgMDA6MDA6
MDAgMjAwMQ0KPiBGcm9tOiBKZWZmIEdhcnppayA8amdhcnppa0Bwb2JveC5jb20+DQo+IERhdGU6
IFRodSwgMTQgT2N0IDIwMDQgMTY6MTE6NDQgLTA0MDANCg0KVGhhbmtzIGZvciBkaWdnaW5nLCB0
aGlzIGlzIGRlZmluaXRlbHkgZnVydGhlciBiYWNrIHRoYW4gSSBsb29rZWQuDQoNCj4gU3ViamVj
dDogW2xpYmF0YSBhaGNpXSBmaXggc2V2ZXJhbCBidWdzDQo+IA0KPiAqIFBDSSBJRHMgZnJvbSB0
ZXN0IHZlcnNpb24gZGlkbid0IG1ha2UgaXQgaW50byBtYWlubGluZS4uLiBkb2gNCj4gKiBkbyBh
bGwgY29tbWFuZCBzZXR1cCBpbiAtPnFjX3ByZXANCj4gKiBwaHlfcmVzZXQgcm91dGluZSB0aGF0
IGRvZXMgc2lnbmF0dXJlIGNoZWNrDQo+ICogY2hlY2sgU0FUQSBwaHkgZm9yIGVycm9ycw0KPiAq
IHJlc2V0IGhhcmR3YXJlIGZyb20gc2NyYXRjaCwgaW4gY2FzZSBjYXJkIEJJT1MgZGlkbid0IHJ1
bg0KPiAqIGltcGxlbWVudCBzdGFnZ2VyZWQgc3BpbnVwIGJ5IGRlZmF1bHQNCj4gKiBhZGRpbmcg
YWRkaXRpb25hbCBkZWJ1Z2dpbmcgb3V0cHV0DQoNCltzbmlwXQ0KDQo+IEBAIC0yMzYsNyArMjM4
LDkgQEAgc3RhdGljIHN0cnVjdCBhdGFfcG9ydF9pbmZvIGFoY2lfcG9ydF9pbmZvW10gPSB7DQo+
ICAgfTsNCj4gICANCj4gICBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgYWhjaV9wY2lfdGJs
W10gPSB7DQo+IC0JeyBQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDAwMDAsIFBDSV9BTllfSUQsIFBD
SV9BTllfSUQsIDAsIDAsDQo+ICsJeyBQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDI2NTIsIFBDSV9B
TllfSUQsIFBDSV9BTllfSUQsIDAsIDAsDQo+ICsJICBib2FyZF9haGNpIH0sDQo+ICsJeyBQQ0lf
VkVORE9SX0lEX0lOVEVMLCAweDI2NTMsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsDQoN
ClRoZXNlIGxvb2sgdG8gYmUgZm9yIHRoZSBJQ0g2LCBhbmQgYXQgdGhlc2UgZWFybHkgZGF5cyBJ
bnRlbCBsb29rcyB0byBiZQ0KdGhlIG9ubHkgdmVuZG9yIGluIHRoZSBsaXN0LiAgVGhhdCB3b3Vs
ZCBleHBsYWluIHRoZSBsYWNrIG9mIGEgdmVuZG9yDQpndWFyZCBvbiB0aGUgUENTIHBva2UgYmVs
b3cuDQoNCj4gICAJICBib2FyZF9haGNpIH0sDQo+ICAgCXsgfQkvKiB0ZXJtaW5hdGUgbGlzdCAq
Lw0KPiAgIH07DQoNCltzbmlwXQ0KDQo+ICAgc3RhdGljIGludCBhaGNpX2hvc3RfaW5pdChzdHJ1
Y3QgYXRhX3Byb2JlX2VudCAqcHJvYmVfZW50KQ0KPiAgIHsNCj4gICAJc3RydWN0IGFoY2lfaG9z
dF9wcml2ICpocHJpdiA9IHByb2JlX2VudC0+cHJpdmF0ZV9kYXRhOw0KPiAgIAlzdHJ1Y3QgcGNp
X2RldiAqcGRldiA9IHByb2JlX2VudC0+cGRldjsNCj4gLQl2b2lkICptbWlvID0gcHJvYmVfZW50
LT5tbWlvX2Jhc2U7DQo+IC0JdTMyIHRtcDsNCj4gLQl1bnNpZ25lZCBpbnQgaSwgdXNpbmdfZGFj
Ow0KPiArCXZvaWQgX19pb21lbSAqbW1pbyA9IHByb2JlX2VudC0+bW1pb19iYXNlOw0KPiArCXUz
MiB0bXAsIGNhcF9zYXZlOw0KPiArCXUxNiB0bXAxNjsNCj4gKwl1bnNpZ25lZCBpbnQgaSwgaiwg
dXNpbmdfZGFjOw0KPiAgIAlpbnQgcmM7DQo+ICsJdm9pZCBfX2lvbWVtICpwb3J0X21taW87DQo+
ICsNCj4gKwljYXBfc2F2ZSA9IHJlYWRsKG1taW8gKyBIT1NUX0NBUCk7DQo+ICsJY2FwX3NhdmUg
Jj0gKCAoMTw8MjgpIHwgKDE8PDE3KSApOw0KPiArCWNhcF9zYXZlIHw9ICgxIDw8IDI3KTsNCj4g
ICANCj4gICAJLyogZ2xvYmFsIGNvbnRyb2xsZXIgcmVzZXQgKi8NCj4gICAJdG1wID0gcmVhZGwo
bW1pbyArIEhPU1RfQ1RMKTsNCj4gQEAgLTY5OCwyMyArNzQ3LDIyIEBAIHN0YXRpYyBpbnQgYWhj
aV9ob3N0X2luaXQoc3RydWN0IGF0YV9wcm9iZV9lbnQgKnByb2JlX2VudCkNCj4gICAJCXJldHVy
biAtRUlPOw0KPiAgIAl9DQo+ICAgDQo+IC0JLyogbWFrZSBzdXJlIHdlJ3JlIGluIEFIQ0kgbW9k
ZSwgd2l0aCBpcnEgZGlzYWJsZWQgKi8NCj4gLQlpZiAoKHRtcCAmIChIT1NUX0FIQ0lfRU4gfCBI
T1NUX0lSUV9FTikpICE9IEhPU1RfQUhDSV9FTikgew0KPiAtCQl0bXAgfD0gSE9TVF9BSENJX0VO
Ow0KPiAtCQl0bXAgJj0gfkhPU1RfSVJRX0VOOw0KPiAtCQl3cml0ZWwodG1wLCBtbWlvICsgSE9T
VF9DVEwpOw0KPiAtCQlyZWFkbChtbWlvICsgSE9TVF9DVEwpOyAvKiBmbHVzaCAqLw0KPiAtCX0N
Cj4gLQl0bXAgPSByZWFkbChtbWlvICsgSE9TVF9DVEwpOw0KPiAtCWlmICgodG1wICYgKEhPU1Rf
QUhDSV9FTiB8IEhPU1RfSVJRX0VOKSkgIT0gSE9TVF9BSENJX0VOKSB7DQo+IC0JCXByaW50ayhL
RVJOX0VSUiBEUlZfTkFNRSAiKCVzKTogQUhDSSBlbmFibGUgZmFpbGVkICgweCV4KVxuIiwNCj4g
LQkJCXBjaV9uYW1lKHBkZXYpLCB0bXApOw0KPiAtCQlyZXR1cm4gLUVJTzsNCj4gLQl9DQo+ICsJ
d3JpdGVsKEhPU1RfQUhDSV9FTiwgbW1pbyArIEhPU1RfQ1RMKTsNCj4gKwkodm9pZCkgcmVhZGwo
bW1pbyArIEhPU1RfQ1RMKTsJLyogZmx1c2ggKi8NCj4gKwl3cml0ZWwoY2FwX3NhdmUsIG1taW8g
KyBIT1NUX0NBUCk7DQo+ICsJd3JpdGVsKDB4ZiwgbW1pbyArIEhPU1RfUE9SVFNfSU1QTCk7DQo+
ICsJKHZvaWQpIHJlYWRsKG1taW8gKyBIT1NUX1BPUlRTX0lNUEwpOwkvKiBmbHVzaCAqLw0KPiAr
DQo+ICsJcGNpX3JlYWRfY29uZmlnX3dvcmQocGRldiwgMHg5MiwgJnRtcDE2KTsNCj4gKwl0bXAx
NiB8PSAweGY7DQo+ICsJcGNpX3dyaXRlX2NvbmZpZ193b3JkKHBkZXYsIDB4OTIsIHRtcDE2KTsN
Cg0KTm90IG11Y2ggdG8gZXhwbGFpbiB3aHkgdGhpcyBpcyBoZXJlIHVuZm9ydHVuYXRlbHkuLi4N
Cg0KTWF5YmUgdGhpcyBpc24ndCBzbyBtdWNoIGEgd29ya2Fyb3VuZCBhcyBhbiBpbXBsZW1lbnRh
dGlvbiBzcGVjaWZpYw0KcXVpcmsuICBJZiB3ZSBjYW4ndCByZWx5IG9uIDEwMCUgb2YgQklPUyBp
bXBsZW1lbnRhdGlvbnMgdG8gaGF2ZSBzZXQgUENTDQp0byBtYXRjaCBQb3J0cyBJbXBsZW1lbnRl
ZCAocHJvYmFibHkgYSBzYWZlIGJldCkgdGhlbiB3ZSBzdGlsbCBuZWVkIHRoZQ0KUENTIHBva2Ug
Y29kZS4NCg0KSW4gdGhhdCBjYXNlIHdlJ3JlIGJhY2sgdG8gQ2hyaXN0b3BoJ3MgcXVlc3Rpb24g
b2YgaWYgdGhlcmUncyBhIGJldHRlcg0Kd2F5IG9mIGZpZ3VyaW5nIG91dCB3aGVyZSBQQ1MgbGl2
ZXMgdGhhbiBjaGVja2luZyBkZXZpY2UgSURzLg0KDQpJbiB0aGUgbWVhbnRpbWUgb24gRGVudmVy
dG9uIDB4OTIgY29udGFpbnMgdGhlIFBvcnQgRGlzYWJsZSBiaXRzIG9mIHRoZQ0KTUFQIHJlZ2lz
dGVyLiAgU2luY2UgdGhlc2UgYXJlIHdyaXRlLW9uY2UgQklPUyBzaG91bGQgaGF2ZSBsb2NrZWQg
dGhlbQ0KYWxyZWFkeSBzbyB3ZSBwcm9iYWJseSB3b24ndCBicmVhayBhbnl0aGluZyBwb2tpbmcg
dGhlbSB1bnRpbCBhIHNvbHV0aW9uDQppcyBpZGVudGlmaWVkLiAgSSBkb24ndCB0aGluayB3ZSB3
YW50IHRvIHJlbHkgb24gdGhhdCBhc3N1bXB0aW9uIGluIHRoZQ0KbG9uZyB0ZXJtIHRob3VnaC4N
Cg==
