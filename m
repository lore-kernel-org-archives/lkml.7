Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CBDC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45296206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QdHxf/cV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="VP+cXv4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfLWJLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:11:03 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33372 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfLWJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:11:03 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 85DB3C045A;
        Mon, 23 Dec 2019 09:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1577092262; bh=hX7shpgTccywnc8twj72NX/Q1JW+Bz6pG/gkgdsD7+o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QdHxf/cVlmtlQmZIn91VCQPuDA6tMRYUf7ffwDqTlweyn/9/p7GFqlvErOzySsf/Q
         9z86OpIQ0Q6H0LhU3lsm8O+6gUXzovMCZFhMAcktjmVNKCP3vkikGZZK66LQDagzjW
         6kOn8xVhqOWCeHM7kYvQLIQjjQbSrNqGFK2wTgQF47PQdJHQNlpM0gPt5bd+Vpd8fR
         Enz5TydR78Wbd23afx5PwKXh5VBscmhBF9TgDNr5r7DTVMftgD5q/m3omuC0ZYGUbS
         YveOovCIHTSaCO3rsE0uChZE6ZO37hIz1/oSsSteCNtPY4OODiv7LVL7L28ZLLTC6B
         pYDlHfe8h2rOQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 54861A0079;
        Mon, 23 Dec 2019 09:10:54 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Dec 2019 01:10:54 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 23 Dec 2019 01:10:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgxddfKpPYc5Fnsq5bqTeIXjgE7hO8w4cs5EnkK3Nkt+BuREU6uGGHkcVi7HtOcBW+UEjEQMWy//8UJeeLGMAmiaboPfRgGi4IWxvNaFQvM/wkr4lwRCtNCbsyDsPZPEA/+TOfkkvO83rQgXcgCU2dIcyfkToHRuP0bgVxfgsOlbEbdm4tJRxtbI4S400Q6CicfryiTKRX6U7QCza4UP/53QgkS1C/ETGF5SrNm3MumpPZeDLg6ihlxaYtlbRb34zJPxODJxtfJoc2xRgFj/8sC/b6I03EkQ7q6uj0ud9G6XBHJMf20WY7pwiu1J0RyiFeMPmnad2E6YsYGw3+5fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX7shpgTccywnc8twj72NX/Q1JW+Bz6pG/gkgdsD7+o=;
 b=EfwLM66SBwSwCZGf5mN8h0RZPr+74AlNjBHfEQ96DlCrg+T3M6RndKZAOZSt2sYvxcgHBKcFFHpKgCIX3yy4orK35WnPXGvBQ+2Mr47LZdbLPCfO5PZW4cI0bhUXVJEKQcy4qSaJ0qtfRz/zhTj5A+10S7Qqk5LaigLtgfMM49VgpT7nr2ycHwqoGWkRvCANVAdZobhLg3FI6CsEJY/ya7hU3tsmu8GSOhgnma8yObhCbDCX2iIqcu+0GMruygOwem+ezdyC5ZMybzu9ooCS5M3aTU7u1T12b7mfo8myJ3tHHfHkUJdiIvMf4JHkBVCX29LO6mzprRVQklyQxVY51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX7shpgTccywnc8twj72NX/Q1JW+Bz6pG/gkgdsD7+o=;
 b=VP+cXv4zI1g08FLfcdknw7wD3LRzQFQ1XHMtWclT7ZWHoUTf5i1o/TPbpx5f0JQVo+zCOYgOo31l+M2aZgKVl1XbqI6S+9aUEolFQZpvlUC5hV207fbtWj8Jw7DJm/ZkDXs2L4jkrYUrXdIHbHaiQ5JrmN207ZWvLGecn2vYp9s=
