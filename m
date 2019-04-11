Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD22420873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDKIS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:18:29 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:40463 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:18:29 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3B8I9fg016167
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Apr 2019 17:18:09 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3B8I9gO023088;
        Thu, 11 Apr 2019 17:18:09 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3B8I8dX018471;
        Thu, 11 Apr 2019 17:18:09 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-4203940; Thu, 11 Apr 2019 17:16:46 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Thu,
 11 Apr 2019 17:16:45 +0900
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
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqAgACP04CAAAH9AA==
Date:   Thu, 11 Apr 2019 08:16:45 +0000
Message-ID: <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
In-Reply-To: <20190411080927.GA30080@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0BA2FCD5BBA63458B0F49155501E2A7@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xMS8xOSA1OjA5IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIFdlZCwgQXBy
IDEwLCAyMDE5IGF0IDExOjM0OjUxUE0gKzAwMDAsIEp1bmljaGkgTm9tdXJhIHdyb3RlOg0KPj4g
QnV0IGVmaV9nZXRfcnNkcF9hZGRyKCkgbmVlZHMgdG8gY2hlY2sgd2hldGhlciB0aGUga2VybmVs
IHdhcw0KPj4ga2V4ZWMgYm9vdGVkIHRvIGF2b2lkIGFjY2Vzc2luZyBpbnZhbGlkIEVGSSB0YWJs
ZSBhZGRyZXNzLg0KPj4gZWZpX2dldF9rZXhlY19zZXR1cF9kYXRhX2FkZHIoKSBpcyB0aGUgb25s
eSBtZXRob2QgSSBrbm93DQo+PiB0byBjaGVjayBpZiBpdCB3YXMga2V4ZWMtYm9vdGVkLg0KPiAN
Cj4gWW91ciB2MyBoYWQgdGhlIHJpZ2h0IGFwcHJvYWNoIC0geW91IGZpcnN0IGNoZWNrIGlmIHlv
dSBjYW4gZ2V0IHRoZQ0KPiBhZGRyZXNzIGFzIGEga2V4ZWMtZWQga2VybmVsLiBJZiB5b3UgZG8s
IHlvdSB1c2UgdGhhdCBvbmUgYW5kIGNvbnRpbnVlDQo+IHRoZSBub3JtYWwgcGF0aC4NCj4gDQo+
IElmIHlvdSBkb24ndCwgeW91IGZhbGwgYmFjayB0byBlZmlfZ2V0X3JzZHBfYWRkcigpIGFuZCBn
ZXQgaXQgZGlyZWN0bHkNCj4gZnJvbSBFRkkuDQo+IA0KPiBBbmQgdGhlbiBjYXJ2ZSBvdXQgdGhl
IGZ1bmN0aW9uYWxpdHkgeW91IG5lZWQgdG8gY2FsbCBtdWx0aXBsZSB0aW1lcyBpbg0KPiBoZWxw
ZXIgZnVuY3Rpb25zIGxpa2UgX19lZmlfZ2V0X3JzZHBfYWRkcigpLg0KPiANCj4gV2h5IGRvZXNu
J3QgdGhhdCB3b3JrIGFueW1vcmU/DQoNCmtleGVjX2dldF9yc2RwX2FkZHIoKSBtaWdodCBmYWls
IG9uIGtleGVjLWJvb3RlZCBrZXJuZWwsIGUuZy4gaWYgdGhlDQpzZXR1cF9kYXRhIHdhcyBpbnZh
bGlkLiBJbiBzdWNoIGEgY2FzZSwgZmFsbGluZyBiYWNrIHRvIGVmaV9nZXRfcnNkcF9hZGRyKCkN
CndpbGwgaGl0IHRoZSBwcm9ibGVtIG9mIGFjY2Vzc2luZyBpbnZhbGlkIHRhYmxlIHBvaW50ZXIg
YWdhaW4uDQoNCi0tIA0KSnVuJ2ljaGkgTm9tdXJhLCBORUMgQ29ycG9yYXRpb24gLyBORUMgU29s
dXRpb24gSW5ub3ZhdG9ycywgTHRkLg==

