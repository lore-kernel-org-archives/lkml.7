Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33261C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D562186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="h7HUiExX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfDEMuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:50:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51727 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfDEMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:50:46 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35CkbuE014977;
        Fri, 5 Apr 2019 14:50:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=snJN3uVajqZZbAd+46DcNEeqDWfwIWDWzWZw8zRjujM=;
 b=h7HUiExXZMOX05vZVBtlDqJV3xABIW9kdTk6Kr3aKxvZ2g0VZT8ttRO5qurQankIiqeB
 6vbehpa1w7bkaWQv9j7VPjH+J1z7FMSgkVBUemS6/epjcZAMK7WD3USzTSEhL7NwI5E6
 82A4lHscsouurCz3SJHuXQ3ztPKnr7qbsTfZt9m4X48c5zm86U4jFENzuelCo0yxOLtb
 2d2Vs5dCGKme/DN1ZTHZpNCUhvUj6sbNkDOWFNZhXMUnO7Sm45Q5EK5sQvdve3mirpZy
 nxjyIsGMaLkKY8LSwkzXDAybAkOCk+fT9BNQKcAgvSFdAfOdCSkj2DIk3xunp26t5+fM Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgevhgtg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 14:50:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7EBE234;
        Fri,  5 Apr 2019 12:50:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53B202AF3;
        Fri,  5 Apr 2019 12:50:28 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr
 2019 14:50:27 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Fri, 5 Apr 2019 14:50:27 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 2/2] tty: add rpmsg driver
Thread-Topic: [PATCH 2/2] tty: add rpmsg driver
Thread-Index: AQHU3/1krl0CVu5p6ki2ctq+1V5DQ6YqEVkAgANpbAA=
Date:   Fri, 5 Apr 2019 12:50:27 +0000
Message-ID: <7f8c49cc-c62a-2243-4178-8292588db8ce@st.com>
References: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
 <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
 <20190403084420.GH6734@localhost>
