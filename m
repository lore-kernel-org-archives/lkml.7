Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8319FECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CDF2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wYjp8BTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfJNNQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:16:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55214 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731563AbfJNNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:16:17 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EDBDZE008607;
        Mon, 14 Oct 2019 15:14:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=+SqLurPUOcS59vau4EpYkNSbXqeGymiKMVDO7NTwWoI=;
 b=wYjp8BTPIAmiE6QHr7eRtSzGqZKpRIHOHPY+V7ZudI77G5LnAZBY7u0Dv5wdf3Hvei9Q
 wYJsWehC3PkG7XmHTkpjU3UL65j2n7w0dlGS6RB7e7Cf2txAZ7Q5qSkqUfs8Ntnaupik
 0WOYd/ERgolpX4hti4TJ/MzmfbyhfC3HEEzpyTTa/zy7HoZRGZoK0z5QwNBZC615SsmM
 oqkhDNRr3UUivey84f7AAfzK8FXrjAPzJxMAQdxB9kFrTMNV7gqwk8Z7+R9ViaTpnwwB
 5K/hfew01P3zGAywcwXvXRUPFZoCUiDO0RCVjmFnuYn8Ax7yymky9gxfPwTCL4oJWSs8 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vk4a12g15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 15:14:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A2DB100034;
        Mon, 14 Oct 2019 15:14:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 62ABD2B4E0B;
        Mon, 14 Oct 2019 15:14:23 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 14 Oct
 2019 15:14:23 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 14 Oct 2019 15:14:23 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] tick: check if broadcast device could really be stopped
Thread-Topic: [PATCH] tick: check if broadcast device could really be stopped
Thread-Index: AQHVfrsEmc79HQHAz0CZKn5VsbroAadZ/p0AgAAE/AA=
Date:   Mon, 14 Oct 2019 13:14:23 +0000
Message-ID: <a4b4b785-c471-a3c2-2c41-01bd9865e479@st.com>
References: <20191009160246.17898-1-benjamin.gaignard@st.com>
 <alpine.DEB.2.21.1910141441350.2531@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910141441350.2531@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F2F22DEDC2D2642B78AA5B6B41FC08F@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_07:2019-10-11,2019-10-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC8xNC8xOSAyOjU2IFBNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IE9uIFdlZCwg
OSBPY3QgMjAxOSwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+PiBAQCAtNzgsNyArNzgsNyBA
QCBzdGF0aWMgYm9vbCB0aWNrX2NoZWNrX2Jyb2FkY2FzdF9kZXZpY2Uoc3RydWN0IGNsb2NrX2V2
ZW50X2RldmljZSAqY3VyZGV2LA0KPj4gICB7DQo+PiAgIAlpZiAoKG5ld2Rldi0+ZmVhdHVyZXMg
JiBDTE9DS19FVlRfRkVBVF9EVU1NWSkgfHwNCj4+ICAgCSAgICAobmV3ZGV2LT5mZWF0dXJlcyAm
IENMT0NLX0VWVF9GRUFUX1BFUkNQVSkgfHwNCj4+IC0JICAgIChuZXdkZXYtPmZlYXR1cmVzICYg
Q0xPQ0tfRVZUX0ZFQVRfQzNTVE9QKSkNCj4+ICsJICAgIHRpY2tfYnJvYWRjYXN0X2NvdWxkX3N0
b3AobmV3ZGV2KSkNCj4gTm8uIFRoaXMgbWlnaHQgYmUgY2FsbGVkIF9iZWZvcmVfIGEgY3B1aWRs
ZSBkcml2ZXIgaXMgYXZhaWxhYmxlIGFuZCB0aGVuDQo+IHdoZW4gdGhhdCBkcml2ZXIgaXMgbG9h
ZGVkIGFuZCBnb2VzIGRlZXAsIGV2ZXJ5dGhpbmcgZ29lcyBzb3V0aC4NCg0KV2hhdCBjb3VsZCBi
ZSB0aGUgc29sdXRpb24gdG8gbGV0IGtub3cgdG8gdGljayBicm9hZGNhc3QgZnJhbWV3b3JrIHRo
YXQgDQp0aGlzIGRldmljZQ0KDQp3aWxsIG5vdCBiZSBzdG9wcGVkIChiZWNhdXNlIENQVSB3b24n
dCBnbyBpbiBpZGxlKSA/DQoNCkkgaGF2ZSB0cmllZCB0byBwdXQgImFsd2F5cy1vbiIgcHJvcGVy
dHkgb24gRFQgYnV0IGl0IHdhcyBhIE5BQ0sgdG9vOg0KDQpodHRwczovL2xrbWwub3JnL2xrbWwv
MjAxOS85LzI3LzE2NA0KDQpEbyBJIGhhdmUgbWlzcyBhIGZsYWcgc29tZXdoZXJlID8NCg0KUmVn
YXJkcywNCg0KQmVuamFtaW4NCg0KPg0KPiBBc2lkZSBvZiB0aGF0IGl0IGRlZmluaXRlbHkgYnJl
YWtzIGV2ZXJ5dGhpbmcgd2hpY2ggZG9lcyBub3QgdXNlIHRoZQ0KPiBjcHVpZGxlIHN0dWZmLCB3
aGljaCBpbmNsdWRlcyBhbGwgbWFjaGluZXMgYWZmZWN0ZWQgYnkgWDg2X0JVR19BTURfQVBJQ19D
MUUNCj4gYW5kIGV2ZXJ5dGhpbmcgd2hpY2ggdXNlcyB0aGUgSU5URUxfSURMRSBkcml2ZXIuDQo+
DQo+IFByZXR0eSBtdWNoIHRoZSBzYW1lIHByb2JsZW0gZm9yIGFsbCBvdGhlciBwbGFjZXMgeW91
IGNoYW5nZWQuDQo+IFRoYW5rcywNCj4NCj4gCXRnbHg=
