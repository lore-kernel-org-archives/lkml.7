Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C938DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 01:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9131E2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 01:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KS+Zr928"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfL3Bam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 20:30:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:15025 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbfL3Bam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 20:30:42 -0500
X-UUID: c9e57f22e32b448986fb37765e38f1ee-20191230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OpBMs91oE19syjj1K1kvYCtFSWX7sZYdpKP8h4EDQcE=;
        b=KS+Zr9282cue6aCg40/OGkKy2BiSm9yaeDdRJAmjLatZE5//AaY+t3fuLV0RYls8QEq2ioC2ICGkOfxy7pnD4CEDsnUkQxZtAAMfqyc0vMULBReWDGMOIrYuewGsLLYAi9QQYSrBFHShlbZufpVkMlQO/c01IHTsW6ufwpo74LA=;
X-UUID: c9e57f22e32b448986fb37765e38f1ee-20191230
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1302598069; Mon, 30 Dec 2019 09:30:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Dec 2019 09:30:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 30 Dec 2019 09:29:22 +0800
Message-ID: <1577669436.25204.8.camel@mtkswgap22>
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM
 panic occurs
From:   Miles Chen <miles.chen@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-mediatek@lists.infradead.org>,
        <wsd_upstream@mediatek.com>
Date:   Mon, 30 Dec 2019 09:30:36 +0800
In-Reply-To: <2EA70B54-A7E1-4C5A-A447-844A3FEA7E93@lca.pw>
References: <1577432670.4248.3.camel@mtkswgap22>
         <2EA70B54-A7E1-4C5A-A447-844A3FEA7E93@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEyLTI3IGF0IDA4OjQ2IC0wNTAwLCBRaWFuIENhaSB3cm90ZToNCj4gDQo+
ID4gT24gRGVjIDI3LCAyMDE5LCBhdCAyOjQ0IEFNLCBNaWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSXQncyBub3QgY29tcGxldGUgc2l0dWF0aW9u
Lg0KPiA+IA0KPiA+IEkndmUgbGlzdGVkIGRpZmZlcmVudCBPT00gcGFuaWMgc2l0dWF0aW9ucyBp
biBwcmV2aW91cyBlbWFpbCBbMV0NCj4gPiBhbmQgd2hhdCB3ZSBjYW4gZG8gYWJvdXQgdGhlbSB3
aXRoIGN1cnJlbnQgaW5mb3JtYXRpb24uDQo+ID4gDQo+ID4gVGhlcmUgYXJlIHNvbWUgY2FzZXMg
d2hpY2ggY2Fubm90IGJlIGNvdmVyZWQgYnkgY3VycmVudCBpbmZvcm1hdGlvbg0KPiA+IGVhc2ls
eS4NCj4gPiBGb3IgZXhhbXBsZTogYSBtZW1vcnkgbGVha2FnZSBjYXVzZWQgYnkgYWxsb2NfcGFn
ZXMoKSBvciB2bWFsbG9jKCkgd2l0aA0KPiA+IGEgbGFyZ2Ugc2l6ZS4NCj4gPiBJIGtlZXAgc2Vl
aW5nIHRoZXNlIGlzc3VlcyBmb3IgeWVhcnMgYW5kIHRoYXQncyB3aHkgSSBidWlsdCB0aGlzIHBh
dGNoLiANCj4gPiBJdCdzIGxpa2UgYSBtaXNzaW5nIHBpZWNlIG9mIHRoZSBwdXp6bGUuDQo+ID4g
DQo+ID4gVG8gcHJvdmUgdGhhdCB0aGUgYXBwcm9hY2ggaXMgcHJhY3RpY2FsIGFuZCB1c2VmdWws
IEkgaGF2ZSBjb2xsZWN0ZWQNCj4gPiByZWFsIHRlc3QgY2FzZXMNCj4gPiB1bmRlciByZWFsIGRl
dmljZXMgYW5kIHBvc3RlZCB0aGUgdGVzdCByZXN1bHQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0K
PiA+IFRoZXNlIGFyZSByZWFsIGNhc2VzLCBub3QgbXkgaW1hZ2luYXRpb24uDQo+IA0KPiBPZiBj
b3Vyc2UgdGhpcyBtYXkgaGVscCBkZWJ1ZyAqeW91ciogcHJvYmxlbXMgaW4gdGhlIHBhc3QsIGJ1
dCBpZiB0aGF0IGlzIHRoZSBvbmx5IHJlcXVpcmVtZW50IHRvIG1lcmdlIHRoZSBkZWJ1Z2dpbmcg
cGF0Y2ggbGlrZSB0aGlzLCB3ZSB3b3VsZCBlbmQgdXAgd2l0aCBlbmRsZXNzIG9mIHRob3NlLiBJ
ZiB5b3VyIGdvYWwgaXMgdG8gc3RvcCBkZXZlbG9wZXJzIGZyb20gcmVwcm9kdWNpbmcgaXNzdWVz
IHVubmVjZXNzYXJpbHkgYWdhaW4gdXNpbmcgcGFnZV9vd25lciB0byBkZWJ1ZywgdGhlbiB5b3Vy
IHBhdGNoIGRvZXMgbm90IGhlbHAgbXVjaCBmb3IgdGhlIG1ham9yaXR5IG9mIG90aGVyIGRldmVs
b3BlcnPigJkgaXNzdWVzLg0KPiANCj4gVGhlIHBhZ2Vfb3duZXIgaXMgZGVzaWduZWQgdG8gZ2l2
ZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgdG9wIGNhbmRpZGF0ZXMgdGhhdCBtaWdodCBjYXVzZSBp
c3N1ZXMsIHNvIGl0IG1ha2Ugc29tZXdoYXQgc2Vuc2UgaWYgaXQgZHVtcHMgdGhlIHRvcCAxMCBn
cmVhdGVzdCBtZW1vcnkgY29uc3VtZXIgZm9yIGV4YW1wbGUsIGJ1dCB0aGF0IGFsc28gY2x1dHRl
ciB0aGUgT09NIHJlcG9ydCBzbyBtdWNoLCBzbyBpdCBpcyBuby1nby4NCg0KWWVzLCBwcmludGlu
ZyB0b3AgMTAgd2lsbCBiZSB0b28gbXVjaC4gVGhhdCdzIHdoeSBJIHByaW50IG9ubHkgdGhlDQpn
cmVhdGVzdCBjb25zdW1lciwgYW5kIHRlc3QgaWYgdGhpcyBhcHByb2FjaCB3b3Jrcy4NCg0KSSB3
aWxsIHJlc2VuZCB0aGlzIHBhdGNoIGFmdGVyIHRoZSBicmVhay4gTGV0J3Mgd2FpdCBmb3Igb3Ro
ZXJzJw0KY29tbWVudHM/DQoNCg0KICAgTWlsZXMNCg==

