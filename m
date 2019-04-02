Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7021C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BA220857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfDBJ7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:59:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10437 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729105AbfDBJ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:59:08 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x329lRlj019726;
        Tue, 2 Apr 2019 11:57:00 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rhxfb9dua-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Apr 2019 11:57:00 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 764F73D;
        Tue,  2 Apr 2019 09:56:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B5FE2428;
        Tue,  2 Apr 2019 09:56:59 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 2 Apr
 2019 11:56:58 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Tue, 2 Apr 2019 11:56:58 +0200
From:   Hugues FRUCHET <hugues.fruchet@st.com>
To:     Andi Kleen <andi@firstfloor.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "mchehab@s-opensource.com" <mchehab@s-opensource.com>
Subject: Re: [PATCH 10/17] delta: Fix buffer overrun in delta_ipc_open
Thread-Topic: [PATCH 10/17] delta: Fix buffer overrun in delta_ipc_open
Thread-Index: AQHU4DF+EkeJEPLYVkuR2+5UpJYj4KYnPk8AgAA2yYCAAR3PAA==
Date:   Tue, 2 Apr 2019 09:56:58 +0000
Message-ID: <32092918-d854-255f-28af-62e909344a91@st.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-11-andi@firstfloor.org>
 <bb7d9aeb-9cde-92c6-cbd1-c0ba3d283f07@st.com>
 <20190401165400.pdp547zqwdojz67r@two.firstfloor.org>
In-Reply-To: <20190401165400.pdp547zqwdojz67r@two.firstfloor.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C16DD51EBA0BF1489A77C6ABD1957B6B@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kaSwNCg0KU28gZG8gYm90aCwgbWVtc2V0IHRoZW4gc3Ryc2NweToNCg0KKwltZW1zZXQo
bXNnLm5hbWUsIDAsIHNpemVvZihtc2cubmFtZSkpOw0KKwlpZiAoc3Ryc2NweShtc2cubmFtZSwg
bmFtZSwgc2l6ZW9mKG1zZy5uYW1lKSkgPD0gMCkNCisgICAgICAgICBnb3RvIGVycjsNCg0KQlIs
DQpIdWd1ZXMuDQoNCk9uIDQvMS8xOSA2OjU0IFBNLCBBbmRpIEtsZWVuIHdyb3RlOg0KPiBPbiBN
b24sIEFwciAwMSwgMjAxOSBhdCAwMTozNzo1NlBNICswMDAwLCBIdWd1ZXMgRlJVQ0hFVCB3cm90
ZToNCj4+IEhpIEFuZGksDQo+Pg0KPj4gV2UgaGF2ZSBhbHJlYWR5IGRpc2N1c3NlZCBhYm91dCB0
aGF0IGhlcmU6DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvODY2
NDA2Lw0KPj4NCj4+IE5vdyB0aGF0IHN0cnNjcHkgaXMgbGFyZ2VseSBkZXBsb3llZCB3aXRoaW4g
a2VybmVsLCBjb3VsZCB5b3UgcmV0ZXN0DQo+PiB3aXRoIHRoZSBjaGFuZ2UgSSBzdWdnZXN0ZWQg
Pw0KPiANCj4gc3Ryc2NweSBpcyBub3QgdGhlIGNvcnJlY3QgZml4IGJlY2F1c2UgaXQgbGVha3Mg
dW5pbml0aWFsaXplZCBtZW1vcnkNCj4gdG8gdGhlIHJlY2VpdmVyLiAgWW91IG5lZWQgdGhlIG1l
bXNldC4NCj4gDQo+IC1BbmRpDQo+IA==
