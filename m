Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFD8C742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600782084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="BlXyKnqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfGLPNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:13:46 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:61974 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfGLPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562944425; x=1594480425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=6paSjuY09ejpoRwHJwgN56Jb7OGwcZrtkGDYZABihlQ=;
  b=BlXyKnqmu06am0Au76ruT2RPvd+7VWZsLgTbDIyXZzoYNUy0ZDgKJAJA
   nnK9R5cE0BmXa1vlwrnOATX9jsLpgmeVRheeHSenvQTTa654mXfulaCGK
   X577M2TyRFhIKK7AQW40qCOi4N2FQnhen3R3oW/ZTInO8YXYaV0fGgQSr
   8=;
X-IronPort-AV: E=Sophos;i="5.62,483,1554768000"; 
   d="scan'208";a="685177933"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Jul 2019 15:13:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 80BBAA2519;
        Fri, 12 Jul 2019 15:13:40 +0000 (UTC)
Received: from EX13D01EUB004.ant.amazon.com (10.43.166.180) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 15:13:39 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB004.ant.amazon.com (10.43.166.180) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 15:13:38 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 12 Jul 2019 15:13:38 +0000
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
Thread-Index: AQHVODcIGfDHKrKqiE2jyO8cjDhCoqbHE70AgAAEl4A=
Date:   Fri, 12 Jul 2019 15:13:38 +0000
Message-ID: <1562944417.1345.17.camel@amazon.de>
References: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
         <20190712145711.mxmnuyn6kpv2dr7u@willie-the-truck>
In-Reply-To: <20190712145711.mxmnuyn6kpv2dr7u@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.55]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC75E5D1726FE342A05CE26978AF7023@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDE1OjU3ICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gRnJpLCBKdWwgMTIsIDIwMTkgYXQgMTI6MjE6MjFBTSArMDIwMCwgS2FyaW1BbGxhaCBBaG1l
ZCB3cm90ZToNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9tbXUuYyBiL2Fy
Y2gvYXJtNjQvbW0vbW11LmMNCj4gPiBpbmRleCAzNjQ1ZjI5Li5jZGMzZThlIDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gvYXJtNjQvbW0vbW11LmMNCj4gPiArKysgYi9hcmNoL2FybTY0L21tL21tdS5j
DQo+ID4gQEAgLTc4LDcgKzc4LDcgQEAgdm9pZCBzZXRfc3dhcHBlcl9wZ2QocGdkX3QgKnBnZHAs
IHBnZF90IHBnZCkNCj4gPiAgcGdwcm90X3QgcGh5c19tZW1fYWNjZXNzX3Byb3Qoc3RydWN0IGZp
bGUgKmZpbGUsIHVuc2lnbmVkIGxvbmcgcGZuLA0KPiA+ICAJCQkgICAgICB1bnNpZ25lZCBsb25n
IHNpemUsIHBncHJvdF90IHZtYV9wcm90KQ0KPiA+ICB7DQo+ID4gLQlpZiAoIXBmbl92YWxpZChw
Zm4pKQ0KPiA+ICsJaWYgKCFtZW1ibG9ja19pc19tZW1vcnkoX19wZm5fdG9fcGh5cyhwZm4pKSkN
Cj4gDQo+IFRoaXMgbG9va3MgYnJva2VuIHRvIG1lLCBzaW5jZSBpdCB3aWxsIGVuZCB1cCByZXR1
cm5pbmcgJ3RydWUnIGZvciBub21hcA0KPiBtZW1vcnkgYW5kIHdlIHJlYWxseSBkb24ndCB3YW50
IHRvIG1hcCB0aGF0IHVzaW5nIHdyaXRlYmFjayBhdHRyaWJ1dGVzLg0KDQpUcnVlLCBJIHdpbGwg
Zml4IHRoaXMgYnkgdXNpbmfCoG1lbWJsb2NrX2lzX21hcF9tZW1vcnkgaW5zdGVhZC4gVGhhdCBz
YWlkLCBkbw0KeW91IGhhdmUgYW55IGNvbmNlcm5zIGFib3V0IHRoaXMgYXBwcm9hY2ggaW7CoGdl
bmVyYWw/DQoNCj4gDQo+IFdpbGwNCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFu
eSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENo
cmlzdGlhbiBTY2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6
IERFIDI4OSAyMzcgODc5CgoK

