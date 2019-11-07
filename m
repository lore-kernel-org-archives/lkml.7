Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D408F214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfKGPcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:32:16 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:56668 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbfKGPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:32:16 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xA7FUKWd066645
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 7 Nov 2019 23:30:20 +0800 (CST)
        (envelope-from lvqiang.huang@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 7 Nov 2019
 23:30:27 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.0847.030; Thu, 7 Nov 2019 23:30:14 +0800
From:   =?gb2312?B?u8bCwMe/IChMdnFpYW5nIEh1YW5nKQ==?= 
        <lvqiang.huang@unisoc.com>
To:     "'Russell King - ARM Linux admin'" <linux@armlinux.org.uk>
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
Subject: RE: [PATCH] ARM: check __ex_table in do_bad()
Thread-Topic: [PATCH] ARM: check __ex_table in do_bad()
Thread-Index: AQHVlT9LZv+9LX02T0yFglLQtX/ntKd+6ZYAgADnuyA=
Date:   Thu, 7 Nov 2019 15:30:14 +0000
Message-ID: <cbf0ce049a04418999ff9fcbdcf38620@BJMBX01.spreadtrum.com>
References: <1573112713-10115-1-git-send-email-Lvqiang.Huang@unisoc.com>
 <20191107092404.GV25745@shell.armlinux.org.uk>
In-Reply-To: <20191107092404.GV25745@shell.armlinux.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.64.20]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com xA7FUKWd066645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


