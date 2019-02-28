Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB27C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D17F2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BOdHzfC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfB1HOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:14:52 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:8963
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730951AbfB1HOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdnG3cLlW+II3tMgg7guvF8HSwcgWuuHfOwSNGJahfA=;
 b=BOdHzfC1rcf4c1R7W/WSSJprdRYYvmzipl11I/f2DtdaNC38HoVFXChN3ZDOLZVHo9WypOHIM3H5bH51UiIFOBYZqw5fbVOoKd8imIkYEwD9DG8f7/6LrZJHEJdq96KD4PpWAz0xxoCG1JqFkkLoopqlZfT4cTThpqVkQvd+HdA=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB5278.eurprd04.prod.outlook.com (20.177.51.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 07:14:45 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d%4]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 07:14:45 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     'Rasmus Villemoes' <rasmus.villemoes@prevas.dk>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: RE: [RFC PATCH] soc/fsl/qe: support MPC8309
Thread-Topic: [RFC PATCH] soc/fsl/qe: support MPC8309
Thread-Index: AQHUzbALXjDeDpgRFU++rfaOQW65LqX0y9ng
Date:   Thu, 28 Feb 2019 07:14:44 +0000
Message-ID: <VI1PR04MB32475CFE4827D2141262D34E91750@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <20190226084816.20535-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190226084816.20535-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f40619fe-f9b8-4e3f-6005-08d69d4c6a91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5278;
x-ms-traffictypediagnostic: VI1PR04MB5278:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtWSTFQUjA0TUI1Mjc4OzIzOkhwdHFibllhQlM1c3NVRWcrOS9YdzdtS2tE?=
 =?gb2312?B?QytXMXZMNGJVMGsvc1FXVk1tb0duVHEzNW1xK3hvS0cxVVFQdzlEcFU5aVdT?=
 =?gb2312?B?MHc5VjN4VThSZFIxaGo1TnI1Y25tYzBubldlL09XOTFGWHRXMEoyUnI1TlNM?=
 =?gb2312?B?SzFpa3YzbFRrMFZYQlBWSWliWXk5RUFacGNoelg1Z2MwSlpjN2tEbFU3NkNT?=
 =?gb2312?B?UU1QRGJpeHhEbUQyNzVDYkRPWERoY3AxRjNwUEdocHNXcWZDaSt5Q0x4MkhO?=
 =?gb2312?B?aytaaEp0M0NibEZuaUhxSnlOWmduN2Q5R0Y2TWtuR2d6MnBmOHA0M0RQelJC?=
 =?gb2312?B?WmNFRmlaQnVGNEN1bjNCRFJiNHdtNllFTW1lN0tFZk9ZR3hmb3FVSTdvWEZU?=
 =?gb2312?B?QlBBcFZsMHBwd2o3dDdBR0Qvd1NJL3JDUkZzRUwzcENhUXBOUk5paTRTeGV2?=
 =?gb2312?B?ZVo0L0xtSlFHY0R2MTRLTzREbyswUVMrZktvZDFQbEFVdmZjc0dTS3FEY1pD?=
 =?gb2312?B?ZDkvSklRWi8xL0lCNGhweVJoOUFLcy90Y2lnYWlLZTUwZnlRbEVRUE9ZYXht?=
 =?gb2312?B?cXNvSzBBU284TVFnSm12MWNxTExYdDZUWm84eG96Q3FpT2E5WVRJOFJyWTk5?=
 =?gb2312?B?ZWlTU1hpaGY2QUlCSnduNVV6dHlHTk90TlNtNlJESVJCMjlJeTVQWWpYcDlv?=
 =?gb2312?B?VUZKS0sxaGd4M21PSUdva0pIOXhTbjRiekhlK2xoaG1zVkUrVStvT1d2ZjNj?=
 =?gb2312?B?U1NxSXlhSTEzYktpR2xvdnJZd2R3SjRjczRlVDVmTkhKZjYwZE1mUGZrWjBa?=
 =?gb2312?B?MEFMaWROTm9KS29ER09BdjJlRVNuUys0cFd2QTdjdmNMYVk0QVlCci8xazVi?=
 =?gb2312?B?dll4bnZ6ODRBbUhxdEJMbEZVZ1hVUGY2aCs0SkdNNjJUZTNQQ1d0L3JFaFla?=
 =?gb2312?B?L1JNZ1JFdGZBRjdFb0VYeGpKbzAwWlBqeG96NSt0S3pYTDZOQmYvcEdYWWNq?=
 =?gb2312?B?aUcyTHBFNWxsYnVRSTVwYmd6dEIvMnZJSUNvUXFoc1NOMisrM0N4WXJpUDRF?=
 =?gb2312?B?OTlTWm5FZEI5dVpzdjh4VjZyeGtrcm9PdUg0b0NKWEFJZ0xlWGY1Z203aENF?=
 =?gb2312?B?OWZ4MVB4TGRaOU5rbGFkbWo3SWFPVkV4dGpCWkJERHFCZTVsRE9TNms5TS9M?=
 =?gb2312?B?N3c1QUpLWnJsd0tFZXJJZDNrbXdMRHhIK1QzT1BHdlZ6dG5tZEZMQ3gyMEZE?=
 =?gb2312?B?SjB6aUNrMlVaQUpwM01ubmF2SWJGdUY4RytIMm1yNE9CbTI0YUFSV0JyY0l5?=
 =?gb2312?B?cjBaNEhSbDdMbGR0VCs4WTdiVW5UQjUxcmdwZ1h5ajhlSktobXZQdlFkZnQ5?=
 =?gb2312?B?dFV3bWhsaEEzaUNIQ0hPTEY3YSs3cm8zcnFQbVo4SUxSTEQ0cGw1QmljeXZW?=
 =?gb2312?B?U0tIejlYQlFYZzFIRVRBQXRSTzFhd015RjdKeDZpRWdtNzRPRGU0UTNaV3Mv?=
 =?gb2312?B?QnZUdXdZWVVHbGhWN0dIWUg0TEF0WDJxd2lBMnU5eEhReld0anlsRWdSb0po?=
 =?gb2312?B?SkRpNnZlSFd3MThoaDJnN2NjSnFMWW16LzdjN2lFN1k0WlF4OFlJRzgzdFNU?=
 =?gb2312?B?MHVLOGVTalZoSHV1eTNyekUxMlhOSzV0aTQrU25DZWRnQUNWZHBmMDlFdlNR?=
 =?gb2312?B?MnF5SmFtNFlpeU5zeDZnbkxodnB1M0VUVC9QVmpLUnB0REJRcjFDU2tNWm90?=
 =?gb2312?B?ZXN2ci9pcW9NdkN3WlVxQT09?=
