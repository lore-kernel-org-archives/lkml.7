Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9128920880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="QuL32gr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDINFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:05:35 -0400
Received: from mail-eopbgr790078.outbound.protection.outlook.com ([40.107.79.78]:7296
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbfDINFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C41PUBBcnnR9YA3IKjd7xBvEj7wdobq/pnqIXKF20sk=;
 b=QuL32gr5KzRwGqH9X+UyGDJ469QQR1zxpwRMr3Y1oyiPuX0SFm2gK0/aLYTXXHM98hz2y3DkPssJjaX4M3na6QiK0jksof+P7Wrmg+R90ZNsKqDGFQFiK4RuMp3Lek2ACvYynvwMw37nZxNWcbtdSoJ6H0WvABh7/f3MBv1rvek=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6030.namprd05.prod.outlook.com (20.178.241.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.8; Tue, 9 Apr 2019 13:04:52 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 13:04:51 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+AgAD+MwCAADQ1gA==
Date:   Tue, 9 Apr 2019 13:04:51 +0000
Message-ID: <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
         <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
         <20190409095740.GE6827@lst.de>
In-Reply-To: <20190409095740.GE6827@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0730120-209b-40a6-b92c-08d6bcebf433
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6030;
x-ms-traffictypediagnostic: MN2PR05MB6030:
x-microsoft-antispam-prvs: <MN2PR05MB60301B836146E453BF743C32A12D0@MN2PR05MB6030.namprd05.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(39860400002)(396003)(376002)(189003)(199004)(54534003)(66066001)(97736004)(305945005)(256004)(14444005)(68736007)(106356001)(105586002)(2351001)(7736002)(1730700003)(8676002)(36756003)(2501003)(8936002)(81166006)(86362001)(81156014)(6506007)(99286004)(476003)(5640700003)(6486002)(2616005)(316002)(71200400001)(446003)(229853002)(6436002)(76176011)(6916009)(5660300002)(71190400001)(11346002)(2906002)(486006)(118296001)(478600001)(14454004)(102836004)(53936002)(6512007)(186003)(26005)(6246003)(4326008)(3846002)(6116002)(25786009)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6030;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N89MSUIDAdhlBnHARM6Ca3nGYKHxeis2+F8Ap8rrHWeZVOJkTt6OAAH1ve+aMGB4Ov1PKigv5VTNyGjACHKxbw7wSpozRtLatdtLRf8q94Yd20Ixlf28V34gQIA2rqvtIrYXfNRo235nJlNbC+1wcQLU//aCVSVlDwK6qBrRIgYsCzXhcwVicE9yuBc+5+3ZxlHxZZNKoChP2+3xAnq+50Hea8hIP8IzkIklCS8AO9PCOwlYDl0xX4IiPYi9S83ovcqTDXmXC5449k99aKB9Vo7p2gSF5SVqbLkFQuGrH5wRI6Sl+jshV6w9II1fc8syo/e8ZlCm0PkyrPyJERMOLpFZe62jHvInKzVOAx3KyR9nX3uW2RYhFZo2L+PYWrtRFfQXpZ4o66EjZvDACEY9WzAi7fOGF4cW4BQEDeh8n4M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <490CD89E2D46FA4C8C1C0C92F9FEC9BF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0730120-209b-40a6-b92c-08d6bcebf433
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 13:04:51.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA0LTA5IGF0IDExOjU3ICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBNb24sIEFwciAwOCwgMjAxOSBhdCAwNjo0Nzo1MlBNICswMDAwLCBUaG9tYXMgSGVsbHN0cm9t
IHdyb3RlOg0KPiA+IFdlIEhBVkUgZGlzY3Vzc2VkIG91ciBuZWVkcywgYWx0aG91Z2ggYWRtaXR0
ZWRseSBzb21lIG9mIG15IGVtYWlscw0KPiA+IGVuZGVkIHVwIHVuYW5zd2VyZWQuDQo+IA0KPiBB
bmQgdGhhbiB5b3UgaGF2ZW4ndCBmb2xsb3dlZCB1cCwgYW5kIGluc3RlYWQgaWdub3JlZCB0aGUg
bGF5ZXJpbmcNCj4gaW5zdHJ1Y3Rpb25zIGFuZCBqdXN0IGNvbW1pdGVkIGEgYnJva2VuIHBhdGNo
Pw0KDQpZZXMsIEknbSByZWFsbHkgc29ycnkgZm9yIG5vdCBvYnNlcnZpbmcgdGhlIGxheWVyaW5n
IGluc3RydWN0aW9ucy4gVG8NCmJlIGNvbXBsZXRlbHkgaG9uZXN0IEkgZGlkbid0IG9ic2VydmUg
dGhhdCBsYXllcmluZyB3YXJuaW5nLCByYXRoZXINCnRoYW4gaWdub3JpbmcgaXQuIFRoZSBwYXRj
aCBkb2Vzbid0IGNsYWltIHRvIGJlIGdlbmVyaWMgYW5kIEkgYmVsaWV2ZQ0KdGhhdCBvbiB0aGUg
Vk13YXJlIHBsYXRmb3JtIGl0IGlzIGZ1bmN0aW9uYWxseSBjb3JyZWN0LCBwbGVhc2Ugc2VlDQpi
ZWxvdy4gSSBhbHNvIHdvdWxkIGxpa2Ugbm90IHRvIGZvY3VzIG9uIHdobyBkaWQgd2hhdCBhbmQg
d2h5LiBJIGNhbid0DQpzZWUgaG93IHRoYXQgd2lsbCBoZWxwIHRoaXMgZGlzY3Vzc2lvbiBtb3Zp
bmcgZm9yd2FyZC4NCg0KPiANCj4gPiBXZSd2ZSBhcyB5b3UncmUgd2VsbCBhd2FyZSBvZiBoYWQg
YSBkaXNjdXNzaW9uIHdpdGggdGhlIG90aGVyDQo+ID4gc3Vic3lzdGVtcyBkb2luZyB1c2VyLXNw
YWNlIERNQS1idWZmZXJzIHdhbnRpbmcgdGhpcyBmdW5jdGlvbmFsaXR5DQo+ID4gZnJvbQ0KPiA+
IHRoZSBkbWEgYXBpIChBTUQgZ3JhcGhpY3MgYW5kIFJETUEgcGVvcGxlIElJUkMpLiB0aGF0IGlz
IGEgYm9vbA0KPiA+IHRoYXQNCj4gPiB0ZWxscyB1cyB3aGV0aGVyIHN0cmVhbWluZyBkbWEgbWFw
cGluZ3MgYXJlIGNvaGVyZW50LCBhbmQgSQ0KPiA+IGRlc2NyaWJlZA0KPiA+IGluIGRldGFpbCB3
aHkgd2UgY291bGRuJ3QgdXNlIHRoZSBkbWFfc3luY18qIEFQSSBhbmQNCj4gPiBkbWFfYWxsb2Nf
Y29oZXJlbnQoKS4NCj4gDQo+IEFuZCB0aGF0IGlzIG5vdCBhdCBhbGwgd2hhdCB5b3UgZWl0aGVy
IGNoZWNrIG9yIGNsYWltIHRvIGRvIGluIHRoZQ0KPiBjaGFuZ2Vsb2cgKHdoaWNoIGJ0dywgYXJl
IHR3byBkaWZmZXJlbnQgdGhpbmdzKS4NCj4gDQo+ID4gVGhlIG90aGVyIG9wdGlvbiB3ZSBoYXZl
IGlzIHRvIGp1c3QgZmFpbCBtaXNlcmFibHkgd2l0aG91dCBtZXNzYWdlcw0KPiA+IGlmDQo+ID4g
c3RyZWFtaW5nIERNQSBpcyBub3QgY29oZXJlbnQsIHdoaWNoIEkgdGhpbmsgdGhlIG90aGVyIGRy
aXZlcnMNCj4gPiBtaWdodA0KPiA+IGRvLi4uIFRoYXQncyBhbGwgSSdtIHRyeWluZyB0byBhdm9p
ZCBoZXJlLiBJJ2QgbXVjaCBwcmVmZXIgdG8gaGF2ZQ0KPiA+IHRoZQ0KPiA+IGRtYSBBUEkgZXhw
b3J0IHRoaXMgYm9vbC4NCj4gDQo+IEJvdGggRE1BIGRpcmVjdCBhbmQgbm9uLURNQSBkaXJlY3Qg
c3RyZWFtaW5nIG1hcHBpbmdzIGNhbiBiZSBlaXRoZXINCj4gY29oZXJlbnQgb3IgaW5jb2hlcmVu
dCwgc28geW91ciBwYXRjaCBkb2Vzbid0IGFyY2hpdmUgdGhhdC4gIFRoZQ0KPiBjb21taXQgbG9n
IGNsYWltcyB0aGUgZm9sbG93aW5nOg0KPiANCj4gImRybS92bXdnZng6IEltcHJvdmUgb24gSU9N
TVUgZGV0ZWN0aW9uDQo+ICAgICANCj4gIGluc3RlYWQgb2YgcmVseWluZyBvbiBpbnRlbF9pb21t
dV9lbmFibGVkLCB1c2UgdGhlIGZhY3QgdGhhdCB0aGUNCj4gIGRtYV9tYXBfb3BzOjptYXBfcGFn
ZSAhPSBkbWFfZGlyZWN0X21hcF9wYWdlIg0KPiANCj4gd2hpY2ggaGFzIG5vdGhpbmcgdG8gZG8g
d2l0aCB0aGUgZmFjdCB0aGF0IHN0cmVhbWluZyBtYXBwaW5ncyBhcmUNCj4gY29oZXJlbnQuICBJ
dCBhbHNvIGlzIGluY29ycmVjdCBhcyB0aGVyZSBhcmUgZGlyZWN0IG1hcHBpbmcgdGhhdA0KPiBk
byBub3QgdXNlIGRtYV9kaXJlY3RfbWFwX3BhZ2UgKGUuZy4gb24gQVJNLCBvciB4ODYgd2l0aCBW
TUQpLg0KDQpPbiB0aGUgVk13YXJlIHBsYXRmb3JtIHdlIGhhdmUgdHdvIHBvc3NpYmxlIHZJT01N
VVMsIHRoZSBBTUQgaW9tbXUgYW5kDQpJbnRlbCBWVEQsIEdpdmVuIHRob3NlIGNvbmRpdGlvbnMg
SSBiZWxpdmUgdGhlIHBhdGNoIGlzIGZ1bmN0aW9uYWxseQ0KY29ycmVjdC4gV2UgY2FuJ3QgY292
ZXIgdGhlIEFNRCBjYXNlIHdpdGggaW50ZWxfaW9tbXVfZW5hYmxlZC4NCkZ1cnRoZXJtb3JlIHRo
ZSBvbmx5IGZvcm0gb2YgaW5jb2hlcmVuY3kgdGhhdCBjYW4gYWZmZWN0IG91ciBncmFwaGljcw0K
ZGV2aWNlIGlzIHNvbWVvbmUgZm9yY2luZyBTV0lPVExCIGluIHdoaWNoIGNhc2UgdGhhdCBwZXJz
b24gd291bGQgYmUNCmhhcHBpZXIgd2l0aCBzb2Z0d2FyZSByZW5kZXJpbmcuIEluIGFueSBjYXNl
LCBvYnNlcnZpbmcgdGhlIGZhY3QgdGhhdA0KdGhlIGRpcmVjdF9vcHMgYXJlIG5vdCB1c2VkIG1h
a2VzIHN1cmUgdGhhdCBTV0lPVExCIGlzIG5vdCB1c2VkLg0KS25vd2luZyB0aGF0IHdlJ3JlIG9u
IHRoZSBWTXdhcmUgcGxhdGZvcm0sIHdlJ3JlIGNvaGVyZW50IGFuZCBjYW4NCnNhZmVseSBoYXZl
IHRoZSBkbWEgbGF5ZXIgZG8gZG1hIGFkZHJlc3MgdHJhbnNsYXRpb24gZm9yIHVzLiBBbGwgdGhp
cw0KaW5mb3JtYXRpb24gd2FzIG5vdCBleHBsaWNpbHR5IHdyaXR0ZW4gaW4gdGhlIGNoYW5nZWxv
Zywgbm8uDQoNCg0KSW4gYW55IGNhc2UsIGFzc3VtaW5nIHRoYXQgdGhhdCBwYXRjaCBpcyByZXZl
cnRlZCBkdWUgdG8gdGhlIGxheWVyaW5nDQp2aW9sYXRpb24sIEFyZSB5b3Ugd2lsbGluZyB0byBo
ZWxwIG91dCB3aXRoIGEgc21hbGwgQVBJIHRvIGRldGVjdCB0aGUNCnNpdHVhdGlvbiB3aGVyZSBz
dHJlYW1pbmcgRE1BIGlzIGluY29oZXJlbnQ/DQoNCi9UaG9tYXMNCg0KDQo=
