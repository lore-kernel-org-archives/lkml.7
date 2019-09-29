Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BE5C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B735A214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XpOCtPIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfI2C51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 22:57:27 -0400
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:42914
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728699AbfI2C51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 22:57:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE/ssykPIOOieL8lOwO+fZVS9Lw4J1jys85U9lLkQ6m9Fgi7Z0oSoOBk6N/KH2jMfeM4p+cNTAsjtO9SsUy37g/uXTTbLeGGb61CkKQ6aiG9mpFTaoE4RSFfQ+tGCyrWd24iwhhhL592MQ7ySJ/4hFg6sabgILGbmIrDHHICAdjXlNjopirNwsvMucK/o/U6oCmFZ4duaQUkIXfy1IPS2e17Z0qygqSyp+3Wb9se9hP87ALHnBuJRX+4jg8RhDavCKpUBE2yFklEAiQCAaDm1RNiJh0oF7yewjk3cfl5VKwALM5/W0WCV+CaPCLDtLYqnLsMs4iv0BpO0YG6padEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7Cr/n4EZzxryUiJBwEqa8KZivcjhF4Yb8S7vhHNSNk=;
 b=Xb+v+bPVe/18UynoDg0ORMxtLleAwDEPtUNH47Hr0/Y85pWkIRRW6gMselM4HU01385jAtgcWiZI0HLp+5WYTKUq1Ez9QgmwsRr6c76ASqAImwlhOkfVe1OTpFWCBPmjt7pb0D0INfZVxDIuQ4sIZnAt33DWRCgbDk12GT6cGfptL1KCicDhaoSlsHSdatdVV322QgGvTndvA+mD27KWuJ+soHjjnfMuMOLMFtbk+q9jwqffIvMwNsgeG5Lm2caO88M4F8MCEWB4AfQrKpHkRSVrPtQGQnAMcq0hPQKKDtkNqv7DGd0EGInUZ272wBqbEqdfwnsVsCJPv8oYot4k+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7Cr/n4EZzxryUiJBwEqa8KZivcjhF4Yb8S7vhHNSNk=;
 b=XpOCtPICRWj250KqiA7e2ewqbGTJtU37MJ3yLq3n1u+k0uljEmGlDR9prTBPpPkQLBGcsg/banZKvt807b6QKN6PnuY64MEYlGqOiHQyZSgCQaKcLbd+fQwV6BBKNIexlt0NSPQ+HjsmqGiY8eUMaDEEHqDn8kRXkXMnD8Z4I18=
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com (52.133.240.82) by
 DB8PR04MB7132.eurprd04.prod.outlook.com (52.135.63.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Sun, 29 Sep 2019 02:57:23 +0000
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::3d0b:c71f:fa1a:e856]) by DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::3d0b:c71f:fa1a:e856%2]) with mapi id 15.20.2305.017; Sun, 29 Sep 2019
 02:57:23 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub add filter for device with specific VID&PID
