Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE723C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6682071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fTbR+yoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfKZNLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:11:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54691 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726121AbfKZNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:11:38 -0500
X-UUID: c3e429ce4cb44acfabb86d3ab2b00dbf-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WlPnUjC0Phkva1NreMCotJOZ/GKrJRhduHCPYVkHaA0=;
        b=fTbR+yooKFztBsSCvuDvMAttoEjWpz/cVcLKPpJ0EKQDKoVquDsLw2z6NDMp4LE8xBsTaUIdyaWLDrnkeuz/7PjepOy4ZfdEqmF5PeXP9dKNECa7JVUnL5cjvKLdK8Xg6pEdDnGpD9cuvGStTSGBN/wHZNXXBlA0fvIAWj10pg0=;
X-UUID: c3e429ce4cb44acfabb86d3ab2b00dbf-20191126
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yt.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1179083908; Tue, 26 Nov 2019 21:11:32 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 21:11:27 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 21:12:01 +0800
Message-ID: <1574773890.12247.23.camel@mtksdccf07>
Subject: Re: [PATCH 1/1] sched: panic, when call schedule with preemption
 disable
From:   Kathleen Chang <yt.chang@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 26 Nov 2019 21:11:30 +0800
In-Reply-To: <20191121123048.GQ4097@hirez.programming.kicks-ass.net>
References: <1574323985-24193-1-git-send-email-yt.chang@mediatek.com>
         <20191121123048.GQ4097@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTIxIGF0IDEzOjMwICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBOb3YgMjEsIDIwMTkgYXQgMDQ6MTM6MDVQTSArMDgwMCwgWVQgQ2hhbmcgd3Jv
dGU6DQo+ID4gV2hlbiBwcmVlbXB0aW9uIGlzIGRpc2FibGUsIGNhbGwgc2NoZWR1bGUoKSBpcyBp
bmNvcnJlY3QgYmVoYXZpb3IuDQo+ID4gU3VnZ2VzdCB0byBwYW5pYyBkaXJlY3RseSByYXRoZXIg
dGhhbiBkZXBlbmQgb24gcGFuaWNfb25fd2Fybi4NCj4gDQo+IFdoeSE/DQoNCg0KMS4gUGFuaWMg
ZGlyZWN0bHkgd2lsbCBlYXNpbHkgZmluZCB0aGUgcm9vdCBjYXVzZS4gDQoNCiAgIENhbGwgc2No
ZWR1bGluZyBpbiBhdG9taWMgYWZmZWN0cyBub3Qgb25seSBwZXJmb3JtYW5jZSBidXQgYWxzbw0K
c3lzdGVtIHN0YWJpbGl0eS4gDQogICAgZXg6IA0KICAgICAgQ2FsbCBzY2hlZHVsaW5nIGluIElS
USB3aWxsIHJlc3VsdCBpbiBJUlEgZW5hYmxlIGFmdGVyIHNjaGVkdWxlKCkgDQoNCjIuIEEgbG90
IG9mIHdhcm5pbmdzIGRlcGVuZCBvbiBwYW5pY19vbl93YXJuLiBJdCBpcyBub3QgcHJhY3RpY2Fs
IHRvDQpzZXQgcGFuaWNfb25fd2Fybj0xLiANCg0K

