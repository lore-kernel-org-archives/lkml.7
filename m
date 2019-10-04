Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D0120862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0qHrBAcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfJDMhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:37:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26344 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728663AbfJDMhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:37:15 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94CaA2g001830;
        Fri, 4 Oct 2019 14:36:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Eq8VGRzEydG9y1D55iUlCtr/VO3wW2x8s/HTu6+rxeg=;
 b=0qHrBAcR+zkoC7C7KOBU4ZCJWSf8XdwfPAG0XtJzzKOhrS1CLL4M1lR/7shesNM0JHu0
 Orp+4CzN6D6iSqOfMJSBbyZqV//+s91lkyy/Trkax/NTGukeDXOycKBrjn7pCSkftuRe
 +k6aXnsqt/z98Lb0lKeLszpiIVddFgbwRcEr/Zpq3aGmVlORlFMAg9ntRQIhH+OLo2WO
 KMf5LeLBuJBNzCc4QTv5tWjMcvXYhXmzuN1S9Cl5OzEMhT7o2Dwtz5XRy4IP4SiY29yD
 DirOsebwqxN8lIHCQ98okr4GT5lkXjeLBUXtRm1DcyKirpfY0TeZpzGhdCayzdIccJDz Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9vnau0r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 14:36:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3884610002A;
        Fri,  4 Oct 2019 14:36:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DFB8A2BE246;
        Fri,  4 Oct 2019 14:36:56 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 4 Oct
 2019 14:36:56 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 4 Oct 2019 14:36:56 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: atomic helper: fix W=1 warnings
Thread-Topic: [PATCH] drm: atomic helper: fix W=1 warnings
Thread-Index: AQHVZxXHHTYpJmVaDk2WfbFEBA3KtKdI/bcAgAAFYgCAAAUtAIAACOSAgAACkoCAAT70AIAAG9+AgAACjYA=
Date:   Fri, 4 Oct 2019 12:36:56 +0000
Message-ID: <5fe9d7e2-f434-70cb-ac0f-ad66a565093d@st.com>
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <20190909135205.10277-2-benjamin.gaignard@st.com>
 <20191003142738.GM1208@intel.com>
 <CA+M3ks4FBAgCRDDHZ=x7kvQ1Y=0dBdj4+KLO2djh__hW+L=3gQ@mail.gmail.com>
 <20191003150526.GN1208@intel.com>
 <CA+M3ks7-SNusVJsiHqrmy4AN+_OO5e1X=ZRN16Hj6f-V3GnVow@mail.gmail.com>
 <20191003154627.GQ1208@intel.com>
 <CA+M3ks4gpDdZTPdBYRd=CrwgEYiSWJbXqvtPb-0KpW1BhzvmEQ@mail.gmail.com>
 <20191004122747.GT1208@intel.com>
