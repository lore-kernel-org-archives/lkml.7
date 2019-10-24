Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213EBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EBF20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JRaspS+8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="N4ufjp4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389972AbfJXJsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:48:52 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:59478 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730318AbfJXJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:48:52 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D94BAC0C3C;
        Thu, 24 Oct 2019 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571910531; bh=vqymZi07lX4tTN+Un/XJwrwInG0vEKloyVoO/PcgCkg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JRaspS+8wQcPjD4NnriWztpVjxMrJXBidIfuV50nnfz+bSJ2kc7ettKmudywVMDT1
         VqZKwolQYNbYQI2oIvR78R9863V7Z38NYzmFfHlGJvSH4/1dSEl5eGTG5T7uZMDeqp
         gqbNNfHn64WepoUDZuYC2qZ3WbaC3MuM/EoWthp8TP7qfOiJpO5dhtJS3cgxJJWFKH
         cX3iPFZLY9hhW+Ha+f1In8Ee8Lx4ZmJmUau6IkfkKS4VfOSIBVWAIrCdaJBsYJESCf
         doSG3uVyKQn8BE6EfKwqG/a4cK2SDnXH3URiL17nHrdMu1CG+eYmevuy8VizGvwN+o
         GK2Zybq9ZxzRw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B8B64A006B;
        Thu, 24 Oct 2019 09:48:44 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Oct 2019 02:47:49 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 24 Oct 2019 02:47:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLbO637rUBRvq2kUxMpcHDtS7KGg/meTxUYCspr04cWp/D6G+TyPhGrYVU3tJgJkJRjAmWOoW7zg7UOHCQNXZ4oEbXyhHOXljqWZbINIspghbo2+8XOD9/UqXTNCQtmpRztWQV6q/H58lxOQyqoQQFTMGtB6v2bAYBPZ6KzkZ3Sp/ppKumBq3BwlzuTf1K7Aba6r9bM/edsWjqkyHZSO5k31XQ3NJpIrETXMObl2gFsYHc6wW90dy1gH9Ezo8n4dkdtQZhvwoqEeavFW/xlmI44mUusOjNtt8dfTLE7k4ySOE2UfocuC5WJfMvhQVinV2eRQzNKcuJNIKFXlp4he8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqymZi07lX4tTN+Un/XJwrwInG0vEKloyVoO/PcgCkg=;
 b=Dh+CaD2TRO2qGebnxh7lk1ddVus4WDxYSc2xR4RLRJ7vG7Wh6rtgM64mExlG665AYWzE8Eau6KNdBdbpPmgdrB0WCoFALrHC7Eb+sQTo1eOUkF2YRPh5QIFKCAwm0SqFyXr1fAiOcpJVvSRqR0g5p9WI9og9CFDGOVb8Eb9oTG02wMFcbAwDTbjthfIStkitfRebe9A3zZR5Q17DJVx7/+HsPCBJWHx+uaZFnN1FaoveTvRF4y1TykwwsxRd39hHSt2eVCxhOoeAETMMjdXrdlqpDIZ1IRFv7kM9d7FjCT1YDa8f/R3ETlXTQYJwz4pIa1gYNNqtUAw6mNdDeB6uCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqymZi07lX4tTN+Un/XJwrwInG0vEKloyVoO/PcgCkg=;
 b=N4ufjp4idxxNDOxyDtm/4doqg5InCtarCjTSpGY2v0o2MiGIA8qhyCPkf6aXweZlGr2JiMpmIhJtHA5QFvM0vKUni2FWxFrz967pyQOdRXXn8Dsa2m2IxO4tArqbPtbsHYO775W2pXRiUKwIxpB5zq6gt08GY5t6Sy2P66TLDtU=
