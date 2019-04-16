Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0E8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27602075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfDPXKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:10:39 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:48182 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPXKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:10:39 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3GNADgZ025108
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 08:10:13 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3GNADg4005793;
        Wed, 17 Apr 2019 08:10:13 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3GNADmm032483;
        Wed, 17 Apr 2019 08:10:13 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.140] [10.38.151.140]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-4349110; Wed, 17 Apr 2019 07:44:33 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC12GP.gisp.nec.co.jp ([10.38.151.140]) with mapi id 14.03.0319.002; Wed,
 17 Apr 2019 07:44:33 +0900
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
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqAgACP04CAAAH9AIAABdcAgAAJ5YCAAAJaAIAAAziAgAACJICAADc+AIAA6YwAgABjYACAAE/IgIAESQcAgAAjCICAABXVgIAA0vGAgACy0YCAANsUAA==
Date:   Tue, 16 Apr 2019 22:44:32 +0000
Message-ID: <34d02ae0-7182-2983-b601-acbdb4085f33@ce.jp.nec.com>
References: <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
In-Reply-To: <20190416094024.GE27892@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFF80D1B370C3D44A0BF4317EB451BD0@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8xOSA2OjQwIFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIE1vbiwgQXBy
IDE1LCAyMDE5IGF0IDExOjAwOjI1UE0gKzAwMDAsIEp1bmljaGkgTm9tdXJhIHdyb3RlOg0KPj4g
SSB0aG91Z2h0IHdlIHNob3VsZCBoYW5nIGhlcmUgaW5zdGVhZCBvZiByZXR1cm4gc28gdGhhdCB3
ZQ0KPj4gZG9uJ3QgcnVuIGludG8gZWZpX2dldF9yc2RwX2FkZHIoKSBpbiBjYXNlIG9mIGtleGVj
Lg0KPiANCj4gSGFuZ2luZyB0aGF0IGVhcmx5IHdpdGhvdXQgZGVidWcgb3V0cHV0IGlzIG5vdCB2
ZXJ5IGZyaWVuZGx5IHRvDQo+IGRlYnVnZ2VycywgbWV0aGlua3MuDQoNClJpZ2h0LiBCdXQgaWYg
d2UgY291bGQgbW92ZSBnZXRfcnNkcF9hZGRyKCkgYWZ0ZXIgY29uc29sZV9pbml0KCksDQp5b3Ug
Z2V0IGRlYnVnIG91dHB1dC4NCg0KLS0gDQpKdW4naWNoaSBOb211cmEsIE5FQyBDb3Jwb3JhdGlv
biAvIE5FQyBTb2x1dGlvbiBJbm5vdmF0b3JzLCBMdGQu