In-Reply-To: <20191004122747.GT1208@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DD3969DC9BA124BA94E8961F5D561CA@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC80LzE5IDI6MjcgUE0sIFZpbGxlIFN5cmrDpGzDpCB3cm90ZToNCj4gT24gRnJpLCBP
Y3QgMDQsIDIwMTkgYXQgMTI6NDg6MDJQTSArMDIwMCwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6
DQo+PiBMZSBqZXUuIDMgb2N0LiAyMDE5IMOgIDE3OjQ2LCBWaWxsZSBTeXJqw6Rsw6QNCj4+IDx2
aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4gYSDDqWNyaXQgOg0KPj4+IE9uIFRodSwgT2N0
IDAzLCAyMDE5IGF0IDA1OjM3OjE1UE0gKzAyMDAsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0K
Pj4+PiBMZSBqZXUuIDMgb2N0LiAyMDE5IMOgIDE3OjA1LCBWaWxsZSBTeXJqw6Rsw6QNCj4+Pj4g
PHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPiBhIMOpY3JpdCA6DQo+Pj4+PiBPbiBUaHUs
IE9jdCAwMywgMjAxOSBhdCAwNDo0Njo1NFBNICswMjAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90
ZToNCj4+Pj4+PiBMZSBqZXUuIDMgb2N0LiAyMDE5IMOgIDE2OjI3LCBWaWxsZSBTeXJqw6Rsw6QN
Cj4+Pj4+PiA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+IGEgw6ljcml0IDoNCj4+Pj4+
Pj4gT24gTW9uLCBTZXAgMDksIDIwMTkgYXQgMDM6NTI6MDVQTSArMDIwMCwgQmVuamFtaW4gR2Fp
Z25hcmQgd3JvdGU6DQo+Pj4+Pj4+PiBGaXggd2FybmluZ3Mgd2l0aCBXPTEuDQo+Pj4+Pj4+PiBG
ZXcgZm9yX2VhY2ggbWFjcm8gc2V0IHZhcmlhYmxlcyB0aGF0IGFyZSBuZXZlciB1c2VkIGxhdGVy
Lg0KPj4+Pj4+Pj4gUHJldmVudCB3YXJuaW5nIGJ5IG1hcmtpbmcgdGhlc2UgdmFyaWFibGVzIGFz
IF9fbWF5YmVfdW51c2VkLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEJlbmph
bWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+Pj4+Pj4+PiAtLS0NCj4+
Pj4+Pj4+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMgfCAzNiArKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYyBiL2RyaXZlcnMv
Z3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jDQo+Pj4+Pj4+PiBpbmRleCBhYTE2ZWExN2ZmOWIu
LmI2OWQxN2IwYjliZCAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1f
YXRvbWljX2hlbHBlci5jDQo+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21p
Y19oZWxwZXIuYw0KPj4+Pj4+Pj4gQEAgLTI2Miw3ICsyNjIsNyBAQCBzdGVhbF9lbmNvZGVyKHN0
cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwNCj4+Pj4+Pj4+ICAgICAgICAgICAgICBzdHJ1
Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIpDQo+Pj4+Pj4+PiAgIHsNCj4+Pj4+Pj4+ICAgICAgICBz
dHJ1Y3QgZHJtX2NydGNfc3RhdGUgKmNydGNfc3RhdGU7DQo+Pj4+Pj4+PiAtICAgICBzdHJ1Y3Qg
ZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yOw0KPj4+Pj4+Pj4gKyAgICAgc3RydWN0IGRybV9jb25u
ZWN0b3IgX19tYXliZV91bnVzZWQgKmNvbm5lY3RvcjsNCj4+Pj4+Pj4gUmF0aGVyIHVnbHkuIElN
TyB3b3VsZCBiZSBuaWNlciBpZiB3ZSBjb3VsZCBoaWRlIHNvbWV0aGluZyBpbnNpZGUNCj4+Pj4+
Pj4gdGhlIGl0ZXJhdG9yIG1hY3JvcyB0byBzdXBwcmVzcyB0aGUgd2FybmluZy4NCj4+Pj4+PiBP
ayBidXQgaG93ID8NCj4+Pj4+PiBjb25uZWN0b3IgaXMgYXNzaWduZWQgaW4gdGhlIG1hY3JvcyBi
dXQgbm90IHVzZWQgbGF0ZXIgYW5kIHdlIGNhbid0DQo+Pj4+Pj4gc2V0ICJfX21heWJlX3VudXNl
ZCINCj4+Pj4+PiBpbiB0aGUgbWFjcm8uDQo+Pj4+Pj4gRG9lcyBhbm90aGVyIGtleXdvcmQgZXhp
c3QgZm9yIHRoYXQgPw0KPj4+Pj4gU3RpY2sgYSAodm9pZCkoY29ubmVjdG9yKSBpbnRvIHRoZSBt
YWNybz8NCj4+Pj4gVGhhdCBjb3VsZCB3b3JrIGJ1dCBpdCB3aWxsIGxvb2sgc3RyYW5nZSBpbnNp
ZGUgdGhlIG1hY3JvLg0KPj4+Pg0KPj4+Pj4gQW5vdGhlciAoYXJndWFibHkgY2xlYW5lcikgaWRl
YSB3b3VsZCBiZSB0byByZW1vdmUgdGhlIGNvbm5lY3Rvci9jcnRjL3BsYW5lDQo+Pj4+PiBhcmd1
bWVudCBmcm9tIHRoZSBpdGVyYXRvcnMgZW50aXJlbHkgc2luY2UgaXQncyByZWR1bmRhbnQsIGFu
ZCBpbnN0ZWFkIGp1c3QNCj4+Pj4+IGV4dHJhY3QgaXQgZnJvbSB0aGUgYXBwcm9wcmlhdGUgbmV3
L29sZCBzdGF0ZSBhcyBuZWVkZWQuDQo+Pj4+Pg0KPj4+Pj4gV2UgY291bGQgdGhlbiBhbHNvIGFk
ZCBhIGZvcl9lYWNoX2Nvbm5lY3Rvcl9pbl9zdGF0ZSgpL2V0Yy4gd2hpY2ggb21pdA0KPj4+Pj4g
cyB0aGUgc3RhdGUgYXJndW1lbnRzIGFuZCBqdXN0IGhhcyB0aGUgY29ubmVjdG9yIGFyZ3VtZW50
LCBmb3IgY2FzZXMgd2hlcmUNCj4+Pj4+IHlvdSBkb24ndCBjYXJlIGFib3V0IHRoZSBzdGF0ZXMg
d2hlbiBpdGVyYXRpbmcuDQo+Pj4+IFRoYXQgbWF5IGxlYWQgdG8gZ2V0IGEgbWFjcm8gZm9yIGVh
Y2ggcG9zc2libGUgY29tYmluYXRpb24gb2YgdXNlZCB2YXJpYWJsZXMuDQo+Pj4gV2UgYWxyZWFk
eSBoYXZlIG5ldy9vbGQvb2xkbmV3LCBzbyB3b3VsZCAianVzdCIgYWRkIG9uZSBtb3JlLg0KPj4g
Tm90IGp1c3Qgb25lLCBpdCB3aWxsIGJlIG9uZSBlYWNoIG5ldy9vbGQvb2xkbmV3IG1hY3JvIHRv
IGJlIGFibGUgdG8gZGlzdGluZ3Vpc2gNCj4+IHdoZW4gY29ubmVjdG9yIGlzIHVzZWQgb3Igbm90
Lg0KPiBXaGF0IEknbSBzdWdnZXN0aW5nIGlzIHRoaXM6DQo+IGZvcl9lYWNoX2Nvbm5lY3Rvcl9p
bl9zdGF0ZShzdGF0ZSwgY29ubmVjdG9yLCBpKQ0KPiBmb3JfZWFjaF9vbGRfY29ubmVjdG9yX2lu
X3N0YXRlKHN0YXRlLCBvbGRfY29ubl9zdGF0ZSwgaSkNCj4gZm9yX2VhY2hfbmV3X2Nvbm5lY3Rv
cl9pbl9zdGF0ZShzdGF0ZSwgbmV3X2Nvbm5fc3RhdGUsIGkpDQo+IGZvcl9lYWNoX29sZG5ld19j
b25uZWN0b3JfaW5fc3RhdGUoc3RhdGUsIG9sZF9jb25uX3N0YXRlLCBuZXdfY29ubl9zdGF0ZSwg
aSkNCj4NCj4gU28gb25seSBmb3VyIGluIHRvdGFsIGZvciBlYWNoIG9iamVjdCB0eXBlLCBpbnN0
ZWFkIG9mIHRoZSBjdXJyZW50DQo+IHRocmVlLg0KDQpZb3UgYXJlIG1pc3NpbmcgdGhlc2UgY2Fz
ZXM6IG9sZCBhbmQgY29ubmVjdG9yLCBuZXcgYW5kIGNvbm5lY3RvciwNCg0Kb2xkIGFuZCBuZXcg
YW5kIGNvbm5lY3RvciBhcmUgbmVlZGVkIHRvZ2V0aGVyLg0KDQo+
