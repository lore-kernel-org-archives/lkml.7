Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04670C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C131320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="wM3ebq/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfGKRKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:10:32 -0400
Received: from mail-eopbgr790045.outbound.protection.outlook.com ([40.107.79.45]:53856
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728639AbfGKRKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:10:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLxPExYfOy8/05vdQHnbK3qUD9aGXaay3T2cLAT1e16sqkoL+f1o1PzzX/+hHe2kfLvmVgBLwaH4UQRTGWUlq3nLBhky3asF3tXiX8Y07OBS4Q2E82zxeR6m+/tbaSyU2X9AEPL+ZtanYj2oVc0I0+Y79j8qEL2g55zGRxjgiZKrI3MmsbzERn/EAgKzdOeWquf1m6mvPXdzFDwSG28kE6XLOr3mAdtF5UdfryopydJklfJd/Yl7nCtWxmBzxkLAwC9ePM5mIEqnbecPSrTIB0W8aKotVikCXVfVFzGyPkuydMniFfVH5JCJPR/YvrV4VvtEQyeJCqB9cxMJ8K7KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtMwGOJugBJWpMC6xORFWKhdnSsFAcVcjn0o5vUGYGU=;
 b=fFuNVPgxhZdfTb5gkmct46y81Llv4auvbkATZ2iF4cT3RljZzvdIxgYDUooLcavZ64sk7wjXhqPVDR6fpI0Jorvc4NNX44hULEZKttavGBzJH1EpCILMQhTWC6uryXeWRpOjXmpaqmqFuB/y+0M1W+jBWM7HCm+ZtLnrdMypjzALVa5gULaCXOKnhf+KMVF4pRHTHRmXEst9xnmw3yXzoksps9oIQBSJ4J40mFeurbH8CUs7/iAHnX+O0+Ct5zCalhDmBBfwB7GwrJ4DxOLhr4Ie4yVVZiaV/GytgIYV8ju/4SBV8nWLmcYSVknjKqLF/6FSE//5hf6k/jPLa2Zkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtMwGOJugBJWpMC6xORFWKhdnSsFAcVcjn0o5vUGYGU=;
 b=wM3ebq/v/Zg+D+Idj67UBS39kqB6+DcpjOrOOGMGNYbeL7OqXNvcI8oc4Xw3ApujwNcBUJUyU4JhhCchIs9+T1hb1JcZnSUR6wf8nvsUewUeAufUgrlVRjJ8TKZfViqxUONZc6Bobo7dQ6tdcJMF/bJCl/rt+Wqmp1u/5aMOp50=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYASPR01MB0019.namprd05.prod.outlook.com (20.177.126.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.7; Thu, 11 Jul 2019 17:09:09 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 17:09:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Xi Ruoyao <xry111@mengyan1223.wang>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
Thread-Topic: [GIT PULL] x86/topology changes for v5.3
Thread-Index: AQHVNxtt0mU1kD//MEyJwVSBEnYucabD3RUDgAAKnYCAARnCAIAADgsAgAB3aYCAACGUAA==
Date:   Thu, 11 Jul 2019 17:09:09 +0000
Message-ID: <9C204E93-5638-4272-A209-205A591D9FC7@vmware.com>
References: <201907091727.91CC6C72D8@keescook>
 <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
 <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
 <20190710134433.GN3402@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
 <89EBC357-BEAC-4252-915F-E183C2D350C4@vmware.com>
 <20190711080134.GT3402@hirez.programming.kicks-ass.net>
 <201907110806.9C79329@keescook>
In-Reply-To: <201907110806.9C79329@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [38.119.166.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba4e6ffe-af67-4bc7-818a-08d706227d40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYASPR01MB0019;
x-ms-traffictypediagnostic: BYASPR01MB0019:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYASPR01MB001971C0DF1481C20569B1F9D0F30@BYASPR01MB0019.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(66066001)(99286004)(5660300002)(71190400001)(71200400001)(229853002)(6246003)(81156014)(8936002)(478600001)(305945005)(68736007)(66556008)(81166006)(66476007)(86362001)(256004)(14444005)(64756008)(66446008)(76116006)(66946007)(486006)(316002)(102836004)(966005)(476003)(6306002)(76176011)(7416002)(36756003)(14454004)(6116002)(3846002)(4326008)(6436002)(6916009)(7736002)(53936002)(26005)(33656002)(8676002)(25786009)(6486002)(6512007)(54906003)(2906002)(53546011)(6506007)(11346002)(446003)(186003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYASPR01MB0019;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sw95ddQKUuRMWW9gUuJzo/B+dNe1Z9totsgOAhjtt8KhpJxdHmrMuMKmNvW7sGbFIVeMO9vWO2a7m/0sn6DlJSZMZduTzxbH1kkGyWOydQh2j0T26UcwxpIEc+hIxccJEnr1nmSTY71sOUcHGVMbc/ajsQV2YDC/6aWCADedsTiV0wIW80EKXeawxxaoQKtAu4RNEUdpIuTij2MlD9fk8m4CajDwBRZG9czwWZe/bRxlUbXa8Epuh8b98kXlKFmKuPt5S2w/RopLhVdIgkXodMScLlbnp3peLxWmqjXZ4etlPBs9pM5z/g0FWtae+z0P6USDXbj208kBE1SE/16d3dGdAaDOu0tHNBRwVxPn8KIikDbbTynYa+AbcYPxapmpy5rLfbgf8LBq4Oydlenhz/guVPI8aoXYKaeP3odaAKw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88644E2445D4134FA69FA6B4D196EE0A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4e6ffe-af67-4bc7-818a-08d706227d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 17:09:09.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTEsIDIwMTksIGF0IDg6MDggQU0sIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21p
dW0ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVsIDExLCAyMDE5IGF0IDEwOjAxOjM0QU0g
KzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4gT24gVGh1LCBKdWwgMTEsIDIwMTkgYXQg
MDc6MTE6MTlBTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+Pj4gT24gSnVsIDEwLCAyMDE5
LCBhdCA3OjIyIEFNLCBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+
IA0KPj4+PiBPbiBXZWQsIDEwIEp1bCAyMDE5LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+Pj4g
DQo+Pj4+PiBJZiB3ZSBtYXJrIHRoZSBrZXkgYXMgUk8gYWZ0ZXIgaW5pdCwgYW5kIHRoZW4gdHJ5
IGFuZCBtb2RpZnkgdGhlIGtleSB0bw0KPj4+Pj4gbGluayBtb2R1bGUgdXNhZ2Ugc2l0ZXMsIHRo
aW5ncyBtaWdodCBnbyBiYW5nIGFzIGRlc2NyaWJlZC4NCj4+Pj4+IA0KPj4+Pj4gVGhhbmtzIQ0K
Pj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2Nv
bW1vbi5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYw0KPj4+Pj4gaW5kZXggMjdkNzg2
NGU3MjUyLi41YmY3YTgzNTRkYTIgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2NvbW1vbi5jDQo+Pj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+
Pj4+PiBAQCAtMzY2LDcgKzM2Niw3IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBzZXR1
cF91bWlwKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4+Pj4+IAljcjRfY2xlYXJfYml0cyhYODZf
Q1I0X1VNSVApOw0KPj4+Pj4gfQ0KPj4+Pj4gDQo+Pj4+PiAtREVGSU5FX1NUQVRJQ19LRVlfRkFM
U0VfUk8oY3JfcGlubmluZyk7DQo+Pj4+PiArREVGSU5FX1NUQVRJQ19LRVlfRkFMU0UoY3JfcGlu
bmluZyk7DQo+Pj4+IA0KPj4+PiBHb29kIGNhdGNoLCBJIGd1ZXNzIHRoYXQgaXMgZ29pbmcgdG8g
Zml4IGl0Lg0KPj4+PiANCj4+Pj4gQXQgdGhlIHNhbWUgdGltZSB0aG91Z2gsIGl0IHNvcnQgb2Yg
ZGVzdHJveXMgdGhlIG9yaWdpbmFsIGludGVudCBvZiBLZWVzJyANCj4+Pj4gcGF0Y2gsIHJpZ2h0
PyBUaGUgZXhwbG9pdHMgd2lsbCBqdXN0IGhhdmUgdG8gY2FsbCBzdGF0aWNfa2V5X2Rpc2FibGUo
KSANCj4+Pj4gcHJpb3IgdG8gY2FsbGluZyBuYXRpdmVfd3JpdGVfY3I0KCkgYWdhaW4sIGFuZCB0
aGUgcHJvdGVjdGlvbiBpcyBnb25lLg0KPj4+IA0KPj4+IEV2ZW4gd2l0aCBERUZJTkVfU1RBVElD
X0tFWV9GQUxTRV9STygpLCBJIHByZXN1bWUgeW91IGNhbiBqdXN0IGNhbGwNCj4+PiBzZXRfbWVt
b3J5X3J3KCksIG1ha2UgdGhlIHBhZ2UgdGhhdCBob2xkcyB0aGUga2V5IHdyaXRhYmxlLCBhbmQg
dGhlbiBjYWxsDQo+Pj4gc3RhdGljX2tleV9kaXNhYmxlKCksIGZvbGxvd2VkIGJ5IGEgY2FsbCB0
byBuYXRpdmVfd3JpdGVfY3I0KCkuDQo+PiANCj4+IE9yIGNhbGwgdGV4dF9wb2tlX2JwKCkgd2l0
aCB0aGUgcmlnaHQgc2V0IG9mIGFyZ3VtZW50cy4NCj4gDQo+IFJpZ2h0IC0tIHRoZSBwb2ludCBp
cyB0byBtYWtlIGl0IGRlZmVuZGVkIGFnYWluc3QgYW4gYXJiaXRyYXJ5IHdyaXRlLA0KPiBub3Qg
YXJiaXRyYXJ5IGV4ZWN1dGlvbi4gTm90aGluZyBpcyBzYWZlIGZyb20gYXJiaXRyYXJ5IGV4ZWMs
IGJ1dCB3ZSBjYW4NCj4gZG8gb3VyIGR1ZSBkaWxpZ2VuY2Ugb24gbWFraW5nIHRoaW5ncyByZWFk
LW9ubHkuDQoNCkkgZG9u4oCZdCB1bmRlcnN0YW5kLg0KDQpJbiB0aGUgUG9DIHRoYXQgbW90aXZh
dGVkIHRoaXMgdGhpcyBwYXRjaCBbMV0sIHRoZSBhdHRhY2tlciBnYWluZWQgdGhlDQphYmlsaXR5
IHRvIGNhbGwgYSBmdW5jdGlvbiwgY29udHJvbCBpdHMgZmlyc3QgYXJndW1lbnQgYW5kIHVzZWQg
aXQgdG8NCmRpc2FibGUgU01FUC9TTUFQIGJ5IGNhbGxpbmcgbmF0aXZlX3dyaXRlX2NyNCgpLCB3
aGljaCBoZSBkaWQgYmVmb3JlIGRvaW5nDQphbiBhcmJpdHJhcnkgd3JpdGUgKGFub3RoZXIgYWJp
bGl0eSBoZSBnYWluKS4NCg0KQWZ0ZXIgdGhpcyBwYXRjaCwgdGhlIGF0dGFja2VyIGNhbiBpbnN0
ZWFkIGNhbGwgdGhyZWUgZnVuY3Rpb25zLCBhbmQgYnkNCmNvbnRyb2xsaW5nIHRoZWlyIGZpcnN0
IGFyZ3VtZW50cyAoKikgZGlzYWJsZSBTTUVQLiBJIGRpZG7igJl0IHNlZSBzb21ldGhpbmcNCmlu
IHRoZSBtb3RpdmF0aW5nIFBvQyB0aGF0IHByZXZlbnRlZCBjYWxsaW5nIDMgZnVuY3Rpb25zIG9u
ZSBhdCBhIHRpbWUuDQoNClNvIGl0IHNlZW1zIHRvIG1lIHRoYXQgaXQgcmFpc2VkIHRoZSBiYXIg
Zm9yIGFuIGF0dGFjayBieSB2ZXJ5IGxpdHRsZS4NCg0KLS0NCg0KKCopIHNldF9tZW1vcnlfcnco
KSBoYXMgYSBzZWNvbmQgYXJndW1lbnQgLSB0aGUgbnVtYmVyIG9mIHBhZ2VzIC0gYnV0IG1hbnkN
Cm5vbi16ZXJvIHZhbHVlcyBtYXkgYmUgZmluZSAoaWYgbm90IGEgd2FybmluZyBmcm9tIF9fY3Bh
X3Byb2Nlc3NfZmF1bHQoKQ0KbWlnaHQgYXBwZWFyKS4NCg0KWzFdIGh0dHBzOi8vZ29vZ2xlcHJv
amVjdHplcm8uYmxvZ3Nwb3QuY29tLzIwMTcvMDUvZXhwbG9pdGluZy1saW51eC1rZXJuZWwtdmlh
LXBhY2tldC5odG1sDQoNCg==
