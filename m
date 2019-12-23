Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B5C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8EF20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gc6Yphh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfLWGkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:40:06 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:36739
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfLWGkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:40:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sts5XmVgG7sEjC864k40xL19czKHT+NXje6Ey8LxvCIRPCVFdTqq2mn/i38hVwPqI1Sqap0OFW/36udgF1MS2uGAlO/D0TfUTzl4ms/VNq/AZPA8/6dxnZbNK2Y9mqVskHj/0jkiq1e2vWndMK3b/HebsDpY3kCZOQMZLSD5pH7cRVwaCE9QJx1Vg4U52z5ytLOzIbY6kKeGE3AhjZQ1ZIULm/PlESJWBzSSVASDxg7aZjw5GrIu5QJoH5ziMNPZPhZz7grq0ncmX9aMqRQ0250eqMdSgy7M1/7hQwP/g7zfRNPkf8JmmsYptaO4pr785HtEb0OeP4cvERhpz/srpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MCiQAgF5BHylK0iYUE0ZUrf8xZOaDLDhK97ARAe6Lo=;
 b=Md0ioO1ommQgUfUgflrwxofvcg4BtkfbEJc6ajNQtzTtXDBkcG6mC+ffJYvygjCyVPy+qcEXNa07POKGZkOYCy3EnDxSdBbuRZ8GEdu9Ax9vS+DE7CNmzlxYUHW42/eoK/IwUaxhAgvinUtKnxD/XTP+VKsH+KGanNoS4C8rNXT7Kj/+h542XWMuDxcNxS0TpN9oE65rovFU8TbX8pEKgAM22gyJ6BRfkqPN+ZIjVMfzCZjO0oNsLopVxfY/KCQ5keV0yoz3rov1s9bjDcdelToaHjtFl1KNVslXBUFw8gPaRNRxXKeYzJ7PQATMxvry3CyuR4KP2RIaUQY5jjJ4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MCiQAgF5BHylK0iYUE0ZUrf8xZOaDLDhK97ARAe6Lo=;
 b=gc6Yphh0X23ed+CpwzlIQMePZC+EjCe+l/gsLqMpyVIhmG1DZtRtv3owRw1zjbJJUo30pNtgLA5KkzQ0aG6YRMuOSan3iLs90sOG5/pFYGHKo/8nA438FwQIOzzqVTqtfeWbi25y5j5rK6dO6nYUjIl0FvbpKO3/dXRPjaEl2cc=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4623.eurprd04.prod.outlook.com (20.177.56.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 06:40:01 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 06:40:01 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
Thread-Topic: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
Thread-Index: AQHVttiri4OdXKSsD0CMcioiiuKO06fCZVIAgAAJlQCABNr+AA==
Date:   Mon, 23 Dec 2019 06:40:01 +0000
Message-ID: <20191223063958.GD19921@b29397-desktop>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-11-digetx@gmail.com>
 <20191220035650.GC19921@b29397-desktop>
 <fb7dee6e-e645-fe45-126c-c5f1e280bc26@gmail.com>
In-Reply-To: <fb7dee6e-e645-fe45-126c-c5f1e280bc26@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23843110-eb49-4861-fd82-08d78772efae
x-ms-traffictypediagnostic: VI1PR04MB4623:
x-microsoft-antispam-prvs: <VI1PR04MB4623E528AAC167186750E3018B2E0@VI1PR04MB4623.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(33716001)(4326008)(6506007)(53546011)(6512007)(6486002)(7416002)(6916009)(2906002)(71200400001)(1076003)(9686003)(86362001)(54906003)(44832011)(64756008)(66556008)(66446008)(91956017)(8676002)(8936002)(66946007)(26005)(66476007)(76116006)(81156014)(478600001)(5660300002)(316002)(81166006)(33656002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4623;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0p6AFA+Nio38wtiZbG02lPR0dOfteqUEaPWvFljglG+vLarQwbWWIocGsxWSQoAakDsfp7t6iBLAIvQiQ0dRapRqDHUAlWrNJAP7HP5TbxaHSafWXtafDxANJgqvkpBHZSvVqs+EL4xQ25HukfP2VnzV5tq+GUbvwh+D61wXiZUL9/X4NFTFGAj8DlAoOuWEk2noXLLC6Zf+X6epksFNlIygTgGsiECpxB1du2BcI21H6cbhPx4p3wcdgx20bpCt85uGMTEcFBSk9QU5DXll8VtRx2lywFGUnn+fJU6A/oqmaGcw5udVNWI8CAmzcIbBA6iypeMpHqW+OUbFPldbmLPbYwA5HdO3YuGYEHiQgKq8BdCgeUOSb23LQ93a9qqRMYiAlUuoQoUEV027UeVEcgV708ln7KNEdXlEGtbnLnOPcFK+ZKyhAaQclQRmBSiL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <16EB02898F21B643BAAA0928D96C596E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23843110-eb49-4861-fd82-08d78772efae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 06:40:01.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAB6qLp7Uy1GKSK1AsgGpo3LRadWBQP5Su2PTUBJZWkGL0EvfIfuWbvOOd4QMsw+EKc6WtqzHvCSHTm9ZZhsiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTktMTItMjAgMDc6MzE6MDgsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToNCj4gMjAuMTIuMjAx
OSAwNjo1NiwgUGV0ZXIgQ2hlbiDQv9C40YjQtdGCOg0KPiA+IE9uIDE5LTEyLTIwIDA0OjUyOjM4
LCBEbWl0cnkgT3NpcGVua28gd3JvdGU6DQo+ID4+IE5vdywgd2hlbiBjaV9oZHJjX3RlZ3JhIGtl
cm5lbCBtb2R1bGUgaXMgbG9hZGVkLCB0aGUgcGh5X3RlZ3JhX3VzYiBtb2R1bGUNCj4gPj4gaXMg
bG9hZGVkIHRvbyByZWdhcmRsZXNzIG9mIGtlcm5lbCdzIGNvbmZpZ3VyYXRpb24uIFByZXZpb3Vz
bHkgdGhpcw0KPiA+PiBwcm9ibGVtIHdhcyBtYXNrZWQgYmVjYXVzZSBUZWdyYSdzIEVIQ0kgZHJp
dmVyIGlzIHVzdWFsbHkgZW5hYmxlZCBpbg0KPiA+PiBrZXJuZWwncyBjb25maWcgYW5kIHRodXMg
UEhZIGRyaXZlciB3YXMgZ2V0dGluZyBsb2FkZWQgYmVjYXVzZSBvZiBpdCwgYnV0DQo+ID4+IG5v
dyBJIHdhcyBtYWtpbmcgc29tZSBtb3JlIHRob3JvdWdoIHRlc3RpbmcgYW5kIG5vdGljZWQgdGhh
dCBQSFkncyBtb2R1bGUNCj4gPj4gaXNuJ3QgZ2V0dGluZyBhdXRvLWxvYWRlZCB3aXRob3V0IHRo
ZSBob3N0IGRyaXZlci4NCj4gPj4NCj4gPj4gTm90ZSB0aGF0IENoaXBJZGVhJ3MgZHJpdmVyIGRv
ZXNuJ3QgdXNlIGFueSBvZiB0aGUgZXhwb3J0ZWQgZnVuY3Rpb25zIG9mDQo+ID4+IHBoeV90ZWdy
YV91c2IgbW9kdWxlIGFuZCB0aHVzIHRoZSBtb2R1bGUgbmVlZHMgdG8gYmUgcmVxdWVzdGVkIGV4
cGxpY2l0bHkuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGln
ZXR4QGdtYWlsLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3VzYi9jaGlwaWRlYS9LY29u
ZmlnICAgICAgICAgfCAxICsNCj4gPj4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfdGVn
cmEuYyB8IDYgKysrKysrDQo+ID4+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0K
PiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2hpcGlkZWEvS2NvbmZpZyBiL2Ry
aXZlcnMvdXNiL2NoaXBpZGVhL0tjb25maWcNCj4gPj4gaW5kZXggYWU4NTBiM2ZkZGYyLi5kNTNk
YjUyMGUyMDkgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25maWcN
Cj4gPj4gKysrIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvS2NvbmZpZw0KPiA+PiBAQCAtNyw2ICs3
LDcgQEAgY29uZmlnIFVTQl9DSElQSURFQQ0KPiA+PiAgCXNlbGVjdCBSRVNFVF9DT05UUk9MTEVS
DQo+ID4+ICAJc2VsZWN0IFVTQl9VTFBJX0JVUw0KPiA+PiAgCXNlbGVjdCBVU0JfUk9MRV9TV0lU
Q0gNCj4gPj4gKwlzZWxlY3QgVVNCX1RFR1JBX1BIWSBpZiBBUkNIX1RFR1JBDQo+ID4+ICAJaGVs
cA0KPiA+PiAgCSAgU2F5IFkgaGVyZSBpZiB5b3VyIHN5c3RlbSBoYXMgYSBkdWFsIHJvbGUgaGln
aCBzcGVlZCBVU0INCj4gPj4gIAkgIGNvbnRyb2xsZXIgYmFzZWQgb24gQ2hpcElkZWEgc2lsaWNv
biBJUC4gSXQgc3VwcG9ydHM6DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jaGlwaWRl
YS9jaV9oZHJjX3RlZ3JhLmMgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9jaV9oZHJjX3RlZ3JhLmMN
Cj4gPj4gaW5kZXggNzQ1NWRmMGVkZTQ5Li44YmMxMTEwMDI0NWQgMTAwNjQ0DQo+ID4+IC0tLSBh
L2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfdGVncmEuYw0KPiA+PiArKysgYi9kcml2ZXJz
L3VzYi9jaGlwaWRlYS9jaV9oZHJjX3RlZ3JhLmMNCj4gPj4gQEAgLTUzLDYgKzUzLDEyIEBAIHN0
YXRpYyBpbnQgdGVncmFfdWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4+ICAJc3RydWN0IHRlZ3JhX3VkYyAqdWRjOw0KPiA+PiAgCWludCBlcnI7DQo+ID4+ICANCj4g
Pj4gKwlpZiAoSVNfTU9EVUxFKENPTkZJR19VU0JfVEVHUkFfUEhZKSkgew0KPiA+PiArCQllcnIg
PSByZXF1ZXN0X21vZHVsZSgicGh5X3RlZ3JhX3VzYiIpOw0KPiA+PiArCQlpZiAoZXJyKQ0KPiA+
PiArCQkJcmV0dXJuIGVycjsNCj4gPj4gKwl9DQo+ID4+ICsNCj4gPiANCj4gPiBXaHkgeW91IGRv
IHRoaXMgZGVwZW5kZW5jeSwgaWYgdGhpcyBjb250cm9sbGVyIGRyaXZlciBjYW4ndA0KPiA+IGdl
dCBVU0IgUEhZLCBpdCBzaG91bGQgcmV0dXJuIGVycm9yLiBXaGF0J3MgdGhlIHJldHVybiB2YWx1
ZQ0KPiA+IGFmdGVyIGNhbGxpbmcgYmVsb3c6DQo+ID4gDQo+ID4gCXVkYy0+cGh5ID0gZGV2bV91
c2JfZ2V0X3BoeV9ieV9waGFuZGxlKCZwZGV2LT5kZXYsICJudmlkaWEscGh5IiwgMCk7DQo+IA0K
PiBJdCByZXR1cm5zIC1FUFJPQkVfREVGRVIgd2hlbiBwaHlfdGVncmFfdXNiIGlzbid0IGxvYWRl
ZC4NCj4gDQo+IFNvIGlmIHlvdSdsbCBkbzoNCj4gDQo+ICMgcm1tb2QgY2lfaGRyY190ZWdyYTsg
cm1tb2QgY2lfaGRyYzsgcm1tb2QgcGh5X3RlZ3JhX3VzYjsNCj4gIyBtb2Rwcm9iZSBjaV9oZHJj
X3RlZ3JhDQo+ICMgbHNtb2QNCj4gTW9kdWxlICAgICAgICAgICAgICAgICAgU2l6ZSAgVXNlZCBi
eQ0KPiBjaV9oZHJjX3RlZ3JhICAgICAgICAgIDE2Mzg0ICAwDQo+IGNpX2hkcmMgICAgICAgICAg
ICAgICAgNDUwNTYgIDEgY2lfaGRyY190ZWdyYQ0KPiANCj4gQWZ0ZXIgdGhpcyBwYXRjaDoNCj4g
DQo+ICMgcm1tb2QgY2lfaGRyY190ZWdyYTsgcm1tb2QgY2lfaGRyYzsgcm1tb2QgcGh5X3RlZ3Jh
X3VzYjsNCj4gIyBtb2Rwcm9iZSBjaV9oZHJjX3RlZ3JhDQo+ICMgbHNtb2QNCj4gTW9kdWxlICAg
ICAgICAgICAgICAgICAgU2l6ZSAgVXNlZCBieQ0KPiBNb2R1bGUgICAgICAgICAgICAgICAgICBT
aXplICBVc2VkIGJ5DQo+IHBoeV90ZWdyYV91c2IgICAgICAgICAgMjA0ODAgIDENCj4gY2lfaGRy
Y190ZWdyYSAgICAgICAgICAxNjM4NCAgMA0KPiBjaV9oZHJjICAgICAgICAgICAgICAgIDQ1MDU2
ICAxIGNpX2hkcmNfdGVncmENCg0KSSB3b25kZXIgd2h5IHRoZSBkcml2ZXIgbmVlZHMgc3VjaCBk
ZXBlbmRlbmN5PyBJZiB0aGVyZSBhcmUgdHdvIHBoeQ0KZHJpdmVycyBjb3VsZCB3b3JrIHdpdGgg
dGhpcyBjb250cm9sbGVyIGRyaXZlciwgeW91IG1heSByZXF1ZXN0IHR3bw0KbW9kdWxlcy4gRG9l
c24ndCBzdWNoIGRlcGVuZGVuY3kgc2hvdWxkIGJlIGRvbmUgYnkgdGhlIGJvYXJkDQpsZXZlbCBz
Y3JpcHQ/IERvIHlvdSBrbm93IGFyZSB0aGVyZSBhbnkgb3RoZXIgZHJpdmVycyBkbyBzdWNoIHRo
aW5ncz8NCg0KLS0gDQoNClRoYW5rcywNClBldGVyIENoZW4=
