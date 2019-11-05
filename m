Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710DFC1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1469221928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YvoTvpUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbfKENtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:49:40 -0500
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:28318
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388860AbfKENtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:49:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzClKSznx8cV58rfGIqqRQ0C0cwXDP32+CDIzaDX0GbMmAI2R6iAtZrWNogYiBA216DAGl1g12IEmrGT+wozq1wiH+KMNA6sqPTKl363kptMqTI0wL9fSwMuNY5fyG6ZoccDYOs0GWXZ0itaQYmZ44rx6HX8yfKMSPC1uwAkkb82FHndywdexlzUY95FUpUG54NSYgD1U7tFznXFklVrqFCjZ/1m5Fu1eMLe0t0io0Fldipey+ozXZ9f7cBaQ0MNBm1OIMfkEs34de38evhoKfT25Gqs3rg8PjHAPvlNLJ3Qyk6TcD4mIJqC7Ock1ygtBJxOmJtCuwyVx/sFzpsMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzJ14HgzTUHJwdztBcsl694yLskaJBgcmSHKOEmoewI=;
 b=B15LAJVTsOYT7YVv2H+J8XObNws2zJXyveVNwy88XbfyzuYbT1YR5luWJ3tBc3kuck0lem/S56cQtyOOu3XBuN6MNdpybUgVHWD/j5zckepAykXrxMbER2/gpLXWfgvyQt6XsTjvzsSlRRd29uIJBk86vjJzx0B4YcVaPOEZf6kHcptBgCtLevJLZBwt6R+85PbvEtUdQ5UJJkzY9XDKuQrMrHvaRA05zm9GY/EA2BXtXVSLJh/cEw7cfwNJey8B/LJEXqu60mjtBtGyL+ubKDzzrJqbxMam9P7o+de5bOV8WiDKlbHKrRHvFnN4ge5wVsGRF6S0q9ovvkc0h7kSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzJ14HgzTUHJwdztBcsl694yLskaJBgcmSHKOEmoewI=;
 b=YvoTvpUkt2FdgfNUtt99H4QaZ7g1kCNAgsw6TbSLbNMw/21Kgs/ZURRBL0wIOJVjsr5TGEnead+stS0MlzG27kGOzIGy5m+nhAFOsABCLnKDtyPG3ErcuEMID9A7oIBjVtBIIF0UacDLNuZ9jsWtsFf4G4Av3NQeWBSDrGDi2ZE=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.175.24.138) by
 VI1PR0402MB3391.eurprd04.prod.outlook.com (52.134.1.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 13:49:34 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::749b:178a:b8c5:5aaa]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::749b:178a:b8c5:5aaa%11]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 13:49:34 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH 00/12] staging: dpaa2-ethsw: add support for control
 interface traffic
Thread-Topic: [PATCH 00/12] staging: dpaa2-ethsw: add support for control
 interface traffic
