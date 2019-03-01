Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A5F20854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eRoNiVEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfCADiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:38:06 -0500
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:6786
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfCADiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhFBPloKY70YrUTHFwqS11GAxF/FGkLyrBPne/1gLOI=;
 b=eRoNiVEJKhK5YWltKCCxXuUZ6CZopC7sML6haaGXsYrBrbnP5kI9Kn0YP1lHhoG/TvWWnPm8plOhKhcJl5X/79O557M3Nh4aODycwibYKu5fxZSZljUQsMjOqcP0iua0u6EHES9ctNHcR2ct530Z7iCZkuMeCGiFFC6c8RbCbFM=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB5471.eurprd04.prod.outlook.com (20.178.121.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 1 Mar 2019 03:36:20 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d%4]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 03:36:20 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@freescale.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: RE: [PATCH 4/4] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Topic: [PATCH 4/4] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Index: AQHUz1CqoXHo27iDIUewTpjp4VynIqX2G6jw
Date:   Fri, 1 Mar 2019 03:36:20 +0000
Message-ID: <VI1PR04MB324774864C3B7B44C41C232191760@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
 <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
 <20190228103026.9566-5-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190228103026.9566-5-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aabd717-4dea-4717-e3fb-08d69df711fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5471;
x-ms-traffictypediagnostic: VI1PR04MB5471:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtWSTFQUjA0TUI1NDcxOzIzOjdXeldLeG5NU1VwajhydUt1VVlXNkkyLzEy?=
 =?gb2312?B?dDR2bHA5SmFWN2N2M0FsNlU3SmxMS2NjZ2pWa2UzaFlvRG83L3FFMkpYK3da?=
 =?gb2312?B?RmRUSk9hTG1RZmdGZEpTM1BrelcrZXBzT2ttMUtVbVlkM0RBeFluVmJDdWQy?=
 =?gb2312?B?bnRjNjE3TmhiWnBlUnNvL2FnVmxvSGN6RjYyNThzdjZsV3RHemVBQzUrMkQr?=
 =?gb2312?B?Q0NaajREd1JYYkRGRDRtOWFXSW85c2xTV2c2UHhqR2ovTW1TcDdhTjJ4Ly9N?=
 =?gb2312?B?TU1BNmJVS2NZMzJVamdLR0dHWjNFVGIvcW01R1pSMlJOTmUyU2tXYjllN3FC?=
 =?gb2312?B?dEw4MDFoT1NkZE5FcXNvbzJTdkU5N0FKSFkzc0NZL2tBN0tyaEZmMjhJYzVO?=
 =?gb2312?B?aU9wcWpMVkg3ZnR6cnZkQk1GSnJidkkwTG1TWHJIcnRnbUZCQ012OFI4RWNH?=
 =?gb2312?B?dDREVFBnTFJWRHFDdDBVOVhqVnpyVnRmekt2WC9KWHVRYkwrN0l3bC9oSWlI?=
 =?gb2312?B?UG9HWktCUW1tYXVRa3RGc1VLVTJhT2R6WHBpM0o1WDJrMkx4VHV5ZEdzbkNp?=
 =?gb2312?B?Mk0xVVlETlJVTnM5VXFQeTNxeFR4V3pIaUlQS3dUNXdPdjdCelVTTU9rdmVT?=
 =?gb2312?B?TUpOV0IzVlJNZVYwdWlZVlMrVS9HQUpwd3ZreTJZeVlpeVZpWTYyU2F5VmFX?=
 =?gb2312?B?UGpnMGpjMlM4cmI2V3hPeU03NW9acFEvUXhrSUhyVUJyQzhqb2dlR1E5MFZ4?=
 =?gb2312?B?ZzMxZUlPc2dqU2xvL0xBTE1GV01sYS9wRFdvMThxMXF2OFJKRFFuaEVYVkN5?=
 =?gb2312?B?WENXTys1U0IrKy9UUG4xZ3Mza3N2dGRLV3hxM3BrZWxtbWxrbzJvL0dDaDRD?=
 =?gb2312?B?UU0rejYyVGVUV3EyRzNaL01KRXpNakpqUUdrbEJoREJBSElOdVNqT0FzSWRv?=
 =?gb2312?B?ZHZWWURXOC92OUtBNzZBTzVzdkhaeHVVUkdYSDg1cTJNTnlMTWZqTDZ4M3pR?=
 =?gb2312?B?WFZtblYzZjhldmJYR25vZEw2Rzd0eVNiczJZK1BIaWNCckNHZndYT29NWDJT?=
 =?gb2312?B?MXdyQ0JvbzA3NWtyYkZBdlI4ZDNvaFIzc2IxRnZYQndKS2FUZElRbUcreCtr?=
 =?gb2312?B?YlpHUkQ5Nm5UdXdCcVBDWUs1L1B0ejM5b0tNblVITklCV3oxeGRrakZLUkhp?=
 =?gb2312?B?OVRQL0xrRE02cEo1YzdwUzNKRExXazdIR2hCYVRGWFh2NDBIZmk1YnpjOWU4?=
 =?gb2312?B?MXhXWlBxM2twYTBxRFdWL0Z1K25qUkNnM055ZktGR1ZJVEkvREs4TW9LK2cv?=
 =?gb2312?B?TlNpRHdLYm5obytoZWFMUHJzREdkQ05tNW1Ec1E5azZzWG9VbTRDZTA0VHhq?=
 =?gb2312?B?MkhHM3V4amVQd2c3Ulg4Ti85Ly95cXMyNU80L0JuL0d3ZXVZeGxZTTN6L29T?=
 =?gb2312?B?VHFjR2xTeDl0MWw2eVpSWW53S0J2RHlEUXVLMTI1L3BVcSs0aTczdFlFTjhR?=
 =?gb2312?B?dkRNZWw0QlBSQnAwajh1VEhtU3RmVm13MVZCVDlmeVd1SkUzYWg4L2p3L3A0?=
 =?gb2312?B?WEhJNVZqajg1N2ZHWFNQNnMwWEhkVGFoVEhZMW1LcDFNOTFRdzhRSFdXSGRl?=
 =?gb2312?B?Qjg0VkMzOWZPK1FnNmhXSVZuU1MvbUdTNCtIbmNoS0dvVUllOVNlTk94VVZl?=
 =?gb2312?B?SXVwK3pjOEZtUnpKNXBlTHdIbmdyZWErcHpadEFmdG5CaFpYMDNBeVozRHY2?=
 =?gb2312?B?SHRwR0ZzU3NtTEJOK05oSGpDSE9zMG9zK3NUUkdBdjBuVU9vOE1BZE9vMnE2?=
 =?gb2312?Q?L9bQRV6rbDswh?=
