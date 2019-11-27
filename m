Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B412C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289112070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="y/J96n3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfK0IUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:20:17 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54073 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0IUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:20:17 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 30F53886BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 21:20:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1574842814;
        bh=6C5xU0xEHLRVnKDkS/is0erdujOAcAU6UZXsUeS3Lxo=;
        h=From:To:CC:Subject:Date;
        b=y/J96n3zO4fvFBN6L6GfVTWmXLGgq7AMCbhZMUGMCPAVgR/U/8T6CWWHM+Hrd5UzG
         6T8+EYoJh9AnFjxsYHmEU6Op1ibJh6Wsv37lSXfvBH88EKcXb4q2lqNyhqbBFUIMzE
         LFCRNmm49LBelCPQeX5KgZo4AZ9YRD+gLuTSueeobJbf2GJw6pKV3oMcAFZxWjHwff
         atrq7UQLQKvGn2zyuGeyh+ioybmohKh7LuZOZhpLEvv6oa/vK6EnVqCq/XhyoVwEHQ
         By2KKNDcmd+6X7nAEjOJLqA+ecmjh557/DgHw+kw2FlKoR0rdm4zIVmhUu7nSLRn0Z
         ddN8TZX9QKN/A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dde31bf0000>; Wed, 27 Nov 2019 21:20:15 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 27 Nov 2019 21:20:13 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 27 Nov 2019 21:20:13 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: ARM expections for location of kernel, ramdisk and dtb
