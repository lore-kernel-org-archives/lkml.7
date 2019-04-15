Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BCD206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfDOHC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:02:59 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:43619 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:02:59 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3F72PG3009623
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Apr 2019 16:02:25 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3F72Pxr010478;
        Mon, 15 Apr 2019 16:02:25 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3F70Msx012625;
        Mon, 15 Apr 2019 16:02:25 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-4293140; Mon, 15 Apr 2019 16:01:55 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Mon,
 15 Apr 2019 16:01:54 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqAgACP04CAAAH9AIAABdcAgAAJ5YCAAAJaAIAAAziAgAACJICAADc+AIAA6YwAgABjYACAAE/IgIAESQcA
Date:   Mon, 15 Apr 2019 07:01:54 +0000
Message-ID: <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
References: <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
 <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
In-Reply-To: <20190412133528.GD19808@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <94E790B68FB193469C00239E878FC0EC@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xMi8xOSAxMDozNSBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBGcmksIEFw
ciAxMiwgMjAxOSBhdCAxMDo0OTo1NkFNICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+
PiBOb3cgSSBuZWVkIHRvIGdvIGZpZ3VyZSBvdXQgd2hldGhlciB0aGVyZSdzIGEgcmVsaWFibGUg
d2F5IHRvIGtub3cgaW4NCj4+IHRoZSBrZXhlYyBrZXJuZWwgdGhhdCBpdCAqaXMqIGEga2V4ZWMg
a2VybmVsLg0KPiANCj4gQWN0dWFsbHksIHRoaW5raW5nIGFib3V0IHRoaXMgbW9yZSwgd2UgZG9u
J3QgbmVlZCB0byBrbm93IHdoZXRoZXIgdGhlDQo+IGtlcm5lbCB3YXMga2V4ZWNlZCBvciBub3Qu
IFdoeT8NCj4gDQo+IEJlY2F1c2UgaWYgaXQgaXMga2V4ZWMnZWQsIGtleGVjKDEpIHBhc3NlcyB0
aGUgcmVxdWlyZWQgaW5mbyBpbg0KPiBzZXR1cF9kYXRhLiBOb3csIGlmIGZvciB3aGF0ZXZlciBy
ZWFzb24gdGhlIGtleGVjJ2VkIGtlcm5lbCBmYWlscyB0bw0KPiBwYXJzZSB0aGF0IEVGSSBpbmZv
IGFuZCBnZXQgdGhlIHN5c3RhYiB0byBmaWd1cmUgb3V0IHRoZSBSRFNQLCB0aGVuIGl0DQo+IGRv
ZXNuJ3QgaGF2ZSBhbnkgb3RoZXIgY2hvaWNlIGJ1dCBmYWlsIGJvb3RpbmcuDQo+IA0KPiBCZWNh
dXNlIHRoZXJlJ3Mgbm8gd2F5IGl0IGNhbiBmaWd1cmUgb3V0IHdoZXJlIHRoZSBFRkkgcnVudGlt
ZSBoYXMgYmVlbg0KPiBtYXBwZWQgYW5kIHJlY292ZXIgYnkgZmluZGluZyB0aGUgUkRTUCBmcm9t
IHRoZXJlLg0KPiANCj4gU28gSSB0aGluayB3ZSdyZSBwZXJmZWN0bHkgZmluZSB3aXRoIHRoZSBv
bGQgYXBwcm9hY2g6DQo+IA0KPiAgICAgICAgIGlmICghcGEpDQo+ICAgICAgICAgICAgICAgICBw
YSA9IGtleGVjX2dldF9yc2RwX2FkZHIoKTsNCj4gDQo+ICAgICAgICAgaWYgKCFwYSkNCj4gICAg
ICAgICAgICAgICAgIHBhID0gZWZpX2dldF9yc2RwX2FkZHIoKTsNCg0KT0suIFRoZW4gSSdsbCBn
byBiYWNrIHRvIHYzIGFuZCBtYWtlIHN1cmUgdG8gaGFuZyB3aGVuDQpzb21ldGhpbmcgaXMgd3Jv
bmcgZHVyaW5nIGtleGVjIGJvb3Qgb24gRUZJIHN5c3RlbS4NCg0KLS0gDQpKdW4naWNoaSBOb211
cmEsIE5FQyBDb3Jwb3JhdGlvbiAvIE5FQyBTb2x1dGlvbiBJbm5vdmF0b3JzLCBMdGQu

