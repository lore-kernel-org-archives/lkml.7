Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897BC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8858720880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VpSW3UxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfDOQKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:10:54 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:37861 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDOQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1555344652; x=1586880652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3p1H0rEmUCz/ZMlrjBdTnDWFO1f81fJ9H6swRiZsskM=;
  b=VpSW3UxN5o7CVEDlR10AURcYfDbuuRIvC1CmG6VjXUT5eEeh5abqht9r
   LEXrDjwcwoG9NvzZDquPCYDJ6sPef+sQV3T+ygUvb+4B27XZ1h1bvq557
   Nx/WnkVvEXGkXdNRQA7p2z/fUsqGp8OhAe5VviqT2HDxAnH0JCfqDrear
   4=;
X-IronPort-AV: E=Sophos;i="5.60,354,1549929600"; 
   d="scan'208";a="794389974"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Apr 2019 16:05:04 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x3FG3Wof126457
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 15 Apr 2019 16:03:35 GMT
Received: from EX13d09UWC001.ant.amazon.com (10.43.162.60) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 15 Apr 2019 16:03:34 +0000
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13d09UWC001.ant.amazon.com (10.43.162.60) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 15 Apr 2019 16:03:34 +0000
Received: from EX13D02UWC004.ant.amazon.com ([10.43.162.236]) by
 EX13D02UWC004.ant.amazon.com ([10.43.162.236]) with mapi id 15.00.1367.000;
 Mon, 15 Apr 2019 16:03:34 +0000
From:   "Saidi, Ali" <alisaidi@amazon.com>
To:     Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in
 mmap_base
Thread-Topic: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in
 mmap_base
Thread-Index: AQHU2PmhiRz/TsWOLEOmeVSaHu1ISKYKLoIAgBXMf4CAHUjGgA==
Date:   Mon, 15 Apr 2019 16:03:34 +0000
Message-ID: <34381CFC-A90F-4979-9802-2BA0E6539C68@amazon.com>
References: <20190312173248.13490-1-alisaidi@amazon.com>
 <20190312173248.13490-3-alisaidi@amazon.com>
 <CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com>
 <CAGXu5jKcBmj0kwAqjqROXuOi=90=Upy8-J8WviGMjD6FV_Guxg@mail.gmail.com>
In-Reply-To: <CAGXu5jKcBmj0kwAqjqROXuOi=90=Upy8-J8WviGMjD6FV_Guxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AAB9B7BD5FCCF47AB714C3009212253@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDMvMjcvMTksIDI6NTIgUE0sICJsaW51eC1hcm0ta2VybmVsIG9uIGJlaGFsZiBv
ZiBLZWVzIENvb2siIDxsaW51eC1hcm0ta2VybmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9y
ZyBvbiBiZWhhbGYgb2Yga2Vlc2Nvb2tAY2hyb21pdW0ub3JnPiB3cm90ZToNCg0KICAgIEFkZGlu
ZyBzb21lIG1vcmUgcGVvcGxlIHRvIENDLi4uIHdoYXQgZG8gcGVvcGxlIHRoaW5rIGFib3V0IHRo
aXMNCiAgICBtb3Zpbmcgb2YgdGhlIGJyayB0byBFTEZfRVRfRFlOX0JBU0UgaW4gdGhpcyBjb3Ju
ZXItY2FzZT8gQW55dGhpbmcNCiAgICB0aGF0IHdvcmtlZCBiZWZvcmUgc2hvdWxkIHN0aWxsIHdv
cmsgKGkuZS4gdGhlIHVsdGltYXRlbHktbGF1bmNoZWQNCiAgICBiaW5hcnkgYWxyZWFkeSBoYWQg
dGhlIGJyayB2ZXJ5IGZhciBmcm9tIGl0cyB0ZXh0LCBzbyB0aGlzIHNob3VsZCBiZQ0KICAgIG5v
IGRpZmZlcmVudCBmcm9tIGEgQ09NUEFUX0JSSyBzdGFuZHBvaW50KS4gVGhlIG9ubHkgcmlzayBJ
IHNlZSBoZXJlDQogICAgaXMgdGhhdCBpZiBzb21lb25lIHN0YXJ0ZWQgdG8gc3VkZGVubHkgZGVw
ZW5kIG9uIHRoZSBlbnRpcmUgbWVtb3J5DQogICAgc3BhY2UgYWJvdmUgdGhlIG1tYXAgcmVnaW9u
IGJlaW5nIGF2YWlsYWJsZSB3aGVuIGxhdW5jaGluZyBiaW5hcmllcw0KICAgIHZpYSBhIGRpcmVj
dCBsb2FkZXIgZXhlY3MuLi4gd2hpY2ggc2VlbXMgaGlnaGx5IHVubGlrZWx5LCBJJ2QgaG9wZToN
CiAgICB0aGlzIHdvdWxkIG1lYW4gYSBiaW5hcnkgd291bGQgbm90IHdvcmsgd2hlbiBleGVjZWQg
bm9ybWFsbHkuDQoNCktlZXMnIHByb3Bvc2FsIGFkZHJlc3NlcyB0aGUgaXNzdWUgZm9yIG1lLiBB
bnlvbmUgaGF2ZSBjb25jZXJucyBvbiB0aGlzIHByb3Bvc2VkIHNvbHV0aW9uPw0KDQpBbGkNCg0K
DQo=
