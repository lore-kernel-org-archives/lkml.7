Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BA7C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DBE215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PuSL3Oqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgABJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:02:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54347 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727874AbgABJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:02:43 -0500
X-UUID: 3b45a37d9a7040bcb5984861a44b0020-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KG5wsHgrhZl10PEHCnPs6GHV74q8j9w1qmh4P5J1XhM=;
        b=PuSL3OqdJRpGb4HpMtfHs36bBtT1VMGRcTyr7zfyrJUGM6tyDmmR9SWb91ktipRYnTx7stxLQ1a5wB+U35/9pLD+t5jNnI9V5gcSiHprQoN8s3R6ziz1unHRZwHfXonSElVQx1cqj3pG6CQJseJGf4M9NmJExVs5w4M4lssf1hM=;
X-UUID: 3b45a37d9a7040bcb5984861a44b0020-20200102
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1303894059; Thu, 02 Jan 2020 17:02:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 17:01:47 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 17:02:38 +0800
Message-ID: <1577955756.23575.2.camel@mtksdaap41>
Subject: Re: [PATCH v7 1/6] Check gpio pin number and use binary search in
 mtk_hw_pin_field_lookup()
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Light Hsieh <light.hsieh@mediatek.com>
CC:     <linus.walleij@linaro.org>, <sean.wang@kernel.org>,
        <kuohong.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Thu, 2 Jan 2020 17:02:36 +0800
In-Reply-To: <1577799707-11855-1-git-send-email-light.hsieh@mediatek.com>
References: <1577799707-11855-1-git-send-email-light.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTMxIGF0IDIxOjQxICswODAwLCBMaWdodCBIc2llaCB3cm90ZToNCj4g
MS4gQ2hlY2sgaWYgZ3BpbyBwaW4gbnVtYmVyIGlzIGluIHZhbGlkIHJhbmdlIHRvIHByZXZlbnQg
ZnJvbSBnZXQgaW52YWxpZA0KPiAgICBwb2ludGVyICdkZXNjJyBpbiB0aGUgZm9sbG93aW5nIGNv
ZGU6DQo+IAlkZXNjID0gKGNvbnN0IHN0cnVjdCBtdGtfcGluX2Rlc2MgKikmaHctPnNvYy0+cGlu
c1tncGlvXTsNCj4gDQo+IDIuIEltcHJvdmUgIG10a19od19waW5fZmllbGRfbG9va3VwKCkNCj4g
Mi4xIE1vZGlmeSBtdGtfaHdfcGluX2ZpZWxkX2xvb2t1cCgpIHRvIHVzZSBiaW5hcnkgc2VhcmNo
IGZvciBhY2NlbGVyYXRpbmcNCj4gICAgICBzZWFyY2guDQo+IDIuMiBDb3JyZWN0IG1lc3NhZ2Ug
YWZ0ZXIgdGhlIGZvbGxvd2luZyBjaGVjayBmYWlsOg0KPiAgICAgaWYgKGh3LT5zb2MtPnJlZ19j
YWwgJiYgaHctPnNvYy0+cmVnX2NhbFtmaWVsZF0ucmFuZ2UpIHsNCj4gCQlyYyA9ICZody0+c29j
LT5yZWdfY2FsW2ZpZWxkXTsNCj4gICAgIFRoZSBvcmlnaW5hbCBtZXNzYWdlIGlzOg0KPiAgICAg
CSJOb3Qgc3VwcG9ydCBmaWVsZCAlZCBmb3IgcGluICVkICglcylcbiINCj4gICAgIEhvd2V2ZXIs
IHRoZSBjaGVjayBpcyBvbiBzb2MgY2hpcCBsZXZlbCwgbm90IG9uIHBpbiBsZXZlbCB5ZXQuDQo+
ICAgICBTbyB0aGUgbWVzc2FnZSBpcyBjb3JyZWN0ZWQgYXM6DQo+ICAgICAJIk5vdCBzdXBwb3J0
IGZpZWxkICVkIGZvciB0aGlzIHNvY1xuIg0KPiANCj4gQ2hhbmdlLUlkOiBJNDk4YTE4ZGY3M2U2
YTY5M2UwZTM1NjM1ZDViOTJiOGRjOWMwNjNhYw0KPiAtLS0NCj4gIGRyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24tdjIuYyB8IDI3ICsrKysrKysrKysrKysrKysrKy0t
LS0tLQ0KPiAgZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtcGFyaXMuYyAgICAgICAg
IHwgMjUgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpUaGlzIHBhdGNoIHNlcmllcyBjaGFuZ2UgTVRL
IHBpbmN0cmwgZHJpdmVyLCBwbGVhc2UgYWRkICdwaW5jdHJsOg0KbWVkaWF0ZWs6ICcgYXMgcHJl
Zml4Lg0KDQpKb2UuQw0KDQo=