Received: from CH2PR12MB4088.namprd12.prod.outlook.com (20.180.5.200) by
 CH2PR12MB4311.namprd12.prod.outlook.com (20.180.6.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 09:48:20 +0000
Received: from CH2PR12MB4088.namprd12.prod.outlook.com
 ([fe80::a499:32d2:91a1:1715]) by CH2PR12MB4088.namprd12.prod.outlook.com
 ([fe80::a499:32d2:91a1:1715%6]) with mapi id 15.20.2367.025; Thu, 24 Oct 2019
 09:48:20 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "mka@chromium.org" <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc2: Fix NULL qh in dwc2_queue_transaction
Thread-Topic: [PATCH v2] usb: dwc2: Fix NULL qh in dwc2_queue_transaction
Thread-Index: AQHVieX3H84sjbtrEUOt2I85DdzzGadpjIiA
Date:   Thu, 24 Oct 2019 09:48:20 +0000
Message-ID: <bcd6d6ff-2b62-c73d-03ea-ed103d01d026@synopsys.com>
References: <20191023140530.v2.1.I9850aab29e945168070b0a9c50c421d5485e7d97@changeid>
In-Reply-To: <20191023140530.v2.1.I9850aab29e945168070b0a9c50c421d5485e7d97@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [92.123.244.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f855e89e-8ae7-4112-6fb7-08d758674df0
x-ms-traffictypediagnostic: CH2PR12MB4311:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <CH2PR12MB4311DFA58FE80C88F7B54772A76A0@CH2PR12MB4311.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:156;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(71200400001)(71190400001)(486006)(476003)(31686004)(6512007)(6306002)(478600001)(31696002)(86362001)(6436002)(6486002)(229853002)(2906002)(36756003)(6116002)(3846002)(11346002)(256004)(14444005)(446003)(2616005)(5660300002)(66556008)(65806001)(65956001)(66946007)(66066001)(66476007)(99286004)(110136005)(54906003)(8676002)(8936002)(66446008)(81166006)(7736002)(305945005)(76116006)(966005)(91956017)(81156014)(64756008)(14454004)(4326008)(316002)(102836004)(26005)(76176011)(186003)(53546011)(6506007)(58126008)(25786009)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB4311;H:CH2PR12MB4088.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9r52e5+JbPI/FkQJV4ZM50yG/hZsLZKV7318Xs+8R7e0jXg84boscDqzBmLxQj5TIbjpquhcwnQgpuJZsLbhHYBra1ouhx1xUHKDfk4WkojeG3kHfRqBj9tbINf3GVamAB7WGR5l3ISUuueawRxDFITs67i9njL+Ij4ioMZbKpcrOopt6JrA38WrMnuuaKhl2BaAGpNQEfttVIkkFRMzoVMf37UolPDeYLnPThLU63nzknFTini5eYu1KedM5ywyL9PqE6XFMxvIW7hj1FsFOdc2JHRA/lWdxyOHL+EIlqykfe+u4DcwQSsopY1TQRrqFRMGkZwFb/eMnTknyTlWk6+hgoAHaIT+GXAzUimHOIIPHbYDka7tB+zH3iE+q9OOAliSVmA/AZ1N493EmHxjIp60gNGUsxXm/QZo0ly56m5YoLWLLQkJcD1ARbYGdc4iaDKpdGimdyNxAFN8q8v+j0yFY4GWNj9d7jiiw/EGN4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDF7DCB2DCE30A4880A9087654969F83@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f855e89e-8ae7-4112-6fb7-08d758674df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 09:48:20.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlwoQpwfNJd4Yjpy6wtSZ65Quj1IG/JLbW796eBdkDGUHyKMXkrUv/XYaP3DbLi5Av0I3myaaZatCofdrw9QWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI0LzIwMTkgMTowNiBBTSwgRG91Z2xhcyBBbmRlcnNvbiB3cm90ZToNCj4gRnJv
bTogQWxleGFuZHJ1IE0gU3RhbiA8YW1zdGFuQGNocm9taXVtLm9yZz4NCj4gDQo+IFdoZW4gYSB1
c2IgZGV2aWNlIGRpc2Nvbm5lY3RzIGluIGEgY2VydGFpbiB3YXksIGR3YzJfcXVldWVfdHJhbnNh
Y3Rpb24NCj4gc3RpbGwgZ2V0cyBjYWxsZWQgYWZ0ZXIgZHdjMl9oY2RfY2xlYW51cF9jaGFubmVs
cy4NCj4gDQo+IGR3YzJfaGNkX2NsZWFudXBfY2hhbm5lbHMgZG9lcyAiY2hhbm5lbC0+cWggPSBO
VUxMOyIgYnV0DQo+IGR3YzJfcXVldWVfdHJhbnNhY3Rpb24gc3RpbGwgd2FudHMgdG8gZGVyZWZl
cmVuY2UgcWguDQo+IFRoaXMgYWRkcyBhIGNoZWNrIGZvciBhIG51bGwgcWguDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgTSBTdGFuIDxhbXN0YW5AY2hyb21pdW0ub3JnPg0KPiBbZGlh
bmRlcnM6IHJlYmFzZWQgdG8gbWFpbmxpbmVdDQo+IFNpZ25lZC1vZmYtYnk6IERvdWdsYXMgQW5k
ZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4NCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVu
eWFuIDxobWluYXNAc3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiBXaGlsZSB0ZXN0aW5nIGEgbmV3
ZXIgdmVyc2lvbiBvZiB0aGUgTGludXgga2VybmVsIG9uIHJrMzI4OC12ZXlyb24NCj4gZGV2aWNl
cyB3ZSBzYXcgYSBidW5jaCBvZiBjcmFzaGVzIHJlcG9ydGVkIGluIGR3YzJfcXVldWVfdHJhbnNh
Y3Rpb24oKQ0KPiB3aGVyZSBjaGFuLT5xaCB3YXMgTlVMTCBbMV0uICBJIGRvbid0IGtub3cgaG93
IHRvIHJlcHJvZHVjZSB0aG9zZQ0KPiBjcmFzaGVzIG15c2VsZiwgYnV0IEkgbm90aWNlZCB0aGF0
IGluIG91ciAzLjE0IGtlcm5lbCB3ZSBoYWQgYSBwYXRjaA0KPiB0aGF0IHByb2JhYmx5IGZpeGVk
IGl0LiAgVGhhdCBwYXRjaCB3YXMgc2VudCB1cHN0cmVhbSBhZ2VzIGFnbyBbMl0gYnV0DQo+IG5l
dmVyIGxhbmRlZC4gIEhlcmUgSSd2ZSByZWJhc2VkIHRoZSBwYXRjaC4gIFdoaWxlIEkgaGF2ZW4n
dA0KPiByZXByb2R1Y2VkIHRoZSBjcmFzaCBteXNlbGYsIGl0IHNlZW1zIGZhaXJseSBsaWtlbHkg
dGhhdCB0aGlzIHdpbGwgZml4DQo+IHRoZSBwcm9ibGVtLg0KPiANCj4gWzFdIGh0dHBzOi8vdXJs
ZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fY3JidWcuY29tXzEwMTcz
ODgmZD1Ed0lEQVEmYz1EUEw2X1hfNkprWEZ4N0FYV3FCMHRnJnI9Y1FCS3Q0cS1xek5WQzUzck5B
d3V3cGxIMjNWNjFySFFoaFVMdmRMQTBVOCZtPWNub3pUbHkxRHRJMDFwWjR3YndFR1NRVzNUdENz
aXdhTlV5NXNuNXZnMHcmcz03Yk9XMUZUZWxRRUpuWmVySVdIV29zSUJpWVQ2ZHZ3YnNtWVRyWXl6
S2ZBJmU9DQo+IFsyXSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9
aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19yXzE0NDI5NTI2NTEtMkQ0MzQxLTJEMi0yRGdpdC0y
RHNlbmQtMkRlbWFpbC0yRGFtc3Rhbi00MGNocm9taXVtLm9yZyZkPUR3SURBUSZjPURQTDZfWF82
SmtYRng3QVhXcUIwdGcmcj1jUUJLdDRxLXF6TlZDNTNyTkF3dXdwbEgyM1Y2MXJIUWhoVUx2ZExB
MFU4Jm09Y25velRseTFEdEkwMXBaNHdid0VHU1FXM1R0Q3Npd2FOVXk1c241dmcwdyZzPXZtWmpG
Vlduc0ZQVTZTZ3h3NUlwSi1OWUlBYkRxeVcwaXRKeTAwTUxZU3MmZT0NCj4gDQo+IENoYW5nZXMg
aW4gdjI6DQo+IC0gUmViYXNlZCB0byBtYWlubGluZQ0KPiANCj4gICBkcml2ZXJzL3VzYi9kd2My
L2hjZC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMgYi9kcml2
ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IGluZGV4IDgxYWZlNTUzYWE2Ni4uYjkwZjg1OGFmOTYwIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzIvaGNkLmMNCj4gQEAgLTI4MjQsNyArMjgyNCw3IEBAIHN0YXRpYyBpbnQgZHdjMl9xdWV1
ZV90cmFuc2FjdGlvbihzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsDQo+ICAgCQlsaXN0X21vdmVf
dGFpbCgmY2hhbi0+c3BsaXRfb3JkZXJfbGlzdF9lbnRyeSwNCj4gICAJCQkgICAgICAgJmhzb3Rn
LT5zcGxpdF9vcmRlcik7DQo+ICAgDQo+IC0JaWYgKGhzb3RnLT5wYXJhbXMuaG9zdF9kbWEpIHsN
Cj4gKwlpZiAoaHNvdGctPnBhcmFtcy5ob3N0X2RtYSAmJiBjaGFuLT5xaCkgew0KPiAgIAkJaWYg
KGhzb3RnLT5wYXJhbXMuZG1hX2Rlc2NfZW5hYmxlKSB7DQo+ICAgCQkJaWYgKCFjaGFuLT54ZmVy
X3N0YXJ0ZWQgfHwNCj4gICAJCQkgICAgY2hhbi0+ZXBfdHlwZSA9PSBVU0JfRU5EUE9JTlRfWEZF
Ul9JU09DKSB7DQo+IA0K
