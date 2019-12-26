Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF9EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 04:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0102075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 04:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="byBjXLMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfLZEBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 23:01:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21526 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726741AbfLZEBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 23:01:24 -0500
X-UUID: 234d05049e7e47a68b444cd3c5bea829-20191226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SOFsA6XoDQBIw637BsIfztzTRDRPnBhAyPLmANxVkxc=;
        b=byBjXLMOx4RGQl+0mmjFyHddsPhZtRtybLd6njGLzBT3ZP8mBkaLB0eLFc6qaruw5vIya506WUd/W2fF55Q1k6gxb2dV+AErQSBNONHSSX6JB5+wQ34AJ7XxbTMfBBnL9XfuOrtD6XKq1vhrkVYncpusw8unia2nuT32qF1yt6g=;
X-UUID: 234d05049e7e47a68b444cd3c5bea829-20191226
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 10305091; Thu, 26 Dec 2019 12:01:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 26 Dec 2019 12:01:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 26 Dec 2019 12:00:10 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-mediatek@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM panic occurs
Date:   Thu, 26 Dec 2019 12:01:14 +0800
Message-ID: <20191226040114.8123-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1806FE86&#45;9508&#45;43BC&#45;8E2F&#45;3620CD243B14@lca.pw>
References: <1806FE86&#45;9508&#45;43BC&#45;8E2F&#45;3620CD243B14@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBOb3Qgc3VyZSBpZiB5b3UgaGF2ZSBjb2RlIHRoYXQgY2FuIHNoYXJlIGJ1dCBJIGNhbid0IGlt
YWdpbmUgdGhlcmUgYXJlIG1hbnkgcGxhY2VzIHRoYXQgd291bGQgaGF2ZSBhIHNpbmdsZSBjYWxs
IHNpdGUgaW4gdGhlIGRyaXZlciBkb2luZyBhbGxvY19wYWdlcygpIG92ZXIgYW5kIG92ZXIgYWdh
aW4uIEZvciBleGFtcGxlLCB0aGVyZSBpcyBvbmx5IHR3byBhbGxvY19wYWdlcygpIGluIGludGVs
LWlvbW11LmMgd2l0aCBvbmUgaXMgb25seSBpbiB0aGUgY29sZCBwYXRoLCBzbyBldmVuIGlmIGFs
bG9jX3BndGFibGVfcGFnZSgpIG9uZSBkbyBsZWFraW5nLCBpdCBpcyBzdGlsbCB1cCB0byB0aGVy
ZSBhaXIgaWYgeW91ciBwYXRjaCB3aWxsIGNhdGNoIGl0IGJlY2F1c2UgaXQgbWF5IG5vdCBhIHNp
bmdsZSBjYWxsIHNpdGUgYW5kIGl0IG5lZWRzIHRvIGxlYWsgc2lnbmlmaWNhbnQgYW1vdW50IG9m
IG1lbW9yeSB0byBiZSB0aGUgZ3JlYXRlc3QgY29uc3VtZXIgd2hlcmUgaXQgaXMganVzdCBub3Qg
c28gcmVhbGlzdGljLiANCg0KVGhhdCBpcyB3aGF0IHRoZSBwYXRjaCBkb2VzIC0tIHRhcmdldGlu
ZyBvbiB0aGUgbWVtb3J5IGxlYWthZ2Ugd2hpY2ggY2F1c2VzIGFuIE9PTSBrZXJuZWwgcGFuaWMs
IHNvIHRoZSBncmVhdGVzdCBjb25zdW1lciBpbmZvcm1hdGlvbiBoZWxwcyAodGhlIGFtb3VudCBv
ZiBsZWFrYWdlIGlzIGJpZyBlbm91Z2ggdG8gY2F1c2UgYW4gT09NIGtlcm5lbCBwYW5pYykNCg0K
SSd2ZSBwb3N0ZWQgdGhlIG51bWJlciBvZiByZWFsIHByb2JsZW1zIHNpbmNlIDIwMTkvNSBJIHNv
bHZlZCBieSB0aGlzIGFwcHJvYWNoLg0KDQogIE1pbGVz

