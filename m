Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B185206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NkkHB4At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfL0Hoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 02:44:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45188 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbfL0Hoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 02:44:37 -0500
X-UUID: cf1569c8872441638eb8f3651e14fb66-20191227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=c7+sXShYFxG3wcTEwAICxBEiQe2t3QIDNgGX1i8gy9E=;
        b=NkkHB4AtSFSKPRgdPKrWCW+PoJMENdBLHJk10B8rFqV8VlTsM0EF0WB4B6Na5uoS4b8HWeA9CxITGIfxO6cmRvPZLyaMEvLT6tihiom4Yk8+MDDAFOT4khsnUZK0ay9HXatevwwAz1O+5YvcwPutAAC+SK//zHt2O/StzDEcUY0=;
X-UUID: cf1569c8872441638eb8f3651e14fb66-20191227
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 268154553; Fri, 27 Dec 2019 15:44:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Dec 2019 15:44:08 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Dec 2019 15:44:19 +0800
Message-ID: <1577432670.4248.3.camel@mtkswgap22>
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM
 panic occurs
From:   Miles Chen <miles.chen@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-mediatek@lists.infradead.org>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 27 Dec 2019 15:44:30 +0800
In-Reply-To: <95CD23C9-D10D-4E6A-BF53-A4C1A4DB281A@lca.pw>
References: <20191226040114.8123-1-miles.chen@mediatek.com>
         <95CD23C9-D10D-4E6A-BF53-A4C1A4DB281A@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTI2IGF0IDAwOjUzIC0wNTAwLCBRaWFuIENhaSB3cm90ZToNCj4gDQo+
ID4gT24gRGVjIDI1LCAyMDE5LCBhdCAxMTowMSBQTSwgTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBt
ZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IFRoYXQgaXMgd2hhdCB0aGUgcGF0Y2ggZG9l
cyAtLSB0YXJnZXRpbmcgb24gdGhlIG1lbW9yeSBsZWFrYWdlIHdoaWNoIGNhdXNlcyBhbiBPT00g
a2VybmVsIHBhbmljLCBzbyB0aGUgZ3JlYXRlc3QgY29uc3VtZXIgaW5mb3JtYXRpb24gaGVscHMg
KHRoZSBhbW91bnQgb2YgbGVha2FnZSBpcyBiaWcgZW5vdWdoIHRvIGNhdXNlIGFuIE9PTSBrZXJu
ZWwgcGFuaWMpDQo+ID4gDQo+ID4gSSd2ZSBwb3N0ZWQgdGhlIG51bWJlciBvZiByZWFsIHByb2Js
ZW1zIHNpbmNlIDIwMTkvNSBJIHNvbHZlZCBieSB0aGlzIGFwcHJvYWNoLg0KPiANCj4gVGhlIHBv
aW50IGlzIGluIG9yZGVyIHRvIG1ha2UgeW91ciBkZWJ1Z2dpbmcgcGF0Y2ggdXBzdHJlYW0sIGl0
IGhhcyB0byBiZSBnZW5lcmFsIHVzZWZ1bC4gUmlnaHQgbm93LCANCg0KPiBpdCBmZWVscyByYXRo
ZXIgc2l0dWF0aW9uYWwgZm9yIG1lIGZvciB0aGUgcmVhc29ucyBnaXZlbiBpbiB0aGUgcHJldmlv
dXMgZW1haWxzLg0KDQoNCkl0J3Mgbm90IGNvbXBsZXRlIHNpdHVhdGlvbi4NCg0KSSd2ZSBsaXN0
ZWQgZGlmZmVyZW50IE9PTSBwYW5pYyBzaXR1YXRpb25zIGluIHByZXZpb3VzIGVtYWlsIFsxXQ0K
YW5kIHdoYXQgd2UgY2FuIGRvIGFib3V0IHRoZW0gd2l0aCBjdXJyZW50IGluZm9ybWF0aW9uLg0K
DQpUaGVyZSBhcmUgc29tZSBjYXNlcyB3aGljaCBjYW5ub3QgYmUgY292ZXJlZCBieSBjdXJyZW50
IGluZm9ybWF0aW9uDQplYXNpbHkuDQpGb3IgZXhhbXBsZTogYSBtZW1vcnkgbGVha2FnZSBjYXVz
ZWQgYnkgYWxsb2NfcGFnZXMoKSBvciB2bWFsbG9jKCkgd2l0aA0KYSBsYXJnZSBzaXplLg0KSSBr
ZWVwIHNlZWluZyB0aGVzZSBpc3N1ZXMgZm9yIHllYXJzIGFuZCB0aGF0J3Mgd2h5IEkgYnVpbHQg
dGhpcyBwYXRjaC4gDQpJdCdzIGxpa2UgYSBtaXNzaW5nIHBpZWNlIG9mIHRoZSBwdXp6bGUuDQoN
ClRvIHByb3ZlIHRoYXQgdGhlIGFwcHJvYWNoIGlzIHByYWN0aWNhbCBhbmQgdXNlZnVsLCBJIGhh
dmUgY29sbGVjdGVkDQpyZWFsIHRlc3QgY2FzZXMNCnVuZGVyIHJlYWwgZGV2aWNlcyBhbmQgcG9z
dGVkIHRoZSB0ZXN0IHJlc3VsdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQpUaGVzZSBhcmUgcmVh
bCBjYXNlcywgbm90IG15IGltYWdpbmF0aW9uLg0KDQpbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21s
LzIwMTkvMTIvMjUvNTMNCg0KDQp0aGFua3MgYWdhaW4gZm9yIHlvdXIgY29tbWVudHMNCg0KICBN
aWxlcw0K

