Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F400C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0F4217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDKJNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:13:52 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:47553 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:13:52 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3B9DZe2013554
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Apr 2019 18:13:35 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3B9DZ51015426;
        Thu, 11 Apr 2019 18:13:35 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3B99eWv007463;
        Thu, 11 Apr 2019 18:13:35 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-4202875; Thu, 11 Apr 2019 18:13:04 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Thu,
 11 Apr 2019 18:13:03 +0900
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
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqAgACP04CAAAH9AIAABdcAgAAJ5YA=
Date:   Thu, 11 Apr 2019 09:13:03 +0000
Message-ID: <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
In-Reply-To: <20190411083738.GC30080@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <50D1F48D00732841994A423F797DD49D@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xMS8xOSA1OjM3IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIFRodSwgQXBy
IDExLCAyMDE5IGF0IDA4OjE2OjQ1QU0gKzAwMDAsIEp1bmljaGkgTm9tdXJhIHdyb3RlOg0KPj4g
a2V4ZWNfZ2V0X3JzZHBfYWRkcigpIG1pZ2h0IGZhaWwgb24ga2V4ZWMtYm9vdGVkIGtlcm5lbCwg
ZS5nLiBpZiB0aGUNCj4+IHNldHVwX2RhdGEgd2FzIGludmFsaWQuIEluIHN1Y2ggYSBjYXNlLCBm
YWxsaW5nIGJhY2sgdG8gZWZpX2dldF9yc2RwX2FkZHIoKQ0KPj4gd2lsbCBoaXQgdGhlIHByb2Js
ZW0gb2YgYWNjZXNzaW5nIGludmFsaWQgdGFibGUgcG9pbnRlciBhZ2Fpbi4NCj4gDQo+IFRoZW4g
eW91IG5lZWQgdG8gZG8gdGhpczoNCj4gDQo+IAlpZiAoa2V4ZWNlZCBrZXJuZWwpIHsNCj4gCQlh
ZGRyID0ga2V4ZWNfZ2V0X3JzZHBfYWRkcigpOw0KPiAJCWlmICghYWRkcikgew0KPiAJCQkvKiBj
YW5ub3QgZ2V0IGFkZHJlc3MgKi8NCj4gCQkJcmV0dXJuIC0xOw0KPiAJCX0NCj4gDQo+IAkJcmV0
dXJuIGFkZHI7DQo+IAl9DQo+IA0KPiBhbmQgdGhlIGNhbGxpbmcgZnVuY3Rpb24gZ2V0X3JzZHBf
YWRkcigpIG11c3QgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBhbmQNCj4gaWYgaXQgaXMgbm90IDAs
IHJldHVybiBpbW1lZGlhdGVseS4NCg0KRG8geW91IG1lYW4gbWFraW5nIGdldF9yc2RwX2FkZHIo
KSBsaWtlIHRoaXM/DQoNCmFjcGlfcGh5c2ljYWxfYWRkcmVzcyBnZXRfcnNkcF9hZGRyKHZvaWQp
DQp7DQogICAgICAgIGFjcGlfcGh5c2ljYWxfYWRkcmVzcyBwYTsNCisgICAgICAgc3RydWN0IGVm
aV9zZXR1cF9kYXRhICplc2Q7DQoNCiAgICAgICAgcGEgPSBnZXRfYWNwaV9yc2RwKCk7DQoNCiAg
ICAgICAgaWYgKCFwYSkNCiAgICAgICAgICAgICAgICBwYSA9IGJvb3RfcGFyYW1zLT5hY3BpX3Jz
ZHBfYWRkcjsNCg0KKyAgICAgICBlc2QgPSAoc3RydWN0IGVmaV9zZXR1cF9kYXRhICopIGVmaV9n
ZXRfa2V4ZWNfc2V0dXBfZGF0YV9hZGRyKCk7DQorICAgICAgIGlmIChlc2QpDQorCQlyZXR1cm4g
a2V4ZWNfZ2V0X3JzZHBfYWRkcihlc2QpOw0KDQogICAgICAgIGlmICghcGEpDQogICAgICAgICAg
ICAgICAgcGEgPSBlZmlfZ2V0X3JzZHBfYWRkcigpOw0KDQoNCg0KLS0gDQpKdW4naWNoaSBOb211
cmEsIE5FQyBDb3Jwb3JhdGlvbiAvIE5FQyBTb2x1dGlvbiBJbm5vdmF0b3JzLCBMdGQu

