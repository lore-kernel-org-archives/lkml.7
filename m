Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FED2063F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JoDFZ6w/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfDHM1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:27:19 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16318 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfDHM1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:27:18 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38CQT85021923;
        Mon, 8 Apr 2019 14:26:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=5w0OyiL/BNTzt4uWQ9/h0C9sXqy6a8VcFL4J4XkUPM4=;
 b=JoDFZ6w/1GrwHqTMdUMgRZqODZ6nmA8HJlntfkfQO7qTf54lj7osbuEa/nD7SH4dUhVh
 XQgNhy5x1qyE+ONBoztVselsbQ0E+hSAz28eiXsiN4b4JhUeiqUtDhxieNpCOrM3UvmX
 FLeDlhH7YQpfo2txR8wyhfQRLcgVu6/KuqCzWfdajpmtGwN8F6xAuS7JhRDe1xElb9d/
 SW6GkMPZ2rPmaiW7ISB/TlMsVYcFLRaosTqETlEPC6TAurecFsV/vW3/P/TTZ2F5wzFS
 Rb/UoZr56KeeG59wO9/Cyz0d1PfsBxhAuG9UuuZa2D1HYxZ1y2+MeWzFZEdGxAlSe5yt hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcntdjd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Apr 2019 14:26:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E60DD38;
        Mon,  8 Apr 2019 12:26:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A9132264E;
        Mon,  8 Apr 2019 12:26:33 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 8 Apr
 2019 14:26:33 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 8 Apr 2019 14:26:33 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ARM: dts: stm32: add stpmic1 support on stm32mp157c
 ed1 board
Thread-Topic: [PATCH 1/3] ARM: dts: stm32: add stpmic1 support on stm32mp157c
 ed1 board
Thread-Index: AQHU6iLcQk0sRaIxpESSFZE472+6sg==
Date:   Mon, 8 Apr 2019 12:26:33 +0000
Message-ID: <5CAB3DF8.7020505@st.com>
References: <1554298852-9955-1-git-send-email-p.paillet@st.com>
 <1554298852-9955-2-git-send-email-p.paillet@st.com>
 <CACRpkdZ9evBnvnmidQ2VW=dPUdGBM4Pkzo1VyMfDdQZFe6U7TA@mail.gmail.com>
In-Reply-To: <CACRpkdZ9evBnvnmidQ2VW=dPUdGBM4Pkzo1VyMfDdQZFe6U7TA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <149534930B54F74E978E209E1753A909@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8hDQoNCkxlIDA0LzA4LzIwMTkgMDI6MDUgUE0sIExpbnVzIFdhbGxlaWogYSDDqWNyaXQg
Og0KPiBPbiBXZWQsIEFwciAzLCAyMDE5IGF0IDM6NDEgUE0gUGFzY2FsIFBBSUxMRVQtTE1FIDxw
LnBhaWxsZXRAc3QuY29tPiB3cm90ZToNCj4NCj4+IFRoaXMgcGF0Y2ggYWRkcyBzdHBtaWMxIHN1
cHBvcnQgb24gc3RtMzJtcDE1N2MgZWQxIGJvYXJkLg0KPj4gVGhlIFNUUE1JQzEgaXMgYSBQTUlD
IGZyb20gU1RNaWNyb2VsZWN0cm9uaWNzLiBUaGUgU1RQTUlDMSBpbnRlZ3JhdGVzIDEwDQo+PiBy
ZWd1bGF0b3JzLCAzIHBvd2VyIHN3aXRjaGVzLCBhIHdhdGNoZG9nIGFuZCBhbiBpbnB1dCBmb3Ig
YSBwb3dlciBvbiBrZXkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFzY2FsIFBhaWxsZXQgPHAu
cGFpbGxldEBzdC5jb20+DQo+IE9LDQo+DQo+PiArICAgICAgIC9kZWxldGUtcHJvcGVydHkvZG1h
czsNCj4+ICsgICAgICAgL2RlbGV0ZS1wcm9wZXJ0eS9kbWEtbmFtZXM7DQo+IE1heWJlIHlvdSBj
YW4gYWRkIGEgY29tbWVudCBib3RoIHRvIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgdGhlDQo+IERU
UyBmaWxlIGFzIHRvIHdoeSB5b3UgYXJlIGRvaW5nIHRoaXM/DQo+DQo+IEkgaG9wZSB5b3UgYXJl
IG5vdCB0cnlpbmcgdG8gd29yayBhcm91bmQgYSBidWcgaW4gdGhlIGRyaXZlciBieQ0KPiBzdHJp
cHBpbmcgb3V0IERNQSBjb25maWd1cmF0aW9uIGZyb20gdGhlIGRldmljZSB0cmVlLCBiZWNhdXNl
IHRoZW4NCj4gaXQgaXMgcHJvYmFibHkgYSBiZXR0ZXIgaWRlYSB0byBmaXggdGhlIGJ1Zy4NClRo
aXMgaXMgbm90IGEgd29ya2Fyb3VuZC4gVGhlIFBNSUMgY2FuIHVzZSB0aGUgRE1BIG92ZXIgSTJD
IGJ1cy4NCk91ciBnb2FsIGlzIHRvIGF2b2lkIHVzaW5nIGEgRE1BIGNoYW5uZWwgZm9yIGEgY29u
c3VtZXIgdGhhdCBnZW5lcmF0ZXMgYQ0KdmVyeSBmZXcgdHJhZmZpYy4gRG1hIGNoYW5uZWxzIG1h
eSBsYWNrIGZvciBvdGhlciB1c2UgY2FzZXMuDQoNCklmIHlvdSBhZ3JlZSwgeW91IGNhbiBhZGQg
dGhlIHRvIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCj4N
Cg0KdGhhbmsgeW91LA0KQmVzdCBSZWdhcmRzLA0KUGFzY2FsDQo=
