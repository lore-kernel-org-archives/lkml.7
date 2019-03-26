Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED9AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB6420823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nE5CA/I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfCZCNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:13:51 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14828 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbfCZCNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1553566428; x=1585102428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZS39O6+dawLFLm/ta8ub3QcAXlZPozHwxmUIuUsfM90=;
  b=nE5CA/I0xUC7yw2cHwt5YRtZZSO21Hu6Ct9+KQxS/SVrHRsdlE9/cXcc
   SBYM6Y2y+lPZRXJfa+enRpM0a+qvrOIcMupPj6faK3mt2smHJScvFWjf1
   nM0ns7oM5gcMKowtuAc73B9p62CWRc3wQmGasCCaKBE0KpaXxiFSsvS2Y
   4=;
X-IronPort-AV: E=Sophos;i="5.60,270,1549929600"; 
   d="scan'208";a="790845472"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Mar 2019 02:13:43 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2Q2DXi5078649
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 26 Mar 2019 02:13:35 GMT
Received: from EX13d09UWC003.ant.amazon.com (10.43.162.113) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 26 Mar 2019 02:13:35 +0000
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13d09UWC003.ant.amazon.com (10.43.162.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 26 Mar 2019 02:13:34 +0000
Received: from EX13D02UWC004.ant.amazon.com ([10.43.162.236]) by
 EX13D02UWC004.ant.amazon.com ([10.43.162.236]) with mapi id 15.00.1367.000;
 Tue, 26 Mar 2019 02:13:34 +0000
From:   "Saidi, Ali" <alisaidi@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Will Deacon" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Andy Lutomirski" <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Liguori, Anthony" <aliguori@amazon.com>
Subject: Re: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in
 mmap_base
Thread-Topic: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in
 mmap_base
Thread-Index: AQHU2PmhiRz/TsWOLEOmeVSaHu1ISKYWLY6AgAa/s4A=
Date:   Tue, 26 Mar 2019 02:13:34 +0000
Message-ID: <037ACE94-A408-4CB0-BCA5-3FF9041E43B0@amazon.com>
References: <20190312173248.13490-1-alisaidi@amazon.com>
 <20190312173248.13490-3-alisaidi@amazon.com>
 <alpine.DEB.2.21.1903211508440.1784@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903211508440.1784@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.180]
Content-Type: text/plain; charset="utf-8"
Content-ID: <852CE8557F754E4FB47D67B97DC97127@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDMvMjEvMTksIDk6MTEgQU0sICJsaW51eC1hcm0ta2VybmVsIG9uIGJlaGFsZiBv
ZiBUaG9tYXMgR2xlaXhuZXIiIDxsaW51eC1hcm0ta2VybmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFk
ZWFkLm9yZyBvbiBiZWhhbGYgb2YgdGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCg0KICAgIE9u
IFR1ZSwgMTIgTWFyIDIwMTksIEFsaSBTYWlkaSB3cm90ZToNCiAgICANCiAgICA+IEluY3JlYXNl
IG1tYXBfYmFzZSBieSB0aGUgd29yc3QtY2FzZSBicmsgcmFuZG9taXphdGlvbiBzbyB0aGF0DQog
ICAgPiB0aGUgc3RhY2sgYW5kIGhlYXAgcmVtYWluIGFwYXJ0Lg0KICAgID4gDQogICAgPiBJbiBM
aW51eCA0LjEzIGEgY2hhbmdlIHdhcyBjb21taXR0ZWQgdGhhdCBzcGVjaWFsIGNhc2VkIHRoZSBr
ZXJuZWwgRUxGDQogICAgPiBsb2FkZXIgd2hlbiB0aGUgbG9hZGVyIGlzIGludm9rZWQgZGlyZWN0
bHkgKGVhYjA5NTMyZDQwMDsgYmluZm10X2VsZjogdXNlDQogICAgPiBFTEZfRVRfRFlOX0JBU0Ug
b25seSBmb3IgUElFKS4gR2VuZXJhbGx5LCB0aGUgbG9hZGVyIGlzbuKAmXQgaW52b2tlZA0KICAg
ID4gZGlyZWN0bHkgYW5kIHRoaXMgaXNzdWUgaXMgbGltaXRlZCB0byBjYXNlcyB3aGVyZSBpdCBp
cywgKGUuZyB0byBzZXQgYQ0KICAgID4gbm9uLWluaGVyaXRhYmxlIExEX0xJQlJBUllfUEFUSCwg
dGVzdGluZyBuZXcgdmVyc2lvbnMgb2YgdGhlIGxvYWRlcikuIEluDQogICAgPiB0aG9zZSByYXJl
IGNhc2VzLCB0aGUgbG9hZGVyIGRvZXNuJ3QgdGFrZSBpbnRvIGFjY291bnQgdGhlIGFtb3VudCBv
ZiBicmsNCiAgICA+IHJhbmRvbWl6YXRpb24gdGhhdCB3aWxsIGJlIGFwcGxpZWQgYnkgYXJjaF9y
YW5kb21pemVfYnJrKCkuIFRoaXMgY2FuDQogICAgPiBsZWFkIHRvIHRoZSBzdGFjayBhbmQgaGVh
cCBiZWluZyBhcmJpdHJhcmlseSBjbG9zZSB0byBlYWNoIG90aGVyLg0KICAgIA0KICAgIFRoYXQg
ZXhwbGFpbnMgbm90IHdoeSB5b3UgbmVlZCB0aGlzIGNoYW5nZS4gV2hhdCdzIHRoZSBjb25zZXF1
ZW5jZSBvZiB0aGVtDQogICAgYmVpbmcgY2xvc2UgdG8gZWFjaCBvdGhlcj8NCiAgICANClRoZSBw
cm9jZXNzIGRvZXNuJ3QgZ2V0IGl0J3MgcmVxdWVzdGVkIHN0YWNrIHNpemUgYW5kIHN0YWNrIGFs
bG9jYXRpb25zIGNvdWxkIGVuZCB1cCBzY3JpYmJsaW5nIG9uIHRoZSBoZWFwLg0KDQpUaGFua3Ms
DQpBbGkNCiANCg0K
