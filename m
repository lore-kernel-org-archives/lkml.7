Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5598C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC962081E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAHCCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:02:03 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2555 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgAHCCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:02:03 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id EC7F51C574EDD228C64A;
        Wed,  8 Jan 2020 10:01:59 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0439.000;
 Wed, 8 Jan 2020 10:01:53 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Thread-Topic: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Thread-Index: AQHVwRzFqRRtqHdXdESmtZr5m5x/BafdeacAgAD0jOCAAEGigIABXL6g
Date:   Wed, 8 Jan 2020 02:01:53 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340B85A4@dggemm526-mbx.china.huawei.com>
References: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
 <14a39167-5704-f406-614d-4d25b8fe8c68@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340B5552@dggemm526-mbx.china.huawei.com>
 <0bd0e87b-e1ad-79a4-d820-f234ec6960fa@arm.com>
In-Reply-To: <0bd0e87b-e1ad-79a4-d820-f234ec6960fa@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEaWV0bWFyIEVnZ2VtYW5uIFtt
YWlsdG86ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5
IDA3LCAyMDIwIDk6MTIgUE0NCj4gVG86IFplbmd0YW8gKEIpOyBzdWRlZXAuaG9sbGFAYXJtLmNv
bQ0KPiBDYzogTGludXhhcm07IEdyZWcgS3JvYWgtSGFydG1hbjsgUmFmYWVsIEouIFd5c29ja2k7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
Y3B1LXRvcG9sb2d5OiBTa2lwIHRoZSBleGlzdCBidXQgbm90IHBvc3NpYmxlIGNwdQ0KPiBub2Rl
cw0KPiANCj4gT24gMDcvMDEvMjAyMCAwMjozNSwgWmVuZ3RhbyAoQikgd3JvdGU6DQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IERpZXRtYXIgRWdnZW1hbm4gW21h
aWx0bzpkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb21dDQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEphbnVh
cnkgMDcsIDIwMjAgMjo0MiBBTQ0KPiA+PiBUbzogWmVuZ3RhbyAoQik7IHN1ZGVlcC5ob2xsYUBh
cm0uY29tDQo+ID4+IENjOiBMaW51eGFybTsgR3JlZyBLcm9haC1IYXJ0bWFuOyBSYWZhZWwgSi4g
V3lzb2NraTsNCj4gPj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBjcHUtdG9wb2xvZ3k6IFNraXAgdGhlIGV4aXN0IGJ1dCBub3QgcG9zc2li
bGUgY3B1DQo+ID4+IG5vZGVzDQo+ID4+DQo+ID4+IE9uIDAyLzAxLzIwMjAgMDQ6MjQsIFplbmcg
VGFvIHdyb3RlOg0KPiA+Pj4gV2hlbiBDT05GSUdfTlJfQ1BVUyBpcyBzbWFsbGVyIHRoYW4gdGhl
IGNwdSBub2RlcyBkZWZpbmVkIGluIHRoZQ0KPiA+PiBkZXZpY2UNCj4gPj4+IHRyZWUsIHRoZSBj
cHUgbm9kZSBwYXJzaW5nIHdpbGwgZmFpbC4gQW5kIHRoaXMgaXMgbm90IHJlYXNvbmFibGUgZm9y
IGENCj4gPj4+IGxlZ2FsIGRldmljZSB0cmVlIGNvbmZpZ3MuDQo+ID4+PiBJbiB0aGlzIHBhdGNo
LCBza2lwIHN1Y2ggY3B1IG5vZGVzIHJhdGhlciB0aGFuIHJldHVybiBhbiBlcnJvci4NCj4gPj4N
Cj4gPj4gSXMgdGhpcyBleHRyYSBjb2RlIHJlYWxseSBuZWNlc3Nhcnk/DQo+ID4+DQo+ID4+IEN1
cnJlbnRseSB5b3UgZ2V0IHdhcm5pbmdzIGluZGljYXRpbmcgdGhhdCBDT05GSUdfTlJfQ1BVUyBp
cyB0b28NCj4gc21hbGwNCj4gPj4gc28geW91IGNvdWxkIGNvcnJlY3QgdGhlIHNldHVwIGlzc3Vl
IGVhc2lseS4NCj4gPj4NCj4gPg0KPiA+IE5vdCBvbmx5IGFib3V0IHdhcm5pbmcgbWVzc2FnZXMs
IHRoZSBwcm9ibGVtIGlzIDoNCj4gPiBXaGF0IHdlIGFyZSBleHBlY3RlZCB0byBkbyBpZiB0aGUg
Q09ORklHX05SX0NQVVMgaXMgdG9vIHNtYWxsPyBJIHRoaW5rDQo+IHRoZXJlDQo+ID4gYXJlIHR3
byBjaG9pY2VzOg0KPiA+IDEuIEtlZXAgdGhlIGR0cyBwYXJzaW5nIHJlc3VsdCwgYnV0IHNraXAg
dGhlIHRoZSBDUFUgbm9kZXMgd2hvc2UgaWQNCj4gZXhjZWVkcyB0aGUNCj4gPiB0aGUgQ09ORklH
X05SX0NQVVMsIGFuZCB0aGlzIGlzIHdoYXQgdGhpcyBwYXRjaCBkby4NCj4gPiAyLiBKdXN0IGFi
b3J0IGFsbCB0aGUgQ1BVIG5vZGVzIHBhcnNpbmcsIGFuZCB1c2luZyBNUElEUiB0byBndWVzcyB0
aGUNCj4gdG9wb2xvZ3ksDQo+ID4gYW5kIHRoaXMgaXMgd2hhdCB0aGUgY3VycmVudCBjb2RlIGRv
Lg0KPiANCj4gQWgsIHlvdSdyZSByZWZlcnJpbmcgdG86DQo+IA0KPiA1MzAgdm9pZCBfX2luaXQg
aW5pdF9jcHVfdG9wb2xvZ3kodm9pZCkNCj4gNTMxIHsNCj4gLi4uDQo+IDU0MCAgICAgICAgIGVs
c2UgaWYgKG9mX2hhdmVfcG9wdWxhdGVkX2R0KCkgJiYgcGFyc2VfZHRfdG9wb2xvZ3koKSkNCj4g
NTQxIC0tPiAgICAgICAgICAgICByZXNldF9jcHVfdG9wb2xvZ3koKTsNCj4gDQo+IFdpdGggbXkg
SnVubyBleGFtcGxlICg2IENwdXMgaW4gRFQgYnV0IENPTkZJR19OUl9DUFVTPTQpOg0KPiANCj4g
cm9vdEBqdW5vOn4jIGRtZXNnIHwgZ3JlcCAiXCpcKlx8bXBpZHIiDQo+IFsgICAgMC4wODQ3NjBd
ICoqIGdldF9jcHVfZm9yX25vZGUoKSBjcHU9MQ0KPiBbICAgIDAuMDg4NzA2XSAqKiBnZXRfY3B1
X2Zvcl9ub2RlKCkgY3B1PTINCj4gWyAgICAwLjA5MjU5Ml0gKiogZ2V0X2NwdV9mb3Jfbm9kZSgp
IGNwdT0wDQo+IFsgICAgMC4wOTY1NTBdICoqIGdldF9jcHVfZm9yX25vZGUoKSBjcHU9Mw0KPiBb
ICAgIDAuMTA1NTc4XSAqKiBnZXRfY3B1X2Zvcl9ub2RlKCkgY3B1PS0xOQ0KPiBbICAgIDAuMTE2
MDcwXSAqKiBzdG9yZV9jcHVfdG9wb2xvZ3koKTogY3B1aWQ9MA0KPiBbICAgIDAuMTIwMzU1XSBD
UFUwOiBjbHVzdGVyIDEgY29yZSAwIHRocmVhZCAtMSBtcGlkciAweDAwMDAwMDgwMDAwMTAwDQo+
IFsgICAgMC4yNDI0NjVdICoqIHN0b3JlX2NwdV90b3BvbG9neSgpOiBjcHVpZD0xDQo+IFsgICAg
MC4yNDI0NzFdIENQVTE6IGNsdXN0ZXIgMCBjb3JlIDAgdGhyZWFkIC0xIG1waWRyIDB4MDAwMDAw
ODAwMDAwMDANCj4gWyAgICAwLjI4NjUwNV0gKiogc3RvcmVfY3B1X3RvcG9sb2d5KCk6IGNwdWlk
PTINCj4gWyAgICAwLjI4NjUxMF0gQ1BVMjogY2x1c3RlciAwIGNvcmUgMSB0aHJlYWQgLTEgbXBp
ZHIgMHgwMDAwMDA4MDAwMDAwMQ0KPiBbICAgIDAuMzMwNjMxXSAqKiBzdG9yZV9jcHVfdG9wb2xv
Z3koKTogY3B1aWQ9Mw0KPiBbICAgIDAuMzMwNjM3XSBDUFUzOiBjbHVzdGVyIDEgY29yZSAxIHRo
cmVhZCAtMSBtcGlkciAweDAwMDAwMDgwMDAwMTAxDQo+IA0KPiBhbmQgd2l0aCB5b3VyIHBhdGNo
Og0KPiANCj4gcm9vdEBqdW5vOn4jIGRtZXNnIHwgZ3JlcCAiXCpcKlx8bXBpZHIiDQo+IFsgICAg
MC4wODQ3NzhdICoqIGdldF9jcHVfZm9yX25vZGUoKSBjcHU9MQ0KPiBbICAgIDAuMDg4NzQyXSAq
KiBnZXRfY3B1X2Zvcl9ub2RlKCkgY3B1PTINCj4gWyAgICAwLjA5MjY2Ml0gKiogZ2V0X2NwdV9m
b3Jfbm9kZSgpIGNwdT0wDQo+IFsgICAgMC4wOTY2MjddICoqIGdldF9jcHVfZm9yX25vZGUoKSBj
cHU9Mw0KPiBbICAgIDAuMTA3OTQyXSAqKiBnZXRfY3B1X2Zvcl9ub2RlKCkgY3B1PS0xOQ0KPiBb
ICAgIDAuMTE5NDI5XSAqKiBnZXRfY3B1X2Zvcl9ub2RlKCkgY3B1PS0xOQ0KPiBbICAgIDAuMTIz
NDYxXSAqKiBzdG9yZV9jcHVfdG9wb2xvZ3koKTogY3B1aWQ9MA0KPiBbICAgIDAuMjQzNTcxXSAq
KiBzdG9yZV9jcHVfdG9wb2xvZ3koKTogY3B1aWQ9MQ0KPiBbICAgIDAuMjg3NjEwXSAqKiBzdG9y
ZV9jcHVfdG9wb2xvZ3koKTogY3B1aWQ9Mg0KPiBbICAgIDAuMzMxNzM3XSAqKiBzdG9yZV9jcHVf
dG9wb2xvZ3koKTogY3B1aWQ9Mw0KPiANCj4gc28gd2UgYmFpbCBvdXQgb2Ygc3RvcmVfY3B1X3Rv
cG9sb2d5KCkgc2luY2UgJ2NwdWlkX3RvcG8tPnBhY2thZ2VfaWQgIT0NCj4gLTEnLg0KPiANCg0K
R29vZCwgeW91IGdvdCBtZS4gQW5kIEkgZm91bmQgdGhpcyBpc3N1ZSB3aGVuIEkgdGVzdCB0aGUg
TlVNQSBpc3N1ZS4NClRoYW5rcy4NCg0KPiA+IEFuZCBpIHRoaW5rIGNob2ljZSAxIGlzIGJldHRl
ciBiZWNhdXNlOg0KPiA+IDEuIEl0J3MgYSBsZWdhbCBkdHMsIHdlIHNob3VsZCBrZWVwIHRoZSBz
YW1lIHJlc3VsdCB3aGV0aGVyDQo+IENPTkZJR19OUl9DUFVTIGlzDQo+ID4gdG9vIHNtYWxsIG9y
IG5vdC4NCj4gPiAyLiBJbiB0aGUgZnVuY3Rpb24gb2ZfcGFyc2VfYW5kX2luaXRfY3B1cywgd2Ug
anVzdCBkbyB0aGUgc2FtZSB3YXkgYXMNCj4gY2hvaWNlIDEuDQo+ID4NCj4gPiBCdXQgaSBhbSBv
cGVuIGZvciB0aGUgaXNzdWUsIGFueSBzdWdnZXN0aW9ucyBhcmUgd2VsY29tZWQuDQo+IA0KPiBb
Li4uXQ0K