x-microsoft-antispam-prvs: <VI1PR04MB5471916973BF1B97C390622891760@VI1PR04MB5471.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(13464003)(40224003)(189003)(199004)(7696005)(76176011)(74316002)(33656002)(53936002)(6116002)(53546011)(256004)(3846002)(102836004)(6246003)(6506007)(71190400001)(229853002)(8936002)(86362001)(8676002)(26005)(81156014)(81166006)(305945005)(7736002)(68736007)(66066001)(2906002)(476003)(44832011)(52536013)(5660300002)(105586002)(97736004)(186003)(446003)(486006)(106356001)(110136005)(25786009)(54906003)(14454004)(55016002)(9686003)(99286004)(71200400001)(6436002)(478600001)(11346002)(4326008)(6636002)(316002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5471;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ku0GsJjgVh5J5JTSeBW8bQytWHb85hneU8rvhBxz5mHi8WyU3Gt/cx/I8auqrdEWqpc8t7RcHhwBvc4/U0m+mEs0omB7tqo3F3NoKi0EEfhW3AQ0q8bD626GkSm9gwj7dxM5JEQxFUIFT8AK0fSHdNgfHeEXvUuykAiK1inhA7DP3bLhc5X74jDLb25kJ7ez3yz+BTqKToR6zQvllbmlvyEWz7NL8qUonOscpzx6Fjzjf40MfzFRYPHFo0DUyX4PzEz4ZBtfII1F1kmZ5ERsBMtkjUqvonK1joX4Iiuz2AX/uhZBUeiNUyr02EJzdGPhXxNETPZEv9nzu4oPU/KQkTExQ92wUb+Ul1MqCAVgsma5yyxpw6wTiNuU1H3IgUFbre5SedupKHvS9ei8y42o1oA/RSWPAtar83C3B4yDJeU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aabd717-4dea-4717-e3fb-08d69df711fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 03:36:20.2347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOcTqMtTCMjjI1SAxODozMaOsUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYXNtdXMgVmlsbGVtb2VzIDxyYXNtdXMu
dmlsbGVtb2VzQHByZXZhcy5kaz4NCj4gU2VudDogMjAxOcTqMtTCMjjI1SAxODozMQ0KPiBUbzog
UWlhbmcgWmhhbyA8cWlhbmcuemhhb0BueHAuY29tPjsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5j
b20+DQo+IENjOiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0PjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgVGltdXIgVGFiaQ0KPiA8dGltdXJAZnJlZXNjYWxlLmNvbT47IFJhc211
cyBWaWxsZW1vZXMgPFJhc211cy5WaWxsZW1vZXNAcHJldmFzLnNlPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggNC80XSBzb2MvZnNsL3FlOiBxZS5jOiBzdXBwb3J0IGZzbCxxZS1zbnVtcyBwcm9wZXJ0eQ0K
PiANCj4gVGhlIGN1cnJlbnQgY29kZSBhc3N1bWVzIHRoYXQgdGhlIHNldCBvZiBzbnVtIF92YWx1
ZXNfIHRvIHBvcHVsYXRlIHRoZQ0KPiBzbnVtc1tdIGFycmF5IHdpdGggaXMgYSBmdW5jdGlvbiBv
ZiB0aGUgX251bWJlcl8gb2Ygc251bXMgYWxvbmUuIEhvd2V2ZXIsDQo+IHJlYWRpbmcgdGFibGUg
NC0zMCwgYW5kIGl0cyBmb290bm90ZXMsIG9mIHRoZSBRVUlDQyBFbmdpbmUgQmxvY2sgUmVmZXJl
bmNlDQo+IE1hbnVhbCBzaG93cyB0aGF0IHRoYXQgaXMgYSBiaXQgdG9vIG5haXZlLg0KPiANCj4g
QXMgYW4gYWx0ZXJuYXRpdmUsIHRoaXMgaW50cm9kdWNlcyBhIG5ldyBiaW5kaW5nIGZzbCxxZS1z
bnVtcywgd2hpY2gNCj4gYXV0b21hdGljYWxseSBlbmNvZGVzIGJvdGggdGhlIG51bWJlciBvZiBz
bnVtcyBhbmQgdGhlIGFjdHVhbCB2YWx1ZXMgdG8gdXNlLg0KPiBDb252ZW5pZW50bHksIG9mX3By
b3BlcnR5X3JlYWRfdmFyaWFibGVfdThfYXJyYXkgZG9lcyBleGFjdGx5IHdoYXQgd2UgbmVlZC4N
Cj4gDQo+IEZvciBleGFtcGxlLCBmb3IgdGhlIE1QQzgzMDksIG9uZSB3b3VsZCBzcGVjaWZ5IHRo
ZSBwcm9wZXJ0eSBhcw0KPiANCj4gICAgICAgICAgICAgICAgZnNsLHFlLXNudW1zID0gL2JpdHMv
IDggPA0KPiAgICAgICAgICAgICAgICAgICAgICAgIDB4ODggMHg4OSAweDk4IDB4OTkgMHhhOCAw
eGE5IDB4YjggMHhiOQ0KPiAgICAgICAgICAgICAgICAgICAgICAgIDB4YzggMHhjOSAweGQ4IDB4
ZDkgMHhlOCAweGU5PjsNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhc211cyBWaWxsZW1vZXMgPHJh
c211cy52aWxsZW1vZXNAcHJldmFzLmRrPg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvYy9mc2wvY3BtX3FlL3FlLnR4dCAgICAgIHwgIDggKysrKysrKy0NCj4gIGRyaXZlcnMv
c29jL2ZzbC9xZS9xZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTQgKysrKysrKysr
KysrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c29jL2ZzbC9jcG1fcWUvcWUudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvYy9mc2wvY3BtX3FlL3FlLnR4dA0KPiBpbmRleCBkN2FmYWZmNWZhZmYuLjA1ZjVmNDg1
NTYyYSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
Yy9mc2wvY3BtX3FlL3FlLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL2ZzbC9jcG1fcWUvcWUudHh0DQo+IEBAIC0xOCw3ICsxOCw4IEBAIFJlcXVpcmVk
IHByb3BlcnRpZXM6DQo+ICAtIHJlZyA6IG9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSBkZXZpY2Ug
cmVnaXN0ZXJzLg0KPiAgLSBidXMtZnJlcXVlbmN5IDogdGhlIGNsb2NrIGZyZXF1ZW5jeSBmb3Ig
UVVJQ0MgRW5naW5lLg0KPiAgLSBmc2wscWUtbnVtLXJpc2NzOiBkZWZpbmUgaG93IG1hbnkgUklT
QyBlbmdpbmVzIHRoZSBRRSBoYXMuDQo+IC0tIGZzbCxxZS1udW0tc251bXM6IGRlZmluZSBob3cg
bWFueSBzZXJpYWwgbnVtYmVyKFNOVU0pIHRoZSBRRSBjYW4gdXNlDQo+IGZvciB0aGUNCj4gKy0g
ZnNsLHFlLXNudW1zOiBUaGlzIHByb3BlcnR5IGhhcyB0byBiZSBzcGVjaWZpZWQgYXMgJy9iaXRz
LyA4JyB2YWx1ZSwNCj4gKyAgZGVmaW5pbmcgdGhlIGFycmF5IG9mIHNlcmlhbCBudW1iZXIgKFNO
VU0pIHZhbHVlcyBmb3IgdGhlIHZpcnR1YWwNCj4gICAgdGhyZWFkcy4NCj4gDQo+ICBPcHRpb25h
bCBwcm9wZXJ0aWVzOg0KPiBAQCAtMzQsNiArMzUsMTEgQEAgUmVjb21tZW5kZWQgcHJvcGVydGll
cw0KPiAgLSBicmctZnJlcXVlbmN5IDogdGhlIGludGVybmFsIGNsb2NrIHNvdXJjZSBmcmVxdWVu
Y3kgZm9yIGJhdWQtcmF0ZQ0KPiAgICBnZW5lcmF0b3JzIGluIEh6Lg0KPiANCj4gK0RlcHJlY2F0
ZWQgcHJvcGVydGllcw0KPiArLSBmc2wscWUtbnVtLXNudW1zOiBkZWZpbmUgaG93IG1hbnkgc2Vy
aWFsIG51bWJlcihTTlVNKSB0aGUgUUUgY2FuIHVzZQ0KPiArICBmb3IgdGhlIHRocmVhZHMuIFVz
ZSBmc2wscWUtc251bXMgaW5zdGVhZCB0byBub3Qgb25seSBzcGVjaWZ5IHRoZQ0KPiArICBudW1i
ZXIgb2Ygc251bXMsIGJ1dCBhbHNvIHRoZWlyIHZhbHVlcy4NCj4gKw0KPiAgRXhhbXBsZToNCj4g
ICAgICAgcWVAZTAxMDAwMDAgew0KPiAgCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb2MvZnNsL3FlL3FlLmMgYi9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYyBp
bmRleA0KPiA3MWJlZWI3MmVlZTQuLjA0OWIzNmQ2YWVlZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9zb2MvZnNsL3FlL3FlLmMNCj4gKysrIGIvZHJpdmVycy9zb2MvZnNsL3FlL3FlLmMNCj4gQEAg
LTI4Myw3ICsyODMsNiBAQCBFWFBPUlRfU1lNQk9MKHFlX2Nsb2NrX3NvdXJjZSk7DQo+ICAgKi8N
Cj4gIHN0YXRpYyB2b2lkIHFlX3NudW1zX2luaXQodm9pZCkNCj4gIHsNCj4gLQlpbnQgaTsNCj4g
IAlzdGF0aWMgY29uc3QgdTggc251bV9pbml0Xzc2W10gPSB7DQo+ICAJCTB4MDQsIDB4MDUsIDB4
MEMsIDB4MEQsIDB4MTQsIDB4MTUsIDB4MUMsIDB4MUQsDQo+ICAJCTB4MjQsIDB4MjUsIDB4MkMs
IDB4MkQsIDB4MzQsIDB4MzUsIDB4ODgsIDB4ODksIEBAIC0zMDQsOQ0KPiArMzAzLDIyIEBAIHN0
YXRpYyB2b2lkIHFlX3NudW1zX2luaXQodm9pZCkNCj4gIAkJMHgyOCwgMHgyOSwgMHgzOCwgMHgz
OSwgMHg0OCwgMHg0OSwgMHg1OCwgMHg1OSwNCj4gIAkJMHg2OCwgMHg2OSwgMHg3OCwgMHg3OSwg
MHg4MCwgMHg4MSwNCj4gIAl9Ow0KPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqcWU7DQo+ICAJY29u
c3QgdTggKnNudW1faW5pdDsNCj4gKwlpbnQgaTsNCj4gDQo+ICAJYml0bWFwX3plcm8oc251bV9z
dGF0ZSwgUUVfTlVNX09GX1NOVU0pOw0KPiArCXFlID0gcWVfZ2V0X2RldmljZV9ub2RlKCk7DQo+
ICsJaWYgKHFlKSB7DQo+ICsJCWkgPSBvZl9wcm9wZXJ0eV9yZWFkX3ZhcmlhYmxlX3U4X2FycmF5
KHFlLCAiZnNsLHFlLXNudW1zIiwNCj4gKwkJCQkJCSAgICAgICBzbnVtcywgMTQsIFFFX05VTV9P
Rl9TTlVNKTsNCj4gKwkJb2Zfbm9kZV9wdXQocWUpOw0KPiArCQlpZiAoaSA+IDApIHsNCj4gKwkJ
CXFlX251bV9vZl9zbnVtID0gaTsNCj4gKwkJCXJldHVybjsNCj4gKwkJfQ0KPiArCX0NCj4gKw0K
PiAgCXFlX251bV9vZl9zbnVtID0gcWVfZ2V0X251bV9vZl9zbnVtcygpOw0KPiANCj4gIAlpZiAo
cWVfbnVtX29mX3NudW0gPT0gNzYpDQoNClNvIHlvdSBkZWZpbmUgMTQgc251bXMgZm9yIE1QQzgz
MDksIGJ1dCB0aGVyZSBzdGlsbCBiZSB0aGUgY29tbWVudCAiLyogTm8gUUUgZXZlciBoYXMgZmV3
ZXIgdGhhbiAyOCBTTlVNcyAqLyIgYW5kIGl0IHdpbGwgY2hlY2sgaWYgDQpUaGUgbnVtX29mX3Nu
dW1zICJpcyA+MjgiLCBpdCB3aWxsIGNhdXNlIGNvbmZ1c2lvbiwgc28gSSBzdWdnZXN0IHRvIG1v
ZGlmeSAyOCB0byAxNC4NCg0KSSByZWFkIHRoZSBvbGQgdmVyc2lvbiBRVUlDQyBFbmdpbmUgQmxv
Y2sgUmVmZXJlbmNlIE1hbnVhbCwgaXQgc2FpZCBzbnVtcyB0YWJsZSBpcyBub3QgYXZhaWxhYmxl
IG9uIE1QQzgzMDYvTVBDODMwNlMvTVBDODMwOSwNClNvIEkgdGhpbmsgdGhlIGNvZGUgaXQgd3Jp
dHRlbiBsb25nIGJlZm9yZSB3aXRoIHRoaXMgdmVyc2lvbiBSTSwgYW5kIGF0IHRoYXQgdGltZSwg
dGhlIHNudW1zIGlzIGF0IGxlYXN0IDI4LCBhbmQgbm9ib2R5IG1vZGlmeSB0aGUgY29kZSBsYXRl
ci4NCkFuZCBub3cgd2l0aCB0aGUgbmV3IHZlcnNpb24gUk0sIGl0IHN1cHBvcnQgTVBDODMwNi9N
UEM4MzA2Uy9NUEM4MzA5IHdpdGggc251bXMgYW5kIGhhdmUgc251bXMgZmV3ZXIgdGhlbiAyOCwg
c28gSSB0aGluayB0aGUgbWluaW11bSB2YWx1ZSBzaG91bGQNCkJlIG1vZGlmaWVkIHRvIDE0Lg0K
DQpUaGFuayB5b3UhDQotUWlhbmcgWmhhbw0K