x-microsoft-antispam-prvs: <VI1PR04MB527867427C7568D97CF3949F91750@VI1PR04MB5278.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(13464003)(189003)(199004)(476003)(53546011)(316002)(6506007)(25786009)(11346002)(86362001)(54906003)(52536013)(2906002)(81166006)(81156014)(8936002)(44832011)(4326008)(186003)(68736007)(446003)(110136005)(102836004)(486006)(6246003)(26005)(5660300002)(8676002)(9686003)(66066001)(478600001)(53936002)(7736002)(14454004)(55016002)(74316002)(6116002)(3846002)(105586002)(6436002)(6636002)(106356001)(305945005)(97736004)(229853002)(33656002)(99286004)(256004)(7696005)(76176011)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5278;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6whb1IDc7OVdXwmJRisqCAhGfT1mB313WiJYmlfQug9Btgym6lpd+k4/d0rgNc7LYUILIbRwgvokWFm4ZMISaYMD8m9ZJWY6T6QL7Hv0Crr7fA/g8RX9A6giqKmapaKXH9eORwaXPbli8rpLv6zdFQrGjjMPLlPQqCnzg2i2hvQceoGtRDASjESAIBt7nOe23VnEc053RQAzPy0Di3D/mo7aouGMY4AL4Fvugi+r6IsUst0Kljs9GDfk9zWacobH0FVoZvOEM0aS4Fj6dpZ9fsCvGMs2LLJa1N81k4UMhU6YTcdtAYrFWsuv3jjTiWc3bHPfDWFxK/BFuINZEUb+DLFWKi38yJKCqIHEPuqzRnDNHHIDzEFPL5898W/XVYWkLGtDO1BYpWdAcihq6Q815PRMECxlnJU7p9CIL7qDcag=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40619fe-f9b8-4e3f-6005-08d69d4c6a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 07:14:44.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMjYsIDIwMTkgYXQgMjo0OSBBTSBSYXNtdXMgVmlsbGVtb2VzIDxyYXNtdXMu
dmlsbGVtb2VzQHByZXZhcy5kaz4gd3JvdGU6DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFJhc211cyBWaWxsZW1vZXMgPHJhc211cy52aWxsZW1vZXNAcHJldmFzLmRrPg0K
PiBTZW50OiAyMDE5xOoy1MIyNsjVIDE2OjQ4DQo+IFRvOiBRaWFuZyBaaGFvIDxxaWFuZy56aGFv
QG54cC5jb20+OyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFZhbGVudGluIExvbmdjaGFtcA0KPiA8dmFsZW50aW4ubG9uZ2No
YW1wQGtleW1pbGUuY29tPjsgU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD47DQo+IFJhc211
cyBWaWxsZW1vZXMgPFJhc211cy5WaWxsZW1vZXNAcHJldmFzLnNlPg0KPiBTdWJqZWN0OiBbUkZD
IFBBVENIXSBzb2MvZnNsL3FlOiBzdXBwb3J0IE1QQzgzMDkNCj4gDQo+IEN1cnJlbnRseSwgd2hl
biBkZXZpY2UgdHJlZSBzcGVjaWZpZXMgZnNsLHFlLW51bS1zbnVtcyA9IDI4ICh3aGljaCBhIG51
bWJlcg0KPiBvZiBpbi10cmVlIC5kdHMgZmlsZXMgZG8sIGFuZCB3aGljaCBpcyB0aGUgZGVmYXVs
dCB3aGVuIHRoYXQgcHJvcGVydHkgaXMgbWlzc2luZyksDQo+IHFlX3NudW1zX2luaXQoKSBlbmRz
IHVwIHVzaW5nIHRoZSBmaXJzdCAyOCBlbGVtZW50cyBvZiB0aGUgc251bV9pbml0XzQ2W10NCj4g
YXJyYXkuDQo+IA0KPiBUaGUgc2l0dWF0aW9uIGlzIHF1aXRlIG1lc3N5LiBUaGlzIHBhdGNoIG1h
eSBicmVhayBleGlzdGluZyBzZXR1cHMgdGhhdCBmb3INCj4gc29tZSByZWFzb24gd29yayB3aXRo
IHNwZWNpZnlpbmcgZnNsLHFlLW51bS1zbnVtcyA9IDI4IGFuZCB1c2luZyB0aGUNCj4gZXhpc3Rp
bmcgc251bV9pbml0XzQ2IGFycmF5LiBPVE9ILCB0aGUgY3VycmVudCBjb2RlIGNlcnRhaW5seSBk
b2VzIG5vdCB3b3JrDQo+IGZvciB0aGUgTVBDODMwOS1iYXNlZCBib2FyZCB3ZSdyZSB3b3JraW5n
IG9uLCBzaW5jZSB0aGUgZmlyc3QgMTQgb2YgdGhlDQo+IGVsZW1lbnRzIGluIHNudW1faW5pdF80
NiBhcmUgIk5vdCBhdmFpbGFibGUgb24NCj4gTVBDODMwNi9NUEM4MzA2Uy9NUEM4MzA5IiBhY2Nv
cmRpbmcgdG8gdGhlIFFVSUNDIEVuZ2luZSBSZWZlcmVuY2UNCj4gTWFudWFsIChUYWJsZSA0LTMw
KSAtIGFuZCBpbmRlZWQsIHdpdGhvdXQgdGhpcyBwYXRjaCAob3Igc29tZXRoaW5nIHRvIHRoZQ0K
PiBzYW1lIGVmZmVjdCksIHdlIGdldA0KDQpBY2NvcmRpbmcgdG8gdGhlIFFVSUNDIEVuZ2luZSBS
ZWZlcmVuY2UgTWFudWFsIChUYWJsZSA0LTMwKSwgdGhlIG51bWJlciBvZiBzbnVtcyB1c2VkIGZv
ciANCiIgTVBDODMwNi9NUEM4MzA2Uy9NUEM4MzA5IiBzaG91bGQgYmUgMTQgaW5zdGVhZCBvZiAy
OCwgc28gbWF5YmUgd2Ugc2hvdWxkIGFzc2lnbiAiZnNsLHFlLW51bS1zbnVtcyA9IDE0Ig0KQW5k
IGRlZmluZSBhIG5ldyBzbnVtX2luaXRfMTQgYXJyYXksIG1lYW53aGlsZSwgbW9kaWZ5IHRoZSBt
aW5pbXVtIHZhbHVlIG9mICJudW1fb2Zfc251bXMiIHRvIDE0IGluIGZ1bmN0aW9uICJxZV9nZXRf
bnVtX29mX3NudW1zIg0KKEkgbWVhbjogIiBpZiAoKG51bV9vZl9zbnVtcyA8IDE0KSB8fCAobnVt
X29mX3NudW1zID4gUUVfTlVNX09GX1NOVU0pKSB7IikNCg0KQmVzdCBSZWdhcmRzDQpRaWFuZyBa
aGFvDQoNCg==