Thread-Index: AQHVk9VvxsH2LOJbvkC7T6NABFcyUqd8kRCAgAAG5IA=
Date:   Tue, 5 Nov 2019 13:49:34 +0000
Message-ID: <50fd8cf7-ab16-24ae-9216-b191f37defd3@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <20191105132435.GA2616182@kroah.com>
In-Reply-To: <20191105132435.GA2616182@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::32) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:b8::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6d5b00c-d5f0-4121-3d2d-08d761f6fda1
x-ms-traffictypediagnostic: VI1PR0402MB3391:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB33919B150376302B1298E861E07E0@VI1PR0402MB3391.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(71200400001)(3846002)(6116002)(14454004)(81156014)(71190400001)(2906002)(8676002)(5660300002)(31686004)(6916009)(86362001)(66066001)(66476007)(66946007)(66556008)(8936002)(81166006)(64756008)(305945005)(7736002)(31696002)(53546011)(6506007)(102836004)(256004)(66446008)(14444005)(446003)(11346002)(229853002)(316002)(386003)(54906003)(25786009)(44832011)(99286004)(6512007)(76176011)(966005)(52116002)(6306002)(186003)(6486002)(4326008)(36756003)(486006)(2616005)(476003)(478600001)(26005)(6246003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3391;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3584aZwf3nQi8ejcvChQW9nBu7OdvO2wsvlyDWFE4j38JlkEVbreO4MLJgtI/bXahEeVNBERI5E8sIrqe9GFjl6d1TI95iP4mUd2/NmapwwIJ7NkyNUAvs+VuyN1bRDrWr5TK9B2o3krE49aURBfVdcl35Sd0JtpHYKY7sUFmLNUrtJnWnx8Dq2DRfJf2qE5a5wlu+soRH2NIVXsO6/FTd/m5HwFRESb4Xju4h0hKtNwcq1qjHoExHjexPA07ZLSyMoWO1LyMgWAzjSz4n1RAE8W7R06/9Qf/X/xeUg/E7QOd25wLv/X/oQ2LzL+5olgrKvoq2GtSiEIW0oWdhpfJCEqV89o1nyv2hddGCAP1zd/eUMNNmMlNLLVp5QCPmiKJh/k5VoWQu0t5EZrPs/vtKW6N3PKCmZYUomCjDtT6hm8cY+AWXcCOEoBRhNJaS6xIs1XfA9Ms+p5nI9rup3+jTtSyCb5CQjLs2gI0o93/8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <09B95CCAB5ECAE45B29185FDBE418A04@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d5b00c-d5f0-4121-3d2d-08d761f6fda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 13:49:34.4474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfvKXcpz6KizyviXUqNaBkGK3D1y6y1hmRLTMAQ3Q3TdsfiE6Y+1jK4q0gnMnOgwtBW1tSnq66TMGjgihhePhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3391
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMTEuMjAxOSAxNToyNCwgR3JlZyBLSCB3cm90ZToNCj4gT24gVHVlLCBOb3YgMDUsIDIw
MTkgYXQgMDI6MzQ6MjNQTSArMDIwMCwgSW9hbmEgQ2lvcm5laSB3cm90ZToNCj4+IFRoaXMgcGF0
Y2ggc2V0IGFkZHMgc3VwcG9ydCBmb3IgUngvVHggY2FwYWJpbGl0aWVzIG9uIHN3aXRjaCBwb3J0
IGludGVyZmFjZXMuDQo+PiBBbHNvLCBjb250cm9sIHRyYWZmaWMgaXMgcmVkaXJlY3RlZCB0aHJv
dWdoIEFDTHMgdG8gdGhlIENQVSBpbiBvcmRlciB0bw0KPj4gZW5hYmxlIHByb3BlciBTVFAgcHJv
dG9jb2wgaGFuZGxpbmcuDQo+Pg0KPj4gVGhlIGNvbnRyb2wgaW50ZXJmYWNlIGlzIGNvbXByaXNl
ZCBvZiAzIHF1ZXVlcyBpbiB0b3RhbDogUngsIFJ4IGVycm9yIGFuZA0KPj4gVHggY29uZmlybWF0
aW9uLiAgSW4gdGhpcyBwYXRjaCBzZXQgd2Ugb25seSBlbmFibGUgUnggYW5kIFR4IGNvbmYuIEFs
bA0KPj4gc3dpdGNoIHBvcnRzIHNoYXJlIHRoZSBzYW1lIHF1ZXVlcyB3aGVuIGZyYW1lcyBhcmUg
cmVkaXJlY3RlZCB0byB0aGUgQ1BVLg0KPj4gSW5mb3JtYXRpb24gcmVnYXJkaW5nIHRoZSBpbmdy
ZXNzIHN3aXRjaCBwb3J0IGlzIHBhc3NlZCB0aHJvdWdoIGZyYW1lDQo+PiBtZXRhZGF0YSAtIHRo
ZSBmbG93IGNvbnRleHQgZmllbGQgb2YgdGhlIGRlc2NyaXB0b3IuIE5BUEkgaW5zdGFuY2VzIGFy
ZQ0KPj4gYWxzbyBzaGFyZWQgYmV0d2VlbiBzd2l0Y2ggbmV0X2RldmljZXMgYW5kIGFyZSBlbmFi
bGVkIHdoZW4gYXQgbGVhc3Qgb24NCj4+IG9uZSBvZiB0aGUgc3dpdGNoIHBvcnRzIC5kZXZfb3Bl
bigpIHdhcyBjYWxsZWQgYW5kIGRpc2FibGVkIHdoZW4gYXQgbGVhc3QNCj4+IG9uZSBzd2l0Y2gg
cG9ydCBpcyBzdGlsbCB1cC4NCj4+DQo+PiBUaGUgbmV3IGZlYXR1cmUgaXMgZW5hYmxlZCBvbmx5
IG9uIE1DIHZlcnNpb25zIGdyZWF0ZXIgdGhhbiAxMC4xOS4wDQo+PiAod2hpY2ggaXMgc29vbiB0
byBiZSByZWxlYXNlZCkuDQo+IA0KPiBJIHRob3VnaHQgSSBhc2tlZCBmb3Igbm8gbmV3IGZlYXR1
cmVzIHVudGlsIHRoaXMgY29kZSBnZXRzIG91dCBvZg0KPiBzdGFnaW5nPyAgT25seSB0aGVuIGNh
biB5b3UgYWRkIG5ldyBzdHVmZi4gIFBsZWFzZSB3b3JrIHRvIG1ha2UgdGhhdA0KPiBoYXBwZW4g
Zmlyc3QuDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KPiANCg0KU29ycnkgYnV0IEkg
ZG8gbm90IHJlbWVtYmVyIHlvdXIgc3VnZ2VzdGlvbiBvbiBmaXJzdCBtb3ZpbmcgdGhlIGRyaXZl
ciANCm91dCBvZiBzdGFnaW5nLg0KDQpBbnlob3csIEkgc3VibWl0dGVkIGFnYWluc3Qgc3RhZ2lu
ZyBiZWNhdXNlIGluIGFuIGVhcmxpZXIgZGlzY3Vzc2lvblsxXSANCml0IHdhcyBzdWdnZXN0ZWQg
dG8gZmlyc3QgYWRkIFJ4L1R4IGNhcGFiaWxpdGllcyBiZWZvcmUgbW92aW5nIGl0Og0KDQoiQWgu
IERvZXMgdGhpcyBhbHNvIG1lYW4gaXQgY2Fubm90IHJlY2VpdmU/DQoNClRoYXQgbWFrZXMgc29t
ZSBvZiB0aGlzIGNvZGUgcG9pbnRsZXNzIGFuZCB1bnRlc3RlZC4NCg0KSSdtIG5vdCBzdXJlIHdl
IHdvdWxkIGJlIHdpbGxpbmcgdG8gbW92ZSB0aGlzIG91dCBvZiBzdGFnaW5nIHVudGlsIGl0DQpj
YW4gdHJhbnNtaXQgYW5kIHJlY2VpdmUuIg0KDQoNCkknbSBub3Qgc3VyZSBob3cgSSBzaG91bGQg
cHJvY2VlZCBoZXJlLg0KDQpUaGFua3MsDQpJb2FuYQ0KDQpbMV0gaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMTkvOC85Lzg5Mg0K