Thread-Topic: [PATCH] usb: hub add filter for device with specific VID&PID
Thread-Index: AQHVcfycJPrHn/IcK0qf/xic1GWPZ6c5GiAAgAEI5+CABaVFgIACLFEQgAAINyA=
Date:   Sun, 29 Sep 2019 02:57:23 +0000
Message-ID: <DB8PR04MB682675054E3A5306F447E6FDF1830@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <DB8PR04MB682649CA98B0704FAF037A40F1840@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <Pine.LNX.4.44L0.1909271305030.4732-100000@iolanthe.rowland.org>
 <DB8PR04MB6826763082AF84812426CC53F1830@DB8PR04MB6826.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB6826763082AF84812426CC53F1830@DB8PR04MB6826.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50cb416f-8165-4d48-7708-08d74488c0c2
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB8PR04MB7132:
x-microsoft-antispam-prvs: <DB8PR04MB713208485020EF838FB43CFDF1830@DB8PR04MB7132.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 017589626D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(8936002)(25786009)(6436002)(14454004)(74316002)(478600001)(66556008)(53546011)(99286004)(446003)(33656002)(6506007)(76116006)(305945005)(66476007)(66946007)(64756008)(66066001)(7696005)(229853002)(66446008)(54906003)(4326008)(9686003)(11346002)(186003)(256004)(6916009)(102836004)(55016002)(6246003)(2171002)(76176011)(52536014)(5660300002)(71200400001)(71190400001)(81156014)(81166006)(316002)(6116002)(3846002)(8676002)(86362001)(2906002)(26005)(476003)(486006)(7736002)(2940100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7132;H:DB8PR04MB6826.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhTQlV1PYr3iPQPN28yuW/8xnwY5tpNtzn9s7o0SSKDmPFQzjN9g1DFJDQCJO/j+N+/eUCXcPFl7xcrOVnzeMNEY/MWsef3cYoBR3MC3ng4mY4prGcJJHN57i5rIl8IvBnPMYqQGghlnYwBI6i7FEleXcAR2yca8eDEJAgID36Kmk51WO7OuDy9oD2AaK/YsXFHaHjFJnlLko2WN//exKkySEbfThc1PWr718ah6TTczmft0inGccyv6ltQCcIB7eFLnUaP/z5aezpJS0SO52jk4vmOUe0SFFSvjSR1xM4wFAoZHvOCDu7Au3VWjZsVa9wxZjf1oduF9JtdLERYvGeZGme6ojTW51ZnvUCRZbHCP2/CVqmbiw+FsOQhKTHcnYpU4URP6ZJJ49yUd8CPAVsS07k3rGltQRRdPAxLJjlk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cb416f-8165-4d48-7708-08d74488c0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2019 02:57:23.4814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJxuOczFpVCfzIjW0SOMS3FYo3UkO46bES5/9sQ6F90/XVt45JEldy1QYwJXrMuKxu0Xz9QbE8Ej78Engb1GKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KT24gU3VuZGF5LCBTZXB0ZW1iZXIgMjksIDIwMTkgMTA6MzUsIHdyb3RlOg0K
PiANCj4gSGkgQWxhbiwNCj4gDQo+IE9uIFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjgsIDIwMTkgMDE6
MDgsIEFsYW4gU3Rlcm4gd3JvdGU6DQo8c25pcD4NCj4gPg0KPiA+IEluIGZhY3QsIHRoZSBzeXN0
ZW0gc2hvdWxkIHJlc3BvbmQgdGhlIHNhbWUgd2F5IHRvIGFueSB1bnJlY29nbml6ZWQNCj4gPiBk
ZXZpY2UgdGhhdCBkb2Vzbid0IHN1cHBvcnQgSE5QLCByaWdodD8gIFRoZXJlJ3Mgbm90aGluZyBz
cGVjaWFsIGFib3V0DQo+ID4gdGhlc2UgVklEL1BJRCB2YWx1ZXMuDQo+IA0KPiBZZXMsIGJ1dCBJ
IHNhdyB0aGVyZSBhcmUgYWxyZWFkeSBzb21lIGltcGxlbWVudGF0aW9uIGluIHVwc3RyZWFtIGtl
cm5lbCBmb3IgdGhpcw0KPiBwdXJwb3NlLCBqdXN0IFBJRCBkaWZmZXJlbnQ6IGRyaXZlcnMvdXNi
L2NvcmUvb3RnX3doaXRlbGlzdC5oIGZ1bmN0aW9uDQo+IGlzX3RhcmdldGVkKCkNCj4gDQo+ID4g
PiA+IEFuZCB3aHkgdGhvc2Ugc3BlY2lmaWMgdmlkL3BpZCB2YWx1ZXM/ICBXaGF0IGRvIHRoZXkg
cmVmZXIgdG8/DQo+ID4gPg0KPiA+ID4gRm9yIHN0ZXAgNSwgd2UgZ290IHRoZSBWSUQgLyBQSUQg
bnVtYmVyIGZyb20gVVNCIElGIGNlcnRpZmllZA0KPiA+ID4gbGFiKEFsbGlvbi5pbmMgYXQgVGFp
d2FuZykuIExvb2tzIGxpa2UgdGhpcyBpcyBhIHJlc2VydmVkIElEIHBhaXINCj4gPiA+IGFuZCB3
aWxsIG5vdCBiZSBhbGxvY2F0ZWQgdG8gYW55IHZlbmRvciBmb3IgdGhlaXIgcHJvZHVjdHMuIFNv
IGl0J3MNCj4gPiA+IGhlbmNlIHVzZWQgZm9yDQo+ID4gdGhpcyBjYXNlIHRlc3QgKGxpa2Ugc2F5
aW5nOiB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gcG9wIGEgbm90LXN1cHBvcnQNCj4gPiBtZXNzYWdl
IGZvciB0aGlzIHJlc2VydmVkIFZJRCZQSUQpLg0KPiA+DQo+ID4gRG9uJ3Qgd2UgZG8gdGhpcyBh
bHJlYWR5Pw0KPiANCj4gWWVzLCBidXQgaW4gZnVuY3Rpb24gaXNfc3RhcmdldGVkKCksIEkgZm91
bmQgaXQncyBhIGxpdHRsZSBiZSBkaWZmZXJlbnQ6DQo+IEN1cnJlbnQgdXBzdHJlYW06ICAgICAg
ICAgICAgICAgICAgICAgVklEID0gMHgxYTBhLCBQSUQgPSAweDAyMDANCj4gSW5mbyBmcm9tIFVT
Qi1JRiBjZXJ0aWZpZWQgbGFiOiBWSUQgPSAweDFhMGEsIFBJRCA9IDB4MDIwMQ0KPiANCg0KU29y
cnkgdGhhdCBJIG1pcy11bmRlcnN0b29kIHRoZSBsb2dpYyBvZiBpc19zdGFyZ2V0ZWQoKSBhbmQg
aXQncyBjYWxsZXIuDQoNClNvIHRoZSBwcm9wZXIgd2F5IHRvIHJlc29sdmUgbXkgcHJvYmxlbSBp
czoNCjEuIFNlbGVjdCBDT05GSUdfVVNCX09URyBpbiAuY29uZmlnDQoyLiBBZGQgcHJvcGVydHkg
J3RwbC1zdXBwb3J0JyB0byBkZXZpY2UgdHJlZQ0KMy4gQ3VzdG9taXplIHdoaXRlbGlzdF90YWJs
ZVtdIGFjY29yZGluZyB0byBteSBUYXJnZXQtUGVyaXBoZXJhbC1MaXN0DQpyZXF1aXJlbWVudC4N
Cg0KQW0gSSByaWdodD8gOikNCg0KUmVnYXJkcywNClJhbg0K
