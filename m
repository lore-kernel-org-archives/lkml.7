Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F031C742CF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A2820863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="V0EOVqqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfGLPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:47:07 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:47727 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfGLPrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562946425; x=1594482425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=VDPsSfLDMFGUaTkgILPNmeH3Xs2t+isejJof1raF71o=;
  b=V0EOVqqn/p7MPadTjnEXcuKYVc88broaRtnQBIUdMUeleCszjhCjdrnA
   Vko2bVJg76/ttAKaRSKxyixTgHWa8BA/7C7eBnyx2WyckHSREUrhBRPJk
   mUY1XUAIF+UCCUJC8zlKKIsiVywT57OhQJ+wrkkSo6Zw+L9vIxBBgDwWD
   0=;
X-IronPort-AV: E=Sophos;i="5.62,483,1554768000"; 
   d="scan'208";a="774330175"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 Jul 2019 15:47:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id D3013A244D;
        Fri, 12 Jul 2019 15:47:01 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 15:47:01 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 15:46:59 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 12 Jul 2019 15:47:00 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "info@metux.net" <info@metux.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm: Extend the check for RAM in /dev/mem
Thread-Topic: [PATCH] arm: Extend the check for RAM in /dev/mem
Thread-Index: AQHVODcIGfDHKrKqiE2jyO8cjDhCoqbHE70AgAAEl4CAAAXNgIAAA4OA
Date:   Fri, 12 Jul 2019 15:46:59 +0000
Message-ID: <1562946417.1345.20.camel@amazon.de>
References: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
         <20190712145711.mxmnuyn6kpv2dr7u@willie-the-truck>
         <1562944417.1345.17.camel@amazon.de>
         <20190712153423.ypyqexfmajrmsa5r@willie-the-truck>
In-Reply-To: <20190712153423.ypyqexfmajrmsa5r@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.107]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2AD7DB16D996F4593FC6CC21BAC9AC8@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDE2OjM0ICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gRnJpLCBKdWwgMTIsIDIwMTkgYXQgMDM6MTM6MzhQTSArMDAwMCwgUmFzbGFuLCBLYXJpbUFs
bGFoIHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwgMjAxOS0wNy0xMiBhdCAxNTo1NyArMDEwMCwg
V2lsbCBEZWFjb24gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIEZyaSwgSnVsIDEyLCAyMDE5IGF0
IDEyOjIxOjIxQU0gKzAyMDAsIEthcmltQWxsYWggQWhtZWQgd3JvdGU6DQo+ID4gPiA+IA0KPiA+
ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vbW11LmMgYi9hcmNoL2Fy
bTY0L21tL21tdS5jDQo+ID4gPiA+IGluZGV4IDM2NDVmMjkuLmNkYzNlOGUgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL2FyY2gvYXJtNjQvbW0vbW11LmMNCj4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9t
bS9tbXUuYw0KPiA+ID4gPiBAQCAtNzgsNyArNzgsNyBAQCB2b2lkIHNldF9zd2FwcGVyX3BnZChw
Z2RfdCAqcGdkcCwgcGdkX3QgcGdkKQ0KPiA+ID4gPiAgcGdwcm90X3QgcGh5c19tZW1fYWNjZXNz
X3Byb3Qoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGxvbmcgcGZuLA0KPiA+ID4gPiAgCQkJ
ICAgICAgdW5zaWduZWQgbG9uZyBzaXplLCBwZ3Byb3RfdCB2bWFfcHJvdCkNCj4gPiA+ID4gIHsN
Cj4gPiA+ID4gLQlpZiAoIXBmbl92YWxpZChwZm4pKQ0KPiA+ID4gPiArCWlmICghbWVtYmxvY2tf
aXNfbWVtb3J5KF9fcGZuX3RvX3BoeXMocGZuKSkpDQo+ID4gPiANCj4gPiA+IFRoaXMgbG9va3Mg
YnJva2VuIHRvIG1lLCBzaW5jZSBpdCB3aWxsIGVuZCB1cCByZXR1cm5pbmcgJ3RydWUnIGZvciBu
b21hcA0KPiA+ID4gbWVtb3J5IGFuZCB3ZSByZWFsbHkgZG9uJ3Qgd2FudCB0byBtYXAgdGhhdCB1
c2luZyB3cml0ZWJhY2sgYXR0cmlidXRlcy4NCj4gPiANCj4gPiBUcnVlLCBJIHdpbGwgZml4IHRo
aXMgYnkgdXNpbmfCoG1lbWJsb2NrX2lzX21hcF9tZW1vcnkgaW5zdGVhZC4gVGhhdCBzYWlkLCBk
bw0KPiA+IHlvdSBoYXZlIGFueSBjb25jZXJucyBhYm91dCB0aGlzIGFwcHJvYWNoIGluwqBnZW5l
cmFsPw0KPiANCj4gSWYgeW91IGRvIHRoYXQsIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgeW91IG5l
ZWQgdGhlIHBhdGNoIGF0IGFsbCBnaXZlbiBvdXINCj4gaW1wbGVtZW50YXRpb24gb2YgcGZuX3Zh
bGlkKCkgaW4gYXJjaC9hcm02NC9tbS9pbml0LmMuDQoNCk9vcHMhIFJpZ2h0LCBJIGd1ZXNzIHRo
YXQgd291bGQgbm90IHdvcmsgZWl0aGVyLg0KDQpMZXQgbWUgZGlnIGludG8gYSBiZXR0ZXIgd2F5
IHRvIGRvIHRoYXQuDQoNCj4gDQo+IFdpbGwNCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIg
R2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1
bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gKRWluZ2V0cmFnZW4gYW0gQW10
c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpV
c3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

