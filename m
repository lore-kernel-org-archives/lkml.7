Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D189C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10D82178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbfKGRY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:24:29 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:63831 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729669AbfKGRY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:24:29 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xA7HN2jR047371
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 8 Nov 2019 01:23:02 +0800 (CST)
        (envelope-from lvqiang.huang@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 8 Nov 2019
 01:23:04 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.0847.030; Fri, 8 Nov 2019 01:22:46 +0800
From:   =?gb2312?B?u8bCwMe/IChMdnFpYW5nIEh1YW5nKQ==?= 
        <lvqiang.huang@unisoc.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: check __ex_table in do_bad()
Thread-Topic: [PATCH] ARM: check __ex_table in do_bad()
Thread-Index: AQHVlT9LZv+9LX02T0yFglLQtX/ntKd+6ZYAgAEL2yc=
Date:   Thu, 7 Nov 2019 17:22:45 +0000
Message-ID: <CE4726AD-630F-44A0-862B-23BC8E6A7E4C@unisoc.com>
References: <1573112713-10115-1-git-send-email-Lvqiang.Huang@unisoc.com>,<20191107092404.GV25745@shell.armlinux.org.uk>
In-Reply-To: <20191107092404.GV25745@shell.armlinux.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com xA7HN2jR047371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


DQo+INTaIDIwMTnE6jEx1MI3yNWjrDE3OjI0o6xSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggYWRt
aW4gPGxpbnV4QGFybWxpbnV4Lm9yZy51az4g0LS1wKO6DQo+IA0KPj4gT24gVGh1LCBOb3YgMDcs
IDIwMTkgYXQgMDM6NDU6MTNQTSArMDgwMCwgTHZxaWFuZyB3cm90ZToNCj4+IA0KPj4gV2UgZ290
IG1hbnkgY3Jhc2hzIGluIGZvcl9lYWNoX2ZyYW1lKzB4MTggYXJjaC9hcm0vbGliL2JhY2t0cmFj
ZS5TDQo+PiAgICAxMDAzOiBsZHIgcjIsIFtzdl9wYywgIy00XQ0KPj4gDQo+PiBUaGUgYmFja3Ry
YWNlIGlzDQo+PiAgICBkdW1wX2JhY2t0cmFjZQ0KPj4gICAgc2hvd19zdGFjaw0KPj4gICAgc2No
ZWRfc2hvd190YXNrDQo+PiAgICBzaG93X3N0YXRlX2ZpbHRlcg0KPj4gICAgc3lzcnFfaGFuZGxl
X3Nob3dzdGF0ZV9ibG9ja2VkDQo+PiAgICBfX2hhbmRsZV9zeXNycQ0KPj4gICAgd3JpdGVfc3lz
cnFfdHJpZ2dlcg0KPj4gICAgcHJvY19yZWdfd3JpdGUNCj4+ICAgIF9fdmZzX3dyaXRlDQo+PiAg
ICB2ZnNfd3JpdGUNCj4+ICAgIHN5c193cml0ZQ0KPj4gDQo+PiBSZWxhdGVkIEtlcm5lbCBjb25m
aWcNCj4+ICAgIENPTkZJR19DUFVfU1dfRE9NQUlOX1BBTj15DQo+PiAgICAjIENPTkZJR19BUk1f
VU5XSU5EIGlzIG5vdCBzZXQNCj4+ICAgIENPTkZJR19GUkFNRV9QT0lOVEVSPXkNCj4+IA0KPj4g
VGhlIHRhc2sgQSB3YXMgZHVtcGluZyB0aGUgc3RhY2sgb2YgYW4gVU4gdGFzayBCLiBIb3dldmVy
LCB0aGUgdGFzayBCDQo+IA0KPiBXaGF0IGlzICJhbiBVTiB0YXNrIEIiPw0KDQpVTiBtZWFucyBU
QVNLX1VOSU5URVJSVVBUSUJMRS4gDQooU29ycnkgZm9yIHRoZSB0eXBvIGluIHRoZSBsYXN0IHJl
cGx5KQ0KDQo+PiBzY2hlZHVsZWQgdG8gcnVuIG9uIGFub3RoZXIgQ1BVLCB3aGljaCBjYXVzZSBp
dCBzdGFjayBjb250ZW50IGNoYW5nZWQuDQo+PiBUaGVuLCB0YXNrIEEgbWF5IGhpdCBhIHBhZ2Ug
ZG9tYWluIGZhdWx0IGFuZCBkaWUoKS4NCj4+ICAgIFs1MjAuNjYxMzE0XSBVbmhhbmRsZWQgZmF1
bHQ6IHBhZ2UgZG9tYWluIGZhdWx0ICgweDAxYikgYXQgMHgzMjg0OGMwMg0KPiANCj4gU28sIHRo
ZSBiYWNrdHJhY2UgY29kZSBpcyB0cnlpbmcgdG8gYWNjZXNzIHVzZXJzcGFjZS4gIEl0IGlzbid0
IHN1cHBvc2VkDQo+IHRvIGJlIGFjY2Vzc2luZyB1c2Vyc3BhY2UgLSB0aGVyZSBhcmUgbm8gZ3Vh
cmFudGVlcyB0aGF0IHVzZXJzcGFjZSB3aWxsDQo+IGJlIHVzaW5nIGZyYW1lIHBvaW50ZXJzLiAg
VGhhdCBpcyB0aGUgYnVnLg0KPiANCg0KVGhlcmUgaXMgYSByYWNlIGNvbmRpdGlvbiB3aGVuIHRy
eSB0byBnZXQgdGhlIGJhY2t0cmFjZSBvZiBhbm90aGVyIHRhc2ujrHdob3NlIGZyYW1lcyBtYXkg
dG90YWxseSBjaGFuZ2VkIGR1cmluZyB0aGUgZXhlY3V0aW9uLiANCg0KPiAtLSANCj4gUk1LJ3Mg
UGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNo
ZXMvDQo+IEZUVEMgYnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmUgaW4gc3VidXJiaWE6IHN5bmMg
YXQgMTIuMU1icHMgZG93biA2MjJrYnBzIHVwDQo+IEFjY29yZGluZyB0byBzcGVlZHRlc3QubmV0
OiAxMS45TWJwcyBkb3duIDUwMGticHMgdXANCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGlz
IGVtYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRzKSBpcyBpbnRlbmRlZCBvbmx5IGZvciB0
aGUgcGVyc29uIG9yIGVudGl0eSB0byB3aGljaCBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250
YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCwgY29uZmlkZW50aWFsIG9yIG90aGVy
d2lzZSBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9zdXJlLiBVbmF1dGhvcml6ZWQgdXNlLCBkaXNzZW1p
bmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29weWluZyBvZiB0aGlzIGVtYWlsIG9yIHRoZSBpbmZv
cm1hdGlvbiBoZXJlaW4gb3IgdGFraW5nIGFueSBhY3Rpb24gaW4gcmVsaWFuY2Ugb24gdGhlIGNv
bnRlbnRzIG9mIHRoaXMgZW1haWwgb3IgdGhlIGluZm9ybWF0aW9uIGhlcmVpbiwgYnkgYW55b25l
IG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgb3IgYW4gZW1wbG95ZWUgb3IgYWdl
bnQgcmVzcG9uc2libGUgZm9yIGRlbGl2ZXJpbmcgdGhlIG1lc3NhZ2UgdG8gdGhlIGludGVuZGVk
IHJlY2lwaWVudCwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRvIG5vdCByZWFkLCBjb3B5LCB1c2Ugb3IgZGlzY2xv
c2UgYW55IHBhcnQgb2YgdGhpcyBlLW1haWwgdG8gb3RoZXJzLiBQbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYW5kIHBlcm1hbmVudGx5IGRlbGV0ZSB0aGlzIGUtbWFpbCBhbmQg
YW55IGF0dGFjaG1lbnRzIGlmIHlvdSByZWNlaXZlZCBpdCBpbiBlcnJvci4gSW50ZXJuZXQgY29t
bXVuaWNhdGlvbnMgY2Fubm90IGJlIGd1YXJhbnRlZWQgdG8gYmUgdGltZWx5LCBzZWN1cmUsIGVy
cm9yLWZyZWUgb3IgdmlydXMtZnJlZS4gVGhlIHNlbmRlciBkb2VzIG5vdCBhY2NlcHQgbGlhYmls
aXR5IGZvciBhbnkgZXJyb3JzIG9yIG9taXNzaW9ucy4gDQqxvtPKvP68sMbkuL28/r7f09Cxo8Pc
0NTWyqOsyty3qMLJsaO7pLK7tcPQucK2o6y99reiy824+LG+08q8/sv51rjM2LaoytW8/sjLoaPR
z737t8e+rcrayKjKudPDoaLQ+7SroaK3orK8u/K4tNbGsb7Tyrz+u/LG5MTayN2ho8j0t8e4w8zY
tqjK1bz+yMujrMfrzvDUxLbBoaK4tNbGoaIgyrnTw7vyxfvCtrG+08q8/rXEyM66zsTayN2ho8j0
zvPK1bG+08q8/qOsx+u008+1zbPW0NPAvsPQ1Mm+s/2xvtPKvP68sMv509C4vbz+o6yyotLUu9i4
tNPKvP61xLe9yr28tL/MuObWqreivP7Iy6Gjzt63qLGj1qS7pcGqzfjNqNDFvLDKsaGisLLIq6Gi
zt7O87vyt8C2vqGjt6K8/sjLttTIzrrOtO3Cqb75sruz0LWj1PDIzqGjDQo=

