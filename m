Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7542721019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nv49+/pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCQPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:52:20 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1332 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCQPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1552837939; x=1584373939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VzmUeWkQQDo7bTzN1x7A+c/QOoqQvVIwRVM72/Tm9N8=;
  b=nv49+/pd5uqbgD8CWHVpwXE+S9UJQ1G2+YPMMWgJ3jPAgiqdKHXv9ose
   SpqVoyANf5GY8WQHomIxhnXApap8MZu17bR6tURMd7DDUSYXREu+Vv8Zd
   odjlx67WLFkR88MABvPdJ7BZuEtJgesqjJp4/CDt8yg3yIDpvN/z4aMKT
   M=;
X-IronPort-AV: E=Sophos;i="5.58,489,1544486400"; 
   d="scan'208";a="665539149"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Mar 2019 15:52:16 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2HFqCkd079957
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 17 Mar 2019 15:52:14 GMT
Received: from EX13d09UWC002.ant.amazon.com (10.43.162.102) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 17 Mar 2019 15:52:12 +0000
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13d09UWC002.ant.amazon.com (10.43.162.102) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 17 Mar 2019 15:52:12 +0000
Received: from EX13D02UWC004.ant.amazon.com ([10.43.162.236]) by
 EX13D02UWC004.ant.amazon.com ([10.43.162.236]) with mapi id 15.00.1367.000;
 Sun, 17 Mar 2019 15:52:09 +0000
From:   "Saidi, Ali" <alisaidi@amazon.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Liguori, Anthony" <aliguori@amazon.com>
Subject: Re: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in
 mmap_base
Thread-Topic: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in
 mmap_base
Thread-Index: AQHU2PmhiRz/TsWOLEOmeVSaHu1ISKYJwNUAgAY/+B8=
Date:   Sun, 17 Mar 2019 15:52:08 +0000
Message-ID: <3A8AEAFE-315E-48D2-A246-D7BF1EBB9FF8@amazon.com>
References: <20190312173248.13490-1-alisaidi@amazon.com>
 <20190312173248.13490-3-alisaidi@amazon.com>,<1bd04037-698f-00c7-aa91-2bfec751bb0e@intel.com>
In-Reply-To: <1bd04037-698f-00c7-aa91-2bfec751bb0e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDEzLCAyMDE5LCBhdCAxMToyNiBBTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPj4gT24gMy8xMi8xOSAxMDozMiBBTSwgQWxpIFNh
aWRpIHdyb3RlOg0KPj4gKyAgICAvKiBQcm92aWRlIHNwYWNlIGZvciBicmsgcmFuZG9taXphdGlv
biAqLw0KPj4gKyAgICBwYWQgKz0gU1pfMzJNOw0KPiANCj4gSnVzdCBjdXJpb3VzOiAgV2h5IGlz
IHRoZSBwYWRkaW5nIGluIHlvdXIgb3RoZXIgcGF0Y2ggY29uZGl0aW9uYWwgb24gdGhlDQo+IDMy
LWJpdCB2cy4gNjQtYml0IGFwcHMsIGJ1dCBoZXJlIGl0J3MgYWx3YXlzIDMyTT8NCkFybSBjaGFu
Z2VzIHRoZSBhbW91bnQgb2YgYnJrIGJhc2VkIG9uIHRoZSBwcm9jZXNzIGJlaW5nIDMyIHZzIDY0
IGJpdC4gWDg2IGRvZXNu4oCZdCBhcHBlYXIgdG8gZG8gdGhpcy4gDQo+IA0KPiBBbHNvLCBkaWQg
eW91IGhpdCB0aGlzIHByb2JsZW0gaW4gcHJhY3RpY2Ugc29tZWhvdz8NCg0KSnVzdCBkZWJ1Z2dp
bmcgYSBjcmFzaCB3aGVuIHRlc3RpbmcgYSB2ZXJzaW9uIG9mIGEgbGlicmFyeSBJIGNvbXBpbGVk
LiANCg0KQWxp