SGkgUnVzc2VsbCwNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHJlcGx5IQ0KDQpVTiBtZWFucyBUQVNL
X0lOVEVSUlVQVElCTEUuIA0KDQpUYXNrIEEgZm91bmQgdGhlIFRhc2sgQiB3YXMgaW4gVEFTS19J
TlRFUlJVUFRJQkxFLiANCkJ1dCBqdXN0IGR1cmluZyB0cnkgdG8gZ2V0IHRoZSBiYWNrdHJhY2Ug
b2YgVGFzayBCLCB0aGUgVGFzayBCIGNoYW5nZWQgdG8gVEFTS19SVU5OSU5HDQoNClRhc2sgQiBw
dXNoIGFuZCBwb3AgdG8gaXQgc3RhY2sgZHVyaW5nIGV4ZWN1dGluZywgc28gdGhlIHN0YWNrIGNv
bnRleHQgb2YgdGFzayBCIGNoYW5nZWQgYSBsb3QuIA0KQnV0IFRhc2sgQSBjYWxjdWxhdGVkIGFu
ZCBwb3AgYSB2YWx1ZSBhcyBzdl9mcCBvZiBUYXNrIEIuIA0KMTAwMjoJCWxkcglzdl9mcCwgW2Zy
YW1lLCAjLTEyXQlAIGdldCBzYXZlZCBmcA0KDQpCdXQsIHRoZSB0YXNrIEIgaGFkIGJlZW4gVEFT
S19SVU5OSU5HLCBzdl9mcCBUYXNrIEEgZ2V0IGNhbiBiZSBhbnkgdmFsdWUgY2hhbmVkIGJ5IHRo
ZSBleGVjdXRpbmcgb2YgVGFzayBCLiANCkl0IGNhbiBiZSBhbiBhY2Nlc3NpYmxlIHVzZXItc3Bh
Y2UgYWRkcmVzcyBvZiBUYXNrIEEncyBhZGRyZXNzIHNwYWNlLiANCg0KSWYgd2UgZW5hYmxlIHRo
ZSBDT05GSUdfQVJNX1VOV0lORCwgdGhlIGNyYXNoIGlzIGdvbmUuIA0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IGFkbWluIFttYWls
dG86bGludXhAYXJtbGludXgub3JnLnVrXSANClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAwNywg
MjAxOSA1OjI0IFBNDQpUbzogu8bCwMe/IChMdnFpYW5nIEh1YW5nKQ0KQ2M6IGViaWVkZXJtQHht
aXNzaW9uLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyBhbnNodW1hbi5raGFuZHVh
bEBhcm0uY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBmLmZhaW5lbGxpQGdtYWlsLmNv
bTsgd2lsbEBrZXJuZWwub3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVj
dDogUmU6IFtQQVRDSF0gQVJNOiBjaGVjayBfX2V4X3RhYmxlIGluIGRvX2JhZCgpDQoNCk9uIFRo
dSwgTm92IDA3LCAyMDE5IGF0IDAzOjQ1OjEzUE0gKzA4MDAsIEx2cWlhbmcgd3JvdGU6DQo+IA0K
PiBXZSBnb3QgbWFueSBjcmFzaHMgaW4gZm9yX2VhY2hfZnJhbWUrMHgxOCBhcmNoL2FybS9saWIv
YmFja3RyYWNlLlMNCj4gICAgIDEwMDM6IGxkciByMiwgW3N2X3BjLCAjLTRdDQo+IA0KPiBUaGUg
YmFja3RyYWNlIGlzDQo+ICAgICBkdW1wX2JhY2t0cmFjZQ0KPiAgICAgc2hvd19zdGFjaw0KPiAg
ICAgc2NoZWRfc2hvd190YXNrDQo+ICAgICBzaG93X3N0YXRlX2ZpbHRlcg0KPiAgICAgc3lzcnFf
aGFuZGxlX3Nob3dzdGF0ZV9ibG9ja2VkDQo+ICAgICBfX2hhbmRsZV9zeXNycQ0KPiAgICAgd3Jp
dGVfc3lzcnFfdHJpZ2dlcg0KPiAgICAgcHJvY19yZWdfd3JpdGUNCj4gICAgIF9fdmZzX3dyaXRl
DQo+ICAgICB2ZnNfd3JpdGUNCj4gICAgIHN5c193cml0ZQ0KPiANCj4gUmVsYXRlZCBLZXJuZWwg
Y29uZmlnDQo+ICAgICBDT05GSUdfQ1BVX1NXX0RPTUFJTl9QQU49eQ0KPiAgICAgIyBDT05GSUdf
QVJNX1VOV0lORCBpcyBub3Qgc2V0DQo+ICAgICBDT05GSUdfRlJBTUVfUE9JTlRFUj15DQo+IA0K
PiBUaGUgdGFzayBBIHdhcyBkdW1waW5nIHRoZSBzdGFjayBvZiBhbiBVTiB0YXNrIEIuIEhvd2V2
ZXIsIHRoZSB0YXNrIEINCg0KV2hhdCBpcyAiYW4gVU4gdGFzayBCIj8NCg0KPiBzY2hlZHVsZWQg
dG8gcnVuIG9uIGFub3RoZXIgQ1BVLCB3aGljaCBjYXVzZSBpdCBzdGFjayBjb250ZW50IGNoYW5n
ZWQuDQo+IFRoZW4sIHRhc2sgQSBtYXkgaGl0IGEgcGFnZSBkb21haW4gZmF1bHQgYW5kIGRpZSgp
Lg0KPiAgICAgWzUyMC42NjEzMTRdIFVuaGFuZGxlZCBmYXVsdDogcGFnZSBkb21haW4gZmF1bHQg
KDB4MDFiKSBhdCANCj4gMHgzMjg0OGMwMg0KDQpTbywgdGhlIGJhY2t0cmFjZSBjb2RlIGlzIHRy
eWluZyB0byBhY2Nlc3MgdXNlcnNwYWNlLiAgSXQgaXNuJ3Qgc3VwcG9zZWQgdG8gYmUgYWNjZXNz
aW5nIHVzZXJzcGFjZSAtIHRoZXJlIGFyZSBubyBndWFyYW50ZWVzIHRoYXQgdXNlcnNwYWNlIHdp
bGwgYmUgdXNpbmcgZnJhbWUgcG9pbnRlcnMuICBUaGF0IGlzIHRoZSBidWcuDQoNCi0tDQpSTUsn
cyBQYXRjaCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0
Y2hlcy8NCkZUVEMgYnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmUgaW4gc3VidXJiaWE6IHN5bmMg
YXQgMTIuMU1icHMgZG93biA2MjJrYnBzIHVwIEFjY29yZGluZyB0byBzcGVlZHRlc3QubmV0OiAx
MS45TWJwcyBkb3duIDUwMGticHMgdXANCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGlzIGVt
YWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRzKSBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUg
cGVyc29uIG9yIGVudGl0eSB0byB3aGljaCBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250YWlu
IGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCwgY29uZmlkZW50aWFsIG9yIG90aGVyd2lz
ZSBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9zdXJlLiBVbmF1dGhvcml6ZWQgdXNlLCBkaXNzZW1pbmF0
aW9uLCBkaXN0cmlidXRpb24gb3IgY29weWluZyBvZiB0aGlzIGVtYWlsIG9yIHRoZSBpbmZvcm1h
dGlvbiBoZXJlaW4gb3IgdGFraW5nIGFueSBhY3Rpb24gaW4gcmVsaWFuY2Ugb24gdGhlIGNvbnRl
bnRzIG9mIHRoaXMgZW1haWwgb3IgdGhlIGluZm9ybWF0aW9uIGhlcmVpbiwgYnkgYW55b25lIG90
aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgb3IgYW4gZW1wbG95ZWUgb3IgYWdlbnQg
cmVzcG9uc2libGUgZm9yIGRlbGl2ZXJpbmcgdGhlIG1lc3NhZ2UgdG8gdGhlIGludGVuZGVkIHJl
Y2lwaWVudCwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVu
ZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRvIG5vdCByZWFkLCBjb3B5LCB1c2Ugb3IgZGlzY2xvc2Ug
YW55IHBhcnQgb2YgdGhpcyBlLW1haWwgdG8gb3RoZXJzLiBQbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgaW1tZWRpYXRlbHkgYW5kIHBlcm1hbmVudGx5IGRlbGV0ZSB0aGlzIGUtbWFpbCBhbmQgYW55
IGF0dGFjaG1lbnRzIGlmIHlvdSByZWNlaXZlZCBpdCBpbiBlcnJvci4gSW50ZXJuZXQgY29tbXVu
aWNhdGlvbnMgY2Fubm90IGJlIGd1YXJhbnRlZWQgdG8gYmUgdGltZWx5LCBzZWN1cmUsIGVycm9y
LWZyZWUgb3IgdmlydXMtZnJlZS4gVGhlIHNlbmRlciBkb2VzIG5vdCBhY2NlcHQgbGlhYmlsaXR5
IGZvciBhbnkgZXJyb3JzIG9yIG9taXNzaW9ucy4gDQqxvtPKvP68sMbkuL28/r7f09Cxo8Pc0NTW
yqOsyty3qMLJsaO7pLK7tcPQucK2o6y99reiy824+LG+08q8/sv51rjM2LaoytW8/sjLoaPRz737
t8e+rcrayKjKudPDoaLQ+7SroaK3orK8u/K4tNbGsb7Tyrz+u/LG5MTayN2ho8j0t8e4w8zYtqjK
1bz+yMujrMfrzvDUxLbBoaK4tNbGoaIgyrnTw7vyxfvCtrG+08q8/rXEyM66zsTayN2ho8j0zvPK
1bG+08q8/qOsx+u008+1zbPW0NPAvsPQ1Mm+s/2xvtPKvP68sMv509C4vbz+o6yyotLUu9i4tNPK
vP61xLe9yr28tL/MuObWqreivP7Iy6Gjzt63qLGj1qS7pcGqzfjNqNDFvLDKsaGisLLIq6Gizt7O
87vyt8C2vqGjt6K8/sjLttTIzrrOtO3Cqb75sruz0LWj1PDIzqGjDQo=