Thread-Topic: ARM expections for location of kernel, ramdisk and dtb
Thread-Index: AQHVpPt9nOgyqufu70+hpQyr7hZevQ==
Date:   Wed, 27 Nov 2019 08:20:12 +0000
Message-ID: <e1f7cca54843abcef0c2703a5f7071c045b99baa.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <03C71421C90DB741AC35CDECE470322F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpXZSdyZSB1cGRhdGluZyBvdXIgc3lzdGVtcyB0byB1c2UgdGhlIGxhdGVzdCBr
ZXJuZWwuIEZvciBtYW55IG9mIHRoZW0NCnRoaXMgaXMgYSBmYWlybHkgbGFyZ2UgbGVhcC4gT25l
IHByb2JsZW0gd2UndmUgaGl0IGlzIHRoYXQgZHVybmcgYm9vdA0KdGhlIGR0YiBpcyBjbG9iYmVy
ZWQgYnkgdGhlIHVuY29tcHJlc3NlZCBrZXJuZWwuDQoNCkhlcmUncyBhIHNuaXBwZXQgb2Ygb3V0
cHV0IGZyb20gdS1ib290DQoNCiMjIExvYWRpbmcga2VybmVsIGZyb20gRklUIEltYWdlIGF0IDYy
MDAwMDAwIC4uLg0KICAgVXNpbmcgJ1hTOTE2TVhTQDInIGNvbmZpZ3VyYXRpb24NCiAgIFRyeWlu
ZyAna2VybmVsQDEnIGtlcm5lbCBzdWJpbWFnZQ0KICAgICBEZXNjcmlwdGlvbjogIGxpbnV4DQog
ICAgIENyZWF0ZWQ6ICAgICAgMjAxOS0xMS0yNyAgIDY6NTM6NDggVVRDDQogICAgIFR5cGU6ICAg
ICAgICAgS2VybmVsIEltYWdlDQogICAgIENvbXByZXNzaW9uOiAgdW5jb21wcmVzc2VkDQogICAg
IERhdGEgU3RhcnQ6ICAgMHg2MjAwMDE3NA0KICAgICBEYXRhIFNpemU6ICAgIDM0OTU0MzIgQnl0
ZXMgPSAzLjMgTWlCDQogICAgIEFyY2hpdGVjdHVyZTogQVJNDQogICAgIE9TOiAgICAgICAgICAg
TGludXgNCiAgICAgTG9hZCBBZGRyZXNzOiAweDAwODAwMDAwDQogICAgIEVudHJ5IFBvaW50OiAg
MHg2MDgwMDAwMA0KICAgLi4uDQogICBCb290aW5nIHVzaW5nIHRoZSBmZHQgYmxvYiBhdCAweDYz
YjkwZjZjDQogICBMb2FkaW5nIEtlcm5lbCBJbWFnZSAuLi4gT0sNCiAgIExvYWRpbmcgUmFtZGlz
ayB0byA2ZTdjNjAwMCwgZW5kIDcwMDAwMDAwIC4uLiBPSw0KICAgTG9hZGluZyBEZXZpY2UgVHJl
ZSB0byA2MDdmYjAwMCwgZW5kIDYwN2ZmZmQ4IC4uLiBPSw0KDQpTdGFydGluZyBrZXJuZWwgLi4u
DQoNClVuY29tcHJlc3NpbmcgTGludXguLi4gZG9uZSwgYm9vdGluZyB0aGUga2VybmVsLg0KDQpF
cnJvcjogaW52YWxpZCBkdGIgYW5kIHVucmVjb2duaXplZC91bnN1cHBvcnRlZCBtYWNoaW5lIElE
DQogIHIxPTB4MDAwMDIwNmUsIHIyPTB4MDAwMDAwMDANCg0KQmV0d2VlbiBvbGQgYW5kIG5ldyB0
aGUgbG9jYXRpb24gb2YgdGhlIGRldmljZXRyZWUgaGFzbid0IGFjdHVhbGx5DQpjaGFuZ2VkLiBC
dXQgd2hhdCBoYXMgY2hhbmdlZCBpcyB0aGUgc2l6ZSBvZiB0aGUga2VybmVsIHRoZSBzZWxmDQpl
eHRyYWN0aW5nIGtlcm5lbCB1bnBhY2tzIHRvIDB4NjAwMDgwMDAgYW5kIHdpdGggb3VyIGN1cnJl
bnQNCmNvbmZpZ3VyYXRpb24gZXh0ZW5kcyBpbnRvIHdoZXJlIHRoZSBkdGIgaXMgbG9jYXRlZC4N
Cg0KRG9jdW1lbnRhdGlvbi9hcm0vYm9vdGluZy5yc3Qgc2F5cyB0aGF0ICJUaGUgZHRiIG11c3Qg
YmUgcGxhY2VkIGluIGENCnJlZ2lvbiBvZiBtZW1vcnkgd2hlcmUgdGhlIGtlcm5lbCBkZWNvbXBy
ZXNzb3Igd2lsbCBub3Qgb3ZlcndyaXRlIGl0Ii4gDQoNClRoaXMgc3VnZ2VzdHMgdGhhdCB0aGUg
cHJvYmxlbSBpcyB3aXRoIG91ciB1LWJvb3QgY29uZmlndXJhdGlvbiwgYnV0DQpob3cgaXMgdS1i
b290IHN1cHBvc2VkIHRvIGtub3cgd2hlcmUgdGhlIHNlbGYtZXh0cmFjdGluZyBrZXJuZWwgaXMN
CmdvaW5nIHRvIHBsYWNlIHRoaW5ncz8gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdS1ib290IGlzIGRv
aW5nIGENCnJlYXNvbmFibGUgam9iIG9mIGZpbmRpbmcgYSBwbGFjZSB0byBwdXQgdGhlIGR0YiB3
aGljaCBpdCB0aGlua3MgaXMNCnVudXNlZC4gSSdtIG5vdCBzdXJlIHdoeSBpdCdzIHBpY2tlZCAw
eDYwN2ZiMDAwIGluc3RlYWQgb2YgcHV0dGluZyBpdA0KanVzdCB1bmRlciB0aGUgcmFtZGlzayBi
dXQgcmVnYXJkbGVzcyB3aXRoIHRoZSBpbmZvcm1hdGlvbiB1LWJvb3QgaGFzDQp0aGF0IGFkZHJl
c3MgaXMgdXAgZm9yIGdyYWJzLg0KDQpIYXMgdGhpcyBjb21lIHVwIGJlZm9yZT8gVGhlIHNlbGYt
ZXh0cmFjdGlvbiBjb2RlIGlzIGZhaXJseSBjYXJlZnVsIG5vdA0KdG8gb3ZlcndyaXRlIGl0c2Vs
ZiBidXQgZG9lc24ndCBzZWVtIHRvIHBheSBhbnkgYXR0ZW50aW9uIHRvIHRoZSBkdGINCndoaWNo
IHN1cnByaXNlZCBtZS4gU28gSSB3b25kZXIgaWYgSSdtIG1pc3Npbmcgc29tZXRoaW5nPw0KDQpU
aGFua3MsDQpDaHJpcw0KDQo=