Received: from MN2PR12MB4093.namprd12.prod.outlook.com (52.135.51.203) by
 MN2PR12MB3821.namprd12.prod.outlook.com (10.255.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 09:10:51 +0000
Received: from MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::35cf:644a:cfa6:72f8]) by MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::35cf:644a:cfa6:72f8%7]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 09:10:51 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 1/2] usb: dwc2: Fix IN FIFO allocation
Thread-Topic: [PATCH 1/2] usb: dwc2: Fix IN FIFO allocation
Thread-Index: AQHVtmBmfU6CbvSImkS5xZoCE5ywbqfHdPwA
Date:   Mon, 23 Dec 2019 09:10:51 +0000
Message-ID: <b2ecd22a-63b2-1da7-3ab9-5a3eb423c07a@synopsys.com>
References: <20191219113432.1229852-1-john@metanate.com>
In-Reply-To: <20191219113432.1229852-1-john@metanate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ba625a4-bc96-4961-2fca-08d7878801f9
x-ms-traffictypediagnostic: MN2PR12MB3821:
x-microsoft-antispam-prvs: <MN2PR12MB3821494E3303DA98EFAE745BA72E0@MN2PR12MB3821.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(86362001)(316002)(36756003)(71200400001)(26005)(5660300002)(8676002)(2616005)(6916009)(186003)(2906002)(478600001)(91956017)(81156014)(66946007)(76116006)(66446008)(31696002)(81166006)(66476007)(66556008)(53546011)(8936002)(6506007)(64756008)(54906003)(6486002)(4326008)(31686004)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB3821;H:MN2PR12MB4093.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdWOe1xjMiEpQj8sUFdIAxgezIvR+vQ8VuX7Z2TZiIMrUORdAaS0ctdZo0WO1+fHORavnUZBimdZYMG02BcCYdERS+g4hgRB3PyAFtlLWE00ukOPIWDp6es614sPOkiU7KdtJW8QdHsDu1NlgEZWkDEay0+jhxY9mBxf8U0ycjUYNT0Rm2/T+os6PCotktivg1M5kR+wkPjpOvDyX/vU0d8dIv21UIbS2kV9DaX/3mkHFn4GN/j51X/aJEATyANDhC+g3jpWZh+n8FyKwC3IkijJUoa1JUGD1oe2gtENPgN9Jes9ilCFsNneyX9ur/37SGQsV65L9k1hruoktLgP7Blr8Z0cbVgoMzxVGBon4jvtg3wednJCALzDKBUxaGJKvViuNXN8jInlEob8rfaH9eoI5LakAgcWjuB0ra4MF96K3GeVBIuJK0fJWr8lwazs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C665A604595EAE42A2E5DD49A3244268@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba625a4-bc96-4961-2fca-08d7878801f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 09:10:51.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOZVRb5JlPEA98DEPsMn0jYvF4DcyyMUwsVeTVJbzyO+efU1VKQZtNmQBCUaw6/bZf/B6Gt16T5mJ16yTEY4/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLzE5LzIwMTkgMzozNCBQTSwgSm9obiBLZWVwaW5nIHdyb3RlOg0KPiBPbiBjaGlw
cyB3aXRoIGZld2VyIEZJRk9zIHRoYW4gZW5kcG9pbnRzIChmb3IgZXhhbXBsZSBSSzMyODggd2hp
Y2ggaGFzIDkNCj4gZW5kcG9pbnRzLCBidXQgb25seSA2IHdoaWNoIGFyZSBjYWJhYmxlIG9mIGlu
cHV0KSwgdGhlIERQVFhGU0laTg0KPiByZWdpc3RlcnMgYWJvdmUgdGhlIEZJRk8gY291bnQgbWF5
IHJldHVybiBpbnZhbGlkIHZhbHVlcy4NCj4gDQo+IFdpdGggbG9nZ2luZyBhZGRlZCBvbiBzdGFy
dHVwLCBJIHNlZToNCj4gDQo+IAlkd2MyIGZmNTgwMDAwLnVzYjogZHdjMl9oc290Z19pbml0X2Zp
Zm86IGVwPTEgc3o9MjU2DQo+IAlkd2MyIGZmNTgwMDAwLnVzYjogZHdjMl9oc290Z19pbml0X2Zp
Zm86IGVwPTIgc3o9MTI4DQo+IAlkd2MyIGZmNTgwMDAwLnVzYjogZHdjMl9oc290Z19pbml0X2Zp
Zm86IGVwPTMgc3o9MTI4DQo+IAlkd2MyIGZmNTgwMDAwLnVzYjogZHdjMl9oc290Z19pbml0X2Zp
Zm86IGVwPTQgc3o9NjQNCj4gCWR3YzIgZmY1ODAwMDAudXNiOiBkd2MyX2hzb3RnX2luaXRfZmlm
bzogZXA9NSBzej02NA0KPiAJZHdjMiBmZjU4MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZv
OiBlcD02IHN6PTMyDQo+IAlkd2MyIGZmNTgwMDAwLnVzYjogZHdjMl9oc290Z19pbml0X2ZpZm86
IGVwPTcgc3o9MA0KPiAJZHdjMiBmZjU4MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBl
cD04IHN6PTANCj4gCWR3YzIgZmY1ODAwMDAudXNiOiBkd2MyX2hzb3RnX2luaXRfZmlmbzogZXA9
OSBzej0wDQo+IAlkd2MyIGZmNTgwMDAwLnVzYjogZHdjMl9oc290Z19pbml0X2ZpZm86IGVwPTEw
IHN6PTANCj4gCWR3YzIgZmY1ODAwMDAudXNiOiBkd2MyX2hzb3RnX2luaXRfZmlmbzogZXA9MTEg
c3o9MA0KPiAJZHdjMiBmZjU4MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD0xMiBz
ej0wDQo+IAlkd2MyIGZmNTgwMDAwLnVzYjogZHdjMl9oc290Z19pbml0X2ZpZm86IGVwPTEzIHN6
PTANCj4gCWR3YzIgZmY1ODAwMDAudXNiOiBkd2MyX2hzb3RnX2luaXRfZmlmbzogZXA9MTQgc3o9
MA0KPiAJZHdjMiBmZjU4MDAwMC51c2I6IGR3YzJfaHNvdGdfaW5pdF9maWZvOiBlcD0xNSBzej0w
DQo+IA0KPiBidXQ6DQo+IA0KPiAJIyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvZmY1ODAwMDAudXNi
L2ZpZm8NCj4gCU5vbi1wZXJpb2RpYyBGSUZPczoNCj4gCVJYRklGTzogU2l6ZSAyNzUNCj4gCU5Q
VFhGSUZPOiBTaXplIDE2LCBTdGFydCAweDAwMDAwMTEzDQo+IA0KPiAJUGVyaW9kaWMgVFhGSUZP
czoNCj4gCQlEUFRYRklGTyAxOiBTaXplIDI1NiwgU3RhcnQgMHgwMDAwMDEyMw0KPiAJCURQVFhG
SUZPIDI6IFNpemUgMTI4LCBTdGFydCAweDAwMDAwMjIzDQo+IAkJRFBUWEZJRk8gMzogU2l6ZSAx
MjgsIFN0YXJ0IDB4MDAwMDAyYTMNCj4gCQlEUFRYRklGTyA0OiBTaXplIDY0LCBTdGFydCAweDAw
MDAwMzIzDQo+IAkJRFBUWEZJRk8gNTogU2l6ZSA2NCwgU3RhcnQgMHgwMDAwMDM2Mw0KPiAJCURQ
VFhGSUZPIDY6IFNpemUgMzIsIFN0YXJ0IDB4MDAwMDAzYTMNCj4gCQlEUFRYRklGTyA3OiBTaXpl
IDAsIFN0YXJ0IDB4MDAwMDAzZTMNCj4gCQlEUFRYRklGTyA4OiBTaXplIDAsIFN0YXJ0IDB4MDAw
MDAzYTMNCj4gCQlEUFRYRklGTyA5OiBTaXplIDI1NiwgU3RhcnQgMHgwMDAwMDEyMw0KPiANCj4g
c28gaXQgc2VlbXMgdGhhdCBGSUZPIDkgaXMgbWlycm9yaW5nIEZJRk8gMS4NCj4gDQo+IEZpeCB0
aGUgYWxsb2NhdGlvbiBieSB1c2luZyB0aGUgRklGTyBjb3VudCBpbnN0ZWFkIG9mIHRoZSBlbmRw
b2ludCBjb3VudA0KPiB3aGVuIHNlbGVjdGluZyBhIEZJRk8gZm9yIGFuIGVuZHBvaW50Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSm9obiBLZWVwaW5nIDxqb2huQG1ldGFuYXRlLmNvbT4NCj4gLS0t
DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5bm9wc3lzLmNvbT4NCg0K
PiAgIGRyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MyL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBpbmRl
eCA5MmU4ZGU5Y2I0NWMuLjkxMWI5NTBlZjI1ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMi9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IEBAIC00
MDU5LDExICs0MDU5LDEyIEBAIHN0YXRpYyBpbnQgZHdjMl9oc290Z19lcF9lbmFibGUoc3RydWN0
IHVzYl9lcCAqZXAsDQo+ICAgCSAqIGEgdW5pcXVlIHR4LWZpZm8gZXZlbiBpZiBpdCBpcyBub24t
cGVyaW9kaWMuDQo+ICAgCSAqLw0KPiAgIAlpZiAoZGlyX2luICYmIGhzb3RnLT5kZWRpY2F0ZWRf
Zmlmb3MpIHsNCj4gKwkJdW5zaWduZWQgZmlmb19jb3VudCA9IGR3YzJfaHNvdGdfdHhfZmlmb19j
b3VudChoc290Zyk7DQo+ICAgCQl1MzIgZmlmb19pbmRleCA9IDA7DQo+ICAgCQl1MzIgZmlmb19z
aXplID0gVUlOVF9NQVg7DQo+ICAgDQo+ICAgCQlzaXplID0gaHNfZXAtPmVwLm1heHBhY2tldCAq
IGhzX2VwLT5tYzsNCj4gLQkJZm9yIChpID0gMTsgaSA8IGhzb3RnLT5udW1fb2ZfZXBzOyArK2kp
IHsNCj4gKwkJZm9yIChpID0gMTsgaSA8PSBmaWZvX2NvdW50OyArK2kpIHsNCj4gICAJCQlpZiAo
aHNvdGctPmZpZm9fbWFwICYgKDEgPDwgaSkpDQo+ICAgCQkJCWNvbnRpbnVlOw0KPiAgIAkJCXZh
bCA9IGR3YzJfcmVhZGwoaHNvdGcsIERQVFhGU0laTihpKSk7DQo+IA0K