In-Reply-To: <20190403084420.GH6734@localhost>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <626492380658924C95FAA84901711CED@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9oYW4sDQoNCg0KT24gMDMvMDQvMjAxOSAxMDo0NCBBTSwgSm9oYW4gSG92b2xkIHdyb3Rl
Og0KPiBPbiBUaHUsIE1hciAyMSwgMjAxOSBhdCAwNDo0NzoxOVBNICswMTAwLCBGYWJpZW4gRGVz
c2VubmUgd3JvdGU6DQo+PiBUaGlzIGRyaXZlciBleHBvc2VzIGEgc3RhbmRhcmQgdHR5IGludGVy
ZmFjZSBvbiB0b3Agb2YgdGhlIHJwbXNnDQo+PiBmcmFtZXdvcmsgdGhyb3VnaCB0aGUgInJwbXNn
LXR0eS1jaGFubmVsIiBycG1zZyBzZXJ2aWNlLg0KPj4NCj4+IFRoaXMgZHJpdmVyIHN1cHBvcnRz
IG11bHRpLWluc3RhbmNlcywgb2ZmZXJpbmcgYSAvZGV2L3R0eVJQTVNHeCBlbnRyeQ0KPj4gcGVy
IHJwbXNnIGVuZHBvaW50Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFybmF1ZCBQb3VsaXF1ZW4g
PGFybmF1ZC5wb3VsaXF1ZW5Ac3QuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogRmFiaWVuIERlc3Nl
bm5lIDxmYWJpZW4uZGVzc2VubmVAc3QuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvdHR5L0tj
b25maWcgICAgIHwgICA5ICsrDQo+PiAgIGRyaXZlcnMvdHR5L01ha2VmaWxlICAgIHwgICAxICsN
Cj4+ICAgZHJpdmVycy90dHkvcnBtc2dfdHR5LmMgfCAzMDkgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMzE5IGlu
c2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdHR5L3JwbXNnX3R0
eS5jDQo+PiArc3RhdGljIGludCBycG1zZ190dHlfd3JpdGUoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0
eSwgY29uc3QgdW5zaWduZWQgY2hhciAqYnVmLA0KPj4gKwkJCSAgIGludCB0b3RhbCkNCj4+ICt7
DQo+PiArCWludCBjb3VudCwgcmV0ID0gMDsNCj4+ICsJY29uc3QgdW5zaWduZWQgY2hhciAqdGJ1
ZjsNCj4+ICsJc3RydWN0IHJwbXNnX3R0eV9wb3J0ICpjcG9ydCA9IGlkcl9maW5kKCZ0dHlfaWRy
LCB0dHktPmluZGV4KTsNCj4+ICsJc3RydWN0IHJwbXNnX2RldmljZSAqcnBkZXY7DQo+PiArCWlu
dCBtc2dfc2l6ZTsNCj4+ICsNCj4+ICsJaWYgKCFjcG9ydCkgew0KPj4gKwkJZGV2X2Vycih0dHkt
PmRldiwgImNhbm5vdCBnZXQgY3BvcnRcbiIpOw0KPj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+PiAr
CX0NCj4+ICsNCj4+ICsJcnBkZXYgPSBjcG9ydC0+cnBkZXY7DQo+PiArDQo+PiArCWRldl9kYmco
JnJwZGV2LT5kZXYsICIlczogc2VuZCBtZXNzYWdlIGZyb20gdHR5LT5pbmRleCA9ICVkXG4iLA0K
Pj4gKwkJX19mdW5jX18sIHR0eS0+aW5kZXgpOw0KPj4gKw0KPj4gKwlpZiAoIWJ1Zikgew0KPj4g
KwkJZGV2X2VycigmcnBkZXYtPmRldiwgImJ1ZiBzaG91bGRuJ3QgYmUgbnVsbC5cbiIpOw0KPj4g
KwkJcmV0dXJuIC1FTk9NRU07DQo+PiArCX0NCj4+ICsNCj4+ICsJbXNnX3NpemUgPSBycG1zZ19n
ZXRfYnVmX3BheWxvYWRfc2l6ZShycGRldi0+ZXB0KTsNCj4+ICsJaWYgKG1zZ19zaXplIDwgMCkN
Cj4+ICsJCXJldHVybiBtc2dfc2l6ZTsNCj4+ICsNCj4+ICsJY291bnQgPSB0b3RhbDsNCj4+ICsJ
dGJ1ZiA9IGJ1ZjsNCj4+ICsJZG8gew0KPj4gKwkJLyogc2VuZCBhIG1lc3NhZ2UgdG8gb3VyIHJl
bW90ZSBwcm9jZXNzb3IgKi8NCj4+ICsJCXJldCA9IHJwbXNnX3NlbmQocnBkZXYtPmVwdCwgKHZv
aWQgKil0YnVmLA0KPj4gKwkJCQkgbWluKGNvdW50LCBtc2dfc2l6ZSkpOw0KPiBKdXN0IGEgZHJp
dmUtYnkgY29tbWVudDsgaXQgbG9va3MgbGlrZSBycG1zZ19zZW5kKCkgbWF5IGJsb2NrLCBidXQN
Cj4gdGhlIHR0eS1kcml2ZXIgd3JpdGUoKSBjYWxsYmFjayBtdXN0IG5ldmVyIHNsZWVwLg0KDQoN
Ck9LLCBJIHdpbGwgdXNlIHJwbXNnX3RyeXNlbmQoKSB3aGljaCBkb2VzIG5vdCBibG9jay4NCg0K
DQpCUiwNCg0KRmFiaWVuDQoNCg0KPg0KPj4gKwkJaWYgKHJldCkgew0KPj4gKwkJCWRldl9lcnIo
JnJwZGV2LT5kZXYsICJycG1zZ19zZW5kIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+PiArCQkJcmV0
dXJuIHJldDsNCj4+ICsJCX0NCj4+ICsNCj4+ICsJCWlmIChjb3VudCA+IG1zZ19zaXplKSB7DQo+
PiArCQkJY291bnQgLT0gbXNnX3NpemU7DQo+PiArCQkJdGJ1ZiArPSBtc2dfc2l6ZTsNCj4+ICsJ
CX0gZWxzZSB7DQo+PiArCQkJY291bnQgPSAwOw0KPj4gKwkJfQ0KPj4gKwl9IHdoaWxlIChjb3Vu
dCA+IDApOw0KPj4gKw0KPj4gKwlyZXR1cm4gdG90YWw7DQo+PiArfQ0KPiBKb2hhbg==
