Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B6C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5889020850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDKJd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:33:28 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:52194 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfDKJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:33:27 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3B9XDUk029154
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Apr 2019 18:33:13 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3B9XDp0031676;
        Thu, 11 Apr 2019 18:33:13 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3B9WSae023303;
        Thu, 11 Apr 2019 18:33:13 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-4203798; Thu, 11 Apr 2019 18:33:01 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Thu,
 11 Apr 2019 18:33:00 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Boris Petkov <bp@alien8.de>
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
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqAgACP04CAAAH9AIAABdcAgAAJ5YCAAAJaAIAAAziA
Date:   Thu, 11 Apr 2019 09:32:59 +0000
Message-ID: <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
 <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
In-Reply-To: <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD781517903E8748BAA9ACA21ED95C78@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xMS8xOSA2OjIxIFBNLCBCb3JpcyBQZXRrb3Ygd3JvdGU6DQo+IE9uIEFwcmlsIDExLCAy
MDE5IDExOjEzOjAzIEFNIEdNVCswMjowMCwgSnVuaWNoaSBOb211cmEgPGotbm9tdXJhQGNlLmpw
Lm5lYy5jb20+IHdyb3RlOg0KPj4gT24gNC8xMS8xOSA1OjM3IFBNLCBCb3Jpc2xhdiBQZXRrb3Yg
d3JvdGU6DQo+Pj4gT24gVGh1LCBBcHIgMTEsIDIwMTkgYXQgMDg6MTY6NDVBTSArMDAwMCwgSnVu
aWNoaSBOb211cmEgd3JvdGU6DQo+Pj4+IGtleGVjX2dldF9yc2RwX2FkZHIoKSBtaWdodCBmYWls
IG9uIGtleGVjLWJvb3RlZCBrZXJuZWwsIGUuZy4gaWYgdGhlDQo+Pj4+IHNldHVwX2RhdGEgd2Fz
IGludmFsaWQuIEluIHN1Y2ggYSBjYXNlLCBmYWxsaW5nIGJhY2sgdG8NCj4+IGVmaV9nZXRfcnNk
cF9hZGRyKCkNCj4+Pj4gd2lsbCBoaXQgdGhlIHByb2JsZW0gb2YgYWNjZXNzaW5nIGludmFsaWQg
dGFibGUgcG9pbnRlciBhZ2Fpbi4NCj4+Pg0KPj4+IFRoZW4geW91IG5lZWQgdG8gZG8gdGhpczoN
Cj4+Pg0KPj4+IAlpZiAoa2V4ZWNlZCBrZXJuZWwpIHsNCj4+PiAJCWFkZHIgPSBrZXhlY19nZXRf
cnNkcF9hZGRyKCk7DQo+Pj4gCQlpZiAoIWFkZHIpIHsNCj4+PiAJCQkvKiBjYW5ub3QgZ2V0IGFk
ZHJlc3MgKi8NCj4+PiAJCQlyZXR1cm4gLTE7DQo+Pj4gCQl9DQo+Pj4NCj4+PiAJCXJldHVybiBh
ZGRyOw0KPj4+IAl9DQo+Pj4NCj4+PiBhbmQgdGhlIGNhbGxpbmcgZnVuY3Rpb24gZ2V0X3JzZHBf
YWRkcigpIG11c3QgY2hlY2sgdGhlIHJldHVybiB2YWx1ZQ0KPj4gYW5kDQo+Pj4gaWYgaXQgaXMg
bm90IDAsIHJldHVybiBpbW1lZGlhdGVseS4NCj4+DQo+PiBEbyB5b3UgbWVhbiBtYWtpbmcgZ2V0
X3JzZHBfYWRkcigpIGxpa2UgdGhpcz8NCj4gDQo+IERvZXMgdGhhdCBsb29rIGxpa2Ugd2hhdCBJ
J3ZlIHR5cGVkIGFib3ZlPw0KDQpOby4gQnV0IHRoYXQncyB3aHkgSSBhc2tlZCB0aGUgcXVlc3Rp
b24uIERvIHlvdSBtZWFuIHB1dHRpbmcNCnRoZSBhYm92ZSBjb2RlIGluIGVmaV9nZXRfcnNkcF9h
ZGRyKCk/DQoNCi0tIA0KSnVuJ2ljaGkgTm9tdXJhLCBORUMgQ29ycG9yYXRpb24gLyBORUMgU29s
dXRpb24gSW5ub3ZhdG9ycywgTHRkLg==

