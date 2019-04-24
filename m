Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A32C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A5C218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfDXCs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 22:48:28 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:55014 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfDXCs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 22:48:28 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3O2ltrt010606
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 11:47:55 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3O2ltrM027201;
        Wed, 24 Apr 2019 11:47:55 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3O2lrSi016119;
        Wed, 24 Apr 2019 11:47:55 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-4579538; Wed, 24 Apr 2019 11:47:34 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Wed,
 24 Apr 2019 11:47:33 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Kairui Song <kasong@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Thread-Topic: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Thread-Index: AQHU+O3agAmzlxHZg0mE9lemKT/NC6ZIsHeAgAC3AoCAAJ/sAA==
Date:   Wed, 24 Apr 2019 02:47:32 +0000
Message-ID: <24f1dc7c-1dea-79b0-d364-0dc7d605ce01@ce.jp.nec.com>
References: <20190422092804.15534-1-kasong@redhat.com>
 <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
 <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
In-Reply-To: <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0A18CB245553D4DBDDB1376DB3E1470@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNC8xOSAyOjE1IEFNLCBLYWlydWkgU29uZyB3cm90ZToNCj4gT24gTW9uLCBBcHIgMjIs
IDIwMTkgYXQgMTE6MjEgUE0gSnVuaWNoaSBOb211cmEgPGotbm9tdXJhQGNlLmpwLm5lYy5jb20+
IHdyb3RlOg0KPj4gSXMgdGhlIG1hcHBpbmcgb2YgQUNQSSB0YWJsZXMganVzdCBieSBsdWNrLCB0
b28/DQo+IA0KPiBHb29kIHF1ZXN0aW9uLCB0aGV5IHNob3VsZCBoYXZlIHNhbWUgaXNzdWUgd2l0
aCBzeXN0YWIsIEkgaWdub3JlZCB0aGlzIG9uZS4NCj4gVGhlbiBpbiBmaXJzdCBrZXJuZWwgd2hl
biBkb2luZyBrZXhlYyBpdCBzaG91bGQgZW5zdXJlIGJvdGggQUNQSQ0KPiB0YWJsZXMgYW5kIHRo
ZSBFRkkgc3lzdGFiIGFyZSBtYXBwZWQsIHRoYXQgc2hvdWxkIGNvdmVyIGV2ZXJ5dGhpbmcgYW5k
DQo+IG1ha2UgaXQgd29yay4NCg0KUmlnaHQuDQoNCj4gSXMgdGhlcmUgYW55dGhpbmcgZWxzZSBt
aXNzaW5nPw0KTm8sIGFzIGZhciBhcyBJIGxvb2tlZCBhcm91bmQgZ2V0X3JzZHBfYWRkcigpLg0K
DQotLSANCkp1bidpY2hpIE5vbXVyYSwgTkVDIENvcnBvcmF0aW9uIC8gTkVDIFNvbHV0aW9uIElu
bm92YXRvcnMsIEx0ZC4=

